Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932224AbeCKMOe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 08:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbeCKMOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 08:14:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A269B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 11 Mar 2018 12:14:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Brauchli <a.brauchli@elementarea.net>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: chemical: sgpxx: Support Sensirion SGPxx
 sensors
Message-ID: <20180311121427.02082f2b@archlinux>
In-Reply-To: <83a96255a243b9298897b78192dbe658ae3f4307.camel@elementarea.net>
References: <1511280685.12439.35.camel@elementarea.net>
        <alpine.DEB.2.20.1711212149110.28150@vps.pmeerw.net>
        <20171125174110.699c114e@archlinux>
        <83a96255a243b9298897b78192dbe658ae3f4307.camel@elementarea.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Mar 2018 23:02:17 +0100
Andreas Brauchli <a.brauchli@elementarea.net> wrote:

> Dear Peter, Jonathan,
> 
> Thanks for the thourough and speedy review and apologies for the delayed reply.
> 
> Many of your comments are integrated in the v2 patch series - details below.
> 
...
> > >   
> > > > +
> > > > +2.2. Indoor Air Quality (IAQ) concentrations
> > > > +
> > > > +* tVOC (in_concentration_voc_input) at ppb precision (1e-9)
> > > > +* CO2eq (in_concentration_co2_input) at ppm precision (1e-6) -- SGP30 only
> > > > +
> > > > +2.2.1. IAQ Initialization
> > > > +Before Indoor Air Quality (IAQ) values can be read, the IAQ mode must be
> > > > +initialized by writing a non-empty value to out_iaq_init:
> > > > +
> > > > +    $ echo init > out_iaq_init    
> > > 
> > > can't this be done on probe()?  
> 
> Yes, v2 now uses this approach and removes iaq_init entirely.
> A semi-replacement is provided in the form of a set_iaq_preheat_seconds
> interface that sets the pre-heat duration, on the low-power SGPC3. All uses of
> iaq_init are now purely internal and called as needed E.g. running the selftest
> can mess up the state on the SGP30. So we're also re-initializing after a
> selftest and after set_baseline.
> 
> > It very much needs to be - userspace code for this sort of sensor
> > should be generic and hence not need to know about how to initialize
> > your particular sensor.  It will assume if the driver is there, the
> > device is on - or will be dynamically enabled when it wants to talk
> > to it.  
> > > 
> > > in any case, private API should be documented under
> > > Documentation/ABI/testing/sysfs-bus-iio-*  
> 
> amended in v2, please check if the format is as expected.
> 
> > >   
> > > > +After initializing IAQ, at least one IAQ signal must be read out every second
> > > > +(SGP30) / every two seconds (SGPC3) for the sensor to correctly maintain its
> > > > +internal baseline:    
> > > 
> > > shouldn't the driver do this?  
> > 
> > Absolutely!
> > 
> > As I understand it, the requirement is also to prevent the hardware being read
> > more often than this so it needs to be under control of the driver.  
> 
> fixed with a kernel thread in v2 - the IAQ thread is now the only accessor of
> the chip's iaq_{init,measure,set_baseline} functions. A separate dedicated
> IAQ-values buffer is used for caching.
> 
> > >   
> > > > +
> > > > +    SGP30:
> > > > +    $ watch -n1 cat in_concentration_voc_input
> > > > +
> > > > +    SGPC3:
> > > > +    $ watch -n2 cat in_concentration_voc_input
> > > > +
> > > > +For the first 15s of operation after writing to out_iaq_init, default values are
> > > > +retured by the sensor.    
> > 
> > In which case it should return -EBUSY from the read function and not garbage
> > data (userspace in general has no way of knowing these chip specific
> > things).  
> 
> fixed in v2. For the low-power/pulsed SGPC3, the time is dependent on the
> pre-heating duration and whether the initialization is performed with a restored
> baseline. This is reflected in the code (sgpc3_iaq_init). A query of default
> values now results in -EBUSY.
> 
> Consequently, in_iaq_baseline now also returns -EBUSY instead of "0000" which is
> considered invalid.
> 
> > > typo: returned  
> 
> fixed in v2
> 
> > > > +
> > > > +2.2.2. Pausing and Resuming IAQ
> > > > +
> > > > +For best performance and faster startup times, the baseline should be saved
> > > > +once every hour, after 12h of operation. The baseline is restored by writing a
> > > > +non-empty value to out_iaq_init, followed by writing an unmodified retrieved
> > > > +baseline value from in_iaq_baseline to out_iaq_baseline.    
> > > 
> > > the out_ prefix seems inappropriate here, the sensors doesn't output CO2 :)  
> 
> renamed to set_iaq_baseline in v2. Should in_iaq_baseline also be renamed to
> get_iaq_baseline?
Nope, just iaq_baseline for both.

