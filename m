Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbeA3JG3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:06:29 -0500
Received: from enterprise03.smtp.diehl.com ([193.201.238.214]:55345 "EHLO
        enterprise03.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751360AbeA3JGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:06:23 -0500
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.46,433,1511823600";
   d="scan'208";a="6769139"
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "robh@kernel.org" <robh@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
Thread-Topic: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
Thread-Index: AQHTlERFJ9rR3DV/NEGUfbSKRuIBAKOLfCYAgACa9AA=
Date: Tue, 30 Jan 2018 08:56:23 +0000
Message-ID: <1517302582.5307.16.camel@diehl.com>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
         <20180123121801.4214-5-m.grzeschik@pengutronix.de>
         <20180129234146.73hvclxohhme5i2w@rob-hp-laptop>
In-Reply-To: <20180129234146.73hvclxohhme5i2w@rob-hp-laptop>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.153.3.249]
MIME-Version: 1.0
X-GBS-PROC: 415AWy8o668fDtCxszluz71SDQ3CLOstM/3bmRsh2YMWa1fYjOnVtF4wvXhe8O3y
X-MIMETrack: Itemize by SMTP Server on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 30.01.2018 09:56:24,
        Serialize by ntm_grab.EXE on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 30.01.2018 09:56:24,
        Serialize complete at 30.01.2018 09:56:24,
        Itemize by ntm_grab.EXE on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 30.01.2018 09:56:24,
        Serialize by Router on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP9 HF139|October
 06, 2017) at 30.01.2018 09:56:24
X-TNEFEvaluated: 1
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <FDA482DA2A6C5B4F8CE2104908DD4BA1@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0U96Z1T024774

Am Montag, den 29.01.2018, 17:41 -0600 schrieb Rob Herring:
> On Tue, Jan 23, 2018 at 01:18:01PM +0100, Michael Grzeschik wrote:
> > 
> > We add support for the ISL1219 chip that got an integrated tamper
> > detection function. This patch implements the feature by using an hwmon
> > interface.
> > 
> > The ISL1219 can also describe the timestamp of the intrusion
> > event. For this we add the documentation of the new interface
> > intrusion[0-*]_timestamp.
> > 
> > The devicetree documentation for the ISL1219 device tree
> > binding is added with an short example.
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> > ---
> >  .../rtc/{intersil,isl1208.txt => isil,isl1208.txt} |  18 +-
> >  Documentation/hwmon/sysfs-interface                |   7 +
> >  drivers/rtc/rtc-isl1208.c                          | 190 +++++++++++++++++++--
> >  3 files changed, 201 insertions(+), 14 deletions(-)
> >  rename Documentation/devicetree/bindings/rtc/{intersil,isl1208.txt => isil,isl1208.txt} (57%)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt b/Documentation/devicetree/bindings/rtc/isil,isl1208.txt
> > similarity index 57%
> > rename from Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> > rename to Documentation/devicetree/bindings/rtc/isil,isl1208.txt
> > index a54e99feae1ca..d549699e1cfc4 100644
> > --- a/Documentation/devicetree/bindings/rtc/intersil,isl1208.txt
> > +++ b/Documentation/devicetree/bindings/rtc/isil,isl1208.txt
> > @@ -1,14 +1,21 @@
> > -Intersil ISL1208, ISL1218 I2C RTC/Alarm chip
> > +Intersil ISL1208, ISL1218, ISL1219 I2C RTC/Alarm chip
> >  
> >  ISL1208 is a trivial I2C device (it has simple device tree bindings,
> >  consisting of a compatible field, an address and possibly an interrupt
> >  line).
> >  
> > +ISL1219 supports tamper detection user space representation through
> > +case intrusion hwmon sensor.
> User space and hwmon are Linux details not relevant to the binding. Just 
> describe the h/w.
OK.
> 
> > 
> > +ISL1219 has additional pins EVIN and #EVDET for tamper detection.
> > +I2C devices support only one irq. #IRQ and #EVDET are open-drain active low,
> > +so it is possible layout them to one SoC pin with pull-up.
> > +
> >  Required properties supported by the device:
> >  
> >   - "compatible": must be one of
> >  	"isil,isl1208"
> >  	"isil,isl1218"
> > +	"isil,isl1219"
> >   - "reg": I2C bus address of the device
> >  
> >  Optional properties:
> > @@ -33,3 +40,12 @@ Example isl1208 node with #IRQ pin connected to SoC gpio1 pin 12:
> >  		interrupt-parent = <&gpio1>;
> >  		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
> >  	};
> > +
> > +Example isl1219 node with #IRQ pin and #EVDET pin connected to SoC gpio1 pin 12:
> > +
> > +	isl1219: isl1219@68 {
> > +		compatible = "intersil,isl1219";
> > +		reg = <0x68>;
> > +		interrupts-extended = <&gpio1 12 IRQ_TYPE_EDGE_FALLING>;
> With 2 interrupts, you should have 2 values. If they are connected 
> together, just repeat the connection. Otherwise, you can't tell if EVDET 
> is a no connect.
If I got you right, you suggest an additional IRQ entry to parse.
A short example, #IRQ pin connected to gpio1 pin 12 and
#EVDET pin connected to gpio2 pin 24:

isl1219: rtc@68 {
	compatible = "intersil,isl1219";
	reg = <0x68>;
	interrupt-names = "irq", "evdet";
	interrupts-extended = <&gpio1 12 IRQ_TYPE_EDGE_FALLING>,
		<&gpio2 24 IRQ_TYPE_EDGE_FALLING>;
};

In driver implementation we need only one interrupt, because we can
determinate action to take based on value of status register.
In current implementation there was no need to do some additional
OF parsing, everything is done by I2C generic code.
I guess, it is not much additional work to do so, but I am not sure
if it´s worthwhile.
> 
> There's not much point in having an example for every compatible. This 
> binding is simple enough, one should be enough.
Shell we remove the example without an interrupt?
> 
> > 
> > +	};
> > +
Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht Nürnberg HRA 11756 –
Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing. Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
___________________________________________________________________________________________________
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
