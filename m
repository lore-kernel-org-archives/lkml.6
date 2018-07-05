Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80424C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408FB23E80
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408FB23E80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754528AbeGEQ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:59:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51188 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754109AbeGEQ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:59:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fb7bV-0008Bz-IK; Thu, 05 Jul 2018 18:59:37 +0200
Date:   Thu, 5 Jul 2018 18:59:37 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Julia Cartwright <julia@ni.com>, tglx@linutronix.de,
        rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT] sched/migrate_disable: fallback to preempt_disable()
 instead barrier()
Message-ID: <20180705165937.5orx3md3krg4akaz@linutronix.de>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
 <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
 <20180705161807.GA5800@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180705161807.GA5800@zipoli.concurrent-rt.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-05 12:18:07 [-0400], joe.korty@concurrent-rt.com wrote:
> Hi Sebastian,
Hi Joe,

> I just verified that this fix does not work for my mix of
> config options (smp && preempt && !rt).

Okay. So for !RT+SMP we keep migrate_disable() around and it almost
nothing. And it is not referenced anywhere so it does not matter as long
as it not used directly.

We could turn migrate_disable() into a nop/barrier but then we have
three uses which do preempt_disable() -> migrate_disable() (see other
thread).
For the futex code it should not matter much because at this point
preemption is disabled due to the spin_lock() (so we would just extend
it past the spin_unlock() or wake_futex_pi() which ends with
preempt_enable()).


> Regards,
> Joe

Sebastian
