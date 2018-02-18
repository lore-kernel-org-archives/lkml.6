Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeBRWuc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:50:32 -0500
Received: from leo.clearchain.com ([199.73.29.74]:16027 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeBRWub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:50:31 -0500
Date: Mon, 19 Feb 2018 08:50:24 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Chuck Ebbert <cebbert.lkml@gmail.com>,
        Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input device
Message-ID: <20180218225024.GB5348@jelly>
References: <1483370825.2420.8.camel@hadess.net>
 <201701021809.58943@pali>
 <1483442481.2420.12.camel@hadess.net>
 <60c21c4d-bb81-342a-45e1-7e92313e05d7@gmail.com>
 <1483540655.2420.18.camel@hadess.net>
 <20180102215437.i3x2j6jvxtac4ntt@pali>
 <1514944049.2523.28.camel@hadess.net>
 <20180103093133.u7wszegjk2msxryl@pali>
 <20180109020424.GC29886@jelly>
 <20180217211914.GB9640@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217211914.GB9640@amd>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 10:19:14PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > So, do you mean to implement this "disable" action as ioctl for
> > > > > particular /dev/input/event* device (instead of sysfs entry)?
> > > > 
> > > > Yes, so the device can be powered down without the device node being
> > > > closed and made unavailable. I don't know whether that's something
> > > > that's already possible for all cases, but there's already
> > > > opportunistic in a lot of drivers and subsystems.
> > > > 
> > > > This opens up a whole new wave of potential problems, but it's a more
> > > > generally useful mechanism, I would think.
> > > 
> > > Ok. How should API for this ioctl looks like? And do you have an idea
> > > for name of that ioctl?
> > > 
> > > Dmitry, what do you think about it? It is acceptable for you?
> > 
> > first: sysfs files are pretty terrible because writing to them requires root
> > and we don't have the benefit of logind. so for any sysfs toggle expect
> > a nicely integrated userspace solution to be less than optimal.
> 
> Well, you can chmod / chown sysfs files.

and that's what I meant by "less than optimal" :)
you're either chmodding, or suid, or any of the other solutions that aren't
really good in the long run.

> > besides: 99% of the above is figuring out the policy *when* to disable the
> > device. disabling it is trivial by just closing the evdev nodes and tbh I
> > don't think we (in userspace) should care about whether the device is
> > powered down or now, it should be the default assumption that it is powered
> > down when not in use.
> > 
> > for the cases where you must keep the device open but you don't want events, 
> > EVIOCSMASK is likely the best solution. improving the kernel so it powers
> > down the device when the mask excludes all events (and there are no other
> > listeners) could be an interesting task.
> 
> But yes, that sounds like an idea.
> 
> BTW in the meantime, someone added this to pmos wiki... this should
> solve some of my problems.
> 
> Best regards,
> 								Pavel
> 
> 
> 
> FILE=~/.screenoff
> if [ -f $FILE ]; then
>  xinput set-prop 8 "Device Enabled" 1
>  xinput set-prop 6 "Device Enabled" 1
>  xinput set-prop 9 "Device Enabled" 1
>  xset dpms force on
>  rm ~/.screenoff
> else
>  xinput set-prop 8 "Device Enabled" 0
>  xinput set-prop 6 "Device Enabled" 0
>  xinput set-prop 9 "Device Enabled" 0
>  xset dpms force off
>  touch ~/.screenoff
> fi

xinput can resolve device names, using device ids is likely to cause upset.
http://who-t.blogspot.com/2016/07/xinput-resolves-device-names-and.html

Cheers,
   Peter
