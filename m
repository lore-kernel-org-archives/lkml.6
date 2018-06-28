Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE67C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BCF20882
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BCF20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966085AbeF1Nig (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:38:36 -0400
Received: from verein.lst.de ([213.95.11.211]:49045 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753771AbeF1Nie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:38:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4F94968B97; Thu, 28 Jun 2018 15:38:33 +0200 (CEST)
Date:   Thu, 28 Jun 2018 15:38:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ye Xiaolong <xiaolong.ye@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org,
        viro@zeniv.linux.org.uk
Subject: Re: [lkp-robot] [fs]  3deb642f0d:  will-it-scale.per_process_ops
        -8.8% regression
Message-ID: <20180628133833.GA11790@lst.de>
References: <20180622082752.GX11011@yexl-desktop> <20180622150251.GA12802@lst.de> <20180626060338.GU12146@yexl-desktop> <20180627070745.GA9765@lst.de> <20180628003834.GH18756@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180628003834.GH18756@yexl-desktop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 08:38:34AM +0800, Ye Xiaolong wrote:
> Update the result:
> 
> testcase/path_params/tbox_group/run: will-it-scale/poll2-performance/lkp-sb03

So this looks like a huge improvement in the per process ops, but not
as large as the original regression, and no change in the per-thread
ops.

But the baseline already looks much lower, e.g. this shows an improvement
from 404611 to 424608 for the per-process ops, while the original showed
a regression from 501456 to 457120.  Are we measuring on different
hardware?   Did we gain new spectre mitigations elsewhere?  Either way
I'm going to send these patches out for review, but I'd like to understand
the numbers a bit more.

> 
> 894b8c000ae6c106  8fbedc19c94fd25a2b9b327015  
> ----------------  --------------------------  
>          %stddev      change         %stddev
>              \          |                \  
>     404611 ±  4%         5%     424608        will-it-scale.per_process_ops
>       1489 ± 21%        28%       1899 ± 18%  will-it-scale.time.voluntary_context_switches
>   45828560                    46155690        will-it-scale.workload
>       2337                        2342        will-it-scale.time.system_time
>        806                         806        will-it-scale.time.percent_of_cpu_this_job_got
>        310                         310        will-it-scale.time.elapsed_time
>        310                         310        will-it-scale.time.elapsed_time.max
>       4096                        4096        will-it-scale.time.page_size
>     233917                      233862        will-it-scale.per_thread_ops
>      17196                       17179        will-it-scale.time.minor_page_faults
>       9901                        9862        will-it-scale.time.maximum_resident_set_size
>      14705 ±  3%                 14397 ±  4%  will-it-scale.time.involuntary_context_switches
>        167                         163        will-it-scale.time.user_time
>       0.66 ± 25%       -17%       0.54        will-it-scale.scalability
>     120508 ± 15%        -7%     112098 ±  5%  interrupts.CAL:Function_call_interrupts
>       1670 ±  3%        10%       1845 ±  3%  vmstat.system.cs
>      32707                       32635        vmstat.system.in
>        121                         122        turbostat.CorWatt
>        149                         150        turbostat.PkgWatt
>       1573                        1573        turbostat.Avg_MHz
>      17.54 ± 19%                 17.77 ± 19%  boot-time.kernel_boot
>        824 ± 12%                   834 ± 12%  boot-time.idle
>      27.45 ± 12%                 27.69 ± 12%  boot-time.boot
>      16.96 ± 21%                 16.93 ± 21%  boot-time.dhcp
>       1489 ± 21%        28%       1899 ± 18%  time.voluntary_context_switches
>       2337                        2342        time.system_time
>        806                         806        time.percent_of_cpu_this_job_got
>        310                         310        time.elapsed_time
>        310                         310        time.elapsed_time.max
>       4096                        4096        time.page_size
>      17196                       17179        time.minor_page_faults
>       9901                        9862        time.maximum_resident_set_size
>      14705 ±  3%                 14397 ±  4%  time.involuntary_context_switches
>        167                         163        time.user_time
>      18320               6%      19506 ±  8%  proc-vmstat.nr_slab_unreclaimable
>       1518 ±  7%                  1558 ± 10%  proc-vmstat.numa_hint_faults
>       1387 ±  8%                  1421 ±  9%  proc-vmstat.numa_hint_faults_local
>       1873 ±  5%                  1917 ±  8%  proc-vmstat.numa_pte_updates
>      19987                       20005        proc-vmstat.nr_anon_pages
>       8464                        8471        proc-vmstat.nr_kernel_stack
>     309815                      310062        proc-vmstat.nr_file_pages
>      50828                       50828        proc-vmstat.nr_free_cma
>   16065590                    16064831        proc-vmstat.nr_free_pages
>    3194669                     3194517        proc-vmstat.nr_dirty_threshold
>    1595384                     1595308        proc-vmstat.nr_dirty_background_threshold
>     798886                      797937        proc-vmstat.pgfault
>       6510                        6499        proc-vmstat.nr_mapped
>     659089                      657491        proc-vmstat.numa_local
>     665458                      663786        proc-vmstat.numa_hit
>       1037                        1033        proc-vmstat.nr_page_table_pages
>     669923                      665906        proc-vmstat.pgfree
>     676982                      672385        proc-vmstat.pgalloc_normal
>       6368                        6294        proc-vmstat.numa_other
>      13013              -7%      12152 ± 11%  proc-vmstat.nr_slab_reclaimable
>   51213164 ± 18%        23%   63014695 ± 25%  perf-stat.node-loads
>   22096136 ± 28%        20%   26619357 ± 35%  perf-stat.node-load-misses
>  2.079e+08 ±  9%        12%  2.323e+08 ± 11%  perf-stat.cache-misses
>     515039 ±  3%        10%     568299 ±  3%  perf-stat.context-switches
>  3.283e+08 ± 22%        10%  3.622e+08 ±  5%  perf-stat.iTLB-loads
> 
> Thanks,
> Xiaolong
---end quoted text---
