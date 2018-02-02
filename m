Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeBBES1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 23:18:27 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37698 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBBEST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 23:18:19 -0500
Subject: Re: [RFC PATCH v1 00/13] lru_lock scalability
To: Steven Whitehouse <swhiteho@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        Dave.Dice@oracle.com, dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        ldufour@linux.vnet.ibm.com, mgorman@suse.de, mhocko@kernel.org,
        pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        yossi.lev@oracle.com
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
 <6bd1c8a5-c682-a3ce-1f9f-f1f53b4117a9@redhat.com>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <e3e47085-1b5e-0d2e-f8cb-03defb9af0dd@oracle.com>
Date: Thu, 1 Feb 2018 23:18:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <6bd1c8a5-c682-a3ce-1f9f-f1f53b4117a9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020042
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/01/2018 10:54 AM, Steven Whitehouse wrote:
> Hi,
> 
> 
> On 31/01/18 23:04, daniel.m.jordan@oracle.com wrote:
>> lru_lock, a per-node* spinlock that protects an LRU list, is one of the
>> hottest locks in the kernel.  On some workloads on large machines, it
>> shows up at the top of lock_stat.
>>
>> One way to improve lru_lock scalability is to introduce an array of locks,
>> with each lock protecting certain batches of LRU pages.
>>
>>          *ooooooooooo**ooooooooooo**ooooooooooo**oooo ...
>>          |           ||           ||           ||
>>           \ batch 1 /  \ batch 2 /  \ batch 3 /
>>
>> In this ASCII depiction of an LRU, a page is represented with either '*'
>> or 'o'.  An asterisk indicates a sentinel page, which is a page at the
>> edge of a batch.  An 'o' indicates a non-sentinel page.
>>
>> To remove a non-sentinel LRU page, only one lock from the array is
>> required.  This allows multiple threads to remove pages from different
>> batches simultaneously.  A sentinel page requires lru_lock in addition to
>> a lock from the array.
>>
>> Full performance numbers appear in the last patch in this series, but this
>> prototype allows a microbenchmark to do up to 28% more page faults per
>> second with 16 or more concurrent processes.
>>
>> This work was developed in collaboration with Steve Sistare.
>>
>> Note: This is an early prototype.  I'm submitting it now to support my
>> request to attend LSF/MM, as well as get early feedback on the idea.  Any
>> comments appreciated.
>>
>>
>> * lru_lock is actually per-memcg, but without memcg's in the picture it
>>    becomes per-node.
> GFS2 has an lru list for glocks, which can be contended under certain workloads. Work is still ongoing to figure out exactly why, but this looks like it might be a good approach to that issue too. The main purpose of GFS2's lru list is to allow shrinking of the glocks under memory pressure via the gfs2_scan_glock_lru() function, and it looks like this type of approach could be used there to improve the scalability,

Glad to hear that this could help in gfs2 as well.

Hopefully struct gfs2_glock is less space constrained than struct page for storing the few bits of metadata that this approach requires.

Daniel

> 
> Steve.
> 
>>
>> Aaron Lu (1):
>>    mm: add a percpu_pagelist_batch sysctl interface
>>
>> Daniel Jordan (12):
>>    mm: allow compaction to be disabled
>>    mm: add lock array to pgdat and batch fields to struct page
>>    mm: introduce struct lru_list_head in lruvec to hold per-LRU batch
>>      info
>>    mm: add batching logic to add/delete/move API's
>>    mm: add lru_[un]lock_all APIs
>>    mm: convert to-be-refactored lru_lock callsites to lock-all API
>>    mm: temporarily convert lru_lock callsites to lock-all API
>>    mm: introduce add-only version of pagevec_lru_move_fn
>>    mm: add LRU batch lock API's
>>    mm: use lru_batch locking in release_pages
>>    mm: split up release_pages into non-sentinel and sentinel passes
>>    mm: splice local lists onto the front of the LRU
>>
>>   include/linux/mm_inline.h | 209 +++++++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/mm_types.h  |   5 ++
>>   include/linux/mmzone.h    |  25 +++++-
>>   kernel/sysctl.c           |   9 ++
>>   mm/Kconfig                |   1 -
>>   mm/huge_memory.c          |   6 +-
>>   mm/memcontrol.c           |   5 +-
>>   mm/mlock.c                |  11 +--
>>   mm/mmzone.c               |   7 +-
>>   mm/page_alloc.c           |  43 +++++++++-
>>   mm/page_idle.c            |   4 +-
>>   mm/swap.c                 | 208 ++++++++++++++++++++++++++++++++++++---------
>>   mm/vmscan.c               |  49 +++++------
>>   13 files changed, 500 insertions(+), 82 deletions(-)
>>
> 
