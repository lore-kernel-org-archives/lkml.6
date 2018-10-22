Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E31C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BE4205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BE4205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeJWAzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:55:08 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35402 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbeJWAzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:55:08 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w9MGYTM4022842;
        Mon, 22 Oct 2018 18:34:29 +0200
Date:   Mon, 22 Oct 2018 18:34:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Richard Genoud <richard.genoud@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        netdev@vger.kernel.org
Subject: Re: CRC errors between mvneta and macb
Message-ID: <20181022163429.GA22826@1wt.eu>
References: <f6ccdfbd-7a67-ae14-5940-c7614cb143e9@sorico.fr>
 <20181019154439.GC24045@1wt.eu>
 <c24489f6-3b9a-f26b-bc7f-b564d5567294@sorico.fr>
 <31385a3b-2196-94d0-7f4f-52e37ee07a28@sorico.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31385a3b-2196-94d0-7f4f-52e37ee07a28@sorico.fr>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 05:15:21PM +0200, Richard Genoud wrote:
> After analyzing the ethernet frame on the Davicom PHY's output (pin
> TX+), I find out that the FCS errors occurs when the ethernet preamble
> is longer than 56bits. (something like 58 or 60 bits)
> 
> To say this in another way, instead of having 28 times 1-0 followed by
> the SFD (10101011), I see 29 or 30 times 1-0 followed by the SFD.
> (sometimes 29, sometimes 30)
> 
> 
> Should a longer preamble be considered as an FCS error ? It seems a
> little harsh since the point of the preamble is to synchronize the frame.

That indeed seems a bit strange considering that you're not supposed to
know what is before the preamble so it would very well contain random
noise looking a lot like alteranted bits.

> I don't know what the 802.3 standard says about that.

Just found it :-)

     https://www.trincoll.edu/Academics/MajorsAndMinors/Engineering/Documents/IEEE%20Standard%20for%20Ethernet.pdf

Page 132, #7.2.3.2 :

    The DTE is required to supply at least 56 bits of preamble in
    order to satisfy system requirements. System components consume
    preamble bits in order to perform their functions. The number
    of preamble bits sourced ensures an adequate number of bits are
    provided to each system component to correctly implement its
    function.

So that totally makes sense since the purpose is to enable signal
detection at the hardware leve, hence the problem definitely is on
the receiver in your case.

Willy
