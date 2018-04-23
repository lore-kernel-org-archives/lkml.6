Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AIpwx4+iAmnlcGDBEmxHyR6AxNmTJoPUGMLlE/KGMEgM9hrFz/mW8QV4/nAmqNWKPAT1sUoFH7Gg
ARC-Seal: i=1; a=rsa-sha256; t=1524495866; cv=none;
        d=google.com; s=arc-20160816;
        b=JwkWVSB53d4aNubDDl7ybLcKMLi/3P+nVCk3m0tG3HKO/EhdZccGq6k47YCFlKNP9/
         khoFK3jmc7JTrICv90NqO42vlDv/8kSFVtB+JBfdWEy+SoKpkqA2xv/rGCZ0JXKX4I3F
         fpyP7dIaIwgH+sUj7q6TyF8KyLQS0BS9NBdRvAoMoORHFreaStQ7/Os/xiSyO6xWtLxQ
         PgqBfiLV1+VHGlEnH9tRg2BtqX0Bz24VpEv7KZ91e9mr7xX+0TCroTVFMVngk93czoVE
         GcoYlrOcDOu/2aFYa+CvhVaPeap4com70RMUV1y8sn5ikw3lGFLHWVp2N55WqdUtLuz0
         XO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Id66A17UQFFdbutAslgtbsz93pLmJUoGM/2wHJ14iYo=;
        b=gZe8pSc+9IFZBpbJaAqiuRYYyzsoYOCK9EFwajueNWDP8QDfav4MKs2e7TFM3QsI2o
         P9VjxeU8t+LDY8Ro43h0mXIvg3tdWYGOoSuEf4TEVegt+NITNVXU6g4BLcCIWWKjfHDt
         ziqMk2uVIqAQXu3GiCKEXB+XzalBWyFWU3FgVWKpaB3q/740z0yYpygkduoS5llJ8Ooe
         CGpUkd8KrfgLaZNxM73SAY9NrK1aFa2wwH/DimgPfzkEKssSyV34oq6AVSy9aY9h1jgl
         CqFMwM3r0xh4rz4F8TyPuQzSP9Y+GNSj0ApAOE6hTq8GgYeyIm+lDyG2B5WUxGlYJnLb
         VcQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=NdOs8OQk;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=NdOs8OQk;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Mon, 23 Apr 2018 16:04:06 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Allen Yan <yanwei@marvell.com>,
	Miquel Raynal <miquel.raynal@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: mvebu-uart: Fix local flags handling on termios
 update
Message-ID: <20180423150406.GE16141@n2100.armlinux.org.uk>
References: <20180422123346.15538-1-marc.zyngier@arm.com>
 <20180422155515.GC16141@n2100.armlinux.org.uk>
 <20180422180728.42d7b354@why.wild-wind.fr.eu.org>
 <20180422195803.GD16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422195803.GD16141@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598449722207347809?=
X-GMAIL-MSGID: =?utf-8?q?1598549777643270719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 08:58:04PM +0100, Russell King - ARM Linux wrote:
> On Sun, Apr 22, 2018 at 06:07:28PM +0100, Marc Zyngier wrote:
> > On Sun, 22 Apr 2018 16:55:16 +0100
> > Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> > 
> > > On Sun, Apr 22, 2018 at 01:33:46PM +0100, Marc Zyngier wrote:
> > > > Commit 68a0db1d7da2 reworked the baud rate selection, but also added
> > > > a (not so) subtle change in the way the local flags (c_lflag in the
> > > > termios structure) are handled, forcing the new flags to always be the
> > > > same as the old ones.
> > > > 
> > > > The reason for that particular change is both obscure and undocumented.
> > > > It also completely breaks userspace. Something as trivial as getty is
> > > > unusable:
> > > > 
> > > > <example>
> > > > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > > > 
> > > > 	sy-borg login: root
> > > > 	root
> > > > 	[timeout]
> > > > 
> > > > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > > > </example>
> > > > 
> > > > which is quite obvious in retrospect: getty cannot get in control of
> > > > the echo mode, is stuck in canonical mode, and times out without ever
> > > > seeing anything valid. It also begs the question of how this change was
> > > > ever tested.
> > > > 
> > > > The fix is pretty obvious: stop messing with c_lflag, and the world
> > > > will be a happier place.  
> > > 
> > > The c_iflag code also looks suspicious as well.  Apparently, the driver
> > > only supports INPCK and IGNPAR, but things such as ISTRIP, INLCR, IGNCR,
> > > ICRNL, IUCLC, IMAXBEL and IUTF8 are all software things done by the TTY
> > > layer and have nothing to do with the driver.
> > 
> > Indeed. I stuck with the most glaring issue (well, the one that
> > prevented me from using this particular box), but the whole termios
> > massaging is quite odd. Someone with a good understanding of the
> > intricacies of the TTY layer should definitely have a look at this.
> 
> Right, remember, I'm the author of the serial core layer (I took over
> from tytso back in the 2.x era.)
> 
> POSIX requirements are:
> 
>   The tcsetattr() function shall return successfully if it
>   was able to perform any of the requested actions, even if
>   some of the requested actions could not be performed. It
>   shall set all the attributes that the implementation
>   supports as requested and leave all the attributes not
>   supported by the implementation unchanged.
> 
> In other words, if the system does not support two stop bits, asking
> for CSTOPB to be set results in CSTOPB being ignored but all other
> supported modes being updated.  This is what the code in that commit
> is trying to implement, but it forgets that the TTY layer implements
> a whole load of termios modes that are not specific to the serial
> driver.

I've just been talking to Jon Nettleton about this, and it seems that
he reported the exact same bug that you've found to Marvell a while
back, yet it seems that the bug was still propagated into mainline.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
