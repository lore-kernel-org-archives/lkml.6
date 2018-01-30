Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeA3LkR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:40:17 -0500
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:62383 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751378AbeA3LkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:40:15 -0500
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.46,434,1511823600";
   d="scan'208";a="27625178"
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
Thread-Topic: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
Thread-Index: AQHTlERFJ9rR3DV/NEGUfbSKRuIBAKOBtRIAgAD2DYCACLRngIAA0RcAgAAUQIA=
Date: Tue, 30 Jan 2018 11:40:10 +0000
Message-ID: <1517312409.5307.22.camel@diehl.com>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
         <20180123121801.4214-5-m.grzeschik@pengutronix.de>
         <20180123182254.GA27379@roeck-us.net>
         <20180124090333.r5o2mzpm4q536w4r@pengutronix.de>
         <20180129215919.GA17988@roeck-us.net> <20180130102740.GD2809@piout.net>
In-Reply-To: <20180130102740.GD2809@piout.net>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.153.3.249]
MIME-Version: 1.0
X-GBS-PROC: PkB65aL1SqtESF35r/jQnyKwu3BnHvZ+4gDQVggCyZQw1vhJEIIjR/w0iV2VNe+i
X-MIMETrack: Itemize by SMTP Server on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 30.01.2018 12:40:12,
        Serialize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 30.01.2018 12:40:12,
        Serialize complete at 30.01.2018 12:40:12,
        Itemize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 30.01.2018 12:40:12,
        Serialize by Router on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 30.01.2018 12:40:12
X-TNEFEvaluated: 1
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <5A4D96A557CE6B4089A5DBBCE3B01A53@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UBeMfY014629

Am Dienstag, den 30.01.2018, 11:27 +0100 schrieb Alexandre Belloni:
> On 29/01/2018 at 13:59:19 -0800, Guenter Roeck wrote:
> > 
> > On Wed, Jan 24, 2018 at 10:03:33AM +0100, Michael Grzeschik wrote:
> > [ ... ]
> > > 
> > > > 
> > > > > 
> > > > > +
> > > > > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> > > > > index fc337c317c673..a12b3c2b2a18c 100644
> > > > > --- a/Documentation/hwmon/sysfs-interface
> > > > > +++ b/Documentation/hwmon/sysfs-interface
> > > > > @@ -702,6 +702,13 @@ intrusion[0-*]_alarm
> > > > >  		the user. This is done by writing 0 to the file. Writing
> > > > >  		other values is unsupported.
> > > > >  
> > > > > +intrusion[0-*]_timestamp
> > > > > +		Chassis intrusion detection
> > > > > +		YYYY-MM-DD HH:MM:SS UTC (ts.sec): intrusion detected
> > > > > +		RO
> > > > > +		The corresponding timestamp on which the intrustion
> > > > > +		was detected.
> > > > > +
> > > > Sneaky. Nack. You don't just add attributes to the ABI because you want it,
> > > > without serious discussion, and much less so hidden in an RTC driver
> > > > (and even less as unparseable attribute).
> > > Right; but it was not meant to be sneaky. I should have stick to my first
> > > thought and label this patch RFC. Sorry for that.
> > > 
> > > > 
> > > > In addition to that, I consider the attribute unnecessary. The intrusion
> > > > already generates an event which should be sufficient for all practical
> > > > purposes.
> > > Would it make sense in between the other sysfs attributes of this driver?
> > > 
> > I don't understand what you mean with that, sorry.
> > 
> > From an ABI perspective, the attibute doesn't add value since it is
> > highly device specific (or at least it is the only chip I am aware of
> > which reports such a time stamp). Feel free to add the attribute to the
> > driver and document it, but not as part of the hwmon ABI. In that
> > case I would be inclined to accept it. However, keep in mind that
> > your version, reporting a human readable date/time, would effectively
> > preclude it from ever making it into the ABI.
> > 
> Actually, there are many RTCs that are able to register one or more
> timestamps. My plan was to add support for that soon but I was not
> planning to do so in the hwmon ABI as this may be used for something
> that is not intrusion detection (interval timers for example).
What would you suggest?
I think about something like this:
event[0-*]_timestamp: timestamp in seconds since epoch or empty if not triggered
event[0-*]_alarm: 1 if event was triggered, else 0; write 0 to clear event
> 
> 
Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht Nürnberg HRA 11756 –
Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing. Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
___________________________________________________________________________________________________
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
