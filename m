Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965849AbeBMVHi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 16:07:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53414 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965676AbeBMVHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 16:07:37 -0500
Subject: Re: [RFC PATCH v1 00/13] lru_lock scalability
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: aaron.lu@intel.com, ak@linux.intel.com, Dave.Dice@oracle.com,
        dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        ldufour@linux.vnet.ibm.com, mgorman@suse.de, mhocko@kernel.org,
        pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        yossi.lev@oracle.com
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
 <20180208153652.481a77e57cc32c9e1a7e4269@linux-foundation.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Organization: Oracle Corporation
Message-ID: <40c02402-ab76-6bd2-5e7d-77fea82e55fe@oracle.com>
Date: Tue, 13 Feb 2018 16:07:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208153652.481a77e57cc32c9e1a7e4269@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802130251
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 06:36 PM, Andrew Morton wrote:
> On Wed, 31 Jan 2018 18:04:00 -0500 daniel.m.jordan@oracle.com wrote:
> 
>> lru_lock, a per-node* spinlock that protects an LRU list, is one of the
>> hottest locks in the kernel.  On some workloads on large machines, it
>> shows up at the top of lock_stat.
> 
> Do you have details on which callsites are causing the problem?  That
> would permit us to consider other approaches, perhaps.

Sure, there are two paths where we're seeing contention.

In the first one, a pagevec's worth of anonymous pages are added to 
various LRUs when the per-cpu pagevec fills up:

   /* take an anonymous page fault, eventually end up at... */
   handle_pte_fault
     do_anonymous_page
       lru_cache_add_active_or_unevictable
         lru_cache_add
           __lru_cache_add
             __pagevec_lru_add
               pagevec_lru_move_fn
                 /* contend on lru_lock */


In the second, one or more pages are removed from an LRU under one hold 
of lru_lock:

   // userland calls munmap or exit, eventually end up at...
   zap_pte_range
     __tlb_remove_page // returns true because we eventually hit
                       // MAX_GATHER_BATCH_COUNT in tlb_next_batch
     tlb_flush_mmu_free
       free_pages_and_swap_cache
         release_pages
           /* contend on lru_lock */


For a broader context, we've run decision support benchmarks where 
lru_lock (and zone->lock) show long wait times. But we're not the only 
ones according to certain kernel comments:

mm/vmscan.c:
  * zone_lru_lock is heavily contended.  Some of the functions that
  * shrink the lists perform better by taking out a batch of pages
  * and working on them outside the LRU lock.
  *
  * For pagecache intensive workloads, this function is the hottest
  * spot in the kernel (apart from copy_*_user functions).
...
static unsigned long isolate_lru_pages(unsigned long nr_to_scan,


include/linux/mmzone.h:
  * zone->lock and the [pgdat->lru_lock] are two of the hottest locks in 
the kernel.
  * So add a wild amount of padding here to ensure that they fall into 
separate
  * cachelines. ...


Anyway, if you're seeing this lock in your workloads, I'm interested in 
hearing what you're running so we can get more real world data on this.
