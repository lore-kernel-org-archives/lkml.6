Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeCGI3X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:29:23 -0500
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:17077 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751090AbeCGI3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:29:18 -0500
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.47,435,1515452400";
   d="scan'208";a="29909364"
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Topic: [PATCH v3 3/4] rtc: isl1208: add support for isl1219 with tamper
 detection
Thread-Index: AQHTtG7aretG2oRbs0uZL0jAjmeJ1KPDncaAgADCjQA=
Date: Wed, 7 Mar 2018 08:19:15 +0000
Message-ID: <1520410754.5976.27.camel@diehl.com>
References: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
         <1520246373-19023-4-git-send-email-Denis.Osterland@diehl.com>
         <20180306204255.GI3035@piout.net>
In-Reply-To: <20180306204255.GI3035@piout.net>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.153.3.249]
MIME-Version: 1.0
X-GBS-PROC: byQFdw3ukCM+zy1/poiPczLN9pzO5BgHhE1g+4tVUWiIEdd3mXyeDjYdqJ6bOayG
X-MIMETrack: Itemize by SMTP Server on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 07.03.2018 09:19:15,
        Serialize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 07.03.2018 09:19:16,
        Serialize complete at 07.03.2018 09:19:16,
        Itemize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 07.03.2018 09:19:16,
        Serialize by Router on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 07.03.2018 09:19:16
X-TNEFEvaluated: 1
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <463768C8F9267843A2C48AFA208DA4B9@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w278TQjG028205

