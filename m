Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4D0C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E62D2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E62D2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeKHQWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:22:20 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42722 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKHQWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:22:20 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKe6y-0006ji-VV; Thu, 08 Nov 2018 07:48:17 +0100
Date:   Thu, 8 Nov 2018 07:48:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        stable@vger.kernel.org, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH stable 4.9] posix-timers: Sanitize overrun handling
In-Reply-To: <6341cf9e-b2aa-9447-88e9-ad89ab42a641@gmail.com>
Message-ID: <alpine.DEB.2.21.1811080747450.1666@nanos.tec.linutronix.de>
References: <1541102558-14839-1-git-send-email-f.fainelli@gmail.com> <6341cf9e-b2aa-9447-88e9-ad89ab42a641@gmail.com>
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

Florian,

On Wed, 7 Nov 2018, Florian Fainelli wrote:
> On 11/1/18 1:02 PM, Florian Fainelli wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > [ Upstream commit 78c9c4dfbf8c04883941445a195276bb4bb92c76 ]
> > 
> > The posix timer overrun handling is broken because the forwarding functions
> > can return a huge number of overruns which does not fit in an int. As a
> > consequence timer_getoverrun(2) and siginfo::si_overrun can turn into
> > random number generators.
> > 
> > The k_clock::timer_forward() callbacks return a 64 bit value now. Make
> > k_itimer::ti_overrun[_last] 64bit as well, so the kernel internal
> > accounting is correct. 3Remove the temporary (int) casts.
> > 
> > Add a helper function which clamps the overrun value returned to user space
> > via timer_getoverrun(2) or siginfo::si_overrun limited to a positive value
> > between 0 and INT_MAX. INT_MAX is an indicator for user space that the
> > overrun value has been clamped.
> > 
> > Reported-by: Team OWL337 <icytxw@gmail.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: John Stultz <john.stultz@linaro.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> > Link: https://lkml.kernel.org/r/20180626132705.018623573@linutronix.de
> > [florian: Make patch apply to v4.9.135]
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> > Thomas, can you review for correctness? Thanks!
> 
> Thomas, John, does that look like a reasonable backport for 4.9?

Looks correct.

Thanks,

	tglx
