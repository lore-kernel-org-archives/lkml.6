Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7663EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2782825FE2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2782825FE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965150AbeF0MrN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:47:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52498 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965132AbeF0MrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:47:11 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fY9qk-0004iE-ML; Wed, 27 Jun 2018 14:47:06 +0200
Date:   Wed, 27 Jun 2018 14:47:06 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tejun Heo <htejun@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, "Steven J . Hill" <steven.hill@cavium.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] Revert mm/vmstat.c: fix vmstat_update() preemption BUG
Message-ID: <20180627124706.g33vlaku7xa4veqq@linutronix.de>
References: <20180411095757.28585-1-bigeasy@linutronix.de>
 <ef663b6d-9e9f-65c6-25ec-ffa88347c58d@suse.cz>
 <20180411140913.GE793541@devbig577.frc2.facebook.com>
 <20180411144221.o3v73v536tpnc6n3@linutronix.de>
 <20180411190729.7sbmbsxtkcng7ddx@linutronix.de>
 <20180627123657.2hb7ow4szjyhg5aj@home.goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627123657.2hb7ow4szjyhg5aj@home.goodmis.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-27 08:36:57 [-0400], Steven Rostedt wrote:
> On Wed, Apr 11, 2018 at 09:07:30PM +0200, Sebastian Andrzej Siewior wrote:
> > 
> > This already happens:
> > - vmstat_shepherd() does get_online_cpus() and within this block it does
> >   queue_delayed_work_on(). So this has to wait until cpuhotplug
> >   completed before it can schedule something and then it won't schedule
> >   anything on the "off" CPU.
> 
> But can't we have something like this happen: ?
> 
> 	CPU0			CPU1			CPU2
> 	----			----			----
>  get_online_cpus()
>  queue_work(vmstat_update, cpu1)
>     wakeup(kworker/1)
> 			     High prio task running
>  put_online_cpus()
>  						     Shutdown CPU 1
> 			     migrate kworker/1
>  schedule kworker/1
>  (smp_processor_id() != 1)

I don't get CPU1 doing in here. kworker/1 should not be migrated to
begin with. The work item should be done before CPU2 shutdowns CPU1 (or
0) because vmstat_cpu_down_prep() cancels the work while the CPUs goes
down so it should not be migrated. Also, the work is enqueued while
holding the CPU HP lock.

Sebastian