Am Dienstag, den 06.03.2018, 21:42 +0100 schrieb Alexandre Belloni:
> On 05/03/2018 at 10:43:52 +0000, Denis OSTERLAND wrote:
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/isil,isl1219.txt b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> > new file mode 100644
> > index 0000000..7937c13
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> If you want that file to be reviewed by Rob (DT maintainer), you should
> probably separate it from that patch and copy his email. The bindings
> seem fine to me though.
OK
> 
> > 
> > diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> > index 1a2c38c..164371b 100644
> > --- a/drivers/rtc/rtc-isl1208.c
> > +++ b/drivers/rtc/rtc-isl1208.c
> > @@ -33,6 +33,7 @@
> >  #define ISL1208_REG_SR_ARST    (1<<7)	/* auto reset */
> >  #define ISL1208_REG_SR_XTOSCB  (1<<6)	/* crystal oscillator */
> >  #define ISL1208_REG_SR_WRTC    (1<<4)	/* write rtc */
> > +#define ISL1208_REG_SR_EVT     (1<<3)	/* event */
> >  #define ISL1208_REG_SR_ALM     (1<<2)	/* alarm */
> >  #define ISL1208_REG_SR_BAT     (1<<1)	/* battery */
> >  #define ISL1208_REG_SR_RTCF    (1<<0)	/* rtc fail */
> > @@ -57,8 +58,29 @@
> >  #define ISL1208_REG_USR2 0x13
> >  #define ISL1208_USR_SECTION_LEN 2
> > 
> > +/* event section */
> > +#define ISL1208_REG_SCT 0x14
> > +#define ISL1208_REG_MNT 0x15
> > +#define ISL1208_REG_HRT 0x16
> > +#define ISL1208_REG_DTT 0x17
> > +#define ISL1208_REG_MOT 0x18
> > +#define ISL1208_REG_YRT 0x19
> > +#define ISL1208_EVT_SECTION_LEN 6
> > +
> Because they are not available on ISL1208, maybe it would be better to
> prefix them with ISL1219.
I see. Yes, this would clarify that they are only available on isl1219.
Shall we rename isl1208_rtc_event_show_timestamp/isl1208_rtc_event_clear
to isl1219_rtc_event_show_timestamp/isl1219_rtc_event_clear, too?
> 
> > 
> > +
> > +	tv64.tv_sec = rtc_tm_to_time64(&tm);
> Why not using an unsigned long long directly here? time64_t is not the
> correct type.
Do you mean timespec64 is not the correct type here?
Then yes, sould be time64_t.
If you mean time64_t is not the correct type here,
then can you give me some detail why there is no rtc_tm_to_u64,
or something like that?
sprintf(buf, "%lld\n", rtc_tm_to_time64(&tm)) seems correct to me.
By the way, is it needed to check for seconds < 0 and return error?
> 
> > 
> > +
> > +	return sprintf(buf, "%lld\n", (long long) tv64.tv_sec);
> And this should become %llu
> 
> > 
> > +};
> > +
> > +static DEVICE_ATTR(timestamp0, 0640,
> Shouldn't the permissions be 644?
644 is OK
> 
> > 
> > +		isl1208_rtc_event_show_timestamp, isl1208_rtc_event_clear);
> > +
> >  static irqreturn_t
> >  isl1208_rtc_interrupt(int irq, void *data)
> >  {
> >  	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> >  	struct i2c_client *client = data;
> > -	struct rtc_device *rtc = i2c_get_clientdata(client);
> > +	struct isl1208 *isl1208 = i2c_get_clientdata(client);
> >  	int handled = 0, sr, err;
> > 
> >  	/*
> > @@ -521,7 +609,7 @@ isl1208_rtc_interrupt(int irq, void *data)
> >  	if (sr & ISL1208_REG_SR_ALM) {
> >  		dev_dbg(&client->dev, "alarm!\n");
> > 
> > -		rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
> > +		rtc_update_irq(isl1208->rtc, 1, RTC_IRQF | RTC_AF);
> > 
> >  		/* Clear the alarm */
> >  		sr &= ~ISL1208_REG_SR_ALM;
> > @@ -538,6 +626,13 @@ isl1208_rtc_interrupt(int irq, void *data)
> >  			return err;
> >  	}
> > 
> > +	if (sr & ISL1208_REG_SR_EVT) {
> > +		sysfs_notify(&client->dev.kobj, NULL,
> > +			dev_attr_timestamp0.attr.name);
> > +		dev_warn(&client->dev, "event detected");
> > +		handled = 1;
> > +	}
> > +
> >  	return handled ? IRQ_HANDLED : IRQ_NONE;
> >  }
> > 
> > @@ -623,11 +718,23 @@ static const struct attribute_group isl1208_rtc_sysfs_files = {
> >  	.attrs	= isl1208_rtc_attrs,
> >  };
> > 
> > +static struct attribute *isl1219_rtc_attrs[] = {
> > +	&dev_attr_atrim.attr,
> > +	&dev_attr_dtrim.attr,
> > +	&dev_attr_usr.attr,
> > +	&dev_attr_timestamp0.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group isl1219_rtc_sysfs_files = {
> > +	.attrs	= isl1219_rtc_attrs,
> > +};
> > +
> >  static int
> >  isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  {
> >  	int rc = 0;
> > -	struct rtc_device *rtc;
> > +	struct isl1208 *isl1208;
> > 
> >  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> >  		return -ENODEV;
> > @@ -635,13 +742,18 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  	if (isl1208_i2c_validate_client(client) < 0)
> >  		return -ENODEV;
> > 
> > -	rtc = devm_rtc_allocate_device(&client->dev);
> > -	if (IS_ERR(rtc))
> > -		return PTR_ERR(rtc);
> > +	isl1208 = devm_kzalloc(&client->dev, sizeof(struct isl1208),
> > +				GFP_KERNEL);
> > +	if (!isl1208)
> > +		return -ENOMEM;
> > 
> > -	rtc->ops = &isl1208_rtc_ops;
> > +	isl1208->rtc = devm_rtc_allocate_device(&client->dev);
> > +	if (IS_ERR(isl1208->rtc))
> > +		return PTR_ERR(isl1208->rtc);
> > 
> > -	i2c_set_clientdata(client, rtc);
> > +	isl1208->rtc->ops = &isl1208_rtc_ops;
> > +
> > +	i2c_set_clientdata(client, isl1208);
> > 
> >  	rc = isl1208_i2c_get_sr(client);
> >  	if (rc < 0) {
> > @@ -653,7 +765,18 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  		dev_warn(&client->dev, "rtc power failure detected, "
> >  			 "please set clock.\n");
> > 
> > -	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
> > +	if (id->driver_data == TYPE_ISL1219) {
> > +		rc = i2c_smbus_write_byte_data(client, ISL1208_REG_09, 0x10);
> > +		if (rc < 0) {
> > +			dev_err(&client->dev, "could not enable tamper detection\n");
> > +			return rc;
> > +		}
> > +		isl1208->sysfs_files = &isl1219_rtc_sysfs_files;
> > +	} else {
> > +		isl1208->sysfs_files = &isl1208_rtc_sysfs_files;
> > +	}
> > +
> I don't think the whole isl1208 is necessary. You should probably use
> the .is_visible callback of isl1219_rtc_sysfs_files. This will make the
> changelog quite smaller.
> 
Well, I don´t know how to access i2c_device_id from kobject.
rtc_attr_is_visible shows how to convert kobject to device and rtc_device,
but how to do (id->driver_data == TYPE_ISL1219) here?
> > 
> > +	rc = sysfs_create_group(&client->dev.kobj, isl1208->sysfs_files);
> >  	if (rc)
> >  		return rc;
> > 
> > @@ -674,20 +797,23 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  		}
> >  	}
> > 
> > -	return rtc_register_device(rtc);
> > +	return rtc_register_device(isl1208->rtc);
> >  }
> > 
> >  static int
> >  isl1208_remove(struct i2c_client *client)
> >  {
> > -	sysfs_remove_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
> > +	struct isl1208 *isl1208 = i2c_get_clientdata(client);
> > +
> > +	sysfs_remove_group(&client->dev.kobj, isl1208->sysfs_files);
> > 
> >  	return 0;
> >  }
> > 
> >  static const struct i2c_device_id isl1208_id[] = {
> > -	{ "isl1208", 0 },
> > -	{ "isl1218", 0 },
> > +	{ "isl1208", TYPE_ISL1208 },
> > +	{ "isl1218", TYPE_ISL1218 },
> > +	{ "isl1219", TYPE_ISL1219 },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, isl1208_id);
> > --
> > 2.7.4
> > 
> > 
> > Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
> > Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
> > Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht
> > Nürnberg HRA 11756 –
> > Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing.
> > Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
> > ___________________________________________________________________________________________________
> > Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
> > Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung,
> > Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
> > The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
> > mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht Nürnberg HRA 11756 –
Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing. Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
___________________________________________________________________________________________________
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
