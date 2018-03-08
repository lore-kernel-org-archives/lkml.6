Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755845AbeCHMDM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:03:12 -0500
Received: from enterprise03.smtp.diehl.com ([193.201.238.214]:4014 "EHLO
        enterprise03.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755460AbeCHMDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:03:09 -0500
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.47,440,1515452400";
   d="scan'208";a="9088310"
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
Thread-Index: AQHTtG7aretG2oRbs0uZL0jAjmeJ1KPDncaAgADCjQCAAClaAIABpL4A
Date: Thu, 8 Mar 2018 11:53:09 +0000
Message-ID: <1520509988.5415.17.camel@diehl.com>
References: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
         <1520246373-19023-4-git-send-email-Denis.Osterland@diehl.com>
         <20180306204255.GI3035@piout.net> <1520410754.5976.27.camel@diehl.com>
         <20180307104714.GL3035@piout.net>
In-Reply-To: <20180307104714.GL3035@piout.net>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.153.3.249]
MIME-Version: 1.0
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc4VMo5BK5JTrdScSVFFRRqOLWuU0OwKxyXw1gXO5gE64
X-MIMETrack: Itemize by SMTP Server on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 08.03.2018 12:53:09,
        Serialize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 08.03.2018 12:53:09,
        Serialize complete at 08.03.2018 12:53:09,
        Itemize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 08.03.2018 12:53:09,
        Serialize by Router on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 08.03.2018 12:53:09
X-TNEFEvaluated: 1
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <637C70F0AB4BE240999DCB55B60C6422@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28C3IqU001049

Am Mittwoch, den 07.03.2018, 11:47 +0100 schrieb Alexandre Belloni:
> > > > +
> > > > +	tv64.tv_sec = rtc_tm_to_time64(&tm);
> > > Why not using an unsigned long long directly here? time64_t is not the
> > > correct type.
> > Do you mean timespec64 is not the correct type here?
> > Then yes, sould be time64_t.
> > If you mean time64_t is not the correct type here,
> > then can you give me some detail why there is no rtc_tm_to_u64,
> > or something like that?
> The rtc subsystem forbids negative times, the proper type should be
> unsigned.
I will add rtc_vaild_tm check.

Which sequence for time conversion would you expect?

time64_t secs = rtc_tm_to_time64(&tm);
BUG_ON(secs < 0);
return sprintf(buf, "%llu\n", (unsigned long long)secs);

or

return sprintf(buf, "%llu\n", (unsigned long long)rtc_tm_to_time64(&tm));
> 
> > 
> > sprintf(buf, "%lld\n", rtc_tm_to_time64(&tm)) seems correct to me.
> > By the way, is it needed to check for seconds < 0 and return error?
> Indeed, you shoud check the tm with rtc_valid_tm before calling
> rtc_tm_to_time64.
> 
> > 
> > > 
> > > > 
> > > > -	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
> > > > +	if (id->driver_data == TYPE_ISL1219) {
> > > > +		rc = i2c_smbus_write_byte_data(client, ISL1208_REG_09, 0x10);
> > > > +		if (rc < 0) {
> > > > +			dev_err(&client->dev, "could not enable tamper detection\n");
> > > > +			return rc;
> > > > +		}
> > > > +		isl1208->sysfs_files = &isl1219_rtc_sysfs_files;
> > > > +	} else {
> > > > +		isl1208->sysfs_files = &isl1208_rtc_sysfs_files;
> > > > +	}
> > > > +
> > > I don't think the whole isl1208 is necessary. You should probably use
> > > the .is_visible callback of isl1219_rtc_sysfs_files. This will make the
> > > changelog quite smaller.
> > > 
> > Well, I don´t know how to access i2c_device_id from kobject.
> > rtc_attr_is_visible shows how to convert kobject to device and rtc_device,
> > but how to do (id->driver_data == TYPE_ISL1219) here?
> I'd use i2c_set_clientdata/i2c_get_clientdata but I agree that then it
> is basically the same as having isl1208->sysfs_files.
> 
> but this makes me realize that the timestamp file doesn't end up at the
> correct location. What you do now is placing it under the i2c device
> while it should be placed under the rtc device (i.e. in
> /sys/class/rtc/rtcX/). This was a mistake made back in 2006.
> 
> I guess you'll have to add a new group instead of adding to the current
> one.
I guess I found a way to do it.

static struct attribute *isl1219_rtc_attrs[] = {
	&dev_attr_timestamp0.attr,
	NULL
};

in probe
	if (id->driver_data == TYPE_ISL1219) {
		sysfs_merge_group(&rtc->kobj, &isl1219_rtc_sysfs_files);

in remove
	struct rtc_device *rtc = i2c_get_clientdata(client);
	sysfs_unmerge_group(&rtc->kobj, &isl1219_rtc_sysfs_files);

As far as I got it, I can call unmerge even if group was not merged before.
If it works I don´t need struct isl1208 at all.
> 
Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht Nürnberg HRA 11756 –
Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing. Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
___________________________________________________________________________________________________
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
