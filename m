Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751206AbeCJWCZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 17:02:25 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33351 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeCJWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 17:02:22 -0500
X-Google-Smtp-Source: AG47ELsmkeQKiRJcs1hZeT2ifD640E6uqiBRBAFB1F/GX3qMzjmpXSoP9iVZ15eYpm04Sy3RftpPDg==
Message-ID: <83a96255a243b9298897b78192dbe658ae3f4307.camel@elementarea.net>
Subject: Re: [PATCH 1/2] iio: chemical: sgpxx: Support Sensirion SGPxx
 sensors
From: Andreas Brauchli <a.brauchli@elementarea.net>
To: Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Mar 2018 23:02:17 +0100
In-Reply-To: <20171125174110.699c114e@archlinux>
References: <1511280685.12439.35.camel@elementarea.net>
         <alpine.DEB.2.20.1711212149110.28150@vps.pmeerw.net>
         <20171125174110.699c114e@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Peter, Jonathan,

Thanks for the thourough and speedy review and apologies for the delayed reply.

Many of your comments are integrated in the v2 patch series - details below.

On Sam, 2017-11-25 at 17:41 +0000, Jonathan Cameron wrote:
> On Tue, 21 Nov 2017 22:46:07 +0100 (CET)
> Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> 
> > Hello,
> > 
> > some quick comments on this driver below
> 
> A few additional bits from me but I think Peter got most of the key
> stuff.
> 
> > 
> > I think documentation is missing and the ABI is a bit problematic and 
> > unusual 

In v2, the interface is definitely more user-friendly and with that,
hopefully, less exotic.

> > 
> > > Support Sensirion SGP30 and SGPC3 multi-pixel I2C gas sensors  
> > 
> > generally, we tend to avoid wildcard driver names; sgp30 would be 
> > preferred over sgpxx

renamed to sgp30 in v2

> >  
> > > Supported Features:
> > > 
> > > * Indoor Air Quality (IAQ) concentrations for
> > >   SGP30 and SGPC3:
> > >   - tVOC (in_concentration_voc_input)
> > >   SGP30 only:
> > >   - CO2eq (in_concentration_co2_input)
> > >   IAQ must first be initialized by writing a non-empty value to
> > >   out_iaq_init. After initializing IAQ, at least one IAQ signal must
> > >   be read out every second (SGP30) / every two seconds (SGPC3) for the
> > >   sensor to correctly maintain its internal baseline
> > > * Baseline support for IAQ (in_iaq_baseline, out_iaq_baseline)
> > > * Gas concentration signals for
> > >   SGP30 and SGPC3:
> > >   - Ethanol (in_concentration_ethanol_raw)
> > >   SGP30 only:
> > >   - H2 (in_concentration_h2_raw)
> > > * On-chip self test (in_selftest)
> > >   The self test interferes with IAQ operations. If needed, first
> > >   retrieve the current baseline, then reset it after the self test
> > > * Sensor interface version (in_feature_set_version)
> > > * Sensor serial number (in_serial_id)
> > > * Humidity compensation for SGP30
> > >   With the help of a humidity signal, the gas signals can be
> > >   humidity-compensated.
> > > * Checksummed I2C communication  
> > 
> > 
> >  
> > > For all features, refer to the data sheet or the documentation in
> > > Documentation/iio/chemical/sgpxx.txt for more details.  
> > 
> > may some brief TODOs; heat controller?

The heater interface is not publicly accessible and not part of the datasheet.
We obviously can't recommend playing with it.

> >  
> > > Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
> > > ---
> > >  Documentation/iio/chemical/sgpxx.txt | 112 +++++
> > >  drivers/iio/chemical/Kconfig         |  13 +
> > >  drivers/iio/chemical/Makefile        |   1 +
> > >  drivers/iio/chemical/sgpxx.c         | 894 +++++++++++++++++++++++++++++++++++
> > >  4 files changed, 1020 insertions(+)
> > >  create mode 100644 Documentation/iio/chemical/sgpxx.txt
> > >  create mode 100644 drivers/iio/chemical/sgpxx.c
> > > 
> > > diff --git a/Documentation/iio/chemical/sgpxx.txt b/Documentation/iio/chemical/sgpxx.txt
> > > new file mode 100644
> > > index 000000000000..f49b2f365df3
> > > --- /dev/null
> > > +++ b/Documentation/iio/chemical/sgpxx.txt
> > > @@ -0,0 +1,112 @@
> > > +sgpxx: Industrial IO driver for Sensirion i2c Multi-Pixel Gas Sensors
> > > +
> > > +1. Overview
> > > +
> > > +The sgpxx driver supports the Sensirion SGP30 and SGPC3 multi-pixel gas sensors.
> > > +
> > > +Datasheets:
> > > +https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/9_Gas_Sensors/Sensirion_Gas_Sensors_SGP30_Datasheet_EN.pdf
> > > +https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/9_Gas_Sensors/Sensirion_Gas_Sensors_SGPC3_Datasheet_EN.pdf
> 
> Put this stuff in the driver itself.

already there, so removed from doc in v2.

> > > +
> > > +2. Modes of Operation
> > > +
> > > +2.1. Driver Instantiation
> > > +
> > > +The sgpxx driver must be instantiated on the corresponding i2c bus with the
> > > +product name (sgp30 or sgpc3) and i2c address (0x58).
> > > +
> > > +Example instantiation of an sgp30 on i2c bus 1 (i2c-1):
> > > +
> > > +    $ echo sgp30 0x58 | sudo tee /sys/bus/i2c/devices/i2c-1/new_device
> > > +
> > > +Using the wrong product name results in an instantiation error. Check dmesg.  
> > 
> > I'd rather drop this section, the only specific information is the I2C 
> > address

dropped in v2

> Which belongs in the device tree bindings not here.
> 
> > 
> > > +
> > > +2.2. Indoor Air Quality (IAQ) concentrations
> > > +
> > > +* tVOC (in_concentration_voc_input) at ppb precision (1e-9)
> > > +* CO2eq (in_concentration_co2_input) at ppm precision (1e-6) -- SGP30 only
> > > +
> > > +2.2.1. IAQ Initialization
> > > +Before Indoor Air Quality (IAQ) values can be read, the IAQ mode must be
> > > +initialized by writing a non-empty value to out_iaq_init:
> > > +
> > > +    $ echo init > out_iaq_init  
> > 
> > can't this be done on probe()?

Yes, v2 now uses this approach and removes iaq_init entirely.
A semi-replacement is provided in the form of a set_iaq_preheat_seconds
interface that sets the pre-heat duration, on the low-power SGPC3. All uses of
iaq_init are now purely internal and called as needed E.g. running the selftest
can mess up the state on the SGP30. So we're also re-initializing after a
selftest and after set_baseline.

> It very much needs to be - userspace code for this sort of sensor
> should be generic and hence not need to know about how to initialize
> your particular sensor.  It will assume if the driver is there, the
> device is on - or will be dynamically enabled when it wants to talk
> to it.
> > 
> > in any case, private API should be documented under
> > Documentation/ABI/testing/sysfs-bus-iio-*

amended in v2, please check if the format is as expected.

> > 
> > > +After initializing IAQ, at least one IAQ signal must be read out every second
> > > +(SGP30) / every two seconds (SGPC3) for the sensor to correctly maintain its
> > > +internal baseline:  
> > 
> > shouldn't the driver do this?
> 
> Absolutely!
> 
> As I understand it, the requirement is also to prevent the hardware being read
> more often than this so it needs to be under control of the driver.