> 
> > > 
> > > handling calibration data in a generic way is difficult  
> > 
> > We can do better than this though.  Init is automatic - if you are updating the
> > baseline and it needs to call it again, then do that in the write of the baseline
> > not a separate init write.  
> 
> Yes, in v2, iaq_init is now always performed automatically by the driver.
> 
> > > > +
> > > > +    Saving the baseline:
> > > > +    $ baseline=$(cat in_iaq_baseline)
> > > > +
> > > > +    Restoring the baseline:
> > > > +    $ echo init > out_iaq_init
> > > > +    $ echo -n $baseline > out_iaq_baseline
> > > > +
> > > > +2.3. Gas Concentration Signals
> > > > +
> > > > +* Ethanol (in_concentration_ethanol_raw)    
> > > 
> > > we'd need a IIO_MOD_ETHANOL?  
> > 
> > Cool a new sensor type ;)  
> 
> Added in v2 - On a side note, I can imagine quite a few more gases to be added
> down the road.. maybe half a dozen if you don't ask a chemist.
> 
Sure, it's fine to add them as they come up.
 
> > These are really calibration values being input to the device.
> > The ABI needs to reflect that rather than putting them through as output channels.
> >   
> > > 
> > > absolute humidity is new, IIO has relative humidity so far (jus saying)  
> 
> Absolute humidity is in fact a concentration but I see the added value in
> knowing what specific concentration it is. I didn't add the IIO_HUMIDITYABSOLUTE
> channel to the type list since it's not used as channel and would therefore
> remain unused.
> 
> > > relative humidity is in milli percent in IIO
> > > temperature is in milli degree Celsius
> > >   
> > > > +converting the relative humidity and temperature. The following units are used:
> > > > +AH in mg/m^3, RH in percent (0..100), T in degrees Celsius, and exp() being the
> > > > +base-e exponential function.
> > > > +
> > > > +                  RH            exp(17.62 * T)
> > > > +                ----- * 6.112 * --------------
> > > > +                100.0            243.12 + T
> > > > +  AH = 216.7 * ------------------------------- * 1000
> > > > +                        273.15 + T
> > > > +
> > > > +Writing a value of 0 to out_absolute_humidity disables the humidity    
> > > 
> > > out_absolute_humidity is the same as out_concentration_ah_raw?  
> 
> Yes, my bad, out_absolute_humidity does not exist, in v2 it's replaced with
> set_absolute_humidity.
I don't like that one much either I'm afraid, we need to be clear this is
a control related to calibration/compensation rather than anything else.

