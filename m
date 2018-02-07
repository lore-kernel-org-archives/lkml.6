Return-Path: <alexandre.belloni@free-electrons.com>
X-Google-Smtp-Source: AH8x2276bmMk4T6r77tKAfSNhkolqteFMTq2IXGiKnhH1gHxwAkI0erc7Jsw2iDllgqAXrsGYmPK
ARC-Seal: i=1; a=rsa-sha256; t=1517968513; cv=none;
        d=google.com; s=arc-20160816;
        b=0HkMoLQ38XlEGp2L3SlttDYSYBSoI5x9fXmHtVhOJnWAa/HtyY+sn5sWsGwaYwFvTj
         wevahsX3XS6yjV5jipzT7uDiSakr98SJm3hdhVlE2Oflai0gJti32XRaHp8A1qlaMsrk
         +ecdvb8LtbUyX2KAjz+q3QVw2SvwY/Ty70+Ql1KvR1u9Q+LrI8Ag6D4RP/8wwPgvB+z4
         koOAwTwVwmlD3Xc0XoC37LTYecJEyRlgVGyM2EJBsarJJWM0za1DoOwKV4oo6ZpiwaXf
         y3klybpLCYdq/Wzd/QKkchLLJ9Xh4JS7BR9kA0zlMNsQXONsp69EN2sF6XKz9IJZMq/U
         CGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+PAk5aghlWnZZkLHPEqgVYEY9HEywaafUOhpJ4nuJ0w=;
        b=zuYOFl4Ben9oZxEPlnK079iN4XC1KZeeki4Bu8hQH1PHgB1+EaqqWH3UAGXaoTqwoo
         s9tj3fZgnaHNj+luMpk537TNqqBJTGRsnB9ReF258Z+3S11zqKmuCKvoHhtgA5t7E60A
         Uhy5CWkCdGeiHWfKPiRqaSk/a3/Pu1YOFqJkkoeuoD0m9O41XuHEPuySflTgkt3LI98G
         l1tU+2+mHZ2NJfhF4mac0AfCzi7OjVSDgt8yhOcNequHU/onQXVbbCU6Z+1REkjy0jWP
         GIDhRDXiUQQ/HDMv5OSCig2T7SX4vUE4hM13Rdyg8r5nc+fYDd17kK5c9nx8/82F4Ztq
         ozSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Date: Wed, 7 Feb 2018 02:55:09 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] char: nvram: disable on ARM
Message-ID: <20180207015509.GV3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591690923969903275?=
X-GMAIL-MSGID: =?utf-8?q?1591705351882683704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/02/2018 at 23:55:02 +0100, Arnd Bergmann wrote:
> * arch/arm/kernel/time.c has this code
> 
> #if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || \
>     defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE)
> /* this needs a better home */
> DEFINE_SPINLOCK(rtc_lock);
> EXPORT_SYMBOL(rtc_lock);
> #endif  /* pc-style 'CMOS' RTC support */
> 
> That can be adapted now, or maybe we could move all definitions into
> a common place (that needs some more planning).
> 

Yes, on arm, the rtc_lock is mostly there to please
drivers/rtc/rtc-cmos.c. Maybe we could make the locking in this driver
x86 and PPC specific.

If we can get rid of arch/powerpc/platforms/chrp/time.c and
arch/powerpc/platforms/maple/time.c (so much duplicated code), then it
is x86 only.

> * similarly, this line in nvram.c can be simplified:
> #if defined(CONFIG_ATARI)
> #  define MACH ATARI
> #elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and ?? */
> #  define MACH PC
> #else
> #  error Cannot build nvram driver for this machine configuration.
> #endif
> 
> * GENERIC_NVRAM is not really generic, instead this seems to be the
>   chardev that is used for 32-bit powerpc (powermac, 85xx, 86xx), while
>   64-bit powerpc (cell, maple, opal, pseries) use code from
>   arch/powerpc/kernel/nvram_64.c, with the same underlying arch hooks.
>   The nvram_64 code appears to be mostly a superset of the 32-bit
>   generic_nvram one.
> 
> * The code in drivers/char/nvram is not used at all when
>    GENERIC_NVRAM is set, and half the code in there is different
>    between x86 and atari.
> 
> * most of the external interface in include/linux/nvram.h is
>   unused, the rest tends to be architecture specific
> 
> * The procfs file appears to be completely useless on any 64-bit
>    x86 machine, this is what I see:
> 
> $ cat /proc/driver/nvram
> Checksum status: valid
> # floppies     : 0
> Floppy 0 type  : none
> Floppy 1 type  : none
> HD 0 type      : none
> HD 1 type      : none
> HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
> HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
> DOS base memory: 635 kB
> Extended memory: 65535 kB (configured), 65535 kB (tested)
> Gfx adapter    : EGA, VGA, ... (with BIOS)
> FPU            : not installed
> 

I really don't think anyone is using that but I don't really know much
about x86 and the specification this may be part of.

I see the info may be used in drivers/video/fbdev/ and
drivers/platform/x86/thinkpad_acpi.c

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
