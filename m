Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA00FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E282250A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E282250A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeGDOft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:35:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47794 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeGDOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:35:47 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faisi-0000FP-7g; Wed, 04 Jul 2018 16:35:44 +0200
Date:   Wed, 4 Jul 2018 16:35:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Guo Ren <ren_guo@c-sky.com>
cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 18/19] clocksource: add C-SKY clocksource drivers
In-Reply-To: <20180704104957.GB23536@guoren>
Message-ID: <alpine.DEB.2.21.1807041632140.1752@nanos.tec.linutronix.de>
References: <cover.1530465325.git.ren_guo@c-sky.com> <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com> <alpine.DEB.2.21.1807031130050.1601@nanos.tec.linutronix.de> <20180704104957.GB23536@guoren>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Guo Ren wrote:
> On Tue, Jul 03, 2018 at 11:39:05AM +0200, Thomas Gleixner wrote:
> > > +static inline u64 get_ccvr(void)
> > > +{
> > > +	u32 lo, hi, t;
> > > +
> > > +	do {
> > > +		hi = mfcr(PTIM_CCVR_HI);
> > > +		lo = mfcr(PTIM_CCVR_LO);
> > > +		t  = mfcr(PTIM_CCVR_HI);
> > > +	} while(t != hi);
> > 
> > No idea which frequency this timer ticks at, but if the 32 bit wrap does
> > not come too fast, then you really should avoid that loop. That function is
> > called very frequently.
> 
> 0000006c <clksrc_read>:
> 		hi = mfcr(PTIM_CCVR_HI);
>   6c:	c1c26023 	mfcr      	r3, cr<2, 14>
> 		lo = mfcr(PTIM_CCVR_LO);
>   70:	c1c36021 	mfcr      	r1, cr<3, 14>
> 		t  = mfcr(PTIM_CCVR_HI);
>   74:	c1c26022 	mfcr      	r2, cr<2, 14>
> 	} while(t != hi);
>   78:	648e      	cmpne      	r3, r2
>   7a:	0bf9      	bt      	0x6c	// 6c <clksrc_read>
> 
> When two read cr<2, 14> is not equal, we'll retry. So only when
> CCVR_LO is at 0xffffffff between the two read of CCVR_HI. That's very
> very small probability event for "bt 0x6c".
> 
> Don't worry about the "do {...} whie(t != hi)", it's no performance issue.

But _three_ mfcr plus a conditional jump which _cannot_ be predicted are a
performance issue. When you can replace that with a single mfcr, then you
win a lot, really. The time keeping and the sched clock code can handle
that nicely unless you really have fast wrap arounds on the LO word.

Thanks,

	tglx


