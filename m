Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524642465; cv=none;
        d=google.com; s=arc-20160816;
        b=hl+MrvfSkc1pmJwnK81NZGwhHtPSSivV5w71scYE6A/bplviybe6BRMuX68Ln+nNaJ
         mnu4F5dUu06x55lcLxxgkJP1rdAmKvsZJVVMvz+0qDrjyo/gK0CIGdxsqqLLfwrGUgh8
         FAjH7b5HKbgcBmPnejDp8QN9JwwAdV3uCLIxpisNq75Q2qL1op1EQreY5uXkSaR11X1A
         3ECpK+tZpJ03UOs/FC8I87/U0oxPtWqxuryFLYQcutO2lTmMXnwiTsVQY7R2RcK5sG7f
         XaNNGcOY4ZvKSnYZQBRaJBpjs5CrSUQyFoSjwFcY9pAfj91IyxxwVCsJXPAd4XyAckkI
         6yLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=e3wy5ph9H8+9mgCEWrSucC+bTaoMPKJtMRla004eyx0=;
        b=0o/W6Dv3pKZJDDtwDoXbK24dweQwvf5pfPWGLiEkLYCNcvriokAxlkNLJMoQQrQfRh
         oXioIaw+pFO6ymlPvpXpDwCXFBeE6L22rLjpRKiX5XwrAKkokkkmvq3Xy103ZUnltVxT
         E8wNBJA+WHPHkc1NY9CPkY05bVzX48olBWTixRS2y2WbTOy5LxfgIbpUJYAQlddZNWuT
         d3QEG3ZvJrpWADOICUIqLnMBC9Ot2LFGSfrMDUBRFiqzUtmMpLQh3P3yIPTnEDbdkHf+
         /KvkivYPFCB9e1Qr1fgHsDpDXqL3ZmtNvQhS9jI7nfsOFB8VU7z3jTQAzUY/9mFspKYY
         4X9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NugO9KGC;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NugO9KGC;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZqOGUa3Bfn2ET19h2JYI+nIBLbSaInkpcmvD2sl4W4AA2GSsmxp55B5Wgh85x2RtZtkF8I4Mg==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 25 Apr 2018 09:47:36 +0200
From: Johan Hovold <johan@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Johan Hovold <johan@kernel.org>,
	Shrirang Bagul <shrirang.bagul@canonical.com>,
	linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	Rob Herring <robh@kernel.org>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/1] serdev: Support HS-UART serdev slaves over tty
Message-ID: <20180425074736.GK4615@localhost>
References: <20180424082954.11453-1-shrirang.bagul@canonical.com>
 <20180424171846.GD4615@localhost>
 <b4947b3c-15b3-15ea-e1b7-38169f11d0f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4947b3c-15b3-15ea-e1b7-38169f11d0f9@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598615562877462543?=
X-GMAIL-MSGID: =?utf-8?q?1598703497753052950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 11:16:38PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 24-04-18 19:18, Johan Hovold wrote:
> > [ Adding some more people on CC. ]
> > 
> > On Tue, Apr 24, 2018 at 04:29:53PM +0800, Shrirang Bagul wrote:
> >> On systems using Intel Atom (Baytrail-I) SoC's, slave devices connected on
> >> HSUART1/2 ports are described by the ACPI BIOS as virtual hardware using
> >> HID's INT3511/INT3512 [1].
> >>
> >> As a consequence, HW manufacturers have complete freedom to install any
> >> devices on-board as long as they can be accessed over serial tty
> >> interface. Once such device is Dell Edge 3002 IoT Gateway which sports
> >> ZigBee & GPS devices on the HS-UART ports 1 & 2 respectively.
> >>
> >> In kernels before the introduction of 'Serial Device Bus (serdev)'
> >> subsystem, these devices were accessible using /dev/ttySx nodes. But,
> >> kernels since 4.15 can no longer do so.
> >>
> >> Post 4.15, with CONFIG_SERIAL_DEV_BUS=y, serdev port controller driver
> >> handles the enumeration for the slaves connected on these ports. Also,
> >> /dev/ttySx device nodes for these ports are no longer exposed to the
> >> userspace.
> >>
> >> This patch implements a new driver which binds to the ACPI serdev slaves
> >> enumerated by the serdev port controller and exposes /dev/ttyHSx device
> >> nodes which the userspace applications can use. Otherwise, upgrades to 4.15
> >> or higher kernels would certainly render these devices unusable.
> >>
> >> Considering serdev is new and evolving, this is one approach to solving
> >> the problem at hand. An obvious drawback is the change in the tty device
> >> node name from ttySx => ttyHSx, which means userspace applications have to
> >> be modified (I know that this is strongly discouraged). For the same
> >> reason, I am submitting these patches as RFC.
> >>
> >> If there are other/better ways of solving this or improving on the
> >> proposed solution, that will be most helpful.
> > 
> > Yeah, I don't think this is the right solution to this problem. It seems
> > we need to blacklist (or maybe even use whitelists) ACPI-ids until there
> > are drivers for the slave devices that would otherwise be claimed by
> > serdev.
> 
> FWIW I've been using this patch for a while for realtek UART attached bluetooth:
> https://github.com/jwrdegoede/linux-sunxi/commit/bc904e3703940600ca66c65fcdb0a8cb01dff55d
> which is a gross hack.
> 
> If we're going to do a whitelist for this, it better support some sort of
> wildcards as there are a LOT of BCM2E?? devices which need to be on the
> whitelist. I think a blacklist would actually be better though, this also
> documents which devices are lacking a proper kernel (where applicable).

Yeah, you guys know the ACPI space better than I do. I just fear that
if we go with the blacklist approach, we'll be playing a whack-a-mole
with this for a long time when people start upgrading there systems to
4.15 and discover that their serial ports are gone.

Since this would qualify as a severe regression, me may need to consider
adding a serdev whitelist for every ACPI id we add to a serdev driver
instead.

Thanks,
Johan
