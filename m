Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B66C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DC320665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DC320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sorico.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeJWPZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:25:23 -0400
Received: from mout02.posteo.de ([185.67.36.142]:35437 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbeJWPZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:25:22 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2018 11:25:21 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 3F6182400FD
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:56:10 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 42fPLJ1jnsz9rxK;
        Tue, 23 Oct 2018 08:56:07 +0200 (CEST)
Subject: Re: CRC errors between mvneta and macb
To:     Willy Tarreau <w@1wt.eu>, Richard Genoud <richard.genoud@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
References: <f6ccdfbd-7a67-ae14-5940-c7614cb143e9@sorico.fr>
 <20181019154439.GC24045@1wt.eu>
 <c24489f6-3b9a-f26b-bc7f-b564d5567294@sorico.fr>
 <31385a3b-2196-94d0-7f4f-52e37ee07a28@sorico.fr>
 <20181022163429.GA22826@1wt.eu>
From:   Richard Genoud <richard@sorico.fr>
Message-ID: <b0ff037c-e32b-6f47-e108-5daefff9b42a@sorico.fr>
Date:   Tue, 23 Oct 2018 08:56:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181022163429.GA22826@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/10/2018 à 18:34, Willy Tarreau a écrit :
> On Mon, Oct 22, 2018 at 05:15:21PM +0200, Richard Genoud wrote:
>> After analyzing the ethernet frame on the Davicom PHY's output (pin
>> TX+), I find out that the FCS errors occurs when the ethernet preamble
>> is longer than 56bits. (something like 58 or 60 bits)
>>
>> To say this in another way, instead of having 28 times 1-0 followed by
>> the SFD (10101011), I see 29 or 30 times 1-0 followed by the SFD.
>> (sometimes 29, sometimes 30)
>>
>>
>> Should a longer preamble be considered as an FCS error ? It seems a
>> little harsh since the point of the preamble is to synchronize the frame.
> 
> That indeed seems a bit strange considering that you're not supposed to
> know what is before the preamble so it would very well contain random
> noise looking a lot like alteranted bits.
> 
>> I don't know what the 802.3 standard says about that.
> 
> Just found it :-)
> 
>      https://www.trincoll.edu/Academics/MajorsAndMinors/Engineering/Documents/IEEE%20Standard%20for%20Ethernet.pdf
> 
> Page 132, #7.2.3.2 :
> 
>     The DTE is required to supply at least 56 bits of preamble in
>     order to satisfy system requirements. System components consume
>     preamble bits in order to perform their functions. The number
>     of preamble bits sourced ensures an adequate number of bits are
>     provided to each system component to correctly implement its
>     function.
> 
> So that totally makes sense since the purpose is to enable signal
> detection at the hardware leve, hence the problem definitely is on
> the receiver in your case.
> 
> Willy
> 
Great ! Thanks !
I'll check on the Marvell side

Richard
