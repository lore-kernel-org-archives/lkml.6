Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeBFRjF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:39:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60096 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeBFRi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:38:57 -0500
Subject: Re: [RFC PATCH v1 13/13] mm: splice local lists onto the front of the
 LRU
To: Aaron Lu <aaron.lu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com, akpm@linux-foundation.org, Dave.Dice@oracle.com,
        dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        ldufour@linux.vnet.ibm.com, mgorman@suse.de, mhocko@kernel.org,
        pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        yossi.lev@oracle.com, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
 <20180131230413.27653-14-daniel.m.jordan@oracle.com>
 <20180202052120.GA16272@intel.com>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Organization: Oracle Corporation
Message-ID: <7b9c0aab-354d-c88b-3598-7bf91dd1ef74@oracle.com>
Date: Tue, 6 Feb 2018 12:38:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202052120.GA16272@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8796 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802060223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 12:21 AM, Aaron Lu wrote:
> On Wed, Jan 31, 2018 at 06:04:13PM -0500, daniel.m.jordan@oracle.com wrote:
>> Now that release_pages is scaling better with concurrent removals from
>> the LRU, the performance results (included below) showed increased
>> contention on lru_lock in the add-to-LRU path.
>>
>> To alleviate some of this contention, do more work outside the LRU lock.
>> Prepare a local list of pages to be spliced onto the front of the LRU,
>> including setting PageLRU in each page, before taking lru_lock.  Since
>> other threads use this page flag in certain checks outside lru_lock,
>> ensure each page's LRU links have been properly initialized before
>> setting the flag, and use memory barriers accordingly.
>>
>> Performance Results
>>
>> This is a will-it-scale run of page_fault1 using 4 different kernels.
>>
>>              kernel     kern #
>>
>>            4.15-rc2          1
>>    large-zone-batch          2
>>       lru-lock-base          3
>>     lru-lock-splice          4
>>
>> Each kernel builds on the last.  The first is a baseline, the second
>> makes zone->lock more scalable by increasing an order-0 per-cpu
>> pagelist's 'batch' and 'high' values to 310 and 1860 respectively
> 
> Since the purpose of the patchset is to optimize lru_lock, you may
> consider adjusting pcp->high to be >= 32768(page_fault1's test size is
> 128M = 32768 pages). That should eliminate zone->lock contention
> entirely.

Interesting, hadn't thought about taking zone->lock completely out of 
the equation.  Will try this next time I test this series.


While we're on this topic, it does seem from the performance of kernel 
#2, and the numbers Aaron posted in a previous thread[*], that the 
default 'batch' and 'high' values should be bigger on large systems.

The code to control these two values last changed in 2005[**], so we hit 
the largest values with just a 512M zone:

    zone       4k_pages  batch   high  high/4k_pages
     64M         16,384      3     18       0.10986%
    128M         32,768      7     42       0.12817%
    256M         65,536     15     90       0.13733%
    512M        131,072     31    186       0.14191%
      1G        262,144     31    186       0.07095%
      2G        524,288     31    186       0.03548%
      4G      1,048,576     31    186       0.01774%
      8G      2,097,152     31    186       0.00887%
     16G      4,194,304     31    186       0.00443%
     32G      8,388,608     31    186       0.00222%
     64G     16,777,216     31    186       0.00111%
    128G     33,554,432     31    186       0.00055%
    256G     67,108,864     31    186       0.00028%
    512G    134,217,728     31    186       0.00014%
   1024G    268,435,456     31    186       0.00007%


[*] https://marc.info/?l=linux-netdev&m=150572010919327
[**] ba56e91c9401 ("[PATCH] mm: page_alloc: increase size of per-cpu-pages")

> 
>> (courtesy of Aaron Lu's patch), the third scales lru_lock without
>> splicing pages (the previous patch in this series), and the fourth adds
>> page splicing (this patch).
>>
>> N tasks mmap, fault, and munmap anonymous pages in a loop until the test
>> time has elapsed.
