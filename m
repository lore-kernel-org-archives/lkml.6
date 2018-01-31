Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeAaKyX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 05:54:23 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:42117 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeAaKyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 05:54:20 -0500
Date: Wed, 31 Jan 2018 11:54:18 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Denis OSTERLAND <denis.osterland@diehl.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
Message-ID: <20180131105418.GP2809@piout.net>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-5-m.grzeschik@pengutronix.de>
 <20180123182254.GA27379@roeck-us.net>
 <20180124090333.r5o2mzpm4q536w4r@pengutronix.de>
 <20180129215919.GA17988@roeck-us.net>
 <20180130102740.GD2809@piout.net>
 <1517312409.5307.22.camel@diehl.com>
 <d2b91530-90ae-2d4f-8940-9d88b68caf2c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2b91530-90ae-2d4f-8940-9d88b68caf2c@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2018 at 06:15:18 -0800, Guenter Roeck wrote:
> On 01/30/2018 03:40 AM, Denis OSTERLAND wrote:
> > Am Dienstag, den 30.01.2018, 11:27 +0100 schrieb Alexandre Belloni:
> > > On 29/01/2018 at 13:59:19 -0800, Guenter Roeck wrote:
> > > > 
> > > > On Wed, Jan 24, 2018 at 10:03:33AM +0100, Michael Grzeschik wrote:
> > > > [ ... ]
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > +
> > > > > > > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> > > > > > > index fc337c317c673..a12b3c2b2a18c 100644
> > > > > > > --- a/Documentation/hwmon/sysfs-interface
> > > > > > > +++ b/Documentation/hwmon/sysfs-interface
> > > > > > > @@ -702,6 +702,13 @@ intrusion[0-*]_alarm
> > > > > > >   		the user. This is done by writing 0 to the file. Writing
> > > > > > >   		other values is unsupported.
> > > > > > > +intrusion[0-*]_timestamp
> > > > > > > +		Chassis intrusion detection
> > > > > > > +		YYYY-MM-DD HH:MM:SS UTC (ts.sec): intrusion detected
> > > > > > > +		RO
> > > > > > > +		The corresponding timestamp on which the intrustion
> > > > > > > +		was detected.
> > > > > > > +
> > > > > > Sneaky. Nack. You don't just add attributes to the ABI because you want it,
> > > > > > without serious discussion, and much less so hidden in an RTC driver
> > > > > > (and even less as unparseable attribute).
> > > > > Right; but it was not meant to be sneaky. I should have stick to my first
> > > > > thought and label this patch RFC. Sorry for that.
> > > > > 
> > > > > > 
> > > > > > In addition to that, I consider the attribute unnecessary. The intrusion
> > > > > > already generates an event which should be sufficient for all practical
> > > > > > purposes.
> > > > > Would it make sense in between the other sysfs attributes of this driver?
> > > > > 
> > > > I don't understand what you mean with that, sorry.
> > > > 
> > > >  From an ABI perspective, the attibute doesn't add value since it is
> > > > highly device specific (or at least it is the only chip I am aware of
> > > > which reports such a time stamp). Feel free to add the attribute to the
> > > > driver and document it, but not as part of the hwmon ABI. In that
> > > > case I would be inclined to accept it. However, keep in mind that
> > > > your version, reporting a human readable date/time, would effectively
> > > > preclude it from ever making it into the ABI.
> > > > 
> > > Actually, there are many RTCs that are able to register one or more
> > > timestamps. My plan was to add support for that soon but I was not
> > > planning to do so in the hwmon ABI as this may be used for something
> > > that is not intrusion detection (interval timers for example).
> > What would you suggest?
> > I think about something like this:
> > event[0-*]_timestamp: timestamp in seconds since epoch or empty if not triggered
> > event[0-*]_alarm: 1 if event was triggered, else 0; write 0 to clear event
> 
> Sure, that makes sense if the events are not specifically related
> to intrusion detection. Question is if there would ever be more than one
> or if event_timestamp and event_alarm would be sufficient.
> 

My target is a PCF85363A which supports up to 3 timestamps. SO I'd go
for timestamp[0-*]. This would be empty if it never triggered (or the
timestamp is invalid) writing anything to that file resets the event. I
don't think we need more than one file per timestamp.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
