Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520873658; cv=none;
        d=google.com; s=arc-20160816;
        b=PYtUnYlBKnNV1Cj5qKUG46ktqFziKsglL5iJSud9555cqOuZ1P6eWMZG8AZl55cWaf
         iV3MJDUBNYCwahQ/IJDeHjorz6hrBI+2zyhnSQaCevfrHepA9Gy3oYKPPT0aeq3aMs0W
         Q9gZepQsCSW8iDfZM3yi9VDfpcMeq0CpRnrb44JeG9cXNTXIFHQ+FqKrJnivIoS+tmFO
         /+6urcmlbDaFdPactmmlRZS3Kj/lGtmBMEa8e1pxcflhqoM5UnVTitUy2GHRMs7x9pHq
         tsBsOkkeVP0wEfds0ibvP/RSwdpFva2L9d6EEm+Y90GZb6Vi1MNmww6eFzLHTJMUYViQ
         BAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1edbKa8/TabGss2P5eSdHEBuzTUCUP5fvRrjTR7ozEM=;
        b=OluIjbkDQDUwssdPYXtav2bhZY5U+2yZUR9haaLU8mVjYSU0D5d1/Bgr5/ka2ahpqC
         1nF+33BuRRNcpOxKmIdrtruLWDpdIyBe+WJHWjGUGQGVNU4Gg3hGzntOuKTae4MMm3Uw
         Wcpht37HNK//Gwst70i4mabGPtWybLjHnplo8Iq+8hpuWALyl/7diP5CMZDkZ4cqP8Dh
         jjqkAdM3inUKSuGKd1SZQ3Eqy18SzED05l2aehmYE8d9ycWoEeblOLpj7ZrPFCOVJ6Jn
         ZZTx1zVyQeNTj7B4sc6QWcU0guUj73MmlPG1Y/rRDHredaIcN4fPo58WBSXJztvAZwXW
         rxJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gi92PFAh;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gi92PFAh;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvDfwdq49XjXXR7+fpCm5uViwJ4+RCItzcPLzU2tDa9wfkpfolbIFecUQGtmkhwbtAgGcE1ueoTU3e35cnBD3k=
MIME-Version: 1.0
In-Reply-To: <20180307232410.248434-2-djkurtz@chromium.org>
References: <20180307232410.248434-1-djkurtz@chromium.org> <20180307232410.248434-2-djkurtz@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Mar 2018 18:54:16 +0200
Message-ID: <CAHp75VfTH5gOM2PHPTVOrghKO0jq_e6Kb_2-WZrBoPLXfpSa2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/Kconfig: Add config for specifying BASE_BAUD
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Aaron Durbin <adurbin@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594323168937167564?=
X-GMAIL-MSGID: =?utf-8?q?1594751617427548756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 1:24 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Not all x86 CPUs have UARTs that use a baud reference clock (BASE_BAUD) of
> 115200 = 1843200 / 16.  For example, the UARTs on AMD Carrizo and later
> use a fixed input clock of 48000000, and hence require BASE_BAUD=3000000.
>
> The BASE_BAUD value is used by the generic earlycon driver to compute the
> UART clock used early in boot before the real serial drivers have a
> chance to load and read their input clock configuration from ACPI.
>
> Add a Kconfig option to override this default hard coded value.

This makes a deviation that prevents to have less kernels to cover
most of x86 cases.

Now we have the following:
 - x86-32 (covers i686)
 - x86-64 (covers x86_64)
 - quark (covers 1 core i586 TSC type of platforms)

In almost all above cases the 1843200 is used as UART clock.
(Exceptions are some of Intel MID devices)

Besides that I told you already the alternatives to mitigate the issue
(in order from preferable to non-preferable):

- since it's ACPI based platform, provide an SPCR table (problem solved!)
- fix your crap firmware to be compatible (even DT drivers are using
the same clock rate!)
- add a specific ->setup() callback for your crap hardware (see
drivers/tty/serial/amba-pl011.c as an example)

NAK.

>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  arch/x86/Kconfig              | 9 +++++++++
>  arch/x86/include/asm/serial.h | 4 ++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index eb7f43f23521..0a258bb30159 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -454,6 +454,15 @@ config INTEL_RDT
>
>           Say N if unsure.
>
> +config X86_SERIAL_BASE_BAUD
> +       int "UART input clock for platform 8250/16550 serial ports"
> +       default "115200"
> +       help
> +         This specifies the default frequency for the reference clock of the
> +         serial ports.  For many systems this is 1843200 / 16, which is the
> +         default, but may need to be changed to get earlycon to work on
> +         some hardware, such as those that use AMD Carrizo or later SoCs.
> +
>  if X86_32
>  config X86_BIGSMP
>         bool "Support for big SMP systems with more than 8 CPUs"
> diff --git a/arch/x86/include/asm/serial.h b/arch/x86/include/asm/serial.h
> index ece8299d2695..c28151090b51 100644
> --- a/arch/x86/include/asm/serial.h
> +++ b/arch/x86/include/asm/serial.h
> @@ -9,7 +9,11 @@
>   * clock, since the 16550A is capable of handling a top speed of 1.5
>   * megabits/second; but this requires a faster clock.
>   */
> +#ifdef CONFIG_X86_SERIAL_BASE_BAUD
> +#define BASE_BAUD CONFIG_X86_SERIAL_BASE_BAUD
> +#else
>  #define BASE_BAUD (1843200/16)
> +#endif
>
>  /* Standard COM flags (except for COM4, because of the 8514 problem) */
>  #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
> --
> 2.16.2.395.g2e18187dfd-goog
>



-- 
With Best Regards,
Andy Shevchenko
