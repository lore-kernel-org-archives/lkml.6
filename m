Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E9EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7DA20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jdUeR+tZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7DA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeK0F2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:28:55 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:60096 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0F2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:28:54 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CBD6210C0839;
        Mon, 26 Nov 2018 10:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543257236; bh=U9/C0lCB/UWMi+y9hNx5bwcwcyhj+qKgNkRakuG0JXs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=jdUeR+tZfgnOGW6ecM5qxNBpmA48Qa2sIhn4E6s71RXxNR5WFLUrt7s9HiZm7+rDz
         CnElnnaAWm5g4x4jvvtO1UsatVXVE1b6zf69q1DLAsGv+M74qBAkzd/yERD4n19PfG
         C12AutmF9rng6JRoHIFms0Hx0JGHw4WOTcTLBCUXMWzowkKldynCAqp+DtyBVD2UgS
         jIbxY6VYQ7D/U4JWzI6jmbs46WY0Aqnz0fTmnZtrE0j6Pe9GMiG6ogndj+cg5OnlLo
         fjnk5jhTU0CsgVhv534Qzvj9RO94x0SaU6ALapWHZHbaAiXc1evLNH2GszUDsIv0bZ
         a1fYj7Ap45FlQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8CF363DD5;
        Mon, 26 Nov 2018 10:33:53 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 26 Nov 2018 10:33:53 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 26 Nov 2018 19:33:51 +0100
Received: from [10.0.2.15] (10.107.19.169) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 26 Nov
 2018 19:33:51 +0100
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
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <4e9c0461-02a3-80b2-c9b7-2e9ea9b38f8b@synopsys.com>
Date:   Mon, 26 Nov 2018 18:33:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126133550.51469816@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.107.19.169]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/11/18 12:35, Boris Brezillon wrote:
> On Mon, 26 Nov 2018 12:06:24 +0000
> vitor <vitor.soares@synopsys.com> wrote:
>
>> Hi Boris,
>>
>>
>> On 23/11/18 12:50, Boris Brezillon wrote:
>>> On Fri, 23 Nov 2018 12:39:31 +0000
>>> vitor <vitor.soares@synopsys.com> wrote:
>>>   
>>>> Hi Boris,
>>>>
>>>>
>>>> On 22/11/18 20:02, Boris Brezillon wrote:
>>>>> On Thu, 22 Nov 2018 17:54:54 +0000
>>>>> Vitor Soares <vitor.soares@synopsys.com> wrote:
>>>>>      
>>>>>> From: Vitor Soares <soares@synopsys.com>
>>>>>>
>>>>>> This patch slipts dw-i3c-master.c into three pieces:
>>>>>> 	dw-i3c-master.c - contains the code that interacts directly with the
>>>>>> 	core in master mode.
>>>>>>
>>>>>> 	dw-i3c-platdrv.c - contains the code specific to the platform driver.
>>>>>>
>>>>>> 	dw-i3c-core.h - contains the definitions and declarations shared by
>>>>>> 	dw-i3c-master and dw-i3c-platdrv
>>>>>>
>>>>>> This patch will allow SOC integrators to add their code specific to
>>>>>> DesignWare I3C IP.
>>>>> Isn't it too early to do this change? Can't we wait until we have a SoC
>>>>> that actually embeds this IP?
>>>> I'm trying to turn it more flexible so the other can reuse the code.
>>> Looking at the separation you've done here, I don't see why you need
>>> it. All the resources you request are generic, so why not just adding a
>>> new compat in the of_match_table?
>> I understand your point.
>>
>>
>> I'm just following what it's done in others Synopsys drivers and what I
>> expect is that in the future we will have the same for the I3C.
>>
>> Some of the current generic functions might be override according with
>> SoC requirements (e.g i2c-designware, pcie-designware).
>>
>>
>> for now what do you prefer?
>>
> I prefer that we keep the driver as is until we actually need to split
> things up.

This is already done and will benefit everyone:

     - for me is better do it now than the secondary master and slave 
development.

     - for the others it will easy the SoC integration avoiding 
duplicated work and doing things from scratch.


>
>>>>   
>>>>>      
>>>>>> Signed-off-by: Vitor Soares <soares@synopsys.com>
>>>>>> ---
>>>>>>     drivers/i3c/master/Kconfig          |   9 +-
>>>>>>     drivers/i3c/master/Makefile         |   5 +-
>>>>>>     drivers/i3c/master/dw-i3c-core.h    | 214 ++++++++++++++++++++++++++
>>>>>>     drivers/i3c/master/dw-i3c-master.c  | 299 ++----------------------------------
>>>>>>     drivers/i3c/master/dw-i3c-platdrv.c | 112 ++++++++++++++
>>> Just realized the driver is named dw-i3c-master, while the cadence
>>> driver is named i3c-master-cdns.c. I'll send a patch to make that
>>> consistent and follow the initial naming scheme: i3c-master-<ipname>.c.
>> As I shared with you in previous email, the structure that I have in
>> mind is this one:
>>
>> - core.h (or common.h, any though?)
>>
>> - common.c
>>
>> - master.c
>>
>> - slave.c
>>
>>
>> so for me doesn't make sense to have for instance: i3c-master-dw-slave.c
> If you have several files and they're all placed in a dw/ subdir, then
> I agree, prefixing everything with i3c-master- is useless, as you'll
> have to define a custom rule to create the i3c-master-dw.ko object.
>
> When there's a single source file, and this source file is directly
> used to create a .ko, we need this prefix, otherwise we would have
> dw.ko, and this would basically conflict with any other designware
> driver that does not have a proper prefix.
>
>> But seeing what is already in the kernel I wasn't coherent and it should
>> be named to i3c-designware-master.c
> Actually it's i3c-master-designware.c (or i3c-master-dw.c) if we follow
> what's been done for the cadence driver.
>

I was referring to what was made in other modules and should be applied 
here too.


>>
>> or
>>
>>
>> follow this https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2017_7_12_430&d=DwICAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=9fGCPbkiqaG2-CJ5qrOU2Os6ZcstSNxi7UbQiF9YEBk&s=ADR3LotyBBy6e8Rv-UFW_-J8B5os_PY71QtUols3tb4&e=
> And I agree with Linus on this, except that does not apply to single
> source file drivers.
>
>>
>> This topic rise another one related with the master folder. I understand
>> that now the subsystem doesn't have slave support but the name is
>> limited. Isn't better to have something like controller or busses? What
>> do you have in mind for the slave?
> drivers/i3c/slave/... for slave drivers and drivers/i3c/slave.c for the
> framework, just like we have drivers/i3c/master/ for master controller
> drivers and drivers/i3c/master.c.

I have to disagree here. I don't see any place on the kernel with 
.../master/ and ../slave/ folders and it is very likely that both rules 
will have some common code.

With this structure the user will have the code spread in /master and 
/slave folders...


I would like you consider to change the folder name and the names rules 
to something like in i2c.


Maybe someone else can give his opinion too.


Best regards,

Vitor Soares




