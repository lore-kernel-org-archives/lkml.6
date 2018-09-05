Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AA0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927BE20861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927BE20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIERo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:44:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59562 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIERo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:44:27 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxXdB-0004Pn-Pz; Wed, 05 Sep 2018 15:14:01 +0200
Date:   Wed, 5 Sep 2018 15:14:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>
cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        peterz@infradead.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dzickus@redhat.com, brendan.jackman@arm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpu/hotplug: Fix rollback during error-out in
 takedown_cpu()
In-Reply-To: <cf91ee04-a4b6-6f2c-d194-71b7e92fbf45@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1809051512450.1416@nanos.tec.linutronix.de>
References: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org> <alpine.DEB.2.21.1809051244500.1416@nanos.tec.linutronix.de> <cf91ee04-a4b6-6f2c-d194-71b7e92fbf45@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1131129232-1536153241=:1416"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1131129232-1536153241=:1416
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 5 Sep 2018, Mukesh Ojha wrote:
> On 9/5/2018 5:03 PM, Thomas Gleixner wrote:
> > > +		st->rollback = true;
> > > +		st->target = prev_state;
> > > +		st->bringup = !st->bringup;
> > No, this is just papering over the actual problem.
> > 
> > The state inconsistency happens in take_cpu_down() when it returns with a
> > failure from __cpu_disable() because that returns with state = TEARDOWN_CPU
> > and st->state is then incremented in undo_cpu_down().
> > 
> > That's the real issue and we need to analyze the whole cpu_down rollback
> > logic first.
> 
> Could this be done like below ?

IOW, more papering over the real root cause.

> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index aa7fe85..47bce90 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -802,17 +802,18 @@ static int take_cpu_down(void *_param)
>         int err, cpu = smp_processor_id();
>         int ret;

  ^^^^^^^

Please fix your mailer or your editor. That patch is whitespace damaged.

Thanks,

	tglx
--8323329-1131129232-1536153241=:1416--
