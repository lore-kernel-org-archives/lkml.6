Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFADAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659D020856
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659D020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeH2O1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:27:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47884 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeH2O1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:27:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AC8372079D; Wed, 29 Aug 2018 12:31:15 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 37528203EC;
        Wed, 29 Aug 2018 12:31:15 +0200 (CEST)
Date:   Wed, 29 Aug 2018 12:31:14 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>, <linux-mtd@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [RFC PATCH v2 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20180829123114.4b67314b@bbrezillon>
In-Reply-To: <5061c929-8db0-3f4c-ec34-303fc351dfdd@amlogic.com>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
        <20180719094612.5833-3-yixun.lan@amlogic.com>
        <20180801235045.5b4d8211@bbrezillon>
        <42877a0d-9830-0626-3f64-e49a326eaa3c@amlogic.com>
        <20180817155608.5929b37a@bbrezillon>
        <96e538a5-1232-11f2-8b9e-5ddb09dcc2de@amlogic.com>
        <20180824144810.31c929a5@bbrezillon>
        <fdea2d54-7a68-64ec-8bb4-4a94677a3293@amlogic.com>
        <20180828152645.457dab5c@bbrezillon>
        <9abf0461-159b-db45-9ded-3d6cb2cc64db@amlogic.com>
        <5061c929-8db0-3f4c-ec34-303fc351dfdd@amlogic.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 18:29:05 +0800
Liang Yang <liang.yang@amlogic.com> wrote:

> On 8/29/2018 6:08 PM, Liang Yang wrote:
> > 
> > On 8/28/2018 9:26 PM, Boris Brezillon wrote:  
> >> On Tue, 28 Aug 2018 21:21:48 +0800
> >> Liang Yang <liang.yang@amlogic.com> wrote:
> >>  
> >>> Hi Boris,
> >>>
> >>> On 8/24/2018 8:48 PM, Boris Brezillon wrote:  
> >>>> On Wed, 22 Aug 2018 22:08:42 +0800
> >>>> Liang Yang <liang.yang@amlogic.com> wrote:  
> >>>>>> You have to wait tWB, that's for sure.  
> >>>>> we have a maximum 32 commands fifo. when command is written into
> >>>>> NFC_REG_CMD, it doesn't mean that command is executing right now, 
> >>>>> maybe
> >>>>> it is buffering on the queue.Assume one ERASE operation, when 2nd
> >>>>> command(0xd0) is written into NFC_REG_CMD and then come into
> >>>>> NAND_OP_WAITRDY_INSTR, if I read the RB status by register, it may be
> >>>>> wrong because 0xd0 may not being executed. it is unusual unless
> >>>>> buffering two many command.  
> >>>>
> >>>> You should flush the queue and wait for it to empty at the end of  
> >>>> ->exec_op().
> >>>>> so it seems that i still need to use nand_soft_waitrdy or wait cmd is
> >>>>> executed somewhere.  
> >>>>
> >>>> Don't you have a WAIT_FOR_RB instruction? What is NFC_CMD_RB for? Also,
> >>>> NFC_CMD_IDLE seems to allow you to add an arbitrary delay, and that's
> >>>> probably what you should use for tWB.
> >>>>
> >>>> em, I can wait for RB by reading the status from register now. but when  
> >>> calling nand_soft_waitrdy, i really met a problem. One *jiffies* is
> >>> about 4ms. When programming, it pass 1ms to
> >>> instr->ctx.waitrdy.timeout_ms and nand_soft_waitrdy will be only one
> >>> *jiffies* to reach timeout. And then calling nand_soft_waitrdy maybe at
> >>> the tail of 4ms interval, it may only wait 100us and next jiffies
> >>> arrive. Is it correct?  
> >>
> >> Hm, no. If you initialize the time you compare to (using time_before()
> >> or time_after()) correctly it should not happen. Anyway, I keep thinking
> >> this is not how it should be done. Did you try NFC_CMD_RB? Did you ask
> >> HW designers what it was created for?
> >>  
> > I am using NFC_CMD_RB and checking with irq. it is ok now.  
> there are two usages for NFC_CMD_RB. One reads the data status 
> continuously by hardware after sending 0x70 command; the other checks 
> the r/b IO status continuously.both can send irq when r/b is ready.

Both should do what you expect, so I guess you're good.
