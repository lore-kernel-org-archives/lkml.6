Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C8FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CADF21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ye6is54D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfBAQ57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:57:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfBAQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Br5lYl7s+8Y4yYqSlwrnkRPN0zdJaZNzKtNFAwwLThk=; b=ye6is54DlRMq2NUGUVSbfB+Hgb
        mh4Sfmg6FrWOOUXPDIo0gVGZTekqU7h+Hwxy0QVYfvRQY+ZI1rFoiRGcnPTcyBqcQXC+ou4wjsCH8
        ksr3a7p62VcRkVUFD/bDoTjRdhZRlYal2JzM/4vwNQRMEVWFZDR2EUeKNIYc23ewQTg6DY/xXyEd3
        /8sEXtJ8c1S3U/Ymrf4vKilWhtOLKJqYarYN7zHjZ/a1dU8/68sqH2HQIm9sf7qrb/bY1ThYOH9Gk
        Vle7VM/XfI1TRAKOi9f79HnNq6nuaqfUGmK1Jq9p8+weLrGdJx24IpyyjHrao55vSnb+j8WFUN3KK
        ofGw/+Vw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpc8a-0002yo-Mb; Fri, 01 Feb 2019 16:57:57 +0000
Subject: Re: linux-next: Tree for Feb 1 (extcon/ptn5150)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
References: <20190201164108.12e1fbff@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <39992a9b-95c2-2e92-706b-409a00ad7d00@infradead.org>
Date:   Fri, 1 Feb 2019 08:57:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190201164108.12e1fbff@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 9:41 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190131:
> 

Hi,

config EXTCON_PTN5150
	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
	depends on I2C && GPIOLIB || COMPILE_TEST
	select REGMAP_I2C

Where did the " || COMPILE_TEST" come from?

I generally support using COMPILE_TEST, but in this case it causes
problems, when EXTCON_PTN5150=y and I2C=m (and COMPILE_TEST=y),
both in kconfig and in build errors:



