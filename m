Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D058C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E1F218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548533133;
	bh=D7ZAcbjZ6EbvJfox6ZHjhYlcVekSl3K6hWpEUfwdl7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Mx95FwbwJ/D5HTuh0HXCChvF2DfT6BxtH9lCM2GpeqxQgSHu/CRzm0eM5GXGY+4rU
	 bLc0dFhpCaTVGw23ONQThjaSMVigANSDfxC19gLBARLJacn9yFNattAElD2WSt5mNF
	 boFYtuY21LZ4lfZ1049mirF0fuCaWYIVKWk4h6XE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfAZUFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 15:05:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfAZUFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 15:05:31 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F722184C;
        Sat, 26 Jan 2019 20:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548533129;
        bh=D7ZAcbjZ6EbvJfox6ZHjhYlcVekSl3K6hWpEUfwdl7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0vIr1h8+dnFNUlzaVjfLCTfVtOyavrGmrSlSOQTe9ge6dfvkaUpaQ/Bu0yhVM7Lfb
         q8GgsGUKFrEOxFQ2Hn2avrxomIQ23BEot23xMk9rfuwIfYjrVuAPrYm/9t5sFvAHF6
         PRshjzFnVz7HAdWpVCOLA02wGkV9owDZJ0LbLvXg=
Date:   Sat, 26 Jan 2019 20:05:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randolph =?UTF-8?B?TWFhw59lbg==?= <gaireg@gaireg.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Martin Kelly <mkelly@xevo.com>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: mpu6050: Add support for the ICM 20602
 IMU
Message-ID: <20190126200523.5233466c@archlinux>
In-Reply-To: <20190122120221.27187-2-gaireg@gaireg.de>
References: <20190122120221.27187-1-gaireg@gaireg.de>
        <20190122120221.27187-2-gaireg@gaireg.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 13:02:14 +0100
Randolph Maa=C3=9Fen <gaireg@gaireg.de> wrote:

> The Invensense ICM-20602 is a 6-axis MotionTracking device that
> combines a 3-axis gyroscope and an 3-axis accelerometer. It is very
> similar to the ICM-20608 imu which is already supported by the mpu6050
> driver. The main difference is that the ICM-20602 has the i2c bus
> disable bit in a separate register.
>=20
> Signed-off-by: Randolph Maa=C3=9Fen <gaireg@gaireg.de>

There is a slight oddity in here, in that you introduce a
field in the chip info to describe the register to control the i2c disable
but then don't actually use it in the code.

