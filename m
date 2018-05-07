Return-Path: <bjorn.andersson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525732482; cv=none;
        d=google.com; s=arc-20160816;
        b=0ANvoRPLECspedd5tA9zYy8dn6inb0IKWEtSA7jtd8d6vP7iikRc14AGX1hMdSZPRv
         Z1xMGyxzCkTBmDU0TnpkSuuahwdSsLi/vZCunJfpjKmbIyoRbavjRGNZlnlW66corIwm
         XK2vwvNCUrsfpQ9CNNJx0o7HIHg21rfgp9Pg2CDva5w6jZy0rIy8KZV795MMCNgcoPAb
         e/lWG7D8NRD2gTP/ltKP2r3uZ2Rr22G0ZP3yUV8JwbHWNo/Zhq3Rc3gAr4gb6EZk+v7p
         9mlt+reIStMN5Mj/i0W868PzfwHAyiq/DwM6ASA0S11S9nz6ms7r4mebIesOWTCvmMJQ
         z6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=YF/pgL3Zsu6ghxCKmFZUQ1Py7+IXv5Wy/syhamACErU=;
        b=i+3uCAPl+04zTiGdQMK8nCMu7OzVUoShjulzlTufvIEEVTXgPY5BlXc57r2eQC+tnK
         5dmSlw/PVmOrS1zaofUcd2K7/aHlqoq8J/lp80JmBPGP0OXoy/Gtf4ZxJN0wRCE3DqyW
         MBL5XKugXz5C9B3YAeOaieasJ52qufmwkDF6xP5Ri0KJCxFO+f5YgnvjIQfvEg9SDqX4
         BrW83wmLaJSZpm4tqLJPW2raHmVhWtWJmmcmLHVAM+iEJ/9XquCUpig3jnf8d2oYh8QD
         Sml5Z1J8en72TrxF92DzmBcWH1fOsbs4PYpqgXKgfAu7gtemzwTrWNfyogFjZ+tci5m4
         LY0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=e86x30mR;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=e86x30mR;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpjnosMOzuChDNKUNCqhd1qttppe4nKawIhMU02O6wEsemQUBUrmx2H38RT8Z727/ku94wn9A==
Date: Mon, 7 May 2018 15:34:38 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Grant Likely <grant.likely@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Architecture Mailman List <boot-architecture@lists.linaro.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
Message-ID: <20180507223438.GB14924@minitux>
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
 <CAL_Jsq+PRUR5rCeV820XZuQmQH3gD-X=6a5fNuF-9qVbq5dqFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+PRUR5rCeV820XZuQmQH3gD-X=6a5fNuF-9qVbq5dqFg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599846464125351865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 07 May 12:55 PDT 2018, Rob Herring wrote:

> On Mon, May 7, 2018 at 1:31 PM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > On Tue 01 May 14:31 PDT 2018, Rob Herring wrote:
> >
> >> Deferred probe will currently wait forever on dependent devices to probe,
> >> but sometimes a driver will never exist. It's also not always critical for
> >> a driver to exist. Platforms can rely on default configuration from the
> >> bootloader or reset defaults for things such as pinctrl and power domains.
> >
> > But how do you know if this is the case?
> 
> Because the platform worked before adding the dependency in the dts.
> 

I'm worried about how to write dts files and drivers to support all
permutation of forward and backward dependencies. And you most
definitely have the same case with bootloader-enabled clocks,
regulators and interconnects.

> >> This is often the case with initial platform support until various drivers
> >> get enabled.
> >
> > Can you please name platform that has enough support for Alexander to
> > care about backwards and forwards compatibility but lacks a pinctrl
> > driver.
> 
> Alex will have to answer that. I do agree pinctrl drivers shouldn't be
> that hard because it is all just translating a bunch of pin data into
> one-time (mostly) register writes, so it shouldn't take that long to
> implement support. OTOH, maybe a pinctrl driver is low priority
> because nothing needs it yet. Either a given board works with the
> defaults and only some new board needs to change things or you don't
> need pinctrl until low power modes are implemented. However, power
> domains have the same problem and it can take years for those to get
> proper support.
> 
> Alex proposed declaring dts files stable and then enforcing
> compatibility after that point. If anyone believes that will work,
> then please send a patch marking all the platforms in the kernel tree
> that are stable.
> 

That might be a reasonable idea, but at least in our corner the current
decision that devicetree should be backwards compatible does make it
quite cumbersome to break this assumption - and in the cases we have had
to do it it's really been necessary.

> >> There's at least 2 scenarios where deferred probe can render
> >> a platform broken. Both involve using a DT which has more devices and
> >> dependencies than the kernel supports. The 1st case is a driver may be
> >> disabled in the kernel config.
> >
> > I agree that there is a chance that you _might_ get some parts of the
> > system working by relying on the boot loader configuration, but
> > misconfiguration issues applies to any other fundamental providers, such
> > as clocks, regulators, power domains and gpios as well.
> 
> If it is only a chance, then perhaps we shouldn't allow things
> upstream without proper drivers for all these things. That will only
> give users the wrong impression.
> 

