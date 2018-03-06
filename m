Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AG47ELsav+fgAU1GATu9B570YpPzAj/X9jpp7B7eE1H5HSJU1arm3Jhdj/dkzRwxU2yy2DIfKSdP
ARC-Seal: i=1; a=rsa-sha256; t=1520335707; cv=none;
        d=google.com; s=arc-20160816;
        b=hn0Z2RqGucH1Gf6LnK9sJqv56MpS2h/OVgeDjkD0Req9J0v/rVhZd0K5v1s1QdjjwG
         Z1zf4nXC8u3QiIGmxkrtudyzb9tas2hw+dGyZOsRe2pRGLHDrdjqv3ypMoTagz811pw+
         10Zfl1LTGvPVQa15l51t8Q88WH/aGzm4NvAl8WvazEvdJoefr6qIbpckuj2sUVBHcqd/
         GjLnylJ/7wyh6bumP7exY14BpxgOSWWPZO6wCStOnQUPL2QQznZZGNEFktNWcN7s5yt3
         IICe/03lcEnZtCNtTmHLySkvex8dVABTEWMkQDLbaVhp4Cx0F4T2R6keGaZ95F9pA5/F
         ixyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=tua8qlT4hMgybx7Pj1F3NF3E7gCWTzLTR7r09w9VFBk=;
        b=ZIXyDYgL768VyeYJye3fxKoWxJR1DIbyOA5FPapKpulmtVNUGojKIjnXxZqj/fD7VV
         1HL6YxGwcX2gyb8Gdh5A59MEe9BJYRxRTgGGXGrzIvg34PBe5ryKH+XIm1nZMI/wTfMf
         pRR7E81bXPzCZjBDT9edPXHiWdniYii56e9gYuvPx0VfxR6SnCMMMEE5KDfTVcuTlEsV
         xPFt6DfGjAh+N5Q6rKgw69NR6ijc0JmWBPxqI2Gmgf4bIMqbwwqVBfALebAwG8od4TO/
         um0BFcTLGg1CCTKVaIcKr9smp9NcXS8XwFGNPBgJSBvHwJcAkTME64CzH1KntI4DQs1P
         1UXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=k7gnrKAz;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=k7gnrKAz;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Tue, 6 Mar 2018 11:28:02 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Jinbum Park <jinb.park7@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com, mark.rutland@arm.com,
	vladimir.murzin@arm.com, keescook@chromium.org,
	gregkh@linuxfoundation.org, will.deacon@arm.com,
	catalin.marinas@arm.com
Subject: Re: [PATCH] arm: mm: Kconfig: Disable KUSER_HELPERS in ARMv6 or
 later as default
Message-ID: <20180306112802.GI9418@n2100.armlinux.org.uk>
References: <20180306112241.GA5938@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306112241.GA5938@pjb1027-Latitude-E5410>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594187181647482868?=
X-GMAIL-MSGID: =?utf-8?q?1594187534887170222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 08:22:41PM +0900, Jinbum Park wrote:
> Codes for KUSER_HELPERS can be abused as ROP gadaget,
> So that It's better to disable that as if possible.
> 
> Since over ARMv6 has ldrex/strex at user-space,
> NEED_KUSER_HELPERS is not selected for over ARMv6.
> 
> But, Even though NEED_KUSER_HELPERS is not selected,
> current configuration enable KUSER_HELPERS as default.
> 
> * as-is
> 
> - Enable KUSER_HELPERS as default even though over ARMv6.
> - User can disable KUSER_HELPERS.
> 
> * to-be
> 
> - Disable KUSER_HELPERS in ARMv6 or later as default.
> - User can enable KUSER_HELPERS for compatibility.
> 
> This change removes the unnecessary configuration that has security-risk.

NAK.

It is not this trivial or easy to make this change - you are assuming
that userspace does not use these, which is in incorrect assumption -
there are armhf distros out there that make use of the kuser helpers,
which means we can't disable it by default without causing userspace
regressions.

Therefore, it defaults to being enabled, unless someone decides to
disable it and knows for certain that their userspace does not depend
on this - it's a choice that distros have to make when building their
kernels with the knowledge of how their distro userspace is configured.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
