Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0A5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7437E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7437E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbeGaQCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:02:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59844 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732222AbeGaQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:02:54 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkVXT-0005ZO-Ro; Tue, 31 Jul 2018 16:22:16 +0200
Date:   Tue, 31 Jul 2018 16:22:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xu YiPing <xuyiping@hisilicon.com>
cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timers: fix offset calculation when the expires align
 with LVL_GRAN
In-Reply-To: <c68d9944-1fcc-dcd5-1e3d-07f979323b8c@hisilicon.com>
Message-ID: <alpine.DEB.2.21.1807311616480.1610@nanos.tec.linutronix.de>
References: <1532669610-103892-1-git-send-email-xuyiping@hisilicon.com> <alpine.DEB.2.21.1807301234310.2518@nanos.tec.linutronix.de> <c68d9944-1fcc-dcd5-1e3d-07f979323b8c@hisilicon.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018, Xu YiPing wrote:
> On 2018/7/30 19:03, Thomas Gleixner wrote:
> >
> > __internal_add_timer(base, timer)
> > {  
> >    idx = calc_wheel_index(1, 1)
> >        {
> >            delta = 1 - 1;	<-   0
> > 
> >            if (0 < LVL_START(1))
> >                idx = calc_index(1, 0)
> >                     {
> >                         expires = (1 + LVL_GRAN(0) - 1) >> LVL_SHIFT(0);
> > 			----> expires = 0
> 			
> 			LVL_GRAN(0) = 1 and LVL_SHIFT(0) = 0
> 			
> 			after the calculation, expires = 1 ?

Indeed. You're right. Math is hard... So the index would be 1 and still not
fulfil the below:
 
> >       mod_timer(timer, jiffies + 1)
> > 
> > will not fire before aty least one jiffy has elapsed. Let's look at the
> > time line:
> > 
> >    |-------------------|-------------------|----------------|
> >   tick               tick                tick
> >  jiffies	   jiffies + 1        jiffies + 2
> > 
> >    |                   |
> >    |  Any timer armed  |                   ^
> >    |  here must be     |                   |
> >    |  queued here -------------------------|
> > 
> > in order to guarantee that. Timer wheel timers are not accurate and never
> > can be.

Thanks,

	tglx
