Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E453AC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940E12087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VRbcrFhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940E12087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLDAep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:34:45 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:55626 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLDAeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:34:44 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D879410C0D9D;
        Mon,  3 Dec 2018 16:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543883683; bh=HxEWwKUr3cxjBM6M14wChG45B2lBPcmcP3Yu7mHlwyw=;
        h=From:Subject:To:CC:References:Date:In-Reply-To:From;
        b=VRbcrFhuQB23FQKRDLCQ0i8MilD7gN1xBoVGC3YnI1a879gJA1+eK1joBVwmtLijV
         +m9MQKJC9gwl2oC2zYl+uWZb1rXyuK/5XQXhpkb3UKqNT0Q75j9CaBD/zAiQFkLvl+
         uoCayvMOC6af13d3enj4fTUE9gE5sz/EY485W826bRNtnvUJ1VXYwD3O3QvYFZ+Muf
         RCuibbBQa20adu+JnKLKOWu/MT8TnBWbhqTMvx5EQli09Qd06aFdZVTL8Nye8nEDQg
         95lDM3R6gbwolVvzdPEEJnMtvo9CrVKUOGymSceakHK/6EHij8nH34laU0XMoL0JeZ
         RAxLMmPBY4B+w==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id E78D73778;
        Mon,  3 Dec 2018 16:34:39 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Dec 2018 16:34:39 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 01:34:37 +0100
Received: from [10.0.2.15] (10.225.2.138) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Dec
 2018 01:34:36 +0100
From:   vitor <vitor.soares@synopsys.com>
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
 <0912ea50-b365-d583-9d33-1dff236acbad@synopsys.com>
 <20181127133350.0361f998@bbrezillon>
Message-ID: <623809f3-1d1f-a10c-783a-07b545c5955c@synopsys.com>
Date:   Tue, 4 Dec 2018 00:34:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127133350.0361f998@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.225.2.138]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


Sorry for the delayed response.


On 27/11/18 12:33, Boris Brezillon wrote:
> Hi Vitor,
>
> On Tue, 27 Nov 2018 11:50:53 +0000
> vitor<vitor.soares@synopsys.com>  wrote:
>
>
>>>> Sorry for that and don't take me wrong... maybe I should rise this
>>>> question early but this only came up now when I started splitting and
>>>> thinking where to put what is for master for slave, what is common and
>>>> the thing of putting everything of controller in a folder.
>>> So you have such a dual-role controller?
>> Yes, we already talked about secondary master support.
> There's a difference between a secondary master that waits for its time
> to become the currrent master, and a secondary master that provides I3C
> device features when it's acting as a slave (sensor, GPIO
> controller, ...). So far we focused on supporting the former. If
> there's a need for the latter, then we should start thinking about the
> slave framework...
>
>>> What I call a slave controller would be something that lets you reply to
>>> SDR/DDR transactions or fill a generic regmap that would be exposed to
>>> other masters on the bus. This way we could implement generic slave
>>> drivers in Linux (the same way we have gadget drivers). Anything else
>>> is likely to be to specific to be exposed as a generic framework.
>> I would bet to do something like in i2c, we don't need the same level of
>> complexity found in USB.
> Can you detail a bit more what you have in mind? I don't think we can
> do like I2C, simply because we need to expose a valid DCR +
> manuf-ID/PID so that other masters can bind the device to the
> appropriate driver on their side. Plus, if we're about to expose
> generic profiles, we likely don't want each I3C slave controller driver
> to do that on its own.


I think this should be discuss in another thread. Do you agree?


>>>> Taking the USB as exemple do you prefer a dwc folder on i3c root?
>>> Hm, not sure I like this idea either. So I see 2 options:
>>>
>>> 1/ put all controller drivers (both master and slave ones) in a common
>>>      directory (drivers/i3c/controllers) as you suggest, and prefix them
>>>      correctly (i3c-master-<ip>.c, i3c-slave-<ip>.c and i3c-dual-<ip>.c)
>> I agree with the controller folder but not with prefix. Please check
>> what is already in the kernel.
> If we mix everything in the same subdir, I'd like to have an easy way
> to quickly identify those that are slave controllers and those that are
> master controllers. For the dual-role thing, maybe we can consider them
> as master (ones with advances slave features).
>
> Would you be okay with drivers/i3c/controllers/{designware,dw}/..., so
> that you can have all designware drivers (for both slave and master
> blocks) in the same dir?


Yes, that was what I trying to tell you. For me this might be the best 
option.

I would like to avoid having dual role i3c driver in a master folder.


> For those that are placed directly under drivers/i3c/controllers/...
> (because they only have one .c file), I'd like to keep a standard
> prefix.


I don't disagree, and for those that have more than one file they should 
be in a folder, right?

What prefix do you have in mind for those files inside a folder?


>> To be clear, the subsystem is nice and I working with daily. As I said
>> this is something that I dealing now and I'm telling what I think that
>> is not correct.
>>
> Come on! All I've seen so far are complaints on tiny details, it
> definitely doesn't prevent you from adding new features.
>
> Regards,
>
> Boris


No, it's not. But as you can see to slipt the driver in parts this 
subject has some relevance.


Best regards,

Vitor Soares