You should check if that is 0 and if not, write the separate
register it provides.

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig        |  8 ++++----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 29 ++++++++++++++++++++++++=
+++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 ++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  8 ++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 12 +++++++++---
>  5 files changed, 56 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mp=
u6050/Kconfig
> index 5483b2ea754d..d2fe9dbddda7 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -13,8 +13,8 @@ config INV_MPU6050_I2C
>  	select INV_MPU6050_IIO
>  	select REGMAP_I2C
>  	help
> -	  This driver supports the Invensense MPU6050/6500/9150 and ICM20608
> -	  motion tracking devices over I2C.
> +	  This driver supports the Invensense MPU6050/6500/9150 and
> +	  ICM20608/20602 motion tracking devices over I2C.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-i2c.
> =20
> @@ -24,7 +24,7 @@ config INV_MPU6050_SPI
>  	select INV_MPU6050_IIO
>  	select REGMAP_SPI
>  	help
> -	  This driver supports the Invensense MPU6050/6500/9150 and ICM20608
> -	  motion tracking devices over SPI.
> +	  This driver supports the Invensense MPU6050/6500/9150 and
> +	  ICM20608/20602 motion tracking devices over SPI.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-spi.
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 1e428c196a82..01c856417d8f 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -38,6 +38,29 @@ static const int gyro_scale_6050[] =3D {133090, 266181=
, 532362, 1064724};
>   */
>  static const int accel_scale[] =3D {598, 1196, 2392, 4785};
> =20
> +static const struct inv_mpu6050_reg_map reg_set_icm20602 =3D {
> +	.sample_rate_div	=3D INV_MPU6050_REG_SAMPLE_RATE_DIV,
> +	.lpf                    =3D INV_MPU6050_REG_CONFIG,
> +	.accel_lpf              =3D INV_MPU6500_REG_ACCEL_CONFIG_2,
> +	.user_ctrl              =3D INV_MPU6050_REG_USER_CTRL,
> +	.fifo_en                =3D INV_MPU6050_REG_FIFO_EN,
> +	.gyro_config            =3D INV_MPU6050_REG_GYRO_CONFIG,
> +	.accl_config            =3D INV_MPU6050_REG_ACCEL_CONFIG,
> +	.fifo_count_h           =3D INV_MPU6050_REG_FIFO_COUNT_H,
> +	.fifo_r_w               =3D INV_MPU6050_REG_FIFO_R_W,
> +	.raw_gyro               =3D INV_MPU6050_REG_RAW_GYRO,
> +	.raw_accl               =3D INV_MPU6050_REG_RAW_ACCEL,
> +	.temperature            =3D INV_MPU6050_REG_TEMPERATURE,
> +	.int_enable             =3D INV_MPU6050_REG_INT_ENABLE,
> +	.int_status             =3D INV_MPU6050_REG_INT_STATUS,
> +	.pwr_mgmt_1             =3D INV_MPU6050_REG_PWR_MGMT_1,
> +	.pwr_mgmt_2             =3D INV_MPU6050_REG_PWR_MGMT_2,
> +	.int_pin_cfg            =3D INV_MPU6050_REG_INT_PIN_CFG,
> +	.accl_offset            =3D INV_MPU6500_REG_ACCEL_OFFSET,
> +	.gyro_offset            =3D INV_MPU6050_REG_GYRO_OFFSET,
> +	.i2c_if                 =3D INV_ICM20602_REG_I2C_IF,
> +};
> +
>  static const struct inv_mpu6050_reg_map reg_set_6500 =3D {
>  	.sample_rate_div	=3D INV_MPU6050_REG_SAMPLE_RATE_DIV,
>  	.lpf                    =3D INV_MPU6050_REG_CONFIG,
> @@ -140,6 +163,12 @@ static const struct inv_mpu6050_hw hw_info[] =3D {
>  		.reg =3D &reg_set_6500,
>  		.config =3D &chip_config_6050,
>  	},
> +	{
> +		.whoami =3D INV_ICM20602_WHOAMI_VALUE,
> +		.name =3D "ICM20602",
> +		.reg =3D &reg_set_icm20602,
> +		.config =3D &chip_config_6050,
> +	},
>  };
> =20
>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32=
 mask)
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_i2c.c
> index dd758e3d403d..e46eb4ddea21 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -127,6 +127,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  	st =3D iio_priv(dev_get_drvdata(&client->dev));
>  	switch (st->chip_type) {
>  	case INV_ICM20608:
> +	case INV_ICM20602:
>  		/* no i2c auxiliary bus on the chip */
>  		break;
>  	default:
> @@ -179,6 +180,7 @@ static const struct i2c_device_id inv_mpu_id[] =3D {
>  	{"mpu9250", INV_MPU9250},
>  	{"mpu9255", INV_MPU9255},
>  	{"icm20608", INV_ICM20608},
> +	{"icm20602", INV_ICM20602},
>  	{}
>  };
> =20
> @@ -213,6 +215,10 @@ static const struct of_device_id inv_of_match[] =3D {
>  		.compatible =3D "invensense,icm20608",
>  		.data =3D (void *)INV_ICM20608
>  	},
> +	{
> +		.compatible =3D "invensense,icm20602",
> +		.data =3D (void *)INV_ICM20602
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, inv_of_match);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h
> index 6bcc11fc1b88..325afd9f5f61 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -44,6 +44,7 @@
>   *  @int_pin_cfg;	Controls interrupt pin configuration.
>   *  @accl_offset:	Controls the accelerometer calibration offset.
>   *  @gyro_offset:	Controls the gyroscope calibration offset.
> + *  @i2c_if:		Controls the i2c interface

This is introduced but never actually used.

>   */
>  struct inv_mpu6050_reg_map {
>  	u8 sample_rate_div;
> @@ -65,6 +66,7 @@ struct inv_mpu6050_reg_map {
>  	u8 int_pin_cfg;
>  	u8 accl_offset;
>  	u8 gyro_offset;
> +	u8 i2c_if;
>  };
> =20
>  /*device enum */
> @@ -77,6 +79,7 @@ enum inv_devices {
>  	INV_MPU9250,
>  	INV_MPU9255,
>  	INV_ICM20608,
> +	INV_ICM20602,
>  	INV_NUM_PARTS
>  };
> =20
> @@ -195,6 +198,10 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_BIT_PWR_ACCL_STBY       0x38
>  #define INV_MPU6050_BIT_PWR_GYRO_STBY       0x07
> =20
> +/* ICM20602 register */
> +#define INV_ICM20602_REG_I2C_IF             0x70
> +#define INV_ICM20602_BIT_I2C_IF_DIS         0x40
> +
>  #define INV_MPU6050_REG_FIFO_COUNT_H        0x72
>  #define INV_MPU6050_REG_FIFO_R_W            0x74
> =20
> @@ -261,6 +268,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU9255_WHOAMI_VALUE		0x73
>  #define INV_MPU6515_WHOAMI_VALUE		0x74
>  #define INV_ICM20608_WHOAMI_VALUE		0xAF
> +#define INV_ICM20602_WHOAMI_VALUE		0x12
> =20
>  /* scan element definition */
>  enum inv_mpu6050_scan {
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_spi.c
> index 227f50afff22..e5b7213c74f9 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -31,9 +31,14 @@ static int inv_mpu_i2c_disable(struct iio_dev *indio_d=
ev)
>  	if (ret)
>  		return ret;
> =20
> -	st->chip_config.user_ctrl |=3D INV_MPU6050_BIT_I2C_IF_DIS;
> -	ret =3D regmap_write(st->map, st->reg->user_ctrl,
> -			   st->chip_config.user_ctrl);
> +	if (st->chip_type =3D=3D INV_ICM20602) {
> +		ret =3D regmap_write(st->map, INV_ICM20602_REG_I2C_IF,
> +				   INV_ICM20602_BIT_I2C_IF_DIS);
> +	} else {
> +		st->chip_config.user_ctrl |=3D INV_MPU6050_BIT_I2C_IF_DIS;
> +		ret =3D regmap_write(st->map, st->reg->user_ctrl,
> +				   st->chip_config.user_ctrl);
> +	}
>  	if (ret) {
>  		inv_mpu6050_set_power_itg(st, false);
>  		return ret;
> @@ -81,6 +86,7 @@ static const struct spi_device_id inv_mpu_id[] =3D {
>  	{"mpu9250", INV_MPU9250},
>  	{"mpu9255", INV_MPU9255},
>  	{"icm20608", INV_ICM20608},
> +	{"icm20602", INV_ICM20602},
>  	{}
>  };
> =20

