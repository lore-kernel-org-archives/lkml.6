Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D320EC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D6A20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D6A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933218AbeFTXmK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:42:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:44748 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932795AbeFTXmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:42:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 16:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="60927400"
Received: from ssarabia-mobl7.amr.corp.intel.com ([10.24.11.100])
  by orsmga003.jf.intel.com with ESMTP; 20 Jun 2018 16:41:40 -0700
Date:   Wed, 20 Jun 2018 16:41:40 -0700
From:   Solio Sarabia <solio.sarabia@intel.com>
To:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        stephen@networkplumber.org
Cc:     linux-perf-users@vger.kernel.org, kys@microsoft.com,
        shiny.sebastian@intel.com, amy.l.leeland@intel.com,
        solio.sarabia@intel.com
Subject: Re: Differences in cpu utilization reported by sar, emon
Message-ID: <20180620234140.GA13040@ssarabia-MOBL7.amr.corp.intel.com>
References: <20180615034133.GA5932@ssarabia-MOBL7.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615034133.GA5932@ssarabia-MOBL7.amr.corp.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andi, Stephen, for your help/insights.

TICK_CPU_ACCOUNTING (default option) does not account for cpu util on
cores handling irqs and softriqs.

IRQ_TIME_ACCOUNTING or VIRT_CPU_ACCOUTING_GEN helps to reduce the util
gap. With either option, there is still a difference, for example, up to
8% in terms of sar/emon ratio (sar shows lesser util). This is an
improvement to the default case though.


This is a brief description of the Kbuild options:

-> General setup
  -> CPU/Task time and stats accounting
    -> Cputime accounting
TICK_CPU_ACCOUNTING
    Simple/basic tick based cpu accounting--maintains statistics about
    user, system and idle time spent on per jiffies granularity.
VIRT_CPU_ACCOUNTING_NATIVE (not available on my kernel)
    Deterministic task and cpu time accounting--more accurate task
    and cpu time accounting. Kernel reads a cpu counter on each kernel
    entry and exit, and on transitions within the kernel between
    system, softirq, and hardirq state, so there is a small performance
    impact.
VIRT_CPU_ACCOUTING_GEN
    Full dynticks cpu time accounting--enable task and cpu time
    accounting on full dynticks systems. Kernel watches every
    kernel-user boundaries using the context tracking subsystem.
    There is significant overhead. For now only useful if you are
    working on the full dynticks subsystem development.
IRQ_TIME_ACCOUNTING
    Fine granularity task level irq time accounting--kernel reads a
    timestamp on each transition between softirq and hardirq state,
    so there can be a performance impact.

-Solio


On Thu, Jun 14, 2018 at 08:41:33PM -0700, Solio Sarabia wrote:
> Hello --
> 
> I'm running into an issue where sar, mpstat, top, and other tools show
> less cpu utilization compared to emon [1]. Sar uses /proc/stat as its
> source, and was configured to collect in 1s intervals. Emon reads
> hardware counter MSRs in the PMU in timer intervals, 0.1s for this
> scenario.
> 
> The platform is based on Xeon E5-2699 v3 (Haswell) 2.3GHz, 2_sockets,
> 18_cores/socket, 36_cores in total, running Ubuntu 16.04, Linux
> 4.4.0-128-generic. A network micro workload, ntttcp-for-linux [2],
> sends packets from client to server, through a 40GbE direct link.
> Numbers below are from server side.
> 
>                  total %util
>            CPU11    CPU21    CPU22    CPU25
> emon       99.99    15.90    36.22    36.82
> sar        99.99     0.06     0.36     0.35
> 
>                  interrupts/sec
>            CPU11    CPU21    CPU22    CPU25
> intrs/sec    846    28923    12844     6304
>     Contributors to /proc/interrupts:
>     CPU11: Local timer interrupts and Rescheduling interrupts
>     CPU21-CPU25: PCI MSI vector from network driver
> 
>                  softirqs/sec
>            CPU11    CPU21    CPU22    CPU25
> TIMER        198        1        2        1
> NET_RX         1    28889    23553    18546
> TASKLET        0    28889    11676     6249
> 
> 
> Somehow hardware irqs and softirqs do not have an effect on the core's
> utilization. Another observation is that as more cores are used to
> process packets, the emon/sar gap increases.
> 
> Kernels used default HZ=250. I also tried HZ=1000, which helped improve
> throughput, but difference in util is still there. Same for newer
> kernels 4.13, 4.15. I would appreciate pointers to debug this, or
> insights as what could cause this behavior.
> 
> [1] https://software.intel.com/en-us/download/emon-users-guide
> [2] https://github.com/simonxiaoss/ntttcp-for-linux
> 
> Thanks,
> -Solio
