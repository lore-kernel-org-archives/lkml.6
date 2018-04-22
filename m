Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AIpwx4+B6rFSA1mcIgALq4EIgZL8A9ubYLOZkazw/8bqVFkSqiVfPKo5trGzZp8J7ZRhZ6O1pyVN
ARC-Seal: i=1; a=rsa-sha256; t=1524412542; cv=none;
        d=google.com; s=arc-20160816;
        b=L5MkTzviY4Fs2Wfk5FzzT0GSExdrtMlqSN0vibFvTWYtdUeIPBwHKnC2qTP0Up/JEf
         ORnxHGaQ8MuaFO/30TOY8leXDGvRleMR5T2Jq0RRRvXbQz+U2REiNNj1AJQCqzxM0d3M
         InEg1fRDp5Rjhk5+Poyt9BxTGr7XM938wGdhXtSF1AzFtzRLifVz1NkPzyXbJ7zdOVJX
         qmuh5cXxgsLyU/n3oxFZ62X4Si8mI5x+g4QoeILtvsTiC3dxYtzM0HXsV+EyXi3xeczq
         QgVBuU+MD4/OqipfeRiqlnu+6kGHw7eVXwlwbtygUuHRseJjr20OYw9+54h3SMtXyqq+
         /ZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=P3lMNNNo6vkeunFTviQe6PoqTR34u1eOl1EU3hsT9NU=;
        b=sHvdnvoL+jVAWQ8mayGVevug7bGzGUzrdsZ/UV1VlhRdAwVX0VYKEww0Dq5rHUFeCH
         x2wRyvYlNpLSCRfCS5Qxz04A2hH55DUHoLgJ27gLxSYVNAJhDbF9HH4DVPbzjqcnjylw
         /U7Om+gYNrFJUHY+7O3+umK4VQ2TMAz08c4nrzpNVefA1BV4jwv4GnQAKr1Icb3LUgl6
         P0jadPV0DS+kvNLL6SQTxwk1AgOid6Wj6sBvexIubp3evA1nIfwTQa9bjYIBc+S3qlwI
         QYnFwJbQodvPowBAgqoH2bVtfeloJPbairCaoQN9iBq6fED0QePEjMVRFAu5VasQnecy
         sS+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=iK/SMF6K;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=iK/SMF6K;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Sun, 22 Apr 2018 16:55:16 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Allen Yan <yanwei@marvell.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: Re: [PATCH] serial: mvebu-uart: Fix local flags handling on termios
 update
Message-ID: <20180422155515.GC16141@n2100.armlinux.org.uk>
References: <20180422123346.15538-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422123346.15538-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598449722207347809?=
X-GMAIL-MSGID: =?utf-8?q?1598462406515851532?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 01:33:46PM +0100, Marc Zyngier wrote:
> Commit 68a0db1d7da2 reworked the baud rate selection, but also added
> a (not so) subtle change in the way the local flags (c_lflag in the
> termios structure) are handled, forcing the new flags to always be the
> same as the old ones.
> 
> The reason for that particular change is both obscure and undocumented.
> It also completely breaks userspace. Something as trivial as getty is
> unusable:
> 
> <example>
> 	Debian GNU/Linux 9 sy-borg ttyMV0
> 
> 	sy-borg login: root
> 	root
> 	[timeout]
> 
> 	Debian GNU/Linux 9 sy-borg ttyMV0
> </example>
> 
> which is quite obvious in retrospect: getty cannot get in control of
> the echo mode, is stuck in canonical mode, and times out without ever
> seeing anything valid. It also begs the question of how this change was
> ever tested.
> 
> The fix is pretty obvious: stop messing with c_lflag, and the world
> will be a happier place.

The c_iflag code also looks suspicious as well.  Apparently, the driver
only supports INPCK and IGNPAR, but things such as ISTRIP, INLCR, IGNCR,
ICRNL, IUCLC, IMAXBEL and IUTF8 are all software things done by the TTY
layer and have nothing to do with the driver.

The driver should only be preserving termios modes that are not supported
by the whole system, not solely the driver.

Interestingly, this aspect of the patch was not described in the commit
message, so how did this patch get in without proper review given that
it does more than what the commit log says?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