fixed with a kernel thread in v2 - the IAQ thread is now the only accessor of
the chip's iaq_{init,measure,set_baseline} functions. A separate dedicated
IAQ-values buffer is used for caching.

> > 
> > > +
> > > +    SGP30:
> > > +    $ watch -n1 cat in_concentration_voc_input
> > > +
> > > +    SGPC3:
> > > +    $ watch -n2 cat in_concentration_voc_input
> > > +
> > > +For the first 15s of operation after writing to out_iaq_init, default values are
> > > +retured by the sensor.  
> 
> In which case it should return -EBUSY from the read function and not garbage
> data (userspace in general has no way of knowing these chip specific
> things).

fixed in v2. For the low-power/pulsed SGPC3, the time is dependent on the
pre-heating duration and whether the initialization is performed with a restored
baseline. This is reflected in the code (sgpc3_iaq_init). A query of default
values now results in -EBUSY.

Consequently, in_iaq_baseline now also returns -EBUSY instead of "0000" which is
considered invalid.

> > typo: returned

fixed in v2

> > > +
> > > +2.2.2. Pausing and Resuming IAQ
> > > +
> > > +For best performance and faster startup times, the baseline should be saved
> > > +once every hour, after 12h of operation. The baseline is restored by writing a
> > > +non-empty value to out_iaq_init, followed by writing an unmodified retrieved
> > > +baseline value from in_iaq_baseline to out_iaq_baseline.  
> > 
> > the out_ prefix seems inappropriate here, the sensors doesn't output CO2 :)

renamed to set_iaq_baseline in v2. Should in_iaq_baseline also be renamed to
get_iaq_baseline?

> > 
> > handling calibration data in a generic way is difficult
> 
> We can do better than this though.  Init is automatic - if you are updating the
> baseline and it needs to call it again, then do that in the write of the baseline
> not a separate init write.

Yes, in v2, iaq_init is now always performed automatically by the driver.

> > > +
> > > +    Saving the baseline:
> > > +    $ baseline=$(cat in_iaq_baseline)
> > > +
> > > +    Restoring the baseline:
> > > +    $ echo init > out_iaq_init
> > > +    $ echo -n $baseline > out_iaq_baseline
> > > +
> > > +2.3. Gas Concentration Signals
> > > +
> > > +* Ethanol (in_concentration_ethanol_raw)  
> > 
> > we'd need a IIO_MOD_ETHANOL?
> 
> Cool a new sensor type ;)

Added in v2 - On a side note, I can imagine quite a few more gases to be added
down the road.. maybe half a dozen if you don't ask a chemist.

> > 
> > > +* H2 (in_concentration_h2_raw) -- SGP30 only  
> > 
> > we'd need a IIO_MOD_H2?

also added in v2

> > 
> > > +
> > > +The gas signals in_concentration_ethanol_raw and in_concentration_h2_raw may be
> > > +used without prior write to out_iaq_init.
> > > +
> > > +2.4. Humidity Compensation (SGP30)
> > > +
> > > +The SGP30 features an on-chip humidity compensation that requires the
> > > +(in-device) environment's absolute humidity.
> > > +
> > > +Set the absolute humidity by writing the absolute humidity concentration (in
> > > +mg/m^3) to out_concentration_ah_raw. The absolute humidity is obtained by  
> > 
> > not sure about the out_ prefix again
> 
> Not unless you are making the air around the sensor wet.

fixed in v2

> These are really calibration values being input to the device.
> The ABI needs to reflect that rather than putting them through as output channels.
> 
> > 
> > absolute humidity is new, IIO has relative humidity so far (jus saying)

Absolute humidity is in fact a concentration but I see the added value in
knowing what specific concentration it is. I didn't add the IIO_HUMIDITYABSOLUTE
channel to the type list since it's not used as channel and would therefore
remain unused.

> > relative humidity is in milli percent in IIO
> > temperature is in milli degree Celsius
> > 
> > > +converting the relative humidity and temperature. The following units are used:
> > > +AH in mg/m^3, RH in percent (0..100), T in degrees Celsius, and exp() being the
> > > +base-e exponential function.
> > > +
> > > +                  RH            exp(17.62 * T)
> > > +                ----- * 6.112 * --------------
> > > +                100.0            243.12 + T
> > > +  AH = 216.7 * ------------------------------- * 1000
> > > +                        273.15 + T
> > > +
> > > +Writing a value of 0 to out_absolute_humidity disables the humidity  
> > 
> > out_absolute_humidity is the same as out_concentration_ah_raw?

Yes, my bad, out_absolute_humidity does not exist, in v2 it's replaced with
set_absolute_humidity.

> > 
> > > +compensation.
> > > +
> > > +2.5. On-chip self test
> > > +
> > > +    $ cat in_selftest
> > > +
> > > +in_selftest returns OK or FAILED.
> > > +
> > > +The self test interferes with IAQ operations. If needed, first save the current
> > > +baseline, then restore it after the self test:
> > > +
> > > +    $ baseline=$(cat in_iaq_baseline)
> > > +    $ cat in_selftest
> > > +    $ echo init > out_iaq_init
> > > +    $ echo -n $baseline > out_iaq_baseline
> > > +
> > > +If the sensor's current operating duration is less than 12h the baseline should
> > > +not be restored by skipping the last step.
> 
> Talk me through the usecase - is power up often enough or are there reasons
> to do it more often?

The self test is more of a convenience than a necessity. It can be useful to
confirm a broken device (e.g. physically broken hotplate) if the signal remains
constantly high. I'd expect user space to perform it since they'll have to
report the failure. Some failures are also non-fatal.

> > > +
> > > +3. Sensor Interface
> > > +
> > > +    $ cat in_feature_set_version
> > > +
> > > +The SGP sensors' minor interface (feature set) version guarantees interface
> > > +stability: a sensor with feature set 1.1 works with a driver for feature set 1.0  
> > 
> > really needed?
> 
> Shouldn't be exposed to userspace.  Worth checking in kernel perhaps and refusing
> to probe if we don't support the newer hardware.

The driver already refuses to probe newer major version interfaces.

Different feature sets have different features, new in v2 is support for the
SGPC3 FS0.6 with an ultra low power mode and humidity compensation. Trying to
set either will result in an -EINVAL when unsupported, so user-space code might
be interested in it.

