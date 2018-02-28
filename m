Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELu/B/srH/cDd2aBL26D7bOLf+VbLNxRA+7rALHmr5pzYljxMMt0Qjpy6vAFGlOZP5hCixMo
ARC-Seal: i=1; a=rsa-sha256; t=1519840388; cv=none;
        d=google.com; s=arc-20160816;
        b=QSXOMGlaHsO92IJTZHqIFIeA6oLo1sbegJsfD5GRC6aBCCp9fqgJl6D9pPMPnOnyP5
         gGjp3ZkMCO1lTpMl5Xi6VNibVvNgV5JYu8mr0xBYif3qV+1whFR2WJge+PG4h2LGUMuU
         d/2GD7u1pxuLzDdyRpK0XNH0zAXXncgzRqekuUNO2f4/L4UgsWWNwP2Vt8qhnYsC3cyr
         b3hRIGx5TzTGKYb+llnSJe582GNmA5FwFnQ3B0bfLT3xHi3d6UCbzVTSeqm9heYJvCyq
         D0yzSGn+JullXlwHwZlm4Z7xkkOyeC2RA2yszhkSNJUdcgpK37TSOztXkastD00Jy9OI
         WyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=LppGnK8QnPyInCW/XrVEITZFUXJSuuvDyMvzjCWxrdw=;
        b=PJ3jdwBlGLQOLAQHElS7FOm0FzZqSIxdtlooE5+b7Urb15x4KArhxAe59HHIa9eECJ
         8fvi01V4TqmUnqXLUfDDIIdlArTYBMDzfhgH24yfRCJx5hZdBtQemVyROeZW8UrtW/Nb
         I69ZCTHL/MGzElbzeLucxEHdX/H9WMSfI4r3GKmJ9QdrLdrInXZRyCk547t1DtrpXZkH
         uZUiMTwa8qrVatmzU2o8bLvejjFjZriHKlYhImHwPT+HRR+9rTt+j+kYpvYApgr7hWk0
         fBkE9XPZYcUrpTVhK4XfmFI2FabzKRRprmzHm+Etws52iW45gImSKnf1DUplY5yIEGlC
         9xMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Wed, 28 Feb 2018 17:53:03 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 0/3] STM32 Extended TrustZone Protection driver
Message-ID: <20180228175303.h7qm3zylmfsitmwn@lakrids.cambridge.arm.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227171124.h2yjhicmlfrwr4nh@lakrids.cambridge.arm.com>
 <CA+M3ks6qV_pGdE6mr3n7TiY9VhbqEkrdH6tN=8e-A=oa4UbDHw@mail.gmail.com>
 <11c3ceb2-8b8d-de59-a0be-0777a42f63a7@arm.com>
 <CA+M3ks5qR++8Vwwk8=5Oh6DBdT9NF3ysqfjayq4Gze-oke8Ayg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+M3ks5qR++8Vwwk8=5Oh6DBdT9NF3ysqfjayq4Gze-oke8Ayg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563499941739218?=
X-GMAIL-MSGID: =?utf-8?q?1593668155184564518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 08:53:28AM +0100, Benjamin Gaignard wrote:
> 2018-02-27 20:46 GMT+01:00 Robin Murphy <robin.murphy@arm.com>:
> > On 27/02/18 19:16, Benjamin Gaignard wrote:
> >> 2018-02-27 18:11 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> >>> On Tue, Feb 27, 2018 at 03:09:23PM +0100, Benjamin Gaignard wrote:
> >>>>
> >>>> On early boot stages STM32MP1 platform is able to dedicate some
> >>>> hardware blocks to a secure OS running in TrustZone.  We need to
> >>>> avoid using those hardware blocks on non-secure context (i.e.
> >>>> kernel) because read/write access will all be discarded.
> >>>>
> >>>> Extended TrustZone Protection driver register itself as listener
> >>>> of BUS_NOTIFY_BIND_DRIVER and check, given the device address, if
> >>>> the hardware block could be used in a Linux context. If not it
> >>>> returns NOTIFY_BAD to driver core to stop driver probing.

> >>> If these devices are not usable from the non-secure side, why are they
> >>> not removed form the DT (or marked disabled)?
> >>>
> >>> In other cases, where resources are carved out for the secure side (e.g.
> >>> DRAM carveouts), that's how we handle things.
> >>
> >> That true you can parse and disable a device a boot time but if DT
> >> doesn't exactly reflect etzpc status bits we will in trouble when
> >> try to get access to the device.
> >
> > Well, yes. If the DT doesn't correctly represent the hardware,
> > things will probably go wrong; that's hardly a novel concept, and
> > it's certainly not unique to this particular SoC.
> >
> >> Changing the DT is a software protection while etzpc is an hardware
> >> protection so we need to check it anyway.
> >
> > There are several in-tree DT and code examples where devices are marked as
> > disabled on certain boards/SoC variants/etc. because attempting to access
> > them can abort/lock up/trigger a secure watchdog reset/etc. The only
> > "special" thing in this particular situation is apparently that this device
> > even allows its secure configuration to be probed from the non-secure side
> > at all.
> >
> > Implementing a boardfile so that you can "check" the DT makes very little
> > sense to me; Linux is not a firmware validation suite.
> 
> It is not about to "check" the DT but if Linux could get access to the
> hardware.  Hardware block assignment to secure or non-secure world
> could change at runtime for example I2C block could be manage by
> secure OS for a trusted application and when it have finish "release"
> the it for Linux.

The driver does not do this today. It probe the HW once during early
boot, then aborts driver probes. It provides no provision for dynamic
assignment.

Is this something you plan to implement? How will the secure world
notify the non-secure world of its intent to manage a device, or
vice-versa?

> I don't think that could be done by changing DT.
> 
> I think that dhecking hardware blocks status bits before probe them is
> also more robust than let
> each driver discover at probe time that it hardware isn't responding.

I don't follow. Robin and I suggest that gets encoded in the DT, which
is *more* efficient than having each driver probe the DT, begin probing,
then abort via the notifier.

This really seems like something that should be done *prior* to entering
Linux.

Thanks,
Mark.
