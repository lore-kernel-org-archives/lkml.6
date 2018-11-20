Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377AC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EDD206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EDD206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeKUABX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:01:23 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56433 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeKUABW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:01:22 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E3F90206A1; Tue, 20 Nov 2018 14:32:10 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 99BEC2037D;
        Tue, 20 Nov 2018 14:32:10 +0100 (CET)
Date:   Tue, 20 Nov 2018 14:32:09 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     masonccyang@mxic.com.tw, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, tpiepho@impinj.com,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
Message-ID: <20181120143209.49217efb@bbrezillon>
In-Reply-To: <6b024f18-d0bc-3e65-f07c-cef913f795ab@gmail.com>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
        <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
        <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
        <OF4FAD10C5.F4F6D29B-ON4825834B.001FAB40-4825834B.00289635@mxic.com.tw>
        <6b024f18-d0bc-3e65-f07c-cef913f795ab@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 14:09:05 +0100
Marek Vasut <marek.vasut@gmail.com> wrote:

> On 11/20/2018 08:23 AM, masonccyang@mxic.com.tw wrote:
> > Hi Marek,  
> 
> Hi,
> 
> >> Marek Vasut <marek.vasut@gmail.com>
> >> 2018/11/19 下午 10:12
> >>
> >> To
> >>  
> >> > +
> >> > +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
> >> > +{
> >> > +   int ret;
> >> > +
> >> > +   if (rpc->cur_speed_hz == freq)
> >> > +      return 0;
> >> > +
> >> > +   clk_disable_unprepare(rpc->clk_rpc);
> >> > +   ret = clk_set_rate(rpc->clk_rpc, freq);
> >> > +   if (ret)
> >> > +      return ret;
> >> > +
> >> > +   ret = clk_prepare_enable(rpc->clk_rpc);
> >> > +   if (ret)
> >> > +      return ret;  
> >>
> >> Is this clock disable/update/enable really needed ? I'd think that
> >> clk_set_rate() would handle the rate update correctly.  
> > 
> > This is for run time PM mechanism in spi-mem layer and __spi_sync(),
> > you may refer to another patch [1].
> > 
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-4.21&id=b942d80b0a394e8ea18fce3b032b4700439e8ca3  
> 
> I think Geert commented on the clock topic, so let's move it there.
> Disabling and enabling clock to change their rate looks real odd to me.

Look at the CLK_SET_RATE_GATE definition and its users and you'll see
it's not unusual to have such constraints on clks. Maybe your HW does
not have such constraints, but it's not particularly odd to do that
(though it could probably be automated by the clk framework somehow).
