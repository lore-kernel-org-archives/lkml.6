Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AIpwx4+WRpIJyOG6Glaj23EQtjlHDIc5dKalQNCSpNFxow3pkPkSbCCFZnBXOegNxaLEnG2MvsRV
ARC-Seal: i=1; a=rsa-sha256; t=1524416859; cv=none;
        d=google.com; s=arc-20160816;
        b=lqrMW+siaACAehK/2y2S3JWHyVBmWEawBOKSL97q5PTW2euwJh8V1ajt099NGMcLE4
         rd/eXv00uaYcpAtNbzDZoqIkqdRdy6HfVUfZNvztl4HDR0AUSNvzXJWeNLfDqppp3ZNz
         IXHiUdrAY42jIWV+IjqHllMY8WpNv+mpEjOK91MEmqKHVwdFbaw7F8bzNmHjEekaHNwz
         5x0rrDqOoO2TQmjZ9LSWIVnlFPMZNaUhUCRKxrezzRXV/atuvS0PsHGe3Dikvoy5yKNG
         8GQHjMaJdYpIY7YyrbLjImfwKIeWiV1IkQNsCkt2RyOEV4ycN4RRzMNruQOmXJOosMkk
         qKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=fa4ZNZEdoo1zFVZrGO4bFe3mRtKgPf/7zqB/BU+tzuw=;
        b=pv02ZaetS13WW4OA9vSEyltmkRIATORffkkf1jXHWdTUsmB/jTOyjH/i7iIoYZzX/I
         wskLG7p0/tsxu6zrGrCC+WMliD/GAaVE9wPKS6ZmyXlJmGqPHd7dKoSbCDLPVmNGP4wt
         UKFO5avHnykXMZESvU6ufYx9WLAh8tiSZ82LgbJUSnGbj3QLmedzblt/jigrQZKSenX9
         J/Lu7LZ3cienYQ1SctUrnN4baJuB72Nx9fQhuIFKVVJIAB2gRcMooNhRelYaJP4UFPk3
         +nNtsZgiE3TKzZOJ/gowRSExK1gNcngmEann+AaSVUoDSCZHhW0bedTCeEeDl5EZg9C1
         PRTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Date: Sun, 22 Apr 2018 18:07:28 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Gregory CLEMENT <gregory.clement@free-electrons.com>, Allen Yan
 <yanwei@marvell.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: Re: [PATCH] serial: mvebu-uart: Fix local flags handling on termios
 update
Message-ID: <20180422180728.42d7b354@why.wild-wind.fr.eu.org>
In-Reply-To: <20180422155515.GC16141@n2100.armlinux.org.uk>
References: <20180422123346.15538-1-marc.zyngier@arm.com>
	<20180422155515.GC16141@n2100.armlinux.org.uk>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598449722207347809?=
X-GMAIL-MSGID: =?utf-8?q?1598466932401180437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 22 Apr 2018 16:55:16 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Sun, Apr 22, 2018 at 01:33:46PM +0100, Marc Zyngier wrote:
> > Commit 68a0db1d7da2 reworked the baud rate selection, but also added
> > a (not so) subtle change in the way the local flags (c_lflag in the
> > termios structure) are handled, forcing the new flags to always be the
> > same as the old ones.
> > 
> > The reason for that particular change is both obscure and undocumented.
> > It also completely breaks userspace. Something as trivial as getty is
> > unusable:
> > 
> > <example>
> > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > 
> > 	sy-borg login: root
> > 	root
> > 	[timeout]
> > 
> > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > </example>
> > 
> > which is quite obvious in retrospect: getty cannot get in control of
> > the echo mode, is stuck in canonical mode, and times out without ever
> > seeing anything valid. It also begs the question of how this change was
> > ever tested.
> > 
> > The fix is pretty obvious: stop messing with c_lflag, and the world
> > will be a happier place.  
> 
> The c_iflag code also looks suspicious as well.  Apparently, the driver
> only supports INPCK and IGNPAR, but things such as ISTRIP, INLCR, IGNCR,
> ICRNL, IUCLC, IMAXBEL and IUTF8 are all software things done by the TTY
> layer and have nothing to do with the driver.

Indeed. I stuck with the most glaring issue (well, the one that
prevented me from using this particular box), but the whole termios
massaging is quite odd. Someone with a good understanding of the
intricacies of the TTY layer should definitely have a look at this.

	M.
-- 
Without deviation from the norm, progress is not possible.