WARNING: unmet direct dependencies detected for REGMAP_I2C
  Depends on [m]: I2C [=m]
  Selected by [y]:
  - EXTCON_PTN5150 [=y] && EXTCON [=y] && (I2C [=m] && GPIOLIB [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - GPIO_PCA953X [=m] && GPIOLIB [=y] && I2C [=m]
  - GPIO_TS4900 [=m] && GPIOLIB [=y] && I2C [=m] && (SOC_IMX6 || COMPILE_TEST [=y])
  - BATTERY_MAX17042 [=m] && POWER_SUPPLY [=y] && I2C [=m]
  - CHARGER_BQ25890 [=m] && POWER_SUPPLY [=y] && I2C [=m] && (GPIOLIB [=y] || COMPILE_TEST [=y])
  - CHARGER_SMB347 [=m] && POWER_SUPPLY [=y] && I2C [=m]
  - CHARGER_RT9455 [=m] && POWER_SUPPLY [=y] && I2C [=m] && (GPIOLIB [=y] || COMPILE_TEST [=y])
  - SENSORS_LTC2945 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_LTC4222 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_LTC4260 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_MAX6621 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_LM75 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_NCT7802 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_ADS7828 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_INA2XX [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_INA3221 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_TMP103 [=m] && HWMON [=y] && I2C [=m]
  - SENSORS_TMP108 [=m] && HWMON [=y] && I2C [=m]
  - MFD_BD9571MWV [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_AXP20X_I2C [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_DA9062 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_DA9063 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_DA9150 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_MC13XXX_I2C [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_88PM800 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_88PM805 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_MAX14577 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_MAX77693 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_MAX8907 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_RT5033 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_RK808 [=m] && HAS_IOMEM [=y] && I2C [=m] && OF [=y]
  - MFD_RN5T618 [=m] && HAS_IOMEM [=y] && I2C [=m] && OF [=y]
  - MFD_SI476X_CORE [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_LP3943 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_TI_LMU [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_TI_LP873X [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_TPS65218 [=m] && HAS_IOMEM [=y] && I2C [=m] && OF [=y]
  - MFD_TPS65912_I2C [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_LM3533 [=m] && HAS_IOMEM [=y] && I2C [=m]
  - MFD_ARIZONA_I2C [=m] && HAS_IOMEM [=y] && I2C [=m]
  - VIDEO_LM3560 [=m] && MEDIA_SUPPORT [=y] && I2C [=m] && VIDEO_V4L2 [=m] && MEDIA_CONTROLLER [=y] && MEDIA_CAMERA_SUPPORT [=y]
  - MEDIA_TUNER_E4000 [=m] && (MEDIA_ANALOG_TV_SUPPORT [=n] || MEDIA_DIGITAL_TV_SUPPORT [=n] || MEDIA_RADIO_SUPPORT [=y] || MEDIA_SDR_SUPPORT [=n]) && MEDIA_SUPPORT [=y] && I2C [=m]
  - MEDIA_TUNER_FC2580 [=m] && (MEDIA_ANALOG_TV_SUPPORT [=n] || MEDIA_DIGITAL_TV_SUPPORT [=n] || MEDIA_RADIO_SUPPORT [=y] || MEDIA_SDR_SUPPORT [=n]) && MEDIA_SUPPORT [=y] && I2C [=m]
  - MEDIA_TUNER_M88RS6000T [=m] && (MEDIA_ANALOG_TV_SUPPORT [=n] || MEDIA_DIGITAL_TV_SUPPORT [=n] || MEDIA_RADIO_SUPPORT [=y] || MEDIA_SDR_SUPPORT [=n]) && MEDIA_SUPPORT [=y] && I2C [=m]
  - MEDIA_TUNER_TUA9001 [=m] && (MEDIA_ANALOG_TV_SUPPORT [=n] || MEDIA_DIGITAL_TV_SUPPORT [=n] || MEDIA_RADIO_SUPPORT [=y] || MEDIA_SDR_SUPPORT [=n]) && MEDIA_SUPPORT [=y] && I2C [=m]
  - MEDIA_TUNER_IT913X [=m] && (MEDIA_ANALOG_TV_SUPPORT [=n] || MEDIA_DIGITAL_TV_SUPPORT [=n] || MEDIA_RADIO_SUPPORT [=y] || MEDIA_SDR_SUPPORT [=n]) && MEDIA_SUPPORT [=y] && I2C [=m]
  - DRM_SII902X [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
  - DRM_TOSHIBA_TC358767 [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
  - DRM_I2C_ADV7511 [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y] && OF [=y]
  - BACKLIGHT_LM3639 [=m] && HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=y] && BACKLIGHT_CLASS_DEVICE [=m] && I2C [=m]
  - LEDS_LM3642 [=m] && NEW_LEDS [=y] && LEDS_CLASS [=m] && I2C [=m]
  - LEDS_LM3692X [=m] && NEW_LEDS [=y] && LEDS_CLASS [=m] && I2C [=m] && OF [=y]
  - LEDS_LP8860 [=m] && NEW_LEDS [=y] && LEDS_CLASS [=m] && I2C [=m] && OF [=y]
  - LEDS_LM355x [=m] && NEW_LEDS [=y] && LEDS_CLASS [=m] && I2C [=m]
  - RTC_I2C_AND_SPI [=m] && RTC_CLASS [=y] && I2C [=m]
  - RTC_DRV_ABB5ZES3 [=m] && RTC_CLASS [=y] && I2C [=m]
  - COMMON_CLK_SI5351 [=m] && COMMON_CLK [=y] && I2C [=m]
  - COMMON_CLK_SI514 [=m] && COMMON_CLK [=y] && I2C [=m] && OF [=y]
  - COMMON_CLK_SI570 [=m] && COMMON_CLK [=y] && I2C [=m] && OF [=y]
  - COMMON_CLK_CDCE925 [=m] && COMMON_CLK [=y] && I2C [=m] && OF [=y]
  - COMMON_CLK_VC5 [=m] && COMMON_CLK [=y] && I2C [=m] && OF [=y]
  - EXTCON_MAX77693 [=m] && EXTCON [=y] && MFD_MAX77693 [=m] && INPUT [=y]
  - EXTCON_RT8973A [=m] && EXTCON [=y] && I2C [=m]
  - EXTCON_SM5502 [=m] && EXTCON [=y] && I2C [=m]
  - ADXL372_I2C [=m] && IIO [=y] && I2C [=m]
  - BMC150_ACCEL_I2C [=m] && IIO [=y]
  - MXC4005 [=m] && IIO [=y] && I2C [=m]
  - MXC6255 [=m] && IIO [=y] && I2C [=m]
  - INA2XX_ADC [=m] && IIO [=y] && I2C [=m] && !SENSORS_INA2XX [=m]
  - TI_ADS1015 [=m] && IIO [=y] && I2C [=m] && !SENSORS_ADS1015 [=n]
  - ATLAS_PH_SENSOR [=m] && IIO [=y] && I2C [=m]
  - BME680_I2C [=m] && IIO [=y] && I2C [=m] && BME680 [=m]
  - BMG160_I2C [=m] && IIO [=y]
  - MPU3050_I2C [=m] && IIO [=y] && INPUT_MPU3050!=y && INPUT_MPU3050!=m && I2C [=m]
  - AFE4404 [=m] && IIO [=y] && I2C [=m]
  - MAX30100 [=m] && IIO [=y] && I2C [=m]
  - MAX30102 [=m] && IIO [=y] && I2C [=m]
  - HTS221_I2C [=m] && IIO [=y] && HTS221 [=y]
  - IIO_ST_LSM6DSX_I2C [=m] && IIO [=y] && IIO_ST_LSM6DSX [=m]
  - APDS9960 [=m] && IIO [=y] && I2C [=m]
  - GP2AP020A00F [=m] && IIO [=y] && I2C [=m]
  - SENSORS_ISL29028 [=m] && IIO [=y] && I2C [=m]
  - MAX44000 [=m] && IIO [=y] && I2C [=m]
  - PA12203001 [=m] && IIO [=y] && I2C [=m]
  - SI1133 [=m] && IIO [=y] && I2C [=m]
  - STK3310 [=m] && IIO [=y] && I2C [=m]
  - ST_UVIS25_I2C [=m] && IIO [=y] && ST_UVIS25 [=y]
  - VCNL4035 [=m] && IIO [=y] && I2C [=m]
  - AK8974 [=m] && IIO [=y] && I2C [=m] && OF [=y]
  - MMC35240 [=m] && IIO [=y] && I2C [=m]
  - SENSORS_RM3100_I2C [=m] && IIO [=y] && I2C [=m]
  - LMP91000 [=m] && IIO [=y] && I2C [=m]
  - HP03 [=m] && IIO [=y] && I2C [=m]
  - ZPA2326_I2C [=m] && IIO [=y]
  - MLX90632 [=m] && IIO [=y] && I2C [=m]


and then:

ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_byte_reg_read':
regmap-i2c.c:(.text+0x122): undefined reference to `i2c_smbus_read_byte_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_byte_reg_write':
regmap-i2c.c:(.text+0x157): undefined reference to `i2c_smbus_write_byte_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_reg_read':
regmap-i2c.c:(.text+0x182): undefined reference to `i2c_smbus_read_word_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_read_swapped':
regmap-i2c.c:(.text+0x1b2): undefined reference to `i2c_smbus_read_word_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_write_swapped':
regmap-i2c.c:(.text+0x1ee): undefined reference to `i2c_smbus_write_word_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_smbus_word_reg_write':
regmap-i2c.c:(.text+0x217): undefined reference to `i2c_smbus_write_word_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_smbus_i2c_read':
regmap-i2c.c:(.text+0x254): undefined reference to `i2c_smbus_read_i2c_block_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_smbus_i2c_write':
regmap-i2c.c:(.text+0x2b0): undefined reference to `i2c_smbus_write_i2c_block_data'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_read':
regmap-i2c.c:(.text+0x312): undefined reference to `i2c_transfer'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_gather_write':
regmap-i2c.c:(.text+0x39c): undefined reference to `i2c_transfer'
ld: drivers/base/regmap/regmap-i2c.o: in function `regmap_i2c_write':
regmap-i2c.c:(.text+0x3f4): undefined reference to `i2c_transfer_buffer_flags'
ld: drivers/extcon/extcon-ptn5150.o: in function `ptn5150_i2c_init':
extcon-ptn5150.c:(.init.text+0xb): undefined reference to `i2c_register_driver'



thanks.
-- 
~Randy
