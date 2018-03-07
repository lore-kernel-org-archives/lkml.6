Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeCGKr3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:47:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60675 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751149AbeCGKr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:47:27 -0500
Date: Wed, 7 Mar 2018 11:47:14 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 3/4] rtc: isl1208: add support for isl1219 with tamper
 detection
Message-ID: <20180307104714.GL3035@piout.net>
References: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
 <1520246373-19023-4-git-send-email-Denis.Osterland@diehl.com>
 <20180306204255.GI3035@piout.net>
 <1520410754.5976.27.camel@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520410754.5976.27.camel@diehl.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 at 08:19:15 +0000, Denis OSTERLAND wrote:
> > > +/* event section */
> > > +#define ISL1208_REG_SCT 0x14
> > > +#define ISL1208_REG_MNT 0x15
> > > +#define ISL1208_REG_HRT 0x16
> > > +#define ISL1208_REG_DTT 0x17
> > > +#define ISL1208_REG_MOT 0x18
> > > +#define ISL1208_REG_YRT 0x19
> > > +#define ISL1208_EVT_SECTION_LEN 6
> > > +
> > Because they are not available on ISL1208, maybe it would be better to
> > prefix them with ISL1219.
> I see. Yes, this would clarify that they are only available on isl1219.
> Shall we rename isl1208_rtc_event_show_timestamp/isl1208_rtc_event_clear
> to isl1219_rtc_event_show_timestamp/isl1219_rtc_event_clear, too?

That could be done too, yes.

> > 
> > > 
> > > +
> > > +	tv64.tv_sec = rtc_tm_to_time64(&tm);
> > Why not using an unsigned long long directly here? time64_t is not the
> > correct type.
> Do you mean timespec64 is not the correct type here?
> Then yes, sould be time64_t.
> If you mean time64_t is not the correct type here,
> then can you give me some detail why there is no rtc_tm_to_u64,
> or something like that?

The rtc subsystem forbids negative times, the proper type should be
unsigned.

> sprintf(buf, "%lld\n", rtc_tm_to_time64(&tm)) seems correct to me.
> By the way, is it needed to check for seconds < 0 and return error?

Indeed, you shoud check the tm with rtc_valid_tm before calling
rtc_tm_to_time64.

> > > -	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
> > > +	if (id->driver_data == TYPE_ISL1219) {
> > > +		rc = i2c_smbus_write_byte_data(client, ISL1208_REG_09, 0x10);
> > > +		if (rc < 0) {
> > > +			dev_err(&client->dev, "could not enable tamper detection\n");
> > > +			return rc;
> > > +		}
> > > +		isl1208->sysfs_files = &isl1219_rtc_sysfs_files;
> > > +	} else {
> > > +		isl1208->sysfs_files = &isl1208_rtc_sysfs_files;
> > > +	}
> > > +
> > I don't think the whole isl1208 is necessary. You should probably use
> > the .is_visible callback of isl1219_rtc_sysfs_files. This will make the
> > changelog quite smaller.
> > 
> Well, I don´t know how to access i2c_device_id from kobject.
> rtc_attr_is_visible shows how to convert kobject to device and rtc_device,
> but how to do (id->driver_data == TYPE_ISL1219) here?

I'd use i2c_set_clientdata/i2c_get_clientdata but I agree that then it
is basically the same as having isl1208->sysfs_files.

but this makes me realize that the timestamp file doesn't end up at the
correct location. What you do now is placing it under the i2c device
while it should be placed under the rtc device (i.e. in
/sys/class/rtc/rtcX/). This was a mistake made back in 2006.

I guess you'll have to add a new group instead of adding to the current
one.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
