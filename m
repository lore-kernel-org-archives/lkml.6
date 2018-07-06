Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A138120849
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="caR3Alp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A138120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeGFGHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753177AbeGFGFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:05:50 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA9220849;
        Fri,  6 Jul 2018 06:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530857149;
        bh=cHFnizQIQa/91dRnh/ZQFa1/2p4kUY/tVBejsbkUufc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caR3Alp+CgSJ5E966mgmbnMBa7xvrn+pwGG8XXISOyjhdigFbmgKrdjOIcieSgoY2
         tryh0KBDDL6lQk0mBULiwaNRGr5fFynj9fwd2BVh9zlswQFIPPaFPtvPubO7J5e5+7
         HJmiB8GWwCAe+i2OULBg9qcsq19chYGzUTs6U1Bg=
Date:   Fri, 6 Jul 2018 11:35:41 +0530
From:   Vinod <vkoul@kernel.org>
To:     Angelo Dureghello <angelo@sysam.it>
Cc:     Stefan Agner <stefan@agner.ch>, dmaengine@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] Serial/dma stall/failure after "dmaengine: fsl-edma:
 extract common fsl-edma code (no changes in behavior intended)"
Message-ID: <20180706060541.GT22377@vkoul-mobl>
References: <CAJKOXPcVFrkEA4YV3gi-gPYhtTXHeKtv4CvL29gstfTacz2sMg@mail.gmail.com>
 <20180705073552.GI22377@vkoul-mobl>
 <20180705081253.GA3513@jerusalem>
 <20180705124526.GA3620@jerusalem>
 <7d2bc5bc8cd01347acf1858ba816b12d@agner.ch>
 <20180705162308.GB3620@jerusalem>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705162308.GB3620@jerusalem>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-18, 18:23, Angelo Dureghello wrote:
> Hi Stafan,
> 
> On Thu, Jul 05, 2018 at 05:55:31PM +0200, Stefan Agner wrote:
> > Hi Vinod, Hi Angelo,
> > 
> > On 05.07.2018 14:45, Angelo Dureghello wrote:
> > > Hi Vinod,
> > > 
> > > On Thu, Jul 05, 2018 at 10:12:53AM +0200, Angelo Dureghello wrote:
> > >> Hi Vinod,
> > >>
> > >> On Thu, Jul 05, 2018 at 01:05:52PM +0530, Vinod wrote:
> > >> > On 04-07-18, 10:54, Krzysztof Kozlowski wrote:
> > >> > > Hi,
> > >> > >
> > >> > > The commit 6ad069123f03bebe4315dea13d44845854ca6043 ("dmaengine:
> > >> > > fsl-edma: extract common fsl-edma code (no changes in behavior
> > >> > > intended)"), even though marked as no changes in behavior intended...
> > >> > > make serial console with DMA broken after boot. The console just hangs
> > >> > > - is not responsive even to SysRq. Usually after finishing boot -
> > >> > > before or after login prompt. Sometimes login is allowed and then it
> > >> > > hangs during printing dmesg.
> > >> > >
> > >> > > Board: Toradex Colibri VF50 (NXP VF500, Cortex A5, serial configured
> > >> > > with DMA) on Iris Carrier.
> > >> >
> > >> > Angelo ?
> > >> >
> > >> sorry for this. As said i couldn't test it in any of those arm boards
> > >> but i take a look.
> > >>
> > >> The only code part that changes is the initial setting up of the registers.
> > >> I am checking that.
> > >>
> > >> Regards,
> > >> Angelo
> > >>
> > > 
> > > I cannot find anything obviously wrong.
> > > And i cannot test on Vybrid.
> > > I will try to get a Vybrid V50 board to test this issue. It would
> > > require some days and also i wil be 3 weeks off on July.
> > > 
> > > So please revert my patch. 
> > 
> > I did not found the issue quickly. But I must say that I gave up pretty
> > quickly. There are too many changes in a single patch which makes it
> > hard to figure out what could be wrong. I'd rather prefer if we could
> > drop that patch again and go through another review phase.
> > 
> > Angelo, as far as I can see the patch has not been sent to LKML or the
> > ARM mailing list. Especially since you do not have such a device it
> > would have been nice to also send it to the ARM mailing list...
> > 
> > Can you resend your last revision with CC to me/ARM mailing list?
> > 
> 
> Thanks for looking into it.
> 
> I have spent a lot of time on this patch and really would have 
> dma for Coldfire available. So, have ordered a Colibri / v50 board.
> 
> Should receive it in few days and should be able to debug this issue, 
> but as said, i will be off for some weeks so looks like it is probably
> better to revert the patch.
> 
> My initial submit was a separate driver, to avoid such issues where
> i cannot test, but it resulted in too much duplicated code.
> 
> Sure, i can send the full patch to you/arm with all the fixes included
> until now.

Okay dropped now from -next. I still keeping topic/fsl around and
collect other fixes for you guys to check.

One way would be to split to common patch into multiple patch and check
regression. That should help quickly identify the issue.

-- 
~Vinod
