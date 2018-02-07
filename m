Return-Path: <alexandre.belloni@free-electrons.com>
X-Google-Smtp-Source: AH8x225sCPIuAB82UzKbbh1fDEEmiD7k/1zjNou9oKLHQJ56Bx5ym/S+nsp2gA5SXiKuCnxczD4D
ARC-Seal: i=1; a=rsa-sha256; t=1518029206; cv=none;
        d=google.com; s=arc-20160816;
        b=j0DzZHP2R5EURB2SJnKB7OUuV8G5qd2Sdc1+PRAZj4Gp5fTWWG1k4uMSkw/i7xioAX
         g9yDgkE02s45nqxtOQgEJHYq+gmGNSfEuAvrdF0mkh0pyYYYzcy+DrGCLijqyHL2k6//
         eSjTcoHZ3HXBAIdo4SjaZZl1t00p0FnaH1Nfg9hyqZj30iyIB1j3dUVGaReBBlJFPSaB
         9/pTjmpIPn1iSqEWaLRPHwtZVnjdgEXZwqxGf2JrxJYGI4uHVmKXMu51KU12gwRAsLgP
         hgzLZb+nup9ww4UfWinKbhQDm41rn/5Z25J82/5U6qzs+Kn6IryP5Ndt7nLgAt/GpXRF
         cy+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5e489fn2ZQXtRT1WtEz87LEWtoCTUwuMYemWT9nOvjM=;
        b=GuFVmzFuSy+WH3pKjO5Xm26Tkgarl5hPdqFkUhOaQ6R79tiDehJNGxC69TYKqsAH52
         /fXp6Z6kr9KtB+Ns0Cw73xHRT+mwN2G7HrAIvssv5QxPhQqrI6+ndcwZ54rwsOH3npgv
         3cI/thxi2lazT9UDcbxm4PEjt9V/C/sNjOVWQeySP2Gqcsk2pnhayklUiV66tefZiUys
         CTb+1/NAeAL3cJrfLbw5JaBbpD1H5MjOe0m258H6HrVu0+crAt/eHJymI2sWLdZ7rBam
         rUZuboyLQA8rw4yTyo5/6I1w+ZTZUeKOzs+4zWDx5RJCWc15oOk+2jrrfQhwX5cg1BqG
         2E0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Date: Wed, 7 Feb 2018 19:46:43 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] char: nvram: disable on ARM
Message-ID: <20180207184643.GA3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
 <20180207015509.GV3404@piout.net>
 <CAK8P3a3dkAESaqGgLAV9uKKet20rVtBXqBJ-eNGbwQv1i05K7A@mail.gmail.com>
 <20180207124839.GX3404@piout.net>
 <CAK8P3a2HscUSs-iV_3dp7+htN+LPFK2LnmiZNTKamQZwMSVxMA@mail.gmail.com>
 <20180207154700.GY3404@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207154700.GY3404@piout.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591690923969903275?=
X-GMAIL-MSGID: =?utf-8?q?1591768993041678935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07/02/2018 at 16:47:00 +0100, Alexandre Belloni wrote:
> > >> > I really don't think anyone is using that but I don't really know much
> > >> > about x86 and the specification this may be part of.
> > >> >
> > >> > I see the info may be used in drivers/video/fbdev/ and
> > >> > drivers/platform/x86/thinkpad_acpi.c
> > >>
> > >> The thinkpad_acpi driver seems to look at some other bytes
> > >> in the nvram, which have a platform specific meaning.
> > >>
> > >
> > > Yeah, I was more concerned that they need drivers/char/nvram.c for
> > > nvram_read_byte so we can't simply remove the driver.
> > 
> > Ok, so the procfs interface may be obsolete, but we still need an
> > interface into the CMOS NVRAM data.
> > 
> 
> Actually, I just found
> https://unix.stackexchange.com/questions/331419/is-dev-nvram-dangerous-to-write-to
> 
> So it seems to have real values for some people (even if they are
> wrong).
> 
> That also points to https://sourceforge.net/projects/nvram-wakeup/ but I
> don't think it is necessary. The RTC driver should be able to wakeup an
> x86 platform.
> 
> All the other uses of /dev/nvram I could find with a simple google
> search (i.e. saving and restoring CMOS settings) could just use
> /sys/class/rtc/rtc0/device/nvram
> 

Ok, the chromeos guys are using it for verified boot it seems:
https://chromium.googlesource.com/chromiumos/platform/vboot_reference

I'm wondering whether they really care about the checksum though.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
