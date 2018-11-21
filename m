Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4DAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212B02075B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212B02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rwth-aachen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbeKVIw1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:52:27 -0500
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:47433 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731864AbeKVIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:52:27 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AEDQAN2PVb/5wagoZiHgEGBwaBZQKBL?=
 =?us-ascii?q?1OBaCcKmhKXTIFmDAEsgUuCdQKECiI4EgEDAQECAQECbShCARABBAGEYwEBAQM?=
 =?us-ascii?q?BJ0UKAxACAQgOCgklDwEiJQIEDgWFGwgBA6xOM4omjAWBWD6DJX6EQiARC4VbA?=
 =?us-ascii?q?odVgzuESY9PVQcCgRGQM4FZiAIrhwCHU5AxAgICAgkCFIFdIYFVTSSDO5BaQTG?=
 =?us-ascii?q?BKIRahFiCXAGBHgEB?=
X-IPAS-Result: =?us-ascii?q?A2AEDQAN2PVb/5wagoZiHgEGBwaBZQKBL1OBaCcKmhKXTIF?=
 =?us-ascii?q?mDAEsgUuCdQKECiI4EgEDAQECAQECbShCARABBAGEYwEBAQMBJ0UKAxACAQgOC?=
 =?us-ascii?q?gklDwEiJQIEDgWFGwgBA6xOM4omjAWBWD6DJX6EQiARC4VbAodVgzuESY9PVQc?=
 =?us-ascii?q?CgRGQM4FZiAIrhwCHU5AxAgICAgkCFIFdIYFVTSSDO5BaQTGBKIRahFiCXAGBH?=
 =?us-ascii?q?gEB?=
X-IronPort-AV: E=Sophos;i="5.56,262,1539640800"; 
   d="scan'208";a="61875155"
Received: from rwthex-w1-a.rwth-ad.de ([134.130.26.156])
  by mail-in-1.itc.rwth-aachen.de with ESMTP; 21 Nov 2018 23:16:10 +0100
Received: from rwthex-w2-a.rwth-ad.de (2a00:8a60:1:e500::26:158) by
 rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Wed, 21 Nov 2018 23:16:09 +0100
Received: from rwthex-w2-a.rwth-ad.de ([fe80::18f3:313d:3e:42ff]) by
 rwthex-w2-a.rwth-ad.de ([fe80::18f3:313d:3e:42ff%21]) with mapi id
 15.01.1531.007; Wed, 21 Nov 2018 23:16:09 +0100
From:   =?iso-8859-1?Q?Br=FCns=2C_Stefan?= <Stefan.Bruens@rwth-aachen.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC][PATCH] hwmon: (ina2xx) Improve current and power reading
 precision
Thread-Topic: [RFC][PATCH] hwmon: (ina2xx) Improve current and power reading
 precision
Thread-Index: AQHUgTlMOgH+/TcWJ0m0L3+ib8kVa6VaVu4AgAA6FACAACtjgA==
Date:   Wed, 21 Nov 2018 22:16:09 +0000
Message-ID: <1717545.GXSegKtrMu@sbruens-linux.lcs.intern>
References: <20181121012629.5432-1-nicoleotsuka@gmail.com>
 <2863036.QIPGp1Eqjm@sbruens-linux.lcs.intern>
 <20181121194051.GA8902@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20181121194051.GA8902@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.153.130.132]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CA6EB60E46892E4F93344B5E046B6A91@rwth-ad.de>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 21. November 2018 20:40:52 CET Nicolin Chen wrote:
> (Removing "m.purski@samsung.com" since it's not reachable any more)
> 
> Hi Stefan,
> 
> Thank you for the comments.
> 
> On Wed, Nov 21, 2018 at 04:13:01PM +0000, Brüns, Stefan wrote:
> > > === Problem ===
> > > Both methods simplify software routine by fixing one factor, which
> > > sacrifices the precision of the hardware measurement results.
> > > 
> > > Using ina226 for example, with method A, the current scale was 1mA
> > > and the power scale was 25mA.
> > > 
> > > With method B, calibration value is fixed at 2048 so the precision
> > > is decided by shunt resistor value. It sounds reasonable since the
> > > hardware engineers can use a larger shunt resistor when they need
> > > higher resolution. However, they often concern power burning across
> > > the resistor as well, so the resistor usually won't be so large: a
> > > typical value 1000 micro-ohms, which results in a current scale at
> > > 2.5 mA and a power sacle at 62.5 mW.
> > 
> > Power loss surely is a concern, but figures should be kept reasonable.
> > 
> > 1. You mention 1.8V bus voltage, and currents in the 30mA range. Using the
> > 1mOhm current shunt:
> > 
> > U_S = R_S * I_S 1e-3 Ohm * 30e-3 A = 30e-6 V  (30uV)
> > P_S = U_S * I_S = 30e-6V * 30e-3 A = 900e-9W = 0.9 uW
> > 
> > INA219 Power Supply (Datasheet)
> > Min operating Voltage: 3V
> > Quiescent Current: 0.7mA
> > -> Min power: 2.1mW
> > 
> > So the INA219 alone uses 2.1mW, 1000 times more than the shunt.
> 
> Chip can enter power-down or one-shot mode. Though this upstream
> driver doesn't have these two mode supports yet, I am working on
> it so they'll be added.

The power-down current is 6uA, so even if you never leave power-down mode, you 
are down to 18uW. But on top of that, you need power for the conversion, and 
you need power for communication.

> > Another concern may be voltage drop over the shunt, but for this case you
> > have a nominal voltage of 1.8V, so 30uV are 0.001%.
> > 
> > > When measuring a 1.8v voltage running a small current (e.g. 33 mA),
> > > the power value (that's supposed to be 59.4 mW) becomes inaccurate
> > > due to the larger scale (25mA for method A; 62.5 mA for method B).
> 
> Just found out that I have typos here: 25mW and 62.5mW.
> 
> > Another look into the datasheet reveals, even at full gain (PGA=1), the
> > LSB is 40mV / 2^12 = 40mV / 4096 ~ 10uV. So when the current ADC reads
> > out as 3*LSB, this anything between 25mA and 35mA. This is the best case
> > figure.
> Current read doesn't get affected a lot actually, since hwmon ABI
> also reports current value in unit mA. However, the power read is
> the matter here. With a 62.5mW power_lsb, power results are kinda
> useless on my system.

The reported current does not matter here, actually. Internally, the ADC value 
will have an uncertainty of 10mA (at PGA=1). At 1.8V, your uncertainty is 
18mW. And thats *only* the quantization noise. It wont get better than that.

Also note, you are apparently using the ina2xx hwmon driver - I strongly 
advise against it, you should either use the ina2xx driver from the IIO 
subsystem directly, or use the IIO driver via iio-hwmon.

1. INA219 is not properly supported by the hwmon driver, see the changes in 
the IIO driver.
2. The IIO driver has many more features:
  - setting the PGA (INA219)
  - setting the bus voltage range (INA219)
  - selecting the conversion time (INA219/226)

There is also always the possibility to read the bus and shunt voltage 
registers and calculate the power manually.

Regards,

Stefan
