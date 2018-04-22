Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AIpwx48U3DzJeS2VJlZGoH3MhgMQz5qFYjinun8VtbZOV+NmtCCxefKVrdAp24s93YF5qveZVxtd
ARC-Seal: i=1; a=rsa-sha256; t=1524427107; cv=none;
        d=google.com; s=arc-20160816;
        b=qvLG7FP5Veug5usBQWsgfaf2VLEeUSSbBI5OpPDrYZQ+01SkpzWj14s5ODLgPJQyUN
         DJDta9gcab8V13ssLnhc5ILvwxMMoG8FW/K4R3c832035CpSvSkVH0/EKbNlg1qIYavH
         jaJaG/2XQnHyyDwMvuGxu0oCkyNJ/RCvNZuzpp5cJIJ6ZkZ/dvmaP+h1cGSsv9dWi9Zi
         YHn4CZlon/T8EUMhtfZD2S2+OljXdVUn9ZljiNkoAc8aknzuVARq70wZEBC7MN18Cvt4
         hXQXEhAdNCsHRcB3y2tOwaZgZT2MxVMcAUUlfQhCVHV8Mu/jcEO7wEBGamWmO4ikV0Zt
         FVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=zfkqVSR7/kElZoDzOb8N7v4GSMTilbjZqd/SqUsNEDw=;
        b=xMe3OaVKEeK1zn/1gT352f4t2Gu6BZfEKWYRp2OTH/KkvYjC/joe4GkO4i3pSARNHM
         4KOjqCsdYq1BQnR2Yg/PoqOSzuyGn83JOWCIenB9dmaJxVGwBu9v9XRxelp8xh/fwpM1
         +LBzYSH+d/WXLSwGVWj1XgKpiFKvFWzyn+ZvZOyrCzDsdlK4/11O7YdAWqqeYYH0LOYK
         AXLuR8zao74LHtdTip8kOqHG06tJSxI0IzrtntJwsQcn51QpNdIFx67HdS7Syl+Y/d3T
         sMDdXeKNWQN2ODKGJWhespMpSgATuOSw5WMTojLYQmLnXA+Uext3Qg/RcPuztIBciAYl
         8cug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=gVFmAQl9;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=gVFmAQl9;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Sun, 22 Apr 2018 20:58:04 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Allen Yan <yanwei@marvell.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: Re: [PATCH] serial: mvebu-uart: Fix local flags handling on termios
 update
Message-ID: <20180422195803.GD16141@n2100.armlinux.org.uk>
References: <20180422123346.15538-1-marc.zyngier@arm.com>
 <20180422155515.GC16141@n2100.armlinux.org.uk>
 <20180422180728.42d7b354@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422180728.42d7b354@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598449722207347809?=
X-GMAIL-MSGID: =?utf-8?q?1598477678960269471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 06:07:28PM +0100, Marc Zyngier wrote:
> On Sun, 22 Apr 2018 16:55:16 +0100
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> > On Sun, Apr 22, 2018 at 01:33:46PM +0100, Marc Zyngier wrote:
> > > Commit 68a0db1d7da2 reworked the baud rate selection, but also added
> > > a (not so) subtle change in the way the local flags (c_lflag in the
> > > termios structure) are handled, forcing the new flags to always be the
> > > same as the old ones.
> > > 
> > > The reason for that particular change is both obscure and undocumented.
> > > It also completely breaks userspace. Something as trivial as getty is
> > > unusable:
> > > 
> > > <example>
> > > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > > 
> > > 	sy-borg login: root
> > > 	root
> > > 	[timeout]
> > > 
> > > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > > </example>
> > > 
> > > which is quite obvious in retrospect: getty cannot get in control of
> > > the echo mode, is stuck in canonical mode, and times out without ever
> > > seeing anything valid. It also begs the question of how this change was
> > > ever tested.
> > > 
> > > The fix is pretty obvious: stop messing with c_lflag, and the world
> > > will be a happier place.  
> > 
> > The c_iflag code also looks suspicious as well.  Apparently, the driver
> > only supports INPCK and IGNPAR, but things such as ISTRIP, INLCR, IGNCR,
> > ICRNL, IUCLC, IMAXBEL and IUTF8 are all software things done by the TTY
> > layer and have nothing to do with the driver.
> 
> Indeed. I stuck with the most glaring issue (well, the one that
> prevented me from using this particular box), but the whole termios
> massaging is quite odd. Someone with a good understanding of the
> intricacies of the TTY layer should definitely have a look at this.

Right, remember, I'm the author of the serial core layer (I took over
from tytso back in the 2.x era.)

POSIX requirements are:

  The tcsetattr() function shall return successfully if it
  was able to perform any of the requested actions, even if
  some of the requested actions could not be performed. It
  shall set all the attributes that the implementation
  supports as requested and leave all the attributes not
  supported by the implementation unchanged.

In other words, if the system does not support two stop bits, asking
for CSTOPB to be set results in CSTOPB being ignored but all other
supported modes being updated.  This is what the code in that commit
is trying to implement, but it forgets that the TTY layer implements
a whole load of termios modes that are not specific to the serial
driver.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