> 
> > >   
> > > > +compensation.
> > > > +
> > > > +2.5. On-chip self test
> > > > +
> > > > +    $ cat in_selftest
> > > > +
> > > > +in_selftest returns OK or FAILED.
> > > > +
> > > > +The self test interferes with IAQ operations. If needed, first save the current
> > > > +baseline, then restore it after the self test:
> > > > +
> > > > +    $ baseline=$(cat in_iaq_baseline)
> > > > +    $ cat in_selftest
> > > > +    $ echo init > out_iaq_init
> > > > +    $ echo -n $baseline > out_iaq_baseline
> > > > +
> > > > +If the sensor's current operating duration is less than 12h the baseline should
> > > > +not be restored by skipping the last step.  
> > 
> > Talk me through the usecase - is power up often enough or are there reasons
> > to do it more often?  
> 
> The self test is more of a convenience than a necessity. It can be useful to
> confirm a broken device (e.g. physically broken hotplate) if the signal remains
> constantly high. I'd expect user space to perform it since they'll have to
> report the failure. Some failures are also non-fatal.
Is there any way of telling if it is fatal?
If not it isn't all that much use...
> 
> > > > +
> > > > +3. Sensor Interface
> > > > +
> > > > +    $ cat in_feature_set_version
> > > > +
> > > > +The SGP sensors' minor interface (feature set) version guarantees interface
> > > > +stability: a sensor with feature set 1.1 works with a driver for feature set 1.0    
> > > 
> > > really needed?  
> > 
> > Shouldn't be exposed to userspace.  Worth checking in kernel perhaps and refusing
> > to probe if we don't support the newer hardware.  
> 
> The driver already refuses to probe newer major version interfaces.
> 
> Different feature sets have different features, new in v2 is support for the
> SGPC3 FS0.6 with an ultra low power mode and humidity compensation. Trying to
> set either will result in an -EINVAL when unsupported, so user-space code might
> be interested in it.
>
Don't provide the userspace interface if it doesn't do anything.
 
