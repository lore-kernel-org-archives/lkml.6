Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F3B2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jHJf0BOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F3B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbeK0Wsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:48:52 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:38006 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeK0Wsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:48:52 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5EB2310C0EAD;
        Tue, 27 Nov 2018 03:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543319473; bh=CqWTuvOUNaWe1aqKHQT21C1KgEuEBx4kR7UCiblxfYU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=jHJf0BOuxTyqyiLnJ5nnYQqDofmWFk2TFGKkx54MPegjVokZKw6Z2GHp4dKEQCxVI
         YBxwch0aIp/cN3DLpsynfcYaezj/LR8WOpyT3WL0OVVD2HIvtjIoCNvKsbHE7QThGf
         M6atfznjJtI7IBCI4uBN8vybEWZJz53G6W84WxkaUQKX3rxe40E77qDweHlwwwj6X5
         fPb7Xfu3rn4sTzycdEbxXkA9hUP2uSf1/Y2Ep1QFoQ59n1b0siWNK04GpFvKcrKQp4
         6ucKTh/r2wxpMZHYDbNvW+iRhyC/EF93Y69l498nGIW48H/GOCOHmBiVKPM47HQrpF
         3q8pu9hmqWIyA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0B86D3271;
        Tue, 27 Nov 2018 03:51:10 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 27 Nov 2018 03:51:09 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 27 Nov 2018 12:51:07 +0100
Received: from [10.0.2.15] (10.107.19.128) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 27 Nov
 2018 12:51:07 +0100
Subject: Re: [PATCH] i3c: master: dw: split dw-i3c-master.c into master and
 bus specific parts
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <vitor.soares@synopsys.com>
CC:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <psroka@cadence.com>, <agolec@cadence.com>,
        <adouglas@cadence.com>, <bfolta@cadence.com>, <dkos@cadence.com>,
        <alicja@cadence.com>, <cwronka@cadence.com>, <sureshp@cadence.com>,
        <rafalc@cadence.com>, <thomas.petazzoni@bootlin.com>, <nm@ti.com>,
        <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <geert@linux-m68k.org>, <linus.walleij@linaro.org>,
        <Xiang.Lin@synaptics.com>, <linux-gpio@vger.kernel.org>,
        <nsekhar@ti.com>, <pgaj@cadence.com>, <peda@axentia.se>,
        <mshettel@codeaurora.org>, <swboyd@chromium.org>,
        <joao.pinto@synopsys.com>
References: <ade2c1a8d1eb48681b01ccdc9bed22caf5e96c4b.1542904564.git.soares@synopsys.com>
 <20181122210202.6af50fcc@bbrezillon>
 <6d513e04-3a57-1989-429c-64631101c5a2@synopsys.com>
 <20181123135004.7fd1cd58@bbrezillon>
 <83115f47-1326-cb33-a7dc-4bc8ff95befa@synopsys.com>
 <20181126133550.51469816@bbrezillon>
 <4e9c0461-02a3-80b2-c9b7-2e9ea9b38f8b@synopsys.com>
 <20181126195618.352eafb1@bbrezillon>
 <4c743a9a-d636-d34c-b7e3-913f18e6c754@synopsys.com>
 <20181126223334.08105d89@bbrezillon>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <0912ea50-b365-d583-9d33-1dff236acbad@synopsys.com>
Date:   Tue, 27 Nov 2018 11:50:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126223334.08105d89@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.128]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

On 26/11/18 21:33, Boris Brezillon wrote:
> On Mon, 26 Nov 2018 20:11:39 +0000
> vitor <vitor.soares@synopsys.com> wrote:
>
> Look at the bus discovery mechanism, the notion of DCR (close to the
> concept of USB class), or the fact that each dev has a unique
> manufacturer+PID pair (which resemble the product/vendor ID concept)
> that allows us to easily bind a dev to a driver without requiring a
> static description.


The major feature close to USB is this one and it can be found in others 
protocols (standardization process).

Just to close this topic I3C vs USB, IMO it's wrong to pass the message 
that the I3C is closer to USB than I2C even more because I3C support the 
I2C on the fly.


>
>>
>> I'm not sure but I think that a controller cannot change between gadget
>> to host in USB in runtime.
> That's called USB OTG. Okay, to be fair, it's not exactly the same, and
> the mastership handover in I3C is probably more complex than what we
> have with USB OTG (I'm not a USB expert, so I might be wrong here).
>
>> Even so, this kind of behavior is more likely
>> to have in an I3C bus.
> Maybe.


Sorry, with the proliferation of sensors I cannot see a multi master 
sensor network based on USB.


>> Sorry for that and don't take me wrong... maybe I should rise this
>> question early but this only came up now when I started splitting and
>> thinking where to put what is for master for slave, what is common and
>> the thing of putting everything of controller in a folder.
> So you have such a dual-role controller?


Yes, we already talked about secondary master support.


> What I call a slave controller would be something that lets you reply to
> SDR/DDR transactions or fill a generic regmap that would be exposed to
> other masters on the bus. This way we could implement generic slave
> drivers in Linux (the same way we have gadget drivers). Anything else
> is likely to be to specific to be exposed as a generic framework.


I would bet to do something like in i2c, we don't need the same level of 
complexity found in USB.


>>
>> Taking the USB as exemple do you prefer a dwc folder on i3c root?
> Hm, not sure I like this idea either. So I see 2 options:
>
> 1/ put all controller drivers (both master and slave ones) in a common
>     directory (drivers/i3c/controllers) as you suggest, and prefix them
>     correctly (i3c-master-<ip>.c, i3c-slave-<ip>.c and i3c-dual-<ip>.c)


I agree with the controller folder but not with prefix. Please check 
what is already in the kernel.


> 2/ place them in separate directories: drivers/i3c/{master,slave,dual}
>
> I'm fine either way.


In this case and taking what is already in the kernel it will be 
drivers/i3c/{master, slave, dwc, other with the same architecture as dwc}.


>>> I'm okay changing it, but I want to understand why the proposed
>>> separation is not good.
>>
>> I already tell you my use case and as I said maybe someone can advise :)
>>
> I think I understand your concerns now, but only because you started to
> mention a few things that were not clearly stated before (at least, I
> didn't understand it this way), like the fact that your controller (and
> probably others too) supports dual-role, or the fact that you plan to
> expose your IP through the PCI bus.


I miss to mention PCI but since the beginning refer the slave and the 
common part.

Splitting the driver is something that soon or later I will have to do. 
If you prefer later I'm ok with that.


I think this discussion is starting to be counterproductive with arguing 
of both parts. Unfortunately I don't see anyone given their inputs too.

To be clear, the subsystem is nice and I working with daily. As I said 
this is something that I dealing now and I'm telling what I think that 
is not correct.

