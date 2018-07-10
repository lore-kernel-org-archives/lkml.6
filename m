Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76384C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222FC20BF2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222FC20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbeGJUWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:22:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37688 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbeGJUWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:22:35 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fcz90-0007pY-6g; Tue, 10 Jul 2018 22:21:54 +0200
Date:   Tue, 10 Jul 2018 22:21:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>
cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] clocksource: arm_arch_timer: set arch_mem_timer
 cpumask to cpu_possible_mask
In-Reply-To: <a8979e78-9844-160a-a758-631505924bbd@arm.com>
Message-ID: <alpine.DEB.2.21.1807102220320.1588@nanos.tec.linutronix.de>
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com> <1531151136-18297-2-git-send-email-sudeep.holla@arm.com> <alpine.DEB.2.21.1807100008100.1590@nanos.tec.linutronix.de> <b98e0d87-3d9a-9b0c-23c4-7b289cc79a97@arm.com>
 <alpine.DEB.2.21.1807101419130.4356@nanos.tec.linutronix.de> <a8979e78-9844-160a-a758-631505924bbd@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018, Sudeep Holla wrote:
> On 10/07/18 13:21, Thomas Gleixner wrote:
> >> Also only few ARM clocksource drivers use cpu_all_mask which could be
> >> result of copy-paste, we can even fix them too.
> >>
> >> arm_arch_timer.c:	clk->cpumask = cpu_all_mask;
> >> tegra20_timer.c:	tegra_clockevent.cpumask = cpu_all_mask;
> >> timer-atcpit100.c:	.cpumask = cpu_all_mask,
> >> timer-keystone.c:	event_dev->cpumask = cpu_all_mask;
> >> zevio-timer.c:		timer->clkevt.cpumask	= cpu_all_mask;
> > 
> > Yes, that makes sense. What we could do is warn, when cpu_all_mask is set
> > at registration time and replace the pointer with cpu_possible_mask.
> > 
> I like this approach than having to bitwise and with cpu_possible_mask
> at all the necessary place. I will cook up a patch.

Appreciated. I'm inclined to take it for 4.18 even. Please send it along
with the fixes for the above obvious failure spots.

Thanks,

	tglx
