Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747F5C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32035216EE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32035216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbeHGTu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:50:59 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:45902 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbeHGTu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:50:59 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:54646 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1fn5tN-000767-Ui; Tue, 07 Aug 2018 19:35:33 +0200
Subject: Re: [PATCH v1 5/5] tinydrm: add winstar wg160160 driver
To:     Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180802193909.GA11443@ravnborg.org>
 <20180802194536.10820-5-sam@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <16dfa544-e454-f59b-91ef-9bac7bf1b490@tronnes.org>
Date:   Tue, 7 Aug 2018 19:35:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802194536.10820-5-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 02.08.2018 21.45, skrev Sam Ravnborg:
> Add driver for the winstar wg160160 display.
> The driver utilises pardata-dbi that
> again utilise the pardata subsystem.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>   MAINTAINERS                        |   5 +
>   drivers/gpu/drm/tinydrm/Kconfig    |  10 ++
>   drivers/gpu/drm/tinydrm/Makefile   |   1 +
>   drivers/gpu/drm/tinydrm/wg160160.c | 298 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 314 insertions(+)
>   create mode 100644 drivers/gpu/drm/tinydrm/wg160160.c
>

[...]

> +
> +/**
> + * write_reg - Write instruction on parallel bus to controller
> + *
> + * Check BUSY flag and write instruction
> + *
> + * @pdd: pardata data
> + * @reg: The register to write
> + * @value: The value of the register
> + *
> + * Returns:
> + * Zero on success, negative error code on failure
> + */
> +int write_reg(struct pardata_data *pdd, unsigned int reg, unsigned int value)
> +{
> +	int ins[PIN_NUM];
> +	int val[PIN_NUM];
> +	int i;
> +
> +	for (i = 0; i < PIN_NUM; i++)
> +		ins[PIN_DB0 + i] = !!BIT(reg);
> +
> +	for (i = 0; i < PIN_NUM; i++)
> +		val[PIN_DB0 + i] = !!(value & BIT(i));
> +
> +	gpiod_set_value_cansleep(pdd->bus->pin_rs, 1);
> +	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, ins);
> +	wait_busy(pdd);
> +	pardata_strobe_write(pdd);
> +
> +	gpiod_set_value_cansleep(pdd->bus->pin_rs, 0);
> +	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, val);
> +	wait_busy(pdd);
> +	pardata_strobe_write(pdd);
> +
> +	return 0;
> +}

If this controller has normal registers, you could do a regmap
implementation for pardata: drivers/base/regmap.

Noralf.

> +
> +/**
> + * write_buf - write buffer on parallel bus to controller
> + *
> + * @pdd: pardata data
> + * @offset: offset into display RAM
> + * @data: pointer to data to write
> + * @len: number of bytes to write
> + *
> + * Returns:
> + * Zero on success, negative error code on failure
> + */
> +int write_buf(struct pardata_data *pdd, u8 offset, u8 *data, size_t len)
> +{
> +	int ins[PIN_NUM];
> +	int val[PIN_NUM];
> +	int bit;
> +	int i;
> +
> +	/* Setup address */
> +	write_reg(pdd, WG160160_ADDRSL_REG, offset & 0xff);
> +	write_reg(pdd, WG160160_ADDRSL_REG, (offset >> 8) & 0xff);
> +
> +	/* prepare to write data */
> +	for (i = 0; i < PIN_NUM; i++)
> +		ins[PIN_DB0 + i] = !!(WG160160_WRITE_REG & BIT(i));
> +
> +	gpiod_set_value_cansleep(pdd->bus->pin_rs, 1);
> +	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, ins);
> +	wait_busy(pdd);
> +	pardata_strobe_write(pdd);
> +
> +	/* Write data byte - by byte */
> +	gpiod_set_value_cansleep(pdd->bus->pin_rs, 0);
> +
> +	for (i = offset; i < (offset + len); i++) {
> +		for (bit = 0; bit < PIN_NUM; bit++)
> +			val[PIN_DB0 + bit] = !!(data[i] & BIT(bit));
> +
> +		gpiod_set_array_value_cansleep(PIN_NUM,
> +					       pdd->bus->data_pins->desc,
> +					       val);
> +		wait_busy(pdd);
> +		pardata_strobe_write(pdd);
> +	}
> +
> +	return 0;
> +}

