Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08534C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B457827615
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MK26VK39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B457827615
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935459AbeF1PjY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:39:24 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:51157 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934364AbeF1PjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:39:20 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 855C124E1150;
        Thu, 28 Jun 2018 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530200360; bh=wO8lm6gnGh5gksVx9oLMnLEtrQdBWOJZb9Oxq00burE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=MK26VK395HRa6pRt9A0QlCD6PWqh60PziSZMsS9qY+M03r9Ia5wzjfnIaWkCrTkc9
         pNfDmABtwpLVAaUkUdMtq8v5zVYFGCbTe6o/MUUvhFYBG5hNdwrqOXL58YbiU8RMa+
         ZK7D2EvHNUK35HdusNRSrJVWYfJUC6847ahyvC3hNM8VkZEXyn5Kxt0eM0W2qt1+Ot
         GB8y8pusr2FminDyrz2IVxfCbZ0zZQfwFM0suGF4vLAVHIBhr4LojJE6vSP64JVtgf
         zluD7iAetmreci8JRAbGVe1ym8aZz+XZeXOzGAN2GUcKZOIAznZgzkdtgBBFkLn2E7
         YVa9Wv6IaNkOw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id BEC7C3BE9;
        Thu, 28 Jun 2018 08:39:16 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 28 Jun 2018 08:39:16 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 28 Jun 2018 17:39:14 +0200
Received: from [10.0.2.15] (10.107.25.57) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Jun
 2018 17:39:14 +0200
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
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
        Przemyslaw Gaj <pgaj@cadence.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-2-boris.brezillon@bootlin.com>
From:   vitor <Vitor.Soares@synopsys.com>
Message-ID: <088dc947-da66-cec9-44a8-0f1097690bfd@synopsys.com>
Date:   Thu, 28 Jun 2018 16:38:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622104930.32050-2-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.107.25.57]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 22-06-2018 11:49, Boris Brezillon wrote:
> +static int of_i3c_master_add_i3c_dev(struct i3c_master_controller *master,
> +				     struct device_node *node, u32 *reg)
> +{
> +	struct i3c_device_info info = { };
> +	enum i3c_addr_slot_status addrstatus;
> +	struct i3c_device *i3cdev;
> +	u32 init_dyn_addr = 0;
> +
> +	if (reg[0]) {
> +		if (reg[0] > I3C_MAX_ADDR)
> +			return -EINVAL;
> +
> +		addrstatus = i3c_bus_get_addr_slot_status(master->bus, reg[0]);
> +		if (addrstatus != I3C_ADDR_SLOT_FREE)
> +			return -EINVAL;
> +	}
> +
> +	info.static_addr = reg[0];
> +
> +	if (!of_property_read_u32(node, "assigned-address", &init_dyn_addr)) {
> +		if (init_dyn_addr > I3C_MAX_ADDR)
> +			return -EINVAL;
> +
> +		addrstatus = i3c_bus_get_addr_slot_status(master->bus,
> +							  init_dyn_addr);
> +		if (addrstatus != I3C_ADDR_SLOT_FREE)
> +			return -EINVAL;
> +	}
> +
> +	info.pid = ((u64)reg[1] << 32) | reg[2];
> +
> +	if ((info.pid & GENMASK_ULL(63, 48)) ||
> +	    I3C_PID_RND_LOWER_32BITS(info.pid))
> +		return -EINVAL;
> +
> +	i3cdev = i3c_master_alloc_i3c_dev(master, &info, &i3c_device_type);
> +	if (IS_ERR(i3cdev))
> +		return PTR_ERR(i3cdev);
> +
> +	i3cdev->init_dyn_addr = init_dyn_addr;
> +	i3cdev->dev.of_node = node;
> +	list_add_tail(&i3cdev->common.node, &master->bus->devs.i3c);
> +
> +	return 0;
> +}
> +

I'm writing the driver for the Synopsys master and but now I getting an 
issue.

I use the "slot" of the device to do all transfers, something like you 
use in DAA. I using the master_priv to save the "slot" per device but 
the problem is when I call the i3c_master_add_i3c_dev_locked() to 
retrieve the info I don't have it yet.

 From my analysis this can be solve with:
     - send PID, BCR and DCR when I call i3c_master_add_i3c_dev_locked() 
or similar function.
     - Pre-allocate an i3c_device -> attach it (slot data goes to 
master_priv) -> retrieve info -> if there is already an i3c_device with 
same PID destroy the pre-allocated one.
     - Replace the info.dyn_address with a structure with dyn_address 
and slot and use it in CCC structure.

This is something that will need to be supported for I3C HCI spec too. 
Do you have any suggestion?

Best regards,
Vitor Soares


