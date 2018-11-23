Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF492C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F80620685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aegsflHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F80620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409841AbeKWXYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:24:01 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:37718 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405500AbeKWXYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:24:01 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A019010C1711;
        Fri, 23 Nov 2018 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542976797; bh=xP3QFyP7v2cNaTc7zxlwMAMA0uGAVbTjTOIkTNecqCE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=aegsflHwkohHqGhNmJVAj4oczMYyLydOvs4aZiBPepBbMvkXYgitwtAZ/fm6H3DLX
         h6xAhk6FX7XscLTH0tkbuaFmmBy5usjDEyQVZsQvxE4Tyhtkd7aPi7mWHyRul7UYvZ
         hdT7RHJszLRYAYFi5VJ4KjRkS2opWPoncIwuTty5n06Pv16QdbB1LxNM7BNg8PlxR7
         zKw03r7zFJss9UnZoW9g0YtIUjdfG1iuLyZHQb+0apBnQH5A8Dv9aWkBA4MnvUMgoe
         GZEb02Zey2ikVxKQFFo9zNIO1GHG0C+8l7t0jebi3XszTfOIp+EYfYSMoXdkkpJUNz
         6sV/LbSX92VFg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 15581553A;
        Fri, 23 Nov 2018 04:39:55 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 23 Nov 2018 04:39:54 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 23 Nov 2018 13:39:52 +0100
Received: from [10.0.2.15] (10.107.19.142) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 23 Nov
 2018 13:39:52 +0100
Subject: Re: [PATCH] i3c: master: dw: split dw-i3c-master.c into master and
 bus specific parts
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Vitor Soares <vitor.soares@synopsys.com>
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
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <6d513e04-3a57-1989-429c-64631101c5a2@synopsys.com>
Date:   Fri, 23 Nov 2018 12:39:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122210202.6af50fcc@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.107.19.142]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 22/11/18 20:02, Boris Brezillon wrote:
> On Thu, 22 Nov 2018 17:54:54 +0000
> Vitor Soares <vitor.soares@synopsys.com> wrote:
>
>> From: Vitor Soares <soares@synopsys.com>
>>
>> This patch slipts dw-i3c-master.c into three pieces:
>> 	dw-i3c-master.c - contains the code that interacts directly with the
>> 	core in master mode.
>>
>> 	dw-i3c-platdrv.c - contains the code specific to the platform driver.
>>
>> 	dw-i3c-core.h - contains the definitions and declarations shared by
>> 	dw-i3c-master and dw-i3c-platdrv
>>
>> This patch will allow SOC integrators to add their code specific to
>> DesignWare I3C IP.
> Isn't it too early to do this change? Can't we wait until we have a SoC
> that actually embeds this IP?


I'm trying to turn it more flexible so the other can reuse the code.


>
>> Signed-off-by: Vitor Soares <soares@synopsys.com>
>> ---
>>   drivers/i3c/master/Kconfig          |   9 +-
>>   drivers/i3c/master/Makefile         |   5 +-
>>   drivers/i3c/master/dw-i3c-core.h    | 214 ++++++++++++++++++++++++++
>>   drivers/i3c/master/dw-i3c-master.c  | 299 ++----------------------------------
>>   drivers/i3c/master/dw-i3c-platdrv.c | 112 ++++++++++++++
> I'd prefer to have a dw/ subdir where you'd place all dw files.


Sure. I will change to this:

../dwc
    |-core.h
    |-master.c
    |-platdrv.c


so the user doesn't need to write dw-i3c.. several times. The folder 
name is the same as for other subsystem (e.g. PCI).

What do you think?

>
>>   5 files changed, 349 insertions(+), 290 deletions(-)
>>   create mode 100644 drivers/i3c/master/dw-i3c-core.h
>>   create mode 100644 drivers/i3c/master/dw-i3c-platdrv.c
>>
>> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
>> index 8ee1ce6..fdc6e46 100644
>> --- a/drivers/i3c/master/Kconfig
>> +++ b/drivers/i3c/master/Kconfig
>> @@ -5,9 +5,14 @@ config CDNS_I3C_MASTER
>>   	help
>>   	  Enable this driver if you want to support Cadence I3C master block.
>>   
>> -config DW_I3C_MASTER
>> -	tristate "Synospsys DesignWare I3C master driver"
>> +config DW_I3C_CORE
>> +	tristate
>> +
>> +config DW_I3C_PLATFORM
>> +	tristate "Synospsys DesignWare I3C Platform driver"
>> +	select DW_I3C_CORE
>>   	depends on I3C
>> +	depends on HAS_IOMEM
>>   	depends on !(ALPHA || PARISC)
>>   	# ALPHA and PARISC needs {read,write}sl()
>>   	help
>> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
>> index fc53939..004ad1c 100644
>> --- a/drivers/i3c/master/Makefile
>> +++ b/drivers/i3c/master/Makefile
>> @@ -1,2 +1,5 @@
>>   obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
>> -obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
>> +obj-$(CONFIG_DW_I3C_CORE)		+= dw-i3c-core.o
>> +dw-i3c-core-objs			:= dw-i3c-master.o
>> +obj-$(CONFIG_DW_I3C_PLATFORM)		+= dw-i3c-platform.o
>> +dw-i3c-platform-objs			:= dw-i3c-platdrv.o
> Do we really have to create one module for the core and one per SoC?
> Can't we have everything in the same .ko?


This will help the introduction of new modules. The design in my mind is 
to have:

-core.h

-common.c

-master.c

-slave.c

...

I'm not sure if make sense to change core.h to common.h.



Thaks for your feedback.


Best regards,

Vitor Soares

