Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517999635; cv=none;
        d=google.com; s=arc-20160816;
        b=Y5DB5R0wX+TNuIUHIpVJj/iMgDj8xn7TL5f9y4CQr92fH2d8Vs5I2A8pGvMmgUcceT
         abmJXadfE85coZI06dIdjoZFCxzyrzYay4lmOezZRxvhhkTtR8TrVOyz97wa9elRW5RP
         61gO0Xzi6uX/zcZdhCEcoVPTMf1vqm5LNPIsZ8+5t99RG+FN6QbCVtD4Y5k5g3xLtpIt
         dqtOfP+bFHEnnTwbonR9K9fCENK6DysKrcb9KxGFEKYrfyG/gzVLB1GY7rIVK9KfREVK
         5TF68NeIpe29roRPKtV1CHJ2K8TgJ9s/61vdKfG6WPN61CIekUvR+UnxqCu3tt/DZBB+
         z/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=vvb8b/o2cyszJqj8RcOWr/sC6zi5GcaV48ROlBvOKZs=;
        b=XpWg205MIexpl3/3DSktG3PXIrYWxs1FbyPnIuObEk8bYRTjCveAjbtIIfwYDKJk1E
         +5ZhqtQVEpsDreGea9kyoChxjuOAaY5vc/l+RNjiUaCp7wuHo99wSA2Zgrxaz1rCWhNM
         SEXyqmvkLiURcSnNOMla+ewJnMh9NYF7rfA+2IdMEwZYKFIa1njVNyZOg6nGE1UIUBvU
         pIYLfDrqy4S4UB4eqbi39xtEd9nCqZKiKqo06q1pB6ZBbgNaejXFwvoqGr5/jy5oaTj3
         P94BTit2Q/vGeT52XVyW7MYLmQa7ekNusr79u60fDNEaFt5VNo6u2/x4Tye/S0NlZ3Gy
         VEZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ATQmS9jo;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ATQmS9jo;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x227z56SpLrxM3dsP+In/wvY6/j0PlRGaf5PSqeOCY3ORLZx9Cf+g3T6fR28XeGJXHuo8YTICpoA07gfrOKBDGVU=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180207015509.GV3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com> <20180207015509.GV3404@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Feb 2018 11:33:55 +0100
X-Google-Sender-Auth: cTEtNkJQlumDl4IpSCqVFiRPcv8
Message-ID: <CAK8P3a3dkAESaqGgLAV9uKKet20rVtBXqBJ-eNGbwQv1i05K7A@mail.gmail.com>
Subject: Re: [PATCH] char: nvram: disable on ARM
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591690923969903275?=
X-GMAIL-MSGID: =?utf-8?q?1591737985774513930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 2:55 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 06/02/2018 at 23:55:02 +0100, Arnd Bergmann wrote:
>> * arch/arm/kernel/time.c has this code
>>
>> #if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || \
>>     defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE)
>> /* this needs a better home */
>> DEFINE_SPINLOCK(rtc_lock);
>> EXPORT_SYMBOL(rtc_lock);
>> #endif  /* pc-style 'CMOS' RTC support */
>>
>> That can be adapted now, or maybe we could move all definitions into
>> a common place (that needs some more planning).
>>
>
> Yes, on arm, the rtc_lock is mostly there to please
> drivers/rtc/rtc-cmos.c. Maybe we could make the locking in this driver
> x86 and PPC specific.
>
> If we can get rid of arch/powerpc/platforms/chrp/time.c and
> arch/powerpc/platforms/maple/time.c (so much duplicated code), then it
> is x86 only.

What about these:

arch/alpha/kernel/rtc.c:        spin_lock(&rtc_lock);
arch/alpha/kernel/rtc.c:        spin_unlock(&rtc_lock);
arch/alpha/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
arch/alpha/kernel/time.c:EXPORT_SYMBOL(rtc_lock);
arch/arm/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
arch/arm/kernel/time.c:EXPORT_SYMBOL(rtc_lock);
arch/m32r/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
arch/m32r/kernel/time.c:EXPORT_SYMBOL(rtc_lock);
arch/m68k/atari/time.c:DEFINE_SPINLOCK(rtc_lock);
arch/m68k/atari/time.c:EXPORT_SYMBOL_GPL(rtc_lock);
arch/mn10300/kernel/rtc.c:DEFINE_SPINLOCK(rtc_lock);
arch/mn10300/kernel/rtc.c:EXPORT_SYMBOL(rtc_lock);
arch/powerpc/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
arch/powerpc/kernel/time.c:EXPORT_SYMBOL_GPL(rtc_lock);
arch/sparc/kernel/time_32.c:DEFINE_SPINLOCK(rtc_lock);
arch/sparc/kernel/time_32.c:EXPORT_SYMBOL(rtc_lock);
arch/sparc/kernel/time_64.c:DEFINE_SPINLOCK(rtc_lock);

Are they all obsolete?

>> * similarly, this line in nvram.c can be simplified:
>> #if defined(CONFIG_ATARI)
>> #  define MACH ATARI
>> #elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and ?? */
>> #  define MACH PC
>> #else
>> #  error Cannot build nvram driver for this machine configuration.
>> #endif
>>
>> * GENERIC_NVRAM is not really generic, instead this seems to be the
>>   chardev that is used for 32-bit powerpc (powermac, 85xx, 86xx), while
>>   64-bit powerpc (cell, maple, opal, pseries) use code from
>>   arch/powerpc/kernel/nvram_64.c, with the same underlying arch hooks.
>>   The nvram_64 code appears to be mostly a superset of the 32-bit
>>   generic_nvram one.
>>
>> * The code in drivers/char/nvram is not used at all when
>>    GENERIC_NVRAM is set, and half the code in there is different
>>    between x86 and atari.
>>
>> * most of the external interface in include/linux/nvram.h is
>>   unused, the rest tends to be architecture specific
>>
>> * The procfs file appears to be completely useless on any 64-bit
>>    x86 machine, this is what I see:
>>
>> $ cat /proc/driver/nvram
>> Checksum status: valid
>> # floppies     : 0
>> Floppy 0 type  : none
>> Floppy 1 type  : none
>> HD 0 type      : none
>> HD 1 type      : none
>> HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
>> HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
>> DOS base memory: 635 kB
>> Extended memory: 65535 kB (configured), 65535 kB (tested)
>> Gfx adapter    : EGA, VGA, ... (with BIOS)
>> FPU            : not installed
>>
>
> I really don't think anyone is using that but I don't really know much
> about x86 and the specification this may be part of.
>
> I see the info may be used in drivers/video/fbdev/ and
> drivers/platform/x86/thinkpad_acpi.c

The thinkpad_acpi driver seems to look at some other bytes
in the nvram, which have a platform specific meaning.

For drivers/video/fbdev/, these appear to all be for pre-x86
Apple Macintosh (m68k or powerpc).

       Arnd
