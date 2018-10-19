Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE8ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CDE21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CDE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJSX3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:29:11 -0400
Received: from mout01.posteo.de ([185.67.36.141]:43846 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeJSX3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:29:11 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 19:29:10 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6DC1120DD7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 17:15:05 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 42c8br21VTz6tmH;
        Fri, 19 Oct 2018 17:15:04 +0200 (CEST)
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Richard Genoud <richard.genoud@gmail.com>
Subject: CRC errors between mvneta and macb
Message-ID: <f6ccdfbd-7a67-ae14-5940-c7614cb143e9@sorico.fr>
Date:   Fri, 19 Oct 2018 17:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been struggling with a strange behavior between a clearfog-pro
and an at91sam9g35-ek boards.

TL;DR: ethernet frames are received with a CRC error on the clearfog
ETH0, but seem perfectly all right. Add a switch between the 2
boards, and the ethernet frames are accepted.


I've got a clearfog pro and an at91sam9g35-ek, both with kernel
4.19-rc8.
An RJ45 cable is plugged between the clearfog (on the solo port (eth0))
and the g35-ek board (100Mb/s).

They are configured with autoneg and a fixed IP address.

I start the 2 board, and, with the clearfog I ping the g35-ek.
If it succeeds, it will until the g35-ek is rebooted.
If it fails, it also will until the g35-ek is rebooted.

Rebooting the cleafog doesn't change anything.
Resetting the g35-ek PHY (mii-diag -R) doesn't change anything either.

When the ping fails, it's actually because the mvneta returns a CRC
error:
mvneta f1070000.ethernet eth0: bad rx status 0cc10000 (crc error), size=66

And, if I plug the RJ45 cable between the clearfog's matrix and the
g35-ek, everything works well, always.

To ease the debugging, instead of a ping I used:
https://gist.github.com/austinmarton/1922600
from the g35-ek in order to have the same frame every time.
So, I check with the scope the ethernet CRC (on the g35-ek PHY TXD[0-1]
(DM9161A)).
And the CRC is all right.

I also manage to trigger this bug by simply doing:
rmmod macb ; insmod macb.ko on the g35-ek.
Then, frames are accepted, or not.

I checked all PHY/macb register values on the g35-ek, they are the same.

The only thing I could find is related to the TXCLK on the PHY.

When there's a CRC error, the TXCLK has its polarity inverted...
That's a clue !

But this TXCLK (25MHz) is not used on the g35-ek.
Only the REFCLK/XT2 (50MHz) is used to synchronise the PHY and the macb.
So I guess that the TXCLK has a role to play to generate TX+/TX-

And I also guess that when the signal is converted back on the clearfog,
the clock polarity is somehow responsible for the CRC errors.

I was heading to get my scope on the clearfog's PHY to see what it
received, but Marvell's documentation is not as freely available as
Atmel's ones, so I'm quite stuck at this point.

Any idea ?

NB: I also managed to trigger this with an at91sam9g20-ek (but not with
a sama5d2)


Regards,
Richard
