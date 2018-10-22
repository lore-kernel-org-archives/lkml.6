Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7F6C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2746720645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vFQI9JLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2746720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeJWCjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:39:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40462 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbeJWCjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=X2MjUn5SdTxwbjQ7NS4UuOUNhjuzvI6CH3UTbd6MP5Q=;
        b=vFQI9JLmGhAV7soC++/8Io3SdVaal+DHRZjLnWCYaxjjY29RT3oGYknoIfbBO56vLxeNCn+Dvoxt97dH8IoIAqBb6Y4fXi5hilzzMh3qkaRbuVvyQ2Rd1UWEYIGKDboJ5YjmzQcb+7Bx/Bgrz6xalO5YCRG2gTrODWaQvz/2U84=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gEenO-0000bB-8o; Mon, 22 Oct 2018 20:19:18 +0200
Date:   Mon, 22 Oct 2018 20:19:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Richard Genoud <richard.genoud@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        netdev@vger.kernel.org
Subject: Re: CRC errors between mvneta and macb
Message-ID: <20181022181918.GF24112@lunn.ch>
References: <f6ccdfbd-7a67-ae14-5940-c7614cb143e9@sorico.fr>
 <20181019154439.GC24045@1wt.eu>
 <c24489f6-3b9a-f26b-bc7f-b564d5567294@sorico.fr>
 <31385a3b-2196-94d0-7f4f-52e37ee07a28@sorico.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31385a3b-2196-94d0-7f4f-52e37ee07a28@sorico.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I dug more on the subject, and I think I found what Marvell's PHY/MAC
> doesn't like.

Hi Richard

What PHY is being used?

> After analyzing the ethernet frame on the Davicom PHY's output (pin
> TX+), I find out that the FCS errors occurs when the ethernet preamble
> is longer than 56bits. (something like 58 or 60 bits)

Some Marvell PHYs have a register bit which might be of interest: Page
2, register 16, bit 6.

0 = Pad odd nibble preambles in copper receive packets.
1 = Pass as is and do not pad odd nibble preambles in

  Andrew
