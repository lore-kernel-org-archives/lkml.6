Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29DFECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD7F21480
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD7F21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJRAfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:35:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60736 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeJRAfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:35:53 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gCoqt-00038C-Bg; Wed, 17 Oct 2018 18:39:19 +0200
Date:   Wed, 17 Oct 2018 18:39:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: What happens before or in `schedule_preempt_disabled()`?
In-Reply-To: <70649a6c-e9a2-3b38-58d6-62f63fc2792e@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1810171829100.1517@nanos.tec.linutronix.de>
References: <70649a6c-e9a2-3b38-58d6-62f63fc2792e@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-773028384-1539794015=:1517"
Content-ID: <alpine.DEB.2.21.1810171834060.1517@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-773028384-1539794015=:1517
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1810171834061.1517@nanos.tec.linutronix.de>

Paul,

On Wed, 17 Oct 2018, Paul Menzel wrote:
> 
> Please find the debug patches attached. The `random: %i` messages are from
> `crng_fast_load()`.
> 
> My question is, how can I figure out, what happens in the code below?
> 
>         complete(&kthreadd_done);
>         pr_info("After kthreadd_done\n");
> 
>         /*
>          * The boot idle thread must execute schedule()
>          * at least once to get things moving:
>          */
>         schedule_preempt_disabled();
>         pr_info("After schedule_preempt_disabled\n");
> 
> Looking at `schedule_preempt_disabled()`, it shouldn¢t take much time, and I
> was unable to find out where `crng_fast_load()` is called from.
> 
> I guess threading is somehow working at that point, and I would though that
> it is the `complete()` call, but wonder why the `After kthreadd_done` is
> printed earlier.

This creates the init thread from the idle thread with preemption
disabled. To get the init thread on the CPU the idle thread must schedule
voluntary, which it does by calling schedule_preempt_disabled(). So the
scheduler picks the init thread and that executes the init callbacks.

The random calls are invoked by add_interrupt_randomness() or
add_hwgenerator_randomness(). But they are probably not consuming all the
time.

The time is consumed by the initcalls which are required before bringing up
the (non boot) CPUs. See kernel_init_freeable() which is called from
kernel_init(). If you add initcall_debug to the command line you will get
more information at least about the functions which are marked with
initcall.

Thanks,

	tglx

--8323329-773028384-1539794015=:1517--
