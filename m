Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79D2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8232624051
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8232624051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeGEFDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:03:25 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:53597 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750854AbeGEFDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:03:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07753187|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03296;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CMUNGGG_1530766992;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CMUNGGG_1530766992)
          by smtp.aliyun-inc.com(10.147.42.16);
          Thu, 05 Jul 2018 13:03:12 +0800
Date:   Thu, 5 Jul 2018 13:03:12 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 18/19] clocksource: add C-SKY clocksource drivers
Message-ID: <20180705050311.GA20088@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1807031130050.1601@nanos.tec.linutronix.de>
 <20180704104957.GB23536@guoren>
 <alpine.DEB.2.21.1807041632140.1752@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807041632140.1752@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 04:35:43PM +0200, Thomas Gleixner wrote:
> On Wed, 4 Jul 2018, Guo Ren wrote:
> > On Tue, Jul 03, 2018 at 11:39:05AM +0200, Thomas Gleixner wrote:
> > > > +static inline u64 get_ccvr(void)
> > > > +{
> > > > +	u32 lo, hi, t;
> > > > +
> > > > +	do {
> > > > +		hi = mfcr(PTIM_CCVR_HI);
> > > > +		lo = mfcr(PTIM_CCVR_LO);
> > > > +		t  = mfcr(PTIM_CCVR_HI);
> > > > +	} while(t != hi);
> > > 
> > > No idea which frequency this timer ticks at, but if the 32 bit wrap does
> > > not come too fast, then you really should avoid that loop. That function is
> > > called very frequently.
> > 
> > 0000006c <clksrc_read>:
> > 		hi = mfcr(PTIM_CCVR_HI);
> >   6c:	c1c26023 	mfcr      	r3, cr<2, 14>
> > 		lo = mfcr(PTIM_CCVR_LO);
> >   70:	c1c36021 	mfcr      	r1, cr<3, 14>
> > 		t  = mfcr(PTIM_CCVR_HI);
> >   74:	c1c26022 	mfcr      	r2, cr<2, 14>
> > 	} while(t != hi);
> >   78:	648e      	cmpne      	r3, r2
> >   7a:	0bf9      	bt      	0x6c	// 6c <clksrc_read>
> > 
> > When two read cr<2, 14> is not equal, we'll retry. So only when
> > CCVR_LO is at 0xffffffff between the two read of CCVR_HI. That's very
> > very small probability event for "bt 0x6c".
> > 
> > Don't worry about the "do {...} whie(t != hi)", it's no performance issue.
> 
> But _three_ mfcr plus a conditional jump which _cannot_ be predicted are a
> performance issue. When you can replace that with a single mfcr, then you
> win a lot, really. The time keeping and the sched clock code can handle
> that nicely unless you really have fast wrap arounds on the LO word.
Timer's frequency is about 50Mhz-100Mhz and LO word wrap arounds timer is
about 42s ~ 84s.

Our Branch prediction buffer will let the CPU speculative execute
continually. So the "bt" won't be the performance issue.

And I could modify it like this:

static inline u64 get_ccvr(void)
{
	u32 lo, hi, t;

	t  = mfcr(PTIM_CCVR_LO);
	hi = mfcr(PTIM_CCVR_HI);
	lo = mfcr(PTIM_CCVR_LO);

	if (lo < t) hi++;

	return ((u64)hi << 32) | lo;
}

	t  = mfcr(PTIM_CCVR_LO);
  50:	c1c36023 	mfcr      	r3, cr<3, 14>
	hi = mfcr(PTIM_CCVR_HI);
  54:	c1c26021 	mfcr      	r1, cr<2, 14>
	lo = mfcr(PTIM_CCVR_LO);
  58:	c1c3602c 	mfcr      	r12, cr<3, 14>
	if (lo < t) hi++;
  5c:	64f0      	cmphs      	r12, r3
  5e:	c4210c21 	incf      	r1, r1, 1
	return ((u64)hi << 32) | lo;
  62:	3200      	movi      	r2, 0
 
Hmm? (No jump at all)

 Guo Ren
