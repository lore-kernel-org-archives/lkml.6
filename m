Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4AAC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3478825586
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4IwTQsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3478825586
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbeF3PdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbeF3PdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:33:11 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0307243C5;
        Sat, 30 Jun 2018 15:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530372790;
        bh=IFWOJbdZw5WJ4w93wdLtD/az/BojZlzn3nbyg/fokxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k4IwTQsh6JMP/Z4KamTyloT1XAL+pqwqAGUdWNwb1NE299s0ox+50PhsAbM+Hz7b1
         6byJbYoo9C3bK9AiJ1bdmbbI4jYHsoVjNubvUJAotnfBPTiQHYfznZ2BeEnu8T8H/Z
         tax0woKecXLaOMmJqUcG3Zd4UVywSvW7YTyYfYV0=
Date:   Sat, 30 Jun 2018 16:33:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] IIO: st_accel.h: sync DT and I2C device ID table
 strings
Message-ID: <20180630163305.00e08e17@archlinux>
In-Reply-To: <5d00983e4fb2869fd3152a609c1fffe7616c4963.1530268235.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
        <5d00983e4fb2869fd3152a609c1fffe7616c4963.1530268235.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 10:45:54 +0200
Nikolaus Voss <nikolaus.voss@loewensteinmedical.de> wrote:

> I2C device ID table strings should really match the DT compatible
> strings (without the manufacturer prefix) to avoid confusion. This is
> especially reasonable when using ACPI PRP0001 HID /DT compatibility
> entries along with the DT compatible property in DSD which is
> used as a modalias (with manufacturer prefix stripped off) by the ACPI
> layer and thus as i2c_board_info->type by the I2C layer.
> 
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Nice to have I agree.  However, it's an ABI change as this is exposed
via
/sys/bus/iio/devices/iio:\deviceN/name and is used by lots of scripts
etc to identify the device.  So we are stuck with it.

There is a reason we've kept this mess here for quite some time.

Jonathan

> ---
>  drivers/iio/accel/st_accel.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 2f931e4837e5..be4a4a41f849 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -37,23 +37,23 @@ enum st_accel_type {
>  	ST_ACCEL_MAX,
>  };
>  
> -#define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl_accel"
> -#define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl_accel"
> -#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
> -#define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
> -#define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
> -#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
> -#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
> -#define LIS331DL_ACCEL_DEV_NAME		"lis331dl_accel"
> -#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
> -#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
> -#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
> -#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
> -#define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
> -#define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr_accel"
> -#define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12_accel"
> +#define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl-accel"
> +#define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl-accel"
> +#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc-accel"
> +#define LIS3DH_ACCEL_DEV_NAME		"lis3dh-accel"
> +#define LSM330D_ACCEL_DEV_NAME		"lsm330d-accel"
> +#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl-accel"
> +#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc-accel"
> +#define LIS331DL_ACCEL_DEV_NAME		"lis331dl-accel"
> +#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh-accel"
> +#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl-accel"
> +#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh-accel"
> +#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm-accel"
> +#define LSM330_ACCEL_DEV_NAME		"lsm330-accel"
> +#define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr-accel"
> +#define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12-accel"
>  #define LIS3L02DQ_ACCEL_DEV_NAME	"lis3l02dq"
> -#define LNG2DM_ACCEL_DEV_NAME		"lng2dm"
> +#define LNG2DM_ACCEL_DEV_NAME		"lng2dm-accel"
>  #define LIS2DW12_ACCEL_DEV_NAME		"lis2dw12"
>  #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
>  

