Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E542F20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E542F20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbeGJSd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:10774 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388051AbeGJSd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 11:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,335,1526367600"; 
   d="scan'208";a="55491032"
Received: from ssarabia-mobl7.amr.corp.intel.com ([10.254.80.171])
  by orsmga007.jf.intel.com with ESMTP; 10 Jul 2018 11:33:40 -0700
Date:   Tue, 10 Jul 2018 11:33:39 -0700
From:   Solio Sarabia <solio.sarabia@intel.com>
To:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        stephen@networkplumber.org
Cc:     linux-perf-users@vger.kernel.org, kys@microsoft.com,
        amy.l.leeland@intel.com, shiny.sebastian@intel.com,
        solio.sarabia@intel.com
Subject: Re: Differences in cpu utilization reported by sar, emon
Message-ID: <20180710183339.GA3796@ssarabia-MOBL7.amr.corp.intel.com>
References: <20180615034133.GA5932@ssarabia-MOBL7.amr.corp.intel.com>
 <20180620234140.GA13040@ssarabia-MOBL7.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180620234140.GA13040@ssarabia-MOBL7.amr.corp.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Further analysis shows that even with CONFIG_IRQ_TIME_ACCOUNTING or
DYNTICKS (CONFIG_VIRT_CPU_ACCOUNTING_GEN) there are some CPU cycles
lost. This difference correlates with the number of interrupts/sec
handled in the core, as the number increases, difference also does.

Network example (linux baremetal):
         sar    emon   emon-sar  interrupts/sec
core18   19.2   20.9   1.7       11057
core21   25.1   30.5   5.4       31472
core27   18.3   20.1   1.8       10384
core30    5.6   11.4   5.8       35841
core34   17.8   20.5   2.7       10973

Storage example (fio, device attached directly to vm):
         sar    perfmon   emon-perfmon  interrupts/sec
core10   7.4    19.7      12.3          100481

In the storage case, up to 12% irq cycles were not accounted. As users
start adopting more capable SSDs for instance, the issue will be more
evident. I would like to understand the reason as to why this happens:

What could be the reason for this issue?
Any pointers to the kernel subsystem/code performing time accounting?

Thanks,
-Solio


On Wed, Jun 20, 2018 at 04:41:40PM -0700, Solio Sarabia wrote:
> Thanks Andi, Stephen, for your help/insights.
> 
> TICK_CPU_ACCOUNTING (default option) does not account for cpu util on
> cores handling irqs and softriqs.
> 
> IRQ_TIME_ACCOUNTING or VIRT_CPU_ACCOUTING_GEN helps to reduce the util
> gap. With either option, there is still a difference, for example, up to
> 8% in terms of sar/emon ratio (sar shows lesser util). This is an
> improvement to the default case though.
> 
> 
> This is a brief description of the Kbuild options:
> 
> -> General setup
>   -> CPU/Task time and stats accounting
>     -> Cputime accounting
> TICK_CPU_ACCOUNTING
>     Simple/basic tick based cpu accounting--maintains statistics about
>     user, system and idle time spent on per jiffies granularity.
> VIRT_CPU_ACCOUNTING_NATIVE (not available on my kernel)
>     Deterministic task and cpu time accounting--more accurate task
>     and cpu time accounting. Kernel reads a cpu counter on each kernel
>     entry and exit, and on transitions within the kernel between
>     system, softirq, and hardirq state, so there is a small performance
>     impact.
> VIRT_CPU_ACCOUTING_GEN
>     Full dynticks cpu time accounting--enable task and cpu time
>     accounting on full dynticks systems. Kernel watches every
>     kernel-user boundaries using the context tracking subsystem.
>     There is significant overhead. For now only useful if you are
>     working on the full dynticks subsystem development.
> IRQ_TIME_ACCOUNTING
>     Fine granularity task level irq time accounting--kernel reads a
>     timestamp on each transition between softirq and hardirq state,
>     so there can be a performance impact.
> 
> -Solio
> 
> 
> On Thu, Jun 14, 2018 at 08:41:33PM -0700, Solio Sarabia wrote:
> > Hello --
> > 
> > I'm running into an issue where sar, mpstat, top, and other tools show
> > less cpu utilization compared to emon [1]. Sar uses /proc/stat as its
> > source, and was configured to collect in 1s intervals. Emon reads
> > hardware counter MSRs in the PMU in timer intervals, 0.1s for this
> > scenario.
> > 
> > The platform is based on Xeon E5-2699 v3 (Haswell) 2.3GHz, 2_sockets,
> > 18_cores/socket, 36_cores in total, running Ubuntu 16.04, Linux
> > 4.4.0-128-generic. A network micro workload, ntttcp-for-linux [2],
> > sends packets from client to server, through a 40GbE direct link.
> > Numbers below are from server side.
> > 
> >                  total %util
> >            CPU11    CPU21    CPU22    CPU25
> > emon       99.99    15.90    36.22    36.82
> > sar        99.99     0.06     0.36     0.35
> > 
> >                  interrupts/sec
> >            CPU11    CPU21    CPU22    CPU25
> > intrs/sec    846    28923    12844     6304
> >     Contributors to /proc/interrupts:
> >     CPU11: Local timer interrupts and Rescheduling interrupts
> >     CPU21-CPU25: PCI MSI vector from network driver
> > 
> >                  softirqs/sec
> >            CPU11    CPU21    CPU22    CPU25
> > TIMER        198        1        2        1
> > NET_RX         1    28889    23553    18546
> > TASKLET        0    28889    11676     6249
> > 
> > 
> > Somehow hardware irqs and softirqs do not have an effect on the core's
> > utilization. Another observation is that as more cores are used to
> > process packets, the emon/sar gap increases.
> > 
> > Kernels used default HZ=250. I also tried HZ=1000, which helped improve
> > throughput, but difference in util is still there. Same for newer
> > kernels 4.13, 4.15. I would appreciate pointers to debug this, or
> > insights as what could cause this behavior.
> > 
> > [1] https://software.intel.com/en-us/download/emon-users-guide
> > [2] https://github.com/simonxiaoss/ntttcp-for-linux
> > 
> > Thanks,
> > -Solio
