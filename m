Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeDCPEz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:04:55 -0400
Received: from muru.com ([72.249.23.125]:35006 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751772AbeDCPEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:04:49 -0400
Date: Tue, 3 Apr 2018 08:04:44 -0700
From: Tony Lindgren <tony@atomide.com>
To: Dan Williams <dcbw@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
Message-ID: <20180403150444.GE5700@atomide.com>
References: <20180331181935.GX5700@atomide.com>
 <20180331191939.GA8999@amd>
 <20180331194616.GA19388@amd>
 <20180331195524.GB19388@amd>
 <20180331234314.GZ5700@atomide.com>
 <20180401131852.GA11086@amd>
 <20180401153631.GA5700@atomide.com>
 <20180401173012.GB5700@atomide.com>
 <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402155754.GD5700@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180402 15:59]:
> * Dan Williams <dcbw@redhat.com> [180402 15:51]:
> > On Sun, 2018-04-01 at 10:30 -0700, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [180401 15:38]:
> > > Found it! Here's what I need to do over n_gsm:
> > > 
> > > ngsm 1 "AT+CFUN=1"
> > > ngsm 1 "AT+CFUN?"
> > > ngsm 2 "AT+EACC=3,0"    # enable mic
> > > ngsm 2 "AT+CLVL=4"      # set speaker volume
> > > ngsm 2 "AT+CMUT=0"      # unmute mic
> > 
> > I tried to look through the QMI dumps we have in libqmi from 2013
> > (latest Qualcomm posted) and couldn't find anything to do with mic
> > control, speaker volume, or anything like that.
> > 
> > If the modem supports the AT service (which I think it does?  Not
> > looking at the libqmi dumps right now) then it could potentially tunnel
> > these AT commands through QMI too.
> > 
> > Perhaps Qualcomm added something to the Voice service after 2013, or
> > perhaps there are other services that might control speaker/mic that we
> > don't have public dumps for yet though.
> 
> OK thanks for checking. So probably only n_gsm channel 1 is for normal
> Qualcomm at commands, and then channel 2 and others are commands
> implemented by Motorola on the mdm6600.
> 
> I guess we'd have to add support for reading and writing to
> /dev/gsmtty2 at least as it looks like these cannot be accessed
> via /dev/ttyUSB4. Or at least I have not figured out any other
> way to access them.

Hmm or maybe there is some way to select where qmi to tunnels the
AT commands to? Some kind of channel type paramenter like n_gsm
has?

Anyways, for trying to figure out things for alsamixer, I tested
that ngsm 2 "AT+EACC=3,0" is not related to cpcap audio register
settings and the mic is enabled during the call with Pavel's patch
with alsamixer "Mode" set to either "Call" or "Normal". Also speaker
keeps working during the call toggling between "Call" and "Normal".
"Voice" in alsamixer does also control the speaker volume during
the call. And setting the second "Speaker" from "Voice" to "HiFi"
mutes the speaker.

Then alsamixer capture settings for "Mic2" do change the mic gain
as expected, and setting "Right" to "Off" mutes the mic. And then
setting "Left" to "Mic 2" turns on the mic again.

So my guess is that ngsm 2 "AT+EACC=3,0" and ngsm 2 "AT+CLVL=4"
might control some external amp over the mdm6600 gpio pins?
With "AT+CLVL" values being 0 7 it sounds like 3 gpios for that?

Regards,

Tony
