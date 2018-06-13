Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 64899C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0078C20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAcJJ0GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0078C20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbeFMIVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:21:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37344 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754495AbeFMIVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:21:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21-v6so2560754lfb.4;
        Wed, 13 Jun 2018 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T6qg6UCjQAwYCS9VdsMHSuJQTbAaeOOLE2+JM83EzDY=;
        b=FAcJJ0GFChW0p8Yc1Qar+Z6H2iFsC+ytthWcbpaNwlk1IMuzV9rT9zSQX2DXgsLG6F
         seSCnzsiiPYdqAtdwr4OWmRQVRGA1Z5XXJcgKaGf+0Kf69eBtZFbfgeEvOHJEP8RXSLe
         Z7v/50W/8FTKC/J7LxjZOfBpEcsQCbM5EQ80QV2KGWirtexu7cSVTRJqy7CqIqYtLWKT
         LKeM+qVp5uDPwE8sUxlwqIc6Zu4o43NQdf6oOCGsOoGXaWq2xpRuxgJ9Jf6knJ21WYgj
         82wLhyPxogarr7LmlD5W7PuH4ZuMhl4aw6IXKYrnpdiNGvA0bM0Oxte1WmDnvl9x4O74
         Zp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T6qg6UCjQAwYCS9VdsMHSuJQTbAaeOOLE2+JM83EzDY=;
        b=lpykmj6TSleuXmfbzTOigOHvA/RjxatYYRegycweEgC0d+MAiVCr22i/hT9pBZExoy
         j1gNKmQoR9169u5Jzio1Z04tFzIl4Pf1hPe8uJwIAo/VW9Wvsrmjz95wX0qaZv1a7y1c
         n0a8OejEukbxRgGVC7ORnuwWuIemav0XUPc98vRMK1mq337npNcZapxGhSIKCiS5w7G9
         ceJZBsACfPNvWJDV2W9l/vWWAxVA/AJHPTwdasJtqj+/VjjKUYWsTpJ73e3WCStuiBaH
         FgGxQonLCuNj4a45zl/G50KalYpuRDd/BQjLlsyf2FTw0pnLENG0FIPhuYlWHp7M9a78
         8IVg==
X-Gm-Message-State: APt69E1APz5doYGyAJBuiHw1rE3vxpdIh9cG3IShgrFU7lllSshYRsgU
        HlkaAR8nq8gDaP4KzRa+QWQ=
X-Google-Smtp-Source: ADUXVKJrA3EeroFlgh+T7Tl6rlZxBD1ONMTHyTn1Xb8I+yhjb15L4wmn0dhowipXpCT7Ho48F80PMA==
X-Received: by 2002:a2e:5d81:: with SMTP id v1-v6mr2378205lje.137.1528878107393;
        Wed, 13 Jun 2018 01:21:47 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id w6-v6sm441374ljw.70.2018.06.13.01.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 01:21:46 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fT11v-0008CN-Tf; Wed, 13 Jun 2018 10:21:23 +0200
Date:   Wed, 13 Jun 2018 10:21:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180613082123.GB30381@localhost>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180601093311.GA31639@amd>
 <20180601094959.GA13775@localhost>
 <20180601102612.GC31639@amd>
 <20180601122217.GB13775@localhost>
 <20180601162645.GA30792@amd>
 <20180604102238.GC13775@localhost>
 <20180605214752.GB28143@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605214752.GB28143@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 11:47:52PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > udev solves device discovery pretty well; I don't think that's good
> > > thing to optimize for.
> > 
> > It's about grouping related devices together, devices which share some
> > common functionality. In this case, providing location data from some
> > satellite system. I really don't understand how you can find having a
> > class type named "gnss" for this to be controversial in any way.
> 
> We normally group devices by interface, not by functionality.

And interfaces also tend to reflect functionality.

> > > (And.. I'd really prefer /dev/nmeaX and /dev/sirfX in that situation;
> > > and yes that makes it _even easier_ for location service to find right
> > > devices). 
> > 
> > As I've already explained, you may not know which protocol is currently
> > active when the device start and you typically switch from NMEA to a
> > vendor protocol during runtime (e.g. for configuration or to access raw
> > GNSS data).
> > 
> > Trying to encode the GNSS protocol in the character-device node name is
> > just a bad idea.
> 
> I thought idea was to switch to the "best" protocol in kernel.

