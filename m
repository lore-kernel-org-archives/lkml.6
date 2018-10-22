Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E379C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADFE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADFE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeJVXeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:34:24 -0400
Received: from mout01.posteo.de ([185.67.36.141]:46372 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbeJVXeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:34:23 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id DFD6A20E25
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:15:23 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 42f0Sp3vvdz6tmD;
        Mon, 22 Oct 2018 17:15:22 +0200 (CEST)
Subject: Re: CRC errors between mvneta and macb
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        netdev@vger.kernel.org
References: <f6ccdfbd-7a67-ae14-5940-c7614cb143e9@sorico.fr>
 <20181019154439.GC24045@1wt.eu>
 <c24489f6-3b9a-f26b-bc7f-b564d5567294@sorico.fr>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <31385a3b-2196-94d0-7f4f-52e37ee07a28@sorico.fr>
Date:   Mon, 22 Oct 2018 17:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c24489f6-3b9a-f26b-bc7f-b564d5567294@sorico.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/10/2018 à 08:51, Richard Genoud a écrit :
> Le 19/10/2018 à 17:44, Willy Tarreau a écrit :
>> On Fri, Oct 19, 2018 at 05:15:03PM +0200, Richard Genoud wrote:
>>> When there's a CRC error, the TXCLK has its polarity inverted...
>>> That's a clue !
>>>
>>> But this TXCLK (25MHz) is not used on the g35-ek.
>>> Only the REFCLK/XT2 (50MHz) is used to synchronise the PHY and the macb.
>>> So I guess that the TXCLK has a role to play to generate TX+/TX-
>>
>> Well, just a stupid idea, maybe when this signal is inverted, the TX+/TX-
>> are desynchronized by half a clock and are not always properly interpreted
>> on the other side ?
>>
>> Willy
>>
> 
> I must admit that I'm not familiar with the PHY internals, I'll have to
> dig into that.
> 
> Richard.
> 

I dug more on the subject, and I think I found what Marvell's PHY/MAC
doesn't like.

First of all, I forced the liaison at 10Mbits full duplex on both sides,
as the Manchester code is "easier" to decode than the 4B5B-MLT3 used for
fast ethernet.

Fortunately, the FCS errors are still present on 10Mbits/s.

After analyzing the ethernet frame on the Davicom PHY's output (pin
TX+), I find out that the FCS errors occurs when the ethernet preamble
is longer than 56bits. (something like 58 or 60 bits)

To say this in another way, instead of having 28 times 1-0 followed by
the SFD (10101011), I see 29 or 30 times 1-0 followed by the SFD.
(sometimes 29, sometimes 30)


Should a longer preamble be considered as an FCS error ? It seems a
little harsh since the point of the preamble is to synchronize the frame.

I don't know what the 802.3 standard says about that.


Regards,
Richard.
