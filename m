Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeDHCpG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 22:45:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752034AbeDHCpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 22:45:03 -0400
Message-ID: <cbfc3cfa8acbc02dde848ec4e1d71b5089ff1d10.camel@redhat.com>
Subject: Re: simultaneous voice/data works (was Re: call/normal switch was
 Re: omap4-droid4: voice call support was)
From: Dan Williams <dcbw@redhat.com>
To: Pavel Machek <pavel@ucw.cz>, Merlijn Wajer <merlijn@wizzup.org>
Cc: Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Date: Sat, 07 Apr 2018 21:44:59 -0500
In-Reply-To: <20180407122233.GA11302@amd>
References: <20180401153631.GA5700@atomide.com>
         <20180401173012.GB5700@atomide.com>
         <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
         <20180402155754.GD5700@atomide.com> <20180403150444.GE5700@atomide.com>
         <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
         <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
         <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
         <20180407081000.GB7818@amd> <20180407122233.GA11302@amd>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-04-07 at 14:22 +0200, Pavel Machek wrote:
> On Sat 2018-04-07 10:10:00, Pavel Machek wrote:
> > Hi!
> > 
> > It seems qmicli can be used while unicsy_demo/ofone talks to the
> > modem
> > using the AT commands.
> > 
> > So I could do:
> > 
> > qmicli -d /dev/cdc-wdm0 --wds-follow-network --wds-start-
> > network=apn=internet.t-mobile.cz
> > route del default
> > sudo ifconfig wwan0 up
> > dhclient wwan0
> > 
> > to get GPRS/UMTS connection. AT commands still work.
> > 
> > Does anyone have any idea what to do to get the GPS to work?
> 
> Got that to work.
> 
> I installed modemmanager -- unfortunately that claims ttyUSB4 so it
> breaks voice/sms -- but then

It shouldn't break SMS since MM will do SMS via QMI, but yeah for now
it'll break voice because that would happen via QMI too, and we haven't
implemented voice for QMI yet.

--help-messaging
--help-sms

Also available via D-Bus of course.

> mmcli -m 0 --enable
> mmcli -m 0  --location-enable-gps-nmea
> watch -n .3 sudo mmcli -m 0  --location-get-gps-nmea
> 
> ...can be used to get GPS data. Droid4 seems to have rather bad GPS,
> so you should probably put it near window for testing.
> 
> Is there way to grab data from modemmanager and feed it to gpsd, so
> that normal applications can access gps? I don't see easy way.
> 
> I tried --location-enable-gps-unmanaged , but that did not work for
> me.

That requires a TTY that would spit out the GPS data; in this mode MM
only sends the start/stop commands, and what comes out the GPS TTY is
undefined (at least by MM).

So unless you know that one of the 6600's TTYs does GPS and in what
format it does GPS, then no.

Doesn't --location-get-gps-nmea work for you?  That will spit out the
latest NMEA traces MM gets from the modem, if it supports NMEA.  I
believe --location-status will tell you what methods MM supports with
the modem.

Also available via D-Bus of course.

> Is modemmanager enabling GPS, or is it talking to libqmi to do that?
> The code is quite confusing to me...

Yes.  When the modem is driven with QMI, then all the data comes from
QMI.  For other modems (like Huawei HiLink and Gobi 1000) the enabling
commands are done via AT on the main command port and then one of the
TTYs starts spewing out NMEA.

Dan