It's not as much the drivers that's the problem here as it is the
composition of the drivers. For this particular case it would be
convenient not to ship the partial dtb, or at least not ship it with the
promise that it's stable.

> >> The 2nd case is the kernel version may
> >> simply not have the dependent driver. This can happen if using a newer DT
> >> (provided by firmware perhaps) with a stable kernel version.
> >>
> >
> > As above, this is in no way limited to pinctrl drivers.
> 
> Yes, I wasn't trying to imply that with this patch. I was just
> starting with 1 example. IOMMUs (which essentially is already doing
> what this patch does) and power domains are the main other 2.

qcom,iommu-v1 is bool, but depends on e.g. CONFIG_MSM_GCC_8916 which is
tristate. So you would need to s/tristate/bool/ everything in
drivers/clk/qcom/Kconfig as well. Not to mention that there are
interconnects and power domains actually involved here as well...

> Clocks is an obvious one too, but from the discussion I referenced
> that problem is a bit different as platforms change from dummy
> fixed-clocks to a real clock controller driver. That will need a
> different solution.

So how are you going to deal with the case when a vendor decides to ship
their firmware package with all clocks enabled and only fixed clocks
described in DT and as they upstream a clock driver and patch their
firmware to do the right thing?


(Or the much less extreme case where this happens for a single clock,
regulator, pinctrl, interconnect, etc to fix some bug/power management
behavior)

And is this really a problem that does not exists in the ACPI world?

> 
> >> Unfortunately, this change breaks with modules as we have no way of
> >> knowing when modules are done loading. One possibility is to make this
> >> opt in or out based on compatible strings rather than at a subsystem level.
> >> Ideally this information could be extracted automatically somehow. OTOH,
> >> maybe the lists are pretty small. There's only a handful of subsystems
> >> that can be optional, and then only so many drivers in those that can be
> >> modules (at least for pinctrl, many drivers are built-in only).
> >>
> >
> > On the Qualcomm platform most drivers are tristate and on most platforms
> > there are size restrictions in the proprietary boot loader preventing us
> > from boot the kernel after switching all these frameworks from tristate
> > to bool (which feels like a more appropriate solution than your hack).
> 
> BTW, QCom platforms are almost the only ones with pinctrl drivers as
> modules. They are also happen to be PIA to configure correctly for a
> board.
> 

There are a few pinctrl drivers for chips sitting on i2c busses, as such
changing this requirement would trickle down to a number of possible i2c
masters as well.

Sorry to hear that you find it so difficult to configure the pinctrl,
it's (almost) entirely using the common pinctrl bindings. Perhaps we
need to add some documentation of the hardware in the binding?

> However, I would like a solution that works with modules. It would be
> nice to know when userspace finished processing all the coldplug
> uevents. That would be sufficient to support modules. I researched
> that a bit and it doesn't seem the kernel can tell when that has
> happened.
> 

It's not that far from the issue I have in remoteproc, where I would
like to boot a DSP as soon as the firmware is available - which might be
probed at any time after boot.

[..]
> >> I tested this on a RPi3 B with the pinctrl driver forced off. With this
> >> change, the MMC/SD and UART drivers can function without the pinctrl
> >> driver.
> >>
> >
> > Cool, so what about graphics, audio, networking, usb and all the other
> > things that people actually expect when they _use_ a distro?
> 
> I often care about none of those things. When I do, I'd rather boot to
> a working console with those broken than have to debug why the kernel
> panicked.
> 

But that's developer-you speaking, developer-me totally agree.

But when I take the role of being a user of a distro I most definitely
do expect functionality beyond the basics used by the boot loader (UART
and dependencies of the primary storage device).

My argument is simply that in neither of these cases this patch is
helpful.

[..]
> >> +int driver_deferred_probe_optional(void)
> >> +{
> >> +     if (initcalls_done)
> >> +             return -ENODEV;
> >
> > You forgot the humongous printout here that tells the users that we do
> > not want any bug reports related hardware not working as expected after
> > this point.
> 
> I assume you were joking, but I would happily add a WARN here.

About the print yes, but I most definitely do not want to debug issues
related to this!

The crazy issues you get from having electrical properties slightly off
(e.g. drive-strength of the SD-card pins) or the fact that any driver
using pinmuxing will depend on the modprobe ordering.

> Spewing new warnings while still booting is a better UX than just
> panicking.  Ideally, it would be once per missing dependency.
> 

Having a convenient way of listing all unmatched devices or devices
sitting in probe deferral would be quite convenient, as a development
tool. I know this hassle was the starting point of some of Frank's
tools.

Regards,
Bjorn
