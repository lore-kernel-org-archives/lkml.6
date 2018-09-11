Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E25C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF0620867
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ct/Leyvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF0620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeIKPCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:02:50 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47404 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:02:50 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id F34E310C080C;
        Tue, 11 Sep 2018 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536660255; bh=8fGwDrxVf9cn5Ac6fZh+V0iy+YTI0GLALSQYoo/AvSU=;
        h=From:Subject:To:CC:References:Date:In-Reply-To:From;
        b=Ct/LeyvxnOFy7VgyjdpAvsuGTbSv7DZ8NZu6JkvXl30bKnwks9iLwcsXhiqagPv1L
         qo+1BtWZjo6K9MsiFZM9a+m0vllP/vw/B/574YXwvevfT7kX5tHmwr75N4SoAXsBVF
         3n0K3JUZGJdMNSm7fYhfivvoA2Wss7TAWlunDZUpw6HP9O+v9xRsv0eNh4NQhxaenV
         hg6lwNlRv+ONrB+6tdKx9d04W7K5XfG1vEvoHS4AxFeiJkivOWKLMZO4nSl83YGV6d
         7mXl3shzvAwOGaBAuDb/r9HNs1glQv3wkmWZHuSlMmHJldzh9FddT/wdtZEQKqecK6
         kMaMQFaSZ/9jw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9F3FB3594;
        Tue, 11 Sep 2018 03:04:12 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 11 Sep 2018 03:04:12 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 11 Sep 2018 12:04:11 +0200
Received: from [10.0.2.15] (10.107.25.91) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 11 Sep
 2018 12:04:10 +0200
From:   vitor <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v7 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        "Alicja Jurasik-Urbaniak" <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "Rafal Ciepiela" <rafalc@cadence.com>,
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
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20180905154108.20770-1-boris.brezillon@bootlin.com>
 <20180905154108.20770-2-boris.brezillon@bootlin.com>
Message-ID: <aa29faa0-237c-3875-64da-b93a1e87ccff@synopsys.com>
Date:   Tue, 11 Sep 2018 11:04:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905154108.20770-2-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.25.91]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

On 05-09-2018 16:40, Boris Brezillon wrote:
> +i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
> +{
> +	struct i3c_dev_desc *desc;
> +	int ret;
> +
> +	if (!master->init_done)
> +		return;
> +
If you have a hot-join and call i3c_master_do_daa this function will 
return without create the i3c_device.

> +	i3c_bus_for_each_i3cdev(master->bus, desc) {
> +		if (desc->dev || !desc->info.dyn_addr || desc == master->this)
> +			continue;
> +
> +		desc->dev = kzalloc(sizeof(*desc->dev), GFP_KERNEL);
> +		if (!desc->dev)
> +			continue;
> +
> +		desc->dev->bus = master->bus;
> +		desc->dev->desc = desc;
> +		desc->dev->dev.parent = &master->bus->dev;
> +		desc->dev->dev.type = &i3c_device_type;
> +		desc->dev->dev.bus = &i3c_bus_type;
> +		desc->dev->dev.release = i3c_device_release;
> +		dev_set_name(&desc->dev->dev, "%d-%llx", master->bus->id,
> +			     desc->info.pid);
> +
> +		if (desc->boardinfo)
> +			desc->dev->dev.of_node = desc->boardinfo->of_node;
> +
> +		ret = device_register(&desc->dev->dev);
> +		if (ret)
> +			dev_err(master->parent,
> +				"Failed to add I3C device (err = %d)\n", ret);
> +	}
> +}
>

Best regards,
Vitor Soares
