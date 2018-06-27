Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A67C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1339C261D6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1339C261D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934344AbeF0MhC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933884AbeF0MhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:37:00 -0400
Received: from home.goodmis.org (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB86241D0;
        Wed, 27 Jun 2018 12:36:59 +0000 (UTC)
Date:   Wed, 27 Jun 2018 08:36:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tejun Heo <htejun@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, "Steven J . Hill" <steven.hill@cavium.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] Revert mm/vmstat.c: fix vmstat_update() preemption BUG
Message-ID: <20180627123657.2hb7ow4szjyhg5aj@home.goodmis.org>
References: <20180411095757.28585-1-bigeasy@linutronix.de>
 <ef663b6d-9e9f-65c6-25ec-ffa88347c58d@suse.cz>
 <20180411140913.GE793541@devbig577.frc2.facebook.com>
 <20180411144221.o3v73v536tpnc6n3@linutronix.de>
 <20180411190729.7sbmbsxtkcng7ddx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411190729.7sbmbsxtkcng7ddx@linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 09:07:30PM +0200, Sebastian Andrzej Siewior wrote:
> 
> This already happens:
> - vmstat_shepherd() does get_online_cpus() and within this block it does
>   queue_delayed_work_on(). So this has to wait until cpuhotplug
>   completed before it can schedule something and then it won't schedule
>   anything on the "off" CPU.

But can't we have something like this happen: ?

	CPU0			CPU1			CPU2
	----			----			----
 get_online_cpus()
 queue_work(vmstat_update, cpu1)
    wakeup(kworker/1)
			     High prio task running
 put_online_cpus()
 						     Shutdown CPU 1
			     migrate kworker/1
 schedule kworker/1
 (smp_processor_id() != 1)

-- Steve