I'm afraid it's not that simple; the vendor protocols are not always
supersets of the data and commands provided by the NMEA modes.
Apparently, some data is only available in NMEA mode for SiRF devices,
for example, so we need to provide some flexibility here.

> > > > As mentioned in the cover letter, we may eventually want to add support
> > > > for some kinds of configuration from within the kernel (e.g. protocol
> > > > and line speed changes).
> > > 
> > > I believe we'll eventually want "real" GPS drivers, with common
> > > interface. input was in this situation before...
> > 
> > As we also already discussed, there's nothing preventing you from trying
> > to move gpsd into the kernel later. I doubt this is something we want,
> > and it may turn out not to be feasible for other reasons.
> 
> Well -- I believe we want "gpsd in kernel". If you take /dev/gnss0 and
> drivers/gnss now, where do I put them?

The subsystem would still live under drivers/gnss. If there's ever going
to be an in-kernel gpsd, then maybe /dev/gnss0 could have been used for
it instead (if a character device is even the right interface).

I started off with separating the gnss device itself from the raw
interface (cf. hid) to allow for something like that, but the more I
looked into this the more it seems I was just over-engineering for
something that would never be realised.

Take a look at some of the papers on the gpsd site about GNSS protocols
and the problem of finding a common representation for all the various
devices out there. gpsd itself has already gone through three revisions
of its internal representation over the past decades. This does not seem
like an exercise we want to repeat in the kernel with its rules about
backwards compatibility etc.

So at least for the time being, I'm convinced that a raw gnss interface
is the right one.

> > Ok, so I did read the damn thing along with the overview of the N900 GPS
> > hardware and reverse-engineered protocol (why didn't you point me to
> > those instead?) and I'm still not sure what the point you're trying to
> > make is.
> 
> Umm. Where did you find the hardware overview/protocol overview?

It looks like Sebastian (and others) once put something together here:

	https://wiki.maemo.org/N900_Hardware_GPS
	https://wiki.maemo.org/N900_GPS_Reverse_Engineering

> > The n900 service you link to above, parses phonet data, does some
> > *floating point* calculations and generates NMEA sentences which it
> > feeds to a pseudo terminal whose slave side is opened by gpsd.
> > 
> > That NMEA data could just as easily be fed through a different kernel
> > subsystem, namely gnss instead of tty, where it could be accessed
> > through a common interface (for now, a raw gnss interface, with some
> > associated meta data). [ And from what I can tell, ugnss would also
> > allow you to get rid of some hacks related to finding out when the GNSS
> > is opened and needs to be powered on. ]
> > 
> > So the ugnss interface looks like it will work for N900 just as it will
> > for other phones.
> 
> Not NMEA please. First, NMEA has strange format of latitude/longitude
> -- that's those calculations IIRC. NMEA has other problems, too --
> like not atomically providing speeds and accuracies. Plus it is crazy
> text protoco with CRCs.

Then of course you also have the issue that all of user space would need
to be taught to understand this yet-to-be-conceived generic protocol.

> > > NMEA would not be my first choice, really. I'd propose something very
> > > similar to existing /dev/input/eventX, but with wider data types.
> > 
> > Fine, you pursue that idea if you want then. I can see many problems
> > with trying to so, but the point is, this series doesn't prevent you
> > from doing so.
> 
> > If you think you'll one day be able to parse and repackage the various
> > vendor protocols within the kernel, you can consider the raw gnss
> > interface as an intermediate step (which may continue to exist in
> > parallel just as say hidraw).
> > 
> > As I've already mentioned, I considered naming the device nodes
> > /dev/gnssraw0 partly because it would leave /dev/gnss namespace free for
> > any such future development. I ultimately found that idea to be too
> > implausible for it to be worth the potential confusion arising from the
> > fact that "raw" GNSS data is already has an established meaning.
> > 
> > But in the end, this is just name bike shedding.
> 
> So I agree /dev/gnssraw is not great. But /dev/gnss is even worse. And
> yes, it is "just" a naming, but it will be impossible to fix later.
> 
> /dev/serdev? /dev/gnssproto?

Again, the gnss subsystem is transport agnostic so /dev/serdev is not
an option.

gpsd uses the term "raw" for its raw access to the device protocol.
Probably best to use "gnssraw" in case this needs to be changed at all.

Thanks,
Johan