...
> > > > +static int sgp_write_raw(struct iio_dev *indio_dev,
> > > > +			 struct iio_chan_spec const *chan,
> > > > +			 int val, int val2, long mask)
> > > > +{
> > > > +	struct sgp_data *data = iio_priv(indio_dev);
> > > > +	int ret;
> > > > +
> > > > +	switch (chan->address) {
> > > > +	case SGP30_SET_AH_IDX:
> > > > +		ret = sgp_absolute_humidity_store(data, val, val2);  
> > 
> > This is fun - making the world wet ;)
> > Joking aside, we need to handle this differently as it
> > isn't an output device but rather a calibration parameter.  
> 
> Consider it my involuntary contribution against said reviewer grumpyness :D
> 
> Refactored from channel to attribute set_absolute_humidity in v2. Since it's not
> a channel I didn't add IIO_HUMIDITYABSOLUTE to the types, but if it were, the
> name would likely be in_humidityabsolute_raw - should the attribute also reflect
> this scheme (set_humidityabsolute)?
This needs some more thought.  It's really a calibration parameter so we
should indicate it in some way but I'm not totally sure how to do so cleanly.
I don't like the idea of set_* though as if we can write to a value then
it should be clear we are setting it.

Hopefully we'll get some other people's input on this question.

> 
> > 
> >    
...
> > > > +
> > > > +	return sprintf(buf, "%s\n",
> > > > +		       measure_test ^ SGP_SELFTEST_OK ? "FAILED" : "OK");
> > > > +  
> > 
> > How would userspace software know to do a self test?
> > Usual convention is to do it on module load and report the failure in the
> > kernel logs if there is one.  
> 
> Not successfully probing might be less desirable since userspace would have to
> check the logs to find out that the sensor is detected as broken, also the
> self-test is quite complete and an unsucessful self-test doesn't have to be a
> completely broken/useless sensor.
Hmm.  I'm still a little unconvinced but let's ignore that one for now as
bigger things to deal with.

Generic usespace is simply never going to run it however...

> 
> >   
> > > > +unlock_fail:
> > > > +	mutex_unlock(&data->data_lock);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static ssize_t sgp_serial_id_show(struct device *dev,
> > > > +				  struct device_attribute *attr, char *buf)
> > > > +{
> > > > +	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
> > > > +
> > > > +	return sprintf(buf, "%llu\n", data->serial_id);  
> > 
> > Not normally of much use except in perhaps debugging so we normally
> > only expose these as a kernel log message rather than cluttering the
> > sysfs abi.  
> 
> Let me know if the following use case is not good enough to keep it:
> The baseline is per-sensor and the sensor id is a good way of couple both
> together in case the system has multiple SGPs attached and i2c bus ids aren't
> stable or the sensors are reattached on a different machine/bus.
> 
Hmm. OK, I think that is a good enough reason...

...

> > > > +static IIO_DEVICE_ATTR(in_serial_id, 0444, sgp_serial_id_show, NULL, 0);
> > > > +static IIO_DEVICE_ATTR(in_feature_set_version, 0444,
> > > > +		       sgp_feature_set_version_show, NULL, 0);
> > > > +static IIO_DEVICE_ATTR(in_selftest, 0444, sgp_selftest_show, NULL, 0);
> > > > +static IIO_DEVICE_ATTR(out_iaq_init, 0220, NULL, sgp_iaq_init_store, 0);
> > > > +static IIO_DEVICE_ATTR(in_iaq_baseline, 0444, sgp_iaq_baseline_show, NULL, 0);
> > > > +static IIO_DEVICE_ATTR(out_iaq_baseline, 0220, NULL, sgp_iaq_baseline_store, 0);    
> > > 
> > > lot of private ABI; all needed?
> > > needs documentation...  
> 
> Better in v2?
Somewhat but still needs discussion.

> 
> > >   
> > > > +static struct attribute *sgp_attributes[] = {
> > > > +	&iio_dev_attr_in_serial_id.dev_attr.attr,
> > > > +	&iio_dev_attr_in_feature_set_version.dev_attr.attr,
> > > > +	&iio_dev_attr_in_selftest.dev_attr.attr,
> > > > +	&iio_dev_attr_out_iaq_init.dev_attr.attr,
> > > > +	&iio_dev_attr_in_iaq_baseline.dev_attr.attr,
> > > > +	&iio_dev_attr_out_iaq_baseline.dev_attr.attr,
> > > > +	NULL
> > > > +};
> > > > +
> > > > +static const struct attribute_group sgp_attr_group = {
> > > > +	.attrs = sgp_attributes,
> > > > +};
> > > > +
> > > > +static const struct iio_info sgp_info = {
> > > > +	.attrs		= &sgp_attr_group,
> > > > +	.read_raw	= sgp_read_raw,
> > > > +	.write_raw	= sgp_write_raw,
> > > > +};
> > > > +
> > > > +static const struct of_device_id sgp_dt_ids[] = {
> > > > +	{ .compatible = "sensirion,sgp30", .data = (void *)SGP30 },
> > > > +	{ .compatible = "sensirion,sgpc3", .data = (void *)SGPC3 },
> > > > +	{ }
> > > > +};
> > > > +
> > > > +static int sgp_probe(struct i2c_client *client,
> > > > +		     const struct i2c_device_id *id)
> > > > +{
> > > > +	struct iio_dev *indio_dev;
> > > > +	struct sgp_data *data;
> > > > +	struct sgp_device *chip;  
> > 
> > Not convinced this local variable adds anything to readability.  
> 
> Do you have a suggestion? I'm not sure if it's the name or the fact that's it's
> there at all.
There at all - just use the array directly in all cases.
 
> >   
> > > > +	const struct of_device_id *of_id;
> > > > +	unsigned long chip_id;
> > > > +	int ret;
> > > > +
> > > > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > > +	if (!indio_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	of_id = of_match_device(sgp_dt_ids, &client->dev);
> > > > +	if (!of_id)  
> > 
> > Seems a touch backward
> > if (of_id)
> > 	chip_id = (unsigned long)of_id->data;
> > else
> > 	chip_id = id->driver_data;  
> 
> fixed in v2
> 
> >   
> > > > +		chip_id = id->driver_data;
> > > > +	else
> > > > +		chip_id = (unsigned long)of_id->data;
> > > > +
> > > > +	chip = &sgp_devices[chip_id];
> > > > +	data = iio_priv(indio_dev);
> > > > +	i2c_set_clientdata(client, indio_dev);
> > > > +	data->client = client;
> > > > +	crc8_populate_msb(sgp_crc8_table, SGP_CRC8_POLYNOMIAL);
> > > > +	mutex_init(&data->data_lock);
> > > > +	mutex_init(&data->i2c_lock);
> > > > +
> > > > +	/* get serial id and write it to client data */
> > > > +	ret = sgp_get_serial_id(data);  
> > 
...
