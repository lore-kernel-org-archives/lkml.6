Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517957703; cv=none;
        d=google.com; s=arc-20160816;
        b=RyxccIlk//0gDn/cj5jsWX8CcTm8ejnZvCpwwk1XVPGz+Naw7c/86h6NKfHWpz8mnE
         2ZsHm8Hm6HjgvVckShcmEe+ed289fnTZyb8cW0JHFYML3XF22U/HkqxTeI1K+84W5m4z
         qmvhBMSapNpnlaBNcWuf5U5LdyLLIm5XGVX/syVub5ix5xlZ6YuFERD2sY/Qoj8NwgVQ
         qrYpz06fOiKIG3Eo5FcVcwmB2xGHN7ZF8ykluSlb7PZE+H8PAU600MyDxXh5lI3sn6RP
         aDkDDC8HVd3xje59CjCLt61R+1wuGnEN011OYbAoJRJdbi/WhhvHv3MPe3+O6l96SjZ7
         jVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=WzM+0w+AYgnE2Pjuf+Zovvk9GloFRPfcUEBaaTjjswk=;
        b=MADa3iPSaUrcsJJ9RW73piiZXkaEA7eJqC4B7zREK1eQVmXAao3hkrKJxuScjB6YPQ
         0ON2p23Th9dQhIzn1SFdG7Fb4B2DjxrlYAMrvM5KTP308gEyfgIGE/WyZ5YOKvCBJW8O
         KjVyzQ2efMJO/f6bmTug1v99Cv2iU0tffYXCxRlr4NQpRLEG0srZqywJErdpQtImGw9P
         ydN3klTOsOKtUwwdESraW1AFX7cog4e6kGMt5kmJHug6FPhrP2/3+1PaIDjV6JXYrAIb
         RYunBgOvtz5nbAtCLmaD++NCpw6QHoGoHQr6sgmInbQBld8+hOTLODsOTHnGI2D3VT1G
         Z65g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dVohM9r+;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dVohM9r+;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x225xeqaY6q8cXViDI1czMW5ga+0phIqDtD73sEcn7IlYCMLTRd32XUcbnbw8eglHwIVi5YC0f6DYpPUgth1z6cQ=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Feb 2018 23:55:02 +0100
X-Google-Sender-Auth: JQKAAmC3B2ZM6q1IZwq9_KI3wwA
Message-ID: <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
Subject: Re: [PATCH] char: nvram: disable on ARM
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591690923969903275?=
X-GMAIL-MSGID: =?utf-8?q?1591694017410501666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 11:05 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> /dev/nvram was never meant to be used alongside the RTC CMOS driver from
> drivers/rtc as it already expose the NVRAM through another interface..
> Anyway, the last defconfig to enable it properly was removed in 2010 so
> prevent ARM users from selecting it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/char/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index c28dca0c613d..9bcac927cfd0 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -264,7 +264,7 @@ source "drivers/char/hw_random/Kconfig"
>
>  config NVRAM
>         tristate "/dev/nvram support"
> -       depends on ATARI || X86 || (ARM && RTC_DRV_CMOS) || GENERIC_NVRAM
> +       depends on ATARI || X86 || GENERIC_NVRAM
>         ---help---
>           If you say Y here and create a character special file /dev/nvram
>           with major number 10 and minor number 144 using mknod ("man mknod"),

The change looks good:

Acked-by: Arnd Bergmann <arnd@arndb.de>

but taking a closer look raises a few other points:

* arch/arm/kernel/time.c has this code

#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || \
    defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE)
/* this needs a better home */
DEFINE_SPINLOCK(rtc_lock);
EXPORT_SYMBOL(rtc_lock);
#endif  /* pc-style 'CMOS' RTC support */

That can be adapted now, or maybe we could move all definitions into
a common place (that needs some more planning).

* similarly, this line in nvram.c can be simplified:
#if defined(CONFIG_ATARI)
#  define MACH ATARI
#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and ?? */
#  define MACH PC
#else
#  error Cannot build nvram driver for this machine configuration.
#endif

* GENERIC_NVRAM is not really generic, instead this seems to be the
  chardev that is used for 32-bit powerpc (powermac, 85xx, 86xx), while
  64-bit powerpc (cell, maple, opal, pseries) use code from
  arch/powerpc/kernel/nvram_64.c, with the same underlying arch hooks.
  The nvram_64 code appears to be mostly a superset of the 32-bit
  generic_nvram one.

* The code in drivers/char/nvram is not used at all when
   GENERIC_NVRAM is set, and half the code in there is different
   between x86 and atari.

* most of the external interface in include/linux/nvram.h is
  unused, the rest tends to be architecture specific

* The procfs file appears to be completely useless on any 64-bit
   x86 machine, this is what I see:

$ cat /proc/driver/nvram
Checksum status: valid
# floppies     : 0
Floppy 0 type  : none
Floppy 1 type  : none
HD 0 type      : none
HD 1 type      : none
HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
DOS base memory: 635 kB
Extended memory: 65535 kB (configured), 65535 kB (tested)
Gfx adapter    : EGA, VGA, ... (with BIOS)
FPU            : not installed

      Arnd
