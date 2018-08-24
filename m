Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7EF2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ibJAnnrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7EF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeHXV2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:28:42 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:38544 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbeHXV2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:28:42 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 571ED10C1BAC;
        Fri, 24 Aug 2018 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535133182; bh=pU6Vt7axWq5CX5naq7DXYQ1wFeapZtzLGaLvIpFHHmw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=ibJAnnrvg8P17BDi0++Rgi4Z2v0FiZn9LFgtcmpozeiUw6RpBSBsfrlrSIUFN6FMd
         9MdOQhFRDVw1Xp5aC72BwoIjjeEx7C8GPc/UmjJ4AyLW7lPqpxjw/WZo3GZzRqTSoI
         pfrkVDGxVc1vJU60xoAIo+1TqB3lNkREqKI+P1yxe00TScEuLES7uyEuab3NF/4YYN
         RMQdQnF64QRd05NfuANVbhq1FYxrPRtlhN8zlalPFiNOHgWmBnKNKmts7sMyCJTpfS
         Q4se1IrEf0GhdoHdO7ep/Vv+d9mQ7pmY55VsQ2Cd5uPmni5zIXe5wRS08lUxUnBQLW
         bCkl/IyCDl/KA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5817B3CB3;
        Fri, 24 Aug 2018 10:52:58 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 24 Aug 2018 10:52:58 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 24 Aug 2018 19:52:56 +0200
Received: from [10.0.2.15] (10.107.25.66) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 24 Aug
 2018 19:52:55 +0200
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <Vitor.Soares@synopsys.com>, <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>
CC:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        "Cyprian Wronka" <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "Rafal Ciepiela" <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
From:   vitor <Vitor.Soares@synopsys.com>
Message-ID: <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
Date:   Fri, 24 Aug 2018 18:52:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824143934.6d6b6487@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.25.66]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 24-08-2018 13:39, Boris Brezillon wrote:
> Hi Vitor,
>
> On Wed, 22 Aug 2018 17:43:34 +0100
> vitor <Vitor.Soares@synopsys.com> wrote:
>
>> Hi Boris,
>>
>>
>> On 19-07-2018 16:29, Boris Brezillon wrote:
>>> +int i3c_bus_register(struct i3c_bus *i3cbus)
>>> +{
>>> +	struct i2c_dev_desc *desc;
>>> +
>>> +	i3c_bus_for_each_i2cdev(i3cbus, desc) {
>>> +		switch (desc->boardinfo->lvr & I3C_LVR_I2C_INDEX_MASK) {
>>> +		case I3C_LVR_I2C_INDEX(0):
>>> +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_FAST)
>>> +				i3cbus->mode = I3C_BUS_MODE_MIXED_FAST;
>>> +			break;
>>> +
>>> +		case I3C_LVR_I2C_INDEX(1):
>>> +		case I3C_LVR_I2C_INDEX(2):
>>> +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_SLOW)
>>> +				i3cbus->mode = I3C_BUS_MODE_MIXED_SLOW;
>>> +			break;
>>> +
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +	}
>>> +
>>> +	if (!i3cbus->scl_rate.i3c)
>>> +		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
>>> +
>>> +	if (!i3cbus->scl_rate.i2c) {
>>> +		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
>>> +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
>>> +		else
>>> +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
>>> +	}
>>> +
>>> +	/*
>>> +	 * I3C/I2C frequency may have been overridden, check that user-provided
>>> +	 * values are not exceeding max possible frequency.
>>> +	 */
>>> +	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
>>> +	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE) {
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	dev_set_name(&i3cbus->dev, "i3c-%d", i3cbus->id);
>>> +
>>> +	return device_add(&i3cbus->dev);
>>> +}
>> During the tests of the bus with i2c devices I found the i2c_dev_desc
>> objects aren't allocated before this function. This cause i3cbus->mode =
>> I3C_BUS_MODE_PURE.
> I just checked and DT parsing (+ I2C descs creation) is done before
> i3c_bus_register() is called, so we should be good. How did you declare
> your I2C devices (right now, only DT declaration is supported).
During the DT parsing, you create the i2c_dev_boardinfo. the 
i2c_dev_desc is created in i3c_master_bus_init() which is after the 
i3c_mater_create_bus(). One possible way to fix this is to pass master 
also to i3c_bus_register and iterate over i2c_dev_board_info list.

>> I want to do something for the slave and secondary master, do you
>> already have infrastructure that you can share?
> What do you mean?
>
> Regards,
>
> Boris

I want start to add the secondary master functionality but it is also 
necessary to add the infrastructure to the subsystem.
So, to avoid duplicated work can you share your plans for the secondary 
master?

Best regards,
Vitor Soares