> 
> > 
> > > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > > index 5cb5be7612b4..4574dd687513 100644
> > > --- a/drivers/iio/chemical/Kconfig
> > > +++ b/drivers/iio/chemical/Kconfig
> > > @@ -38,6 +38,19 @@ config IAQCORE
> > >  	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
> > >  	  sensors
> > >  
> > > +config SENSIRION_SGPXX
> > > +	tristate "Sensirion SGPxx gas sensors"
> > > +	depends on I2C
> > > +	select CRC8
> > > +	help
> > > +	  Say Y here to build I2C interface support for the following
> > > +	  Sensirion SGP gas sensors:
> > > +	    * SGP30 gas sensor
> > > +	    * SGPC3 gas sensor
> > > +
> > > +	  To compile this driver as module, choose M here: the
> > > +	  module will be called sgpxx.
> > > +
> > >  config VZ89X
> > >  	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
> > >  	depends on I2C
> > > diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> > > index a629b29d1e0b..6090a0ae3981 100644
> > > --- a/drivers/iio/chemical/Makefile
> > > +++ b/drivers/iio/chemical/Makefile
> > > @@ -6,4 +6,5 @@
> > >  obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-ph-sensor.o
> > >  obj-$(CONFIG_CCS811)		+= ccs811.o
> > >  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
> > > +obj-$(CONFIG_SENSIRION_SGPXX)	+= sgpxx.o
> > >  obj-$(CONFIG_VZ89X)		+= vz89x.o
> > > diff --git a/drivers/iio/chemical/sgpxx.c b/drivers/iio/chemical/sgpxx.c
> > > new file mode 100644
> > > index 000000000000..aea55e41d4cc
> > > --- /dev/null
> > > +++ b/drivers/iio/chemical/sgpxx.c
> > > @@ -0,0 +1,894 @@
> > > +/*
> > > + * sgpxx.c - Support for Sensirion SGP Gas Sensors
> > > + *
> > > + * Copyright (C) 2017 Andreas Brauchli <andreas.brauchli@sensirion.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License as published by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + * Datasheets:
> > > + * https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/9_Gas_Sensors/Sensirion_Gas_Sensors_SGP30_Datasheet_EN.pdf
> > > + * https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/9_Gas_Sensors/Sensirion_Gas_Sensors_SGPC3_Datasheet_EN.pdf
> > > + */
> > > +
> > > +#include <linux/crc8.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/init.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/sysfs.h>
> > > +
> > > +#define SGP_WORD_LEN			2
> > > +#define SGP_CRC8_POLYNOMIAL		0x31
> > > +#define SGP_CRC8_INIT			0xff
> > > +#define SGP_CRC8_LEN			1
> > > +#define SGP_CMD(cmd_word)		cpu_to_be16(cmd_word)
> > > +#define SGP_CMD_DURATION_US		50000
> > > +#define SGP_SELFTEST_DURATION_US	220000
> > > +#define SGP_CMD_HANDLING_DURATION_US	10000
> > > +#define SGP_CMD_LEN			SGP_WORD_LEN
> > > +#define SGP30_MEASUREMENT_LEN		2
> > > +#define SGPC3_MEASUREMENT_LEN		2  
> > 
> > both _MEASUREMENT_LEN needed, same value?

Unified in v2, dropped data.measurement_len

