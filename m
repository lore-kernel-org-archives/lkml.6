Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeBAXax (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:30:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:53194 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeBAXaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:30:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="200684873"
Subject: Re: [RFC PATCH v1 13/13] mm: splice local lists onto the front of the
 LRU
To: daniel.m.jordan@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        Dave.Dice@oracle.com, dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        ldufour@linux.vnet.ibm.com, mgorman@suse.de, mhocko@kernel.org,
        pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        yossi.lev@oracle.com
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
 <20180131230413.27653-14-daniel.m.jordan@oracle.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <d017b716-6409-fbf2-9b33-4f5ef3192535@linux.intel.com>
Date: Thu, 1 Feb 2018 15:30:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20180131230413.27653-14-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 03:04 PM, daniel.m.jordan@oracle.com wrote:
> Now that release_pages is scaling better with concurrent removals from
> the LRU, the performance results (included below) showed increased
> contention on lru_lock in the add-to-LRU path.
> 
> To alleviate some of this contention, do more work outside the LRU lock.
> Prepare a local list of pages to be spliced onto the front of the LRU,
> including setting PageLRU in each page, before taking lru_lock.  Since
> other threads use this page flag in certain checks outside lru_lock,
> ensure each page's LRU links have been properly initialized before
> setting the flag, and use memory barriers accordingly.
> 
> Performance Results
> 
> This is a will-it-scale run of page_fault1 using 4 different kernels.
> 
>             kernel     kern #
> 
>           4.15-rc2          1
>   large-zone-batch          2
>      lru-lock-base          3
>    lru-lock-splice          4
> 
> Each kernel builds on the last.  The first is a baseline, the second
> makes zone->lock more scalable by increasing an order-0 per-cpu
> pagelist's 'batch' and 'high' values to 310 and 1860 respectively
> (courtesy of Aaron Lu's patch), the third scales lru_lock without
> splicing pages (the previous patch in this series), and the fourth adds
> page splicing (this patch).
> 
> N tasks mmap, fault, and munmap anonymous pages in a loop until the test
> time has elapsed.
> 
> The process case generally does better than the thread case most likely
> because of mmap_sem acting as a bottleneck.  There's ongoing work
> upstream[*] to scale this lock, however, and once it goes in, my
> hypothesis is the thread numbers here will improve.
> 
> kern #  ntask     proc      thr        proc    stdev         thr    stdev
>                speedup  speedup       pgf/s                pgf/s
>      1      1                       705,533    1,644     705,227    1,122
>      2      1     2.5%     2.8%     722,912      453     724,807      728
>      3      1     2.6%     2.6%     724,215      653     723,213      941
>      4      1     2.3%     2.8%     721,746      272     724,944      728
> 
> kern #  ntask     proc      thr        proc    stdev         thr    stdev
>                speedup  speedup       pgf/s                pgf/s
>      1      4                     2,525,487    7,428   1,973,616   12,568
>      2      4     2.6%     7.6%   2,590,699    6,968   2,123,570   10,350
>      3      4     2.3%     4.4%   2,584,668   12,833   2,059,822   10,748
>      4      4     4.7%     5.2%   2,643,251   13,297   2,076,808    9,506
> 
> kern #  ntask     proc      thr        proc    stdev         thr    stdev
>                speedup  speedup       pgf/s                pgf/s
>      1     16                     6,444,656   20,528   3,226,356   32,874
>      2     16     1.9%    10.4%   6,566,846   20,803   3,560,437   64,019
>      3     16    18.3%     6.8%   7,624,749   58,497   3,447,109   67,734
>      4     16    28.2%     2.5%   8,264,125   31,677   3,306,679   69,443
> 
> kern #  ntask     proc      thr        proc    stdev         thr    stdev
>                speedup  speedup       pgf/s                pgf/s
>      1     32                    11,564,988   32,211   2,456,507   38,898
>      2     32     1.8%     1.5%  11,777,119   45,418   2,494,064   27,964
>      3     32    16.1%    -2.7%  13,426,746   94,057   2,389,934   40,186
>      4     32    26.2%     1.2%  14,593,745   28,121   2,486,059   42,004
> 
> kern #  ntask     proc      thr        proc    stdev         thr    stdev
>                speedup  speedup       pgf/s                pgf/s
>      1     64                    12,080,629   33,676   2,443,043   61,973
>      2     64     3.9%     9.9%  12,551,136  206,202   2,684,632   69,483
>      3     64    15.0%    -3.8%  13,892,933  351,657   2,351,232   67,875
>      4     64    21.9%     1.8%  14,728,765   64,945   2,485,940   66,839
> 
> [*] https://lwn.net/Articles/724502/  Range reader/writer locks
>     https://lwn.net/Articles/744188/  Speculative page faults
> 

The speedup looks pretty nice and seems to peak at 16 tasks.  Do you have an explanation of what
causes the drop from 28.2% to 21.9% going from 16 to 64 tasks?  Was
the loss in performance due to increased contention on LRU lock when more tasks running
results in a higher likelihood of hitting the sentinel?  If I understand
your patchset correctly, you will need to acquire LRU lock for sentinel page. Perhaps an increase
in batch size could help?

Thanks.

Tim
