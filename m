Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33EBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F01E208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PJxQQmRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F01E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeHVUJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:09:20 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:38834 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVUJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:09:20 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AEBF610C057E;
        Wed, 22 Aug 2018 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534956223; bh=tWSRTqS8IxJ8KDae8luItOFTlUlcRRPTxeQ4XZKzbHk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=PJxQQmRD9N6Tet62HyphNmKurntZqR/cZErNhTMzBHKKdESPSpFnXSUXRCXd9geuG
         86FBO6Qi8t2Bx6rEcHSwOfVgX8yRrJXNYc/mYNW1rISJpH+TuZ5OfCTk76RIdxcz87
         +UDTZzgnNcPAzX4pLdJa/kGueLC89m/GVmuhWN6YCt7AVLIDM0pZB3k12yb5yLZ1Gt
         FlwpGcpr/uXmKgrxBU2vXf/+0Uv54+v1Wfzyzt0wprjejmS/Kr5Xe7qDs7rzw/rp7o
         +NYF2zSYtfXWaSCOP9Q5wBblHma2+/txzeO4c/D5djJ71XRqml8ZjZA5ZyWOheomb+
         gvbBOYTXFlqXA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id AB74C3343;
        Wed, 22 Aug 2018 09:43:39 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 22 Aug 2018 09:43:39 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 22 Aug 2018 18:43:37 +0200
Received: from [10.0.2.15] (10.107.25.72) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 22 Aug
 2018 18:43:36 +0200
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
From:   vitor <Vitor.Soares@synopsys.com>
Message-ID: <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
Date:   Wed, 22 Aug 2018 17:43:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719152930.3715-2-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.25.72]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 19-07-2018 16:29, Boris Brezillon wrote:
> +int i3c_bus_register(struct i3c_bus *i3cbus)
> +{
> +	struct i2c_dev_desc *desc;
> +
> +	i3c_bus_for_each_i2cdev(i3cbus, desc) {
> +		switch (desc->boardinfo->lvr & I3C_LVR_I2C_INDEX_MASK) {
> +		case I3C_LVR_I2C_INDEX(0):
> +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_FAST)
> +				i3cbus->mode = I3C_BUS_MODE_MIXED_FAST;
> +			break;
> +
> +		case I3C_LVR_I2C_INDEX(1):
> +		case I3C_LVR_I2C_INDEX(2):
> +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_SLOW)
> +				i3cbus->mode = I3C_BUS_MODE_MIXED_SLOW;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!i3cbus->scl_rate.i3c)
> +		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> +
> +	if (!i3cbus->scl_rate.i2c) {
> +		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
> +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
> +		else
> +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
> +	}
> +
> +	/*
> +	 * I3C/I2C frequency may have been overridden, check that user-provided
> +	 * values are not exceeding max possible frequency.
> +	 */
> +	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
> +	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE) {
> +		return -EINVAL;
> +	}
> +
> +	dev_set_name(&i3cbus->dev, "i3c-%d", i3cbus->id);
> +
> +	return device_add(&i3cbus->dev);
> +}
During the tests of the bus with i2c devices I found the i2c_dev_desc 
objects aren't allocated before this function. This cause i3cbus->mode = 
I3C_BUS_MODE_PURE.

I want to do something for the slave and secondary master, do you 
already have infrastructure that you can share?


Best regards,
Vitor Soares