> > 
> > > +#define SGP30_MEASURE_INTERVAL_HZ	1
> > > +#define SGPC3_MEASURE_INTERVAL_HZ	2
> > > +#define SGP_SELFTEST_OK			0xd400
> > > +
> > > +DECLARE_CRC8_TABLE(sgp_crc8_table);
> > > +
> > > +enum sgp_product_id {
> > > +	SGP30 = 0,
> > > +	SGPC3
> > > +};
> > > +
> > > +enum sgp30_channel_idx {
> > > +	SGP30_IAQ_TVOC_IDX = 0,
> > > +	SGP30_IAQ_CO2EQ_IDX,
> > > +	SGP30_SIG_ETOH_IDX,
> > > +	SGP30_SIG_H2_IDX,
> > > +	SGP30_SET_AH_IDX,
> > > +};
> > > +
> > > +enum sgpc3_channel_idx {
> > > +	SGPC3_IAQ_TVOC_IDX = 10,
> > > +	SGPC3_SIG_ETOH_IDX,
> > > +};
> > > +
> > > +enum sgp_cmd {
> > > +	SGP_CMD_IAQ_INIT		= SGP_CMD(0x2003),
> > > +	SGP_CMD_IAQ_MEASURE		= SGP_CMD(0x2008),
> > > +	SGP_CMD_GET_BASELINE		= SGP_CMD(0x2015),
> > > +	SGP_CMD_SET_BASELINE		= SGP_CMD(0x201e),
> > > +	SGP_CMD_GET_FEATURE_SET		= SGP_CMD(0x202f),
> > > +	SGP_CMD_GET_SERIAL_ID		= SGP_CMD(0x3682),
> > > +	SGP_CMD_MEASURE_TEST		= SGP_CMD(0x2032),
> > > +
> > > +	SGP30_CMD_MEASURE_SIGNAL	= SGP_CMD(0x2050),
> > > +	SGP30_CMD_SET_ABSOLUTE_HUMIDITY = SGP_CMD(0x2061),
> > > +
> > > +	SGPC3_CMD_IAQ_INIT0		= SGP_CMD(0x2089),
> > > +	SGPC3_CMD_IAQ_INIT16		= SGP_CMD(0x2024),
> > > +	SGPC3_CMD_IAQ_INIT64		= SGP_CMD(0x2003),
> > > +	SGPC3_CMD_IAQ_INIT184		= SGP_CMD(0x206a),
> > > +	SGPC3_CMD_MEASURE_RAW		= SGP_CMD(0x2046),
> > > +};
> > > +
> > > +enum sgp_measure_mode {
> > > +	SGP_MEASURE_MODE_UNKNOWN,
> > > +	SGP_MEASURE_MODE_IAQ,
> > > +	SGP_MEASURE_MODE_SIGNAL,
> > > +	SGP_MEASURE_MODE_ALL,
> > > +};
> > > +
> > > +struct sgp_version {
> > > +	u8 major;
> > > +	u8 minor;
> > > +};
> > > +
> > > +struct sgp_crc_word {
> > > +	__be16 value;
> > > +	u8 crc8;
> > > +} __attribute__((__packed__));
> > > +
> > > +union sgp_reading {
> > > +	u8 start;
> > > +	struct sgp_crc_word raw_words[4];
> > > +};
> > > +
> > > +struct sgp_data {
> > > +	struct i2c_client *client;
> > > +	struct mutex data_lock; /* mutex to lock access to data buffer */
> > > +	struct mutex i2c_lock; /* mutex to lock access to i2c */
> 
> Given the i2c lock is only ever (other than during probe which doesn't
> matter) held when data_lock is also held, it provides not addition
> protection so drop it.

dropped in v2

> 
> > > +	unsigned long last_update;
> > > +
> > > +	u64 serial_id;
> > > +	u16 chip_id;
> > > +	u16 feature_set;
> > > +	u16 measurement_len;
> > > +	int measure_interval_hz;
> > > +	enum sgp_cmd measure_iaq_cmd;
> > > +	enum sgp_cmd measure_signal_cmd;
> > > +	enum sgp_measure_mode measure_mode;
> > > +	char *baseline_format;
> > > +	bool iaq_initialized;
> > > +	u8 baseline_len;
> > > +	union sgp_reading buffer;
> > > +};
> > > +
> > > +struct sgp_device {
> > > +	const struct iio_chan_spec *channels;
> > > +	int num_channels;
> > > +};
> > > +
> > > +static const struct sgp_version supported_versions_sgp30[] = {
> > > +	{
> > > +		.major = 1,
> > > +		.minor = 0,
> > > +	}  
> > 
> > end with comma (,) so that it can be extended with minimal change

amended in v2

> > 
> > > +};
> > > +
> > > +static const struct sgp_version supported_versions_sgpc3[] = {
> > > +	{
> > > +		.major = 0,
> > > +		.minor = 4,
> > > +	}
> > > +};
> > > +
> > > +static const struct iio_chan_spec sgp30_channels[] = {
> > > +	{
> > > +		.type = IIO_CONCENTRATION,
> > > +		.channel2 = IIO_MOD_VOC,
> > > +		.datasheet_name = "TVOC signal",
> > > +		.scan_index = 0,  
> > 
> > scan_index only needed when adding buffer support

dropped in v2

> > 
> > > +		.modified = 1,
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > > +		.address = SGP30_IAQ_TVOC_IDX,
> > > +	},
> > > +	{
> > > +		.type = IIO_CONCENTRATION,
> > > +		.channel2 = IIO_MOD_CO2,
> > > +		.datasheet_name = "CO2eq signal",
> > > +		.scan_index = 1,
> > > +		.modified = 1,
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > > +		.address = SGP30_IAQ_CO2EQ_IDX,
> > > +	},
> > > +	{
> > > +		.type = IIO_CONCENTRATION,
> > > +		.info_mask_separate =
> > > +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > > +		.address = SGP30_SIG_ETOH_IDX,
> > > +		.extend_name = "ethanol",
> > > +		.datasheet_name = "Ethanol signal",
> > > +		.scan_index = 2,
> > > +		.scan_type = {
> > > +			.endianness = IIO_BE,  
> > 
> > scan_type only neededwhen adding buffer support
> > 
> > maybe add IIO_MOD_ETHANOL?
> 
> Add a new modifier, not an extended_name

added in v2

> 
> > 
> > > +		},
> > > +	},
> > > +	{
> > > +		.type = IIO_CONCENTRATION,
> > > +		.info_mask_separate =
> > > +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > > +		.address = SGP30_SIG_H2_IDX,  
> > 
> > maybe add IIO_MOD_H2?

added in v2

> > 
> > > +		.extend_name = "h2",
> > > +		.datasheet_name = "H2 signal",
> > > +		.scan_index = 3,
> > > +		.scan_type = {
> > > +			.endianness = IIO_BE,
> > > +		},
> > > +	},
> > > +	IIO_CHAN_SOFT_TIMESTAMP(4),
> > > +	{
> > > +		.type = IIO_CONCENTRATION,
> > > +		.address = SGP30_SET_AH_IDX,
> > > +		.extend_name = "ah",
> > > +		.datasheet_name = "absolute humidty",  
> > 
> > typo: humidity

Removed as channel in v2 (now an attribute)

> > 
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > +		.output = 1,
> > > +		.scan_index = 5
> > > +	},
> > > +};
> > > +
> > > +static const struct iio_chan_spec sgpc3_channels[] = {
> > > +	{
> > > +		.type = IIO_CONCENTRATION,
> > > +		.channel2 = IIO_MOD_VOC,
> > > +		.datasheet_name = "TVOC signal",
> > > +		.modified = 1,
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > > +		.address = SGPC3_IAQ_TVOC_IDX,
> > > +	},
> > > +	{
> > > +		.type = IIO_CONCENTRATION,
> > > +		.info_mask_separate =
> > > +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > > +		.address = SGPC3_SIG_ETOH_IDX,
> > > +		.extend_name = "ethanol",
> 
> Add a new modifier, not an extended_name

added in v2

> 
> > > +		.datasheet_name = "Ethanol signal",
> > > +		.scan_index = 0,
> > > +		.scan_type = {
> > > +			.endianness = IIO_BE,
> > > +		},
> > > +	},
> > > +	IIO_CHAN_SOFT_TIMESTAMP(2),
> > > +};
> > > +
> > > +static struct sgp_device sgp_devices[] = {  
> > 
> > const?

Sure, fixed in v2

> > 
> > > +	[SGP30] = {
> > > +		.channels = sgp30_channels,
> > > +		.num_channels = ARRAY_SIZE(sgp30_channels),
> > > +	},
> > > +	[SGPC3] = {
> > > +		.channels = sgpc3_channels,
> > > +		.num_channels = ARRAY_SIZE(sgpc3_channels),
> > > +	},
> > > +};
> > > +
> > > +/**
> > > + * sgp_verify_buffer() - verify the checksums of the data buffer words
> > > + *
> > > + * @data:       SGP data containing the raw buffer
> > > + * @word_count: Num data words stored in the buffer, excluding CRC bytes
> > > + *
> > > + * Return:      0 on success, negative error code otherwise
> > > + */
> > > +static int sgp_verify_buffer(struct sgp_data *data, size_t word_count)
> > > +{
> > > +	size_t size = word_count * (SGP_WORD_LEN + SGP_CRC8_LEN);
> > > +	int i;
> > > +	u8 crc;
> > > +	u8 *data_buf = &data->buffer.start;
> > > +
> > > +	for (i = 0; i < size; i += SGP_WORD_LEN + SGP_CRC8_LEN) {
> > > +		crc = crc8(sgp_crc8_table, &data_buf[i], SGP_WORD_LEN,
> > > +			   SGP_CRC8_INIT);
> > > +		if (crc != data_buf[i + SGP_WORD_LEN]) {
> > > +			dev_err(&data->client->dev, "CRC error\n");
> > > +			return -EIO;
> > > +		}
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * sgp_read_from_cmd() - reads data from SGP sensor after issuing a command
> > > + * The caller must hold data->data_lock for the duration of the call.
> > > + * @data:        SGP data
> > > + * @cmd:         SGP Command to issue
> > > + * @word_count:  Num words to read, excluding CRC bytes
> > > + *
> > > + * Return:       0 on success, negative error otherwise.
> > > + */
> > > +static int sgp_read_from_cmd(struct sgp_data *data,
> > > +			     enum sgp_cmd cmd,
> > > +			     size_t word_count,
> > > +			     unsigned long duration_us)
> > > +{
> > > +	int ret;
> > > +	struct i2c_client *client = data->client;
> > > +	size_t size = word_count * (SGP_WORD_LEN + SGP_CRC8_LEN);
> > > +	u8 *data_buf = &data->buffer.start;
> > > +
> > > +	mutex_lock(&data->i2c_lock);
> 
> Given this is always done (I think) with the data lock held
> I'm not sure you need any more serialization...

i2c_lock is removed in v2.

> > > +	ret = i2c_master_send(client, (const char *)&cmd, SGP_CMD_LEN);
> > > +	if (ret != SGP_CMD_LEN) {
> > > +		mutex_unlock(&data->i2c_lock);
> > > +		return -EIO;
> > > +	}
> > > +	usleep_range(duration_us, duration_us + 1000);
> > > +
> > > +	ret = i2c_master_recv(client, data_buf, size);
> > > +	mutex_unlock(&data->i2c_lock);
> > > +
> > > +	if (ret < 0)
> > > +		ret = -ETXTBSY;
> 
> -EBUSY

fixed in v2

> > > +	else if (ret != size)
> > > +		ret = -EINTR;
> 
> -EIO is more common - please look at other drivers
> when picking your error codes and do whatever they do...
> (I had to look up these two rather obscure options!)

fixed in v2

> 
> > > +	else
> > > +		ret = sgp_verify_buffer(data, word_count);
> > > +
> > > +	return ret;
> 
> just return directly in each branch above (making the
> else bits unnecessary

fixed in v2

> 
> if (ret < 0)
> 	return -EBUSY; // or return ret; which would be better
> if (ret != size)
> 	return -EIO;
> 
> return sgp_verific_buffer(data, word_count);

fixed in v2

> 
> > > +}
> > > +
> > > +/**
> > > + * sgp_i2c_write_from_cmd() - write data to SGP sensor with a command
> > > + * @data:       SGP data
> > > + * @cmd:        SGP Command to issue
> > > + * @buf:        Data to write
> > > + * @buf_size:   Data size of the buffer
> > > + *
> > > + * Return:      0 on success, negative error otherwise.
> > > + */
> > > +static int sgp_write_from_cmd(struct sgp_data *data,
> > > +			      enum sgp_cmd cmd,
> > > +			      u16 *buf,
> > > +			      size_t buf_size,
> > > +			      unsigned long duration_us)
> > > +{
> > > +	int ret, ix;
> > > +	u16 buf_idx = 0;
> > > +	u16 buffer_size = SGP_CMD_LEN + buf_size *
> > > +		(SGP_WORD_LEN + SGP_CRC8_LEN);
> > > +	u8 buffer[buffer_size];  
> > 
> > dynamically sized array, allowed?
> 
> Just make it big enough that we don't have to care
> what size it is (max size).

Nice catch, fixed in v2

> > 
> > > +
> > > +	/* assemble buffer */
> > > +	*((u16 *)&buffer[0]) = cmd;  
> > 
> > be16

fixed in v2

> > 
> > > +	buf_idx += SGP_CMD_LEN;
> > > +	for (ix = 0; ix < buf_size; ix++) {
> > > +		*((u16 *)&buffer[buf_idx]) = ntohs(buf[ix] & 0xffff);
> > 
> > use cpu_to_be16() as everywhere else instead of ntohs()
> > 
> > buf is u16, so & 0xffff needed?

fixed in v2

> > 
> > > +		buf_idx += SGP_WORD_LEN;
> > > +		buffer[buf_idx] = crc8(sgp_crc8_table,
> > > +				       &buffer[buf_idx - SGP_WORD_LEN],
> > > +				       SGP_WORD_LEN, SGP_CRC8_INIT);
> > > +		buf_idx += SGP_CRC8_LEN;
> > > +	}
> > > +	mutex_lock(&data->i2c_lock);
> > > +	ret = i2c_master_send(data->client, buffer, buffer_size);
> > > +	if (ret != buffer_size) {
> > > +		ret = -EIO;
> > > +		goto unlock_return_count;
> > > +	}
> > > +	ret = 0;
> > > +	/* Wait inside lock to ensure the chip is ready before next command */
> > > +	usleep_range(duration_us, duration_us + 1000);
> > > +
> > > +unlock_return_count:
> > > +	mutex_unlock(&data->i2c_lock);
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * sgp_get_measurement() - retrieve measurement result from sensor
> > > + * The caller must hold data->data_lock for the duration of the call.
> > > + * @data:           SGP data
> > > + * @cmd:            SGP Command to issue
> > > + * @measure_mode:   SGP measurement mode
> > > + *
> > > + * Return:      0 on success, negative error otherwise.
> > > + */
> > > +static int sgp_get_measurement(struct sgp_data *data, enum sgp_cmd cmd,
> > > +			       enum sgp_measure_mode measure_mode)
> > > +{
> > > +	int ret;
> > > +
> > > +	/* if all channels are measured, we don't need to distinguish between
> > > +	 * different measure modes
> > > +	 */
> > > +	if (data->measure_mode == SGP_MEASURE_MODE_ALL)
> > > +		measure_mode = SGP_MEASURE_MODE_ALL;
> > > +
> 
> /*
>  * Always

fixed in v2

> 
> > > +	/* Always measure if measure mode changed
> > > +	 * SGP30 should only be polled once a second
> > > +	 * SGPC3 should only be polled once every two seconds
> > > +	 */
> > > +	if (measure_mode == data->measure_mode &&
> > > +	    !time_after(jiffies,
> > > +			data->last_update + data->measure_interval_hz * HZ)) {
> > > +		return 0;
> > > +	}
> > > +
> > > +	ret = sgp_read_from_cmd(data, cmd, data->measurement_len,
> > > +				SGP_CMD_DURATION_US);
> > > +
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	data->measure_mode = measure_mode;
> > > +	data->last_update = jiffies;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sgp_absolute_humidity_store(struct sgp_data *data,
> > > +				       int val, int val2)
> > > +{
> > > +	u32 ah;
> > > +	u16 ah_scaled;
> > > +
> > > +	if (val < 0 || val > 256 || (val == 256 && val2 > 0))
> > > +		return -EINVAL;
> > > +
> > > +	ah = val * 1000 + val2 / 1000;
> > > +	/* ah_scaled = (u16)((ah / 1000.0) * 256.0) */
> > > +	ah_scaled = (u16)(((u64)ah * 256 * 16777) >> 24);
> > > +
> > > +	/* ensure we don't disable AH compensation due to rounding */
> > > +	if (ah > 0 && ah_scaled == 0)
> > > +		ah_scaled = 1;
> > > +
> > > +	return sgp_write_from_cmd(data, SGP30_CMD_SET_ABSOLUTE_HUMIDITY,
> > > +				  &ah_scaled, 1, SGP_CMD_HANDLING_DURATION_US);
> > > +}
> > > +
> > > +static int sgp_read_raw(struct iio_dev *indio_dev,
> > > +			struct iio_chan_spec const *chan, int *val,
> > > +			int *val2, long mask)
> > > +{
> > > +	struct sgp_data *data = iio_priv(indio_dev);
> > > +	struct sgp_crc_word *words;
> > > +	int ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_PROCESSED:
> > > +		mutex_lock(&data->data_lock);
> > > +		if (!data->iaq_initialized) {
> > > +			dev_warn(&data->client->dev,
> > > +				 "IAQ potentially uninitialized\n");
> > > +		}
> > > +		ret = sgp_get_measurement(data, data->measure_iaq_cmd,
> > > +					  SGP_MEASURE_MODE_IAQ);
> > > +		if (ret)
> > > +			goto unlock_fail;
> > > +		words = data->buffer.raw_words;
> > > +		switch (chan->address) {
> > > +		case SGP30_IAQ_TVOC_IDX:
> > > +		case SGPC3_IAQ_TVOC_IDX:
> > > +			*val = 0;
> > > +			*val2 = be16_to_cpu(words[1].value);
> > > +			ret = IIO_VAL_INT_PLUS_NANO;
> > > +			break;
> > > +		case SGP30_IAQ_CO2EQ_IDX:
> > > +			*val = 0;
> > > +			*val2 = be16_to_cpu(words[0].value);
> > > +			ret = IIO_VAL_INT_PLUS_MICRO;
> > > +			break;
> > > +		default:
> > > +			ret = -EINVAL;
> > > +			break;
> > > +		}
> > > +		mutex_unlock(&data->data_lock);
> > > +		break;
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		mutex_lock(&data->data_lock);
> > > +		ret = sgp_get_measurement(data, data->measure_signal_cmd,
> > > +					  SGP_MEASURE_MODE_SIGNAL);
> > > +		if (ret)
> > > +			goto unlock_fail;
> > > +		words = data->buffer.raw_words;
> > > +		switch (chan->address) {
> > > +		case SGP30_SIG_ETOH_IDX:
> > > +			*val = be16_to_cpu(words[1].value);
> > > +			ret = IIO_VAL_INT;
> > > +			break;
> > > +		case SGPC3_SIG_ETOH_IDX:
> > > +		case SGP30_SIG_H2_IDX:
> > > +			*val = be16_to_cpu(words[0].value);
> > > +			ret = IIO_VAL_INT;
> > > +			break;
> > > +		}
> > > +unlock_fail:
> 
> labels for gotos mid switch statement are ugly and hard
> to follow. In this case only called form one place, just put the
> code there.

refactored accordingly in v2

> 
> > > +		mutex_unlock(&data->data_lock);
> > > +		break;
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		switch (chan->address) {
> > > +		case SGP30_SIG_ETOH_IDX:
> > > +		case SGPC3_SIG_ETOH_IDX:
> > > +		case SGP30_SIG_H2_IDX:
> > > +			*val = 0;
> > > +			*val2 = 1953125;
> > > +			ret = IIO_VAL_INT_PLUS_NANO;
> > > +			break;
> > > +		default:
> > > +			ret = -EINVAL;
> > > +			break;
> > > +		}
> > > +		break;
> > > +	default:
> > > +		ret = -EINVAL;
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > > +static int sgp_write_raw(struct iio_dev *indio_dev,
> > > +			 struct iio_chan_spec const *chan,
> > > +			 int val, int val2, long mask)
> > > +{
> > > +	struct sgp_data *data = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	switch (chan->address) {
> > > +	case SGP30_SET_AH_IDX:
> > > +		ret = sgp_absolute_humidity_store(data, val, val2);
> 
> This is fun - making the world wet ;)
> Joking aside, we need to handle this differently as it
> isn't an output device but rather a calibration parameter.

Consider it my involuntary contribution against said reviewer grumpyness :D

Refactored from channel to attribute set_absolute_humidity in v2. Since it's not
a channel I didn't add IIO_HUMIDITYABSOLUTE to the types, but if it were, the
name would likely be in_humidityabsolute_raw - should the attribute also reflect
this scheme (set_humidityabsolute)?

> 
>  
> > > +		break;
> > > +	default:
> > > +		ret = -EINVAL;
> 
> return -EINVAL etc.
> > > +	}
> > > +
> > > +	return ret;
> 
> Direct returns in the switch.

fixed in v2, at least in cases where it's only the return and the unlock is not
needed.

> > > +}
> > > +
> > > +static ssize_t sgp_iaq_init_store(struct device *dev,
> > > +				  struct device_attribute *attr,
> > > +				  const char *buf, size_t count)
> > > +{
> 
> Why is userspace having explicit control of init?
> 
> You init when you load the driver.  The device then needs
> to do periodic readings to maintain the baseline algorithm.
> All that should be wrapped up in the driver not pushed to userspace.
> 
> The basic aim of kernel driver frameworks is to allow generic
> userspace code this driver looks like it needs some very careful
> handling in userspace - you need to make the kernel driver do
> that clever stuff for you.

fair point, as mentioned above, iaq_init is now internal in v2. The user still
has control over the pre-heat duration on the SGPC3 in case an iaq_init is
triggered.

> > > +	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
> > > +	u32 init_time;
> > > +	enum sgp_cmd cmd;
> > > +	int ret;
> > > +
> > > +	cmd = SGP_CMD_IAQ_INIT;
> > > +	if (data->chip_id == SGPC3) {
> > > +		ret = kstrtou32(buf, 10, &init_time);
> > > +
> > > +		if (ret)
> > > +			return -EINVAL;
> > > +
> > > +		switch (init_time) {
> > > +		case 0:
> > > +			cmd = SGPC3_CMD_IAQ_INIT0;
> > > +			break;
> > > +		case 16:
> > > +			cmd = SGPC3_CMD_IAQ_INIT16;
> > > +			break;
> > > +		case 64:
> > > +			cmd = SGPC3_CMD_IAQ_INIT64;
> > > +			break;
> > > +		case 184:
> > > +			cmd = SGPC3_CMD_IAQ_INIT184;
> > > +			break;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > > +
> > > +	mutex_lock(&data->data_lock);
> > > +	ret = sgp_read_from_cmd(data, cmd, 0, SGP_CMD_DURATION_US);
> > > +
> > > +	if (ret < 0)
> > > +		goto unlock_fail;
> > > +
> > > +	data->iaq_initialized = true;
> > > +	mutex_unlock(&data->data_lock);
> > > +	return count;
> > > +
> > > +unlock_fail:
> 
> Only called in place, put this there.

Fixed in v2

> 
> > > +	mutex_unlock(&data->data_lock);
> > > +	return ret;
> > > +}
> > > +
> > > +static ssize_t sgp_iaq_baseline_show(struct device *dev,
> > > +				     struct device_attribute *attr,
> > > +				     char *buf)
> > > +{
> > > +	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
> > > +	u32 baseline;
> > > +	u16 baseline_word;
> > > +	int ret, ix;
> > > +
> > > +	mutex_lock(&data->data_lock);
> > > +	ret = sgp_read_from_cmd(data, SGP_CMD_GET_BASELINE, data->baseline_len,
> > > +				SGP_CMD_DURATION_US);
> > > +
> > > +	if (ret < 0)
> > > +		goto unlock_fail;
> > > +
> > > +	baseline = 0;
> > > +	for (ix = 0; ix < data->baseline_len; ix++) {
> > > +		baseline_word = be16_to_cpu(data->buffer.raw_words[ix].value);
> > > +		baseline |= baseline_word << (16 * ix);
> > > +	}
> > > +
> > > +	mutex_unlock(&data->data_lock);
> > > +	return sprintf(buf, data->baseline_format, baseline);
> > > +
> > > +unlock_fail:
> 
> Given this only happens from one place put this in that if (ret < 0) block.

fixed in v2

> 
> > > +	mutex_unlock(&data->data_lock);
> > > +	return ret;
> > > +}
> > > +
> > > +static ssize_t sgp_iaq_baseline_store(struct device *dev,
> > > +				      struct device_attribute *attr,
> > > +				      const char *buf, size_t count)
> > > +{
> > > +	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
> > > +	int newline = (count > 0 && buf[count - 1] == '\n');
> > > +	u16 words[2];
> > > +	int ret = 0;
> > > +
> > > +	/* 1 word (4 chars) per signal */
> 
> This definitely needs some explanation / documentation including
> how it would be used.

Usage is as-returned: don't modify before writing back. See next paragraph for
details. That should be clear from the doc, let me know if that's not the case.

> 
> I'm unconvinced you need to be this specfic on the formatting of a
> sysfs attribute. Normally a given sysfs attribute should reflect only
> one quantity - this is inherently 2 but the hardware requires
> they be handled together so we may have to cope with this nastiness.

The baseline should indeed be considered an internal state dump and not two
values (even though that is factically true on the SGP30). But if the user
modifies the value (as a whole) before writing it back he'll be held
responsible. I removed the confusing comment in v2. It's safe to play with
though - besides resulting in potentially useless IAQ signals.

> From reading (very briefly) the datasheet I gather this about
> restoring some tracked values after a power down or similar.

Yes, finding a new baseline takes time, if you have one, let the sensor resume
it's operation.

> 
> > > +	if (count - newline == (data->baseline_len * 4)) {
> > > +		if (data->baseline_len == 1)
> > > +			ret = sscanf(buf, "%04hx", &words[0]);
> > > +		else if (data->baseline_len == 2)
> > > +			ret = sscanf(buf, "%04hx%04hx", &words[0], &words[1]);
> > > +		else
> > > +			return -EIO;
> > > +	}
> > > +
> > > +	/* Check if baseline format is correct */
> > > +	if (ret != data->baseline_len) {
> > > +		dev_err(&data->client->dev, "invalid baseline format\n");
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	ret = sgp_write_from_cmd(data, SGP_CMD_SET_BASELINE, words,
> > > +				 data->baseline_len, SGP_CMD_DURATION_US);
> > > +	if (ret < 0)
> > > +		return -EIO;
> > > +
> > > +	return count;
> > > +}
> > > +
> > > +static ssize_t sgp_selftest_show(struct device *dev,
> > > +				 struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
> > > +	u16 measure_test;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&data->data_lock);
> > > +	data->iaq_initialized = false;
> > > +	ret = sgp_read_from_cmd(data, SGP_CMD_MEASURE_TEST, 1,
> > > +				SGP_SELFTEST_DURATION_US);
> > > +
> > > +	if (ret != 0)
> > > +		goto unlock_fail;
> > > +
> > > +	measure_test = be16_to_cpu(data->buffer.raw_words[0].value);
> > > +	mutex_unlock(&data->data_lock);
> > > +
> > > +	return sprintf(buf, "%s\n",
> > > +		       measure_test ^ SGP_SELFTEST_OK ? "FAILED" : "OK");
> > > +
> 
> How would userspace software know to do a self test?
> Usual convention is to do it on module load and report the failure in the
> kernel logs if there is one.

Not successfully probing might be less desirable since userspace would have to
check the logs to find out that the sensor is detected as broken, also the
self-test is quite complete and an unsucessful self-test doesn't have to be a
completely broken/useless sensor.

> 
> > > +unlock_fail:
> > > +	mutex_unlock(&data->data_lock);
> > > +	return ret;
> > > +}
> > > +
> > > +static ssize_t sgp_serial_id_show(struct device *dev,
> > > +				  struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
> > > +
> > > +	return sprintf(buf, "%llu\n", data->serial_id);
> 
> Not normally of much use except in perhaps debugging so we normally
> only expose these as a kernel log message rather than cluttering the
> sysfs abi.

Let me know if the following use case is not good enough to keep it:
The baseline is per-sensor and the sensor id is a good way of couple both
together in case the system has multiple SGPs attached and i2c bus ids aren't
stable or the sensors are reattached on a different machine/bus.

> 
> > > +}
> > > +
> > > +static ssize_t sgp_feature_set_version_show(struct device *dev,
> > > +					    struct device_attribute *attr,
> > > +					    char *buf)
> > > +{
> > > +	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
> > > +
> > > +	return sprintf(buf, "%hu.%hu\n", (data->feature_set & 0x00e0) >> 5,
> > > +		       data->feature_set & 0x001f);
> > > +}
> > > +
> > > +static int sgp_get_serial_id(struct sgp_data *data)
> > > +{
> > > +	int ret;
> > > +	struct sgp_crc_word *words;
> > > +
> > > +	mutex_lock(&data->data_lock);
> > > +	ret = sgp_read_from_cmd(data, SGP_CMD_GET_SERIAL_ID, 3,
> > > +				SGP_CMD_DURATION_US);
> > > +	if (ret != 0)
> > > +		goto unlock_fail;
> > > +
> > > +	words = data->buffer.raw_words;
> > > +	data->serial_id = (u64)(be16_to_cpu(words[2].value) & 0xffff)       |
> > > +			  (u64)(be16_to_cpu(words[1].value) & 0xffff) << 16 |
> > > +			  (u64)(be16_to_cpu(words[0].value) & 0xffff) << 32;
> > > +
> > > +unlock_fail:
> > > +	mutex_unlock(&data->data_lock);
> > > +	return ret;
> > > +}
> > > +
> > > +static int setup_and_check_sgp_data(struct sgp_data *data,
> > > +				    unsigned int chip_id)
> > > +{
> > > +	u16 minor, major, product, eng, ix, num_fs, reserved;
> > > +	struct sgp_version *supported_versions;
> > > +
> > > +	product = (data->feature_set & 0xf000) >> 12;
> 
> Add some macros to represent what is going with this break
> up in to fields.

fixed in v2 - and they already became useful.

> 
> > > +	reserved = (data->feature_set & 0x0e00) >> 9;
> > > +	eng = (data->feature_set & 0x0100) >> 8;
> > > +	major = (data->feature_set & 0x00e0) >> 5;
> > > +	minor = data->feature_set & 0x001f;
> > > +
> > > +	/* driver does not match product */
> > > +	if (product != chip_id) {
> > > +		dev_err(&data->client->dev,
> > > +			"sensor reports a different product: 0x%04hx\n",
> > > +			product);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	if (reserved != 0)
> > > +		dev_warn(&data->client->dev, "reserved bits set: 0x%04hx\n",
> > > +			 reserved);
> > > +
> > > +	/* engineering samples are not supported */
> 
> Comment should probably say why.  Incompatible interface?

Fixed in v2. Yes the interface is not guaranteed to be even close to the final
one at the same version. Also, if you come accross one, someone seriously messed
up here. We have a "bring a cake" rule, so you'd naturally be invited if you
bring it back to the office.

> 
> > > +	if (eng != 0)
> > > +		return -ENODEV;
> > > +
> > > +	data->iaq_initialized = false;
> > > +	switch (product) {
> > > +	case SGP30:
> > > +		supported_versions =
> > > +			(struct sgp_version *)supported_versions_sgp30;
> > > +		num_fs = ARRAY_SIZE(supported_versions_sgp30);
> > > +		data->measurement_len = SGP30_MEASUREMENT_LEN;
> 
> How about having a single chip_info structure with all this stuff
> in and adding that to data
> 
> data->chip_info = sgp_chip_info[sgp30];

In v2, it's a bit less static with the new kid in town (SGPC3 FS0.6) - let me
know if you still want it I'll add it in v3.

> 
> > > +		data->measure_interval_hz = SGP30_MEASURE_INTERVAL_HZ;
> > > +		data->measure_iaq_cmd = SGP_CMD_IAQ_MEASURE;
> > > +		data->measure_signal_cmd = SGP30_CMD_MEASURE_SIGNAL;
> > > +		data->chip_id = SGP30;
> > > +		data->baseline_len = 2;
> > > +		data->baseline_format = "%08x\n";
> > > +		data->measure_mode = SGP_MEASURE_MODE_UNKNOWN;
> > > +		break;
> > > +	case SGPC3:
> > > +		supported_versions =
> > > +			(struct sgp_version *)supported_versions_sgpc3;
> > > +		num_fs = ARRAY_SIZE(supported_versions_sgpc3);
> > > +		data->measurement_len = SGPC3_MEASUREMENT_LEN;
> > > +		data->measure_interval_hz = SGPC3_MEASURE_INTERVAL_HZ;
> > > +		data->measure_iaq_cmd = SGPC3_CMD_MEASURE_RAW;
> > > +		data->measure_signal_cmd = SGPC3_CMD_MEASURE_RAW;
> > > +		data->chip_id = SGPC3;
> > > +		data->baseline_len = 1;
> > > +		data->baseline_format = "%04x\n";
> > > +		data->measure_mode = SGP_MEASURE_MODE_ALL;
> > > +		break;
> > > +	default:
> > > +		return -ENODEV;
> > > +	};
> > > +
> > > +	for (ix = 0; ix < num_fs; ix++) {
> > > +		if (supported_versions[ix].major == major &&
> > > +		    minor >= supported_versions[ix].minor)
> > > +			return 0;
> > > +	}
> > > +
> > > +	dev_err(&data->client->dev, "unsupported sgp version: %d.%d\n",
> > > +		major, minor);
> > > +	return -ENODEV;
> > > +}
> > > +
> > > +static IIO_DEVICE_ATTR(in_serial_id, 0444, sgp_serial_id_show, NULL, 0);
> > > +static IIO_DEVICE_ATTR(in_feature_set_version, 0444,
> > > +		       sgp_feature_set_version_show, NULL, 0);
> > > +static IIO_DEVICE_ATTR(in_selftest, 0444, sgp_selftest_show, NULL, 0);
> > > +static IIO_DEVICE_ATTR(out_iaq_init, 0220, NULL, sgp_iaq_init_store, 0);
> > > +static IIO_DEVICE_ATTR(in_iaq_baseline, 0444, sgp_iaq_baseline_show, NULL, 0);
> > > +static IIO_DEVICE_ATTR(out_iaq_baseline, 0220, NULL, sgp_iaq_baseline_store, 0);  
> > 
> > lot of private ABI; all needed?
> > needs documentation...

Better in v2?

> > 
> > > +static struct attribute *sgp_attributes[] = {
> > > +	&iio_dev_attr_in_serial_id.dev_attr.attr,
> > > +	&iio_dev_attr_in_feature_set_version.dev_attr.attr,
> > > +	&iio_dev_attr_in_selftest.dev_attr.attr,
> > > +	&iio_dev_attr_out_iaq_init.dev_attr.attr,
> > > +	&iio_dev_attr_in_iaq_baseline.dev_attr.attr,
> > > +	&iio_dev_attr_out_iaq_baseline.dev_attr.attr,
> > > +	NULL
> > > +};
> > > +
> > > +static const struct attribute_group sgp_attr_group = {
> > > +	.attrs = sgp_attributes,
> > > +};
> > > +
> > > +static const struct iio_info sgp_info = {
> > > +	.attrs		= &sgp_attr_group,
> > > +	.read_raw	= sgp_read_raw,
> > > +	.write_raw	= sgp_write_raw,
> > > +};
> > > +
> > > +static const struct of_device_id sgp_dt_ids[] = {
> > > +	{ .compatible = "sensirion,sgp30", .data = (void *)SGP30 },
> > > +	{ .compatible = "sensirion,sgpc3", .data = (void *)SGPC3 },
> > > +	{ }
> > > +};
> > > +
> > > +static int sgp_probe(struct i2c_client *client,
> > > +		     const struct i2c_device_id *id)
> > > +{
> > > +	struct iio_dev *indio_dev;
> > > +	struct sgp_data *data;
> > > +	struct sgp_device *chip;
> 
> Not convinced this local variable adds anything to readability.

Do you have a suggestion? I'm not sure if it's the name or the fact that's it's
there at all.

> 
> > > +	const struct of_device_id *of_id;
> > > +	unsigned long chip_id;
> > > +	int ret;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	of_id = of_match_device(sgp_dt_ids, &client->dev);
> > > +	if (!of_id)
> 
> Seems a touch backward
> if (of_id)
> 	chip_id = (unsigned long)of_id->data;
> else
> 	chip_id = id->driver_data;

fixed in v2

> 
> > > +		chip_id = id->driver_data;
> > > +	else
> > > +		chip_id = (unsigned long)of_id->data;
> > > +
> > > +	chip = &sgp_devices[chip_id];
> > > +	data = iio_priv(indio_dev);
> > > +	i2c_set_clientdata(client, indio_dev);
> > > +	data->client = client;
> > > +	crc8_populate_msb(sgp_crc8_table, SGP_CRC8_POLYNOMIAL);
> > > +	mutex_init(&data->data_lock);
> > > +	mutex_init(&data->i2c_lock);
> > > +
> > > +	/* get serial id and write it to client data */
> > > +	ret = sgp_get_serial_id(data);
> 
> No blank line between function call and it's error handling.

fixed in v2

> > > +
> > > +	if (ret != 0)  
> > 
> > matter of taste: most drivers just do
> > if (ret)
> 
> Also in kernel taste tends to lead to static analysers pointing it
> out and hence patches to change it. I'd much rather we went
> with Peter's suggestion in the first place :)

Sounds reasonable, replaced all != 0 checks in v2

> 
> > 
> > > +		return ret;
> > > +
> > > +	/* get feature set version and write it to client data */
> > > +	ret = sgp_read_from_cmd(data, SGP_CMD_GET_FEATURE_SET, 1,
> > > +				SGP_CMD_DURATION_US);
> > > +	if (ret != 0)
> > > +		return ret;
> > > +
> > > +	data->feature_set = be16_to_cpu(data->buffer.raw_words[0].value);
> > > +
> > > +	ret = setup_and_check_sgp_data(data, chip_id);
> > > +	if (ret < 0)
> > > +		goto fail_free;
> > > +
> > > +	/* so initial reading will complete */
> > > +	data->last_update = jiffies - data->measure_interval_hz * HZ;
> > > +
> > > +	indio_dev->dev.parent = &client->dev;
> > > +	indio_dev->info = &sgp_info;
> > > +	indio_dev->name = dev_name(&client->dev);
> > > +	indio_dev->modes = INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE;  
> > 
> > is INDIO_BUFFER_SOFTWARE implemented at this stage? maybe added in 
> > followup patch

Correct. Not relevant anymore in v2.

> > 
> > > +
> > > +	indio_dev->channels = chip->channels;
> > > +	indio_dev->num_channels = chip->num_channels;
> > > +
> > > +	ret = devm_iio_device_register(&client->dev, indio_dev);
> > > +	if (!ret)
> 
> Please don't do this - have error paths indented if there is
> anything to do in them, not the good path.
> 
> It's not what people expect to see so takes more effort to review.
> (I refer you to Greg KH's presentations on the Grumpy maintainer
> - make our lives easy and we'll be less grumpy)

Thanks for pointing this out, I'll stick to it.

> 
> > > +		return ret;
> > > +
> > > +	dev_err(&client->dev, "failed to register iio device\n");  
> > 
> > really message needed?
> > 
> > > +
> > > +fail_free:
> > > +	mutex_destroy(&data->i2c_lock);
> > > +	mutex_destroy(&data->data_lock);  
> > 
> > no need to explicitly destroy mutex
> 
> Actually this is one of those fun ones.  There is a reason for
> calling mutex_destroy and it is about lock debugging... Now we
> almost never bother as if there aren't any bugs in our mutex
> code it doesn't matter - but arguably perhaps we should.
> 
> /***
>  * mutex_destroy - mark a mutex unusable
>  * @lock: the mutex to be destroyed
>  *
>  * This function marks the mutex uninitialized, and any subsequent
>  * use of the mutex is forbidden. The mutex must not be locked when
>  * this function is called.
>  */
> 
> Also if you did want to do this, then you'd also need to have
> them in the remove function for consistency.
> 
> All in all, I'd probably drop them.
> 

ok, removed in v2

> > 
> > > +	iio_device_free(indio_dev);  
> > 
> > no need to explicitly free devm_ stuff
> 
> Particularly not without using devm_iio_device_free
> as this will give a double free error.
> 
> > 
> > > +	return ret;
> > > +}
> > > +
> > > +static int sgp_remove(struct i2c_client *client)
> > > +{
> > > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > > +
> > > +	devm_iio_device_unregister(&client->dev, indio_dev);  
> > 
> > not needed
> 
> Which incidentally means you don't need remove at all.
> 
> Please look at what devm_ calls actually do so you understand
> why this isn't needed.

I see. In v2 remove is still needed to exit the IAQ thread.

> 
> > 
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct i2c_device_id sgp_id[] = {
> > > +	{ "sgp30", SGP30 },
> > > +	{ "sgpc3", SGPC3 },
> > > +	{ }
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(i2c, sgp_id);
> > > +MODULE_DEVICE_TABLE(of, sgp_dt_ids);
> > > +
> > > +static struct i2c_driver sgp_driver = {
> > > +	.driver = {
> > > +		.name	= "sgpxx",
> > > +		.of_match_table = of_match_ptr(sgp_dt_ids),
> > > +	},
> > > +	.probe = sgp_probe,
> > > +	.remove = sgp_remove,
> > > +	.id_table = sgp_id,
> > > +};
> > > +module_i2c_driver(sgp_driver);
> > > +
> > > +MODULE_AUTHOR("Andreas Brauchli <andreas.brauchli@sensirion.com>");
> > > +MODULE_AUTHOR("Pascal Sachs <pascal.sachs@sensirion.com>");
> > > +MODULE_DESCRIPTION("Sensirion SGPxx gas sensors");
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_VERSION("0.5.0");
> > >   
> 
>
