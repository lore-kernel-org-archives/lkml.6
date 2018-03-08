Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AG47ELvrJcY3bCmp3+xSLNmomQoPFDP/jfmYfDT5igIOFEDEOeyetE6YcE8hWB5sLyjK/YjJucvp
ARC-Seal: i=1; a=rsa-sha256; t=1520473762; cv=none;
        d=google.com; s=arc-20160816;
        b=R7S6m4om/ItPRe94anKvrSdKhTWu9t7r1A4DMDvVqdNpop0p0bVoboukeip9poSnuc
         Nh90axl/bAwxRhRlznoIERwqPoT/WdQRaIKpj3ycqTBR8mqzqxmMTXxyTswoyFdld3Z0
         hhVk2S9PdMbTWzHANANG1DYO3wOJ2bGatomrXA4jKEx6BewWPe27RVDo1ttN5Xxs5LyS
         Gxt4mHnWZFz3AT/EePhUJRy6TQgk0GdTZIHvZpYiQ+4ZbFAaWjHl1yUvhYmEBGNNS+PC
         YbIrh2i2p1bMViUo/JC6U6QsfZw2Bzo5WAZOib44FaYUAvZgUMqkxbVrivhaKagQeVQT
         6U4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=CElXej8SU+8jVQmYLAzXQVhwyfNMjAA/MLxUsSV8HWg=;
        b=yjg3JGvLcFHVzH1enOyUdpBjRqmMq/BP0c3DdxYo74JZwEI+7uFAOdEPiy+Mx5vcoy
         aWlt2RaBMcDEnbiJ0LQL6E075IYKwRnXdTeSnQlvjU8ENsZtCF+l/XcEUaMdKJmfaKLV
         J1pZFURn1v/UUwsnIx03EwX3z4mDr0n9czYdpdSLDX5Oj16VOdYmOa5tYXtLSNFvNtIk
         4cBjsiKXem/rpOvDZ9rC6Oo63hjUTmv/fzgfcVUO8spk24JOqLoG2K4OV8n3CJ/MSuVp
         aYcDWuiVgzKQAof59yLqGdb+MjPo5imm4BEk3/kk8fh+Iuv8KN9Q2Ru6x2kyV/X2OWdj
         jY5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=aPCRQTgi;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=aPCRQTgi;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 2/2] x86/Kconfig: Add config to allow not defining old
 serial ports
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20180307232410.248434-1-djkurtz@chromium.org>
 <20180307232410.248434-3-djkurtz@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb1a687d-43ba-3a48-52f7-716963ba6a1c@infradead.org>
Date: Wed, 7 Mar 2018 17:49:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307232410.248434-3-djkurtz@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594323171219342758?=
X-GMAIL-MSGID: =?utf-8?q?1594332295741820713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/2018 03:24 PM, Daniel Kurtz wrote:
> The old_serial_port global array in 8250_core is supposed to hold an entry
> for each serial port on the system that cannot be discovered via a
> standard enumeration mechanism (aka ACPI/PCI/DTS).  The array is populated
> at compile-time from the value specified in the SERIAL_PORT_DFNS macro.
> This macro is defined in arch/serial.h.
> 
> For x86, this macro is currently unconditionally initialized to supply
> four ioport UARTs (0x3F8, 0x2F8, 0x3E8, 0x2E8).
> 
> However, not all x86 CPUs have these four ioport UARTs.  For example, the
> UARTs on AMD Carrizo and later are separate memory mapped Designware IP
> blocks.
> 
> Fairly early in boot the console_initcall univ8250_console_init iterates
> over this array and installs these old UARTs into the global array
> serial8250_ports.  Further, it attemptes to register them for use as
> the console.  In other words, if, for example, the kernel commandline has
> console=ttyS0, the console will be switched over to one of these
> non-existent UARTs.  Only later, when the real UART drivers are probed
> and their devices are instantiated will the console switch back over to
> the proper UART.
> 
> This is most noticeable when using earlycon, since part of the serial
> console log will appear to disappear (when the bogus old takes over) and
> then re-appear (when the real UART finally gets registered for the
> console).
> 
> Add a Kconfig option to allow overriding this default hard coded value
> for arch/x86 devices that do not have such serial ports.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  arch/x86/Kconfig              | 11 +++++++++++
>  arch/x86/include/asm/serial.h |  4 ++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0a258bb30159..7501cd776cfc 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -463,6 +463,17 @@ config X86_SERIAL_BASE_BAUD
>  	  default, but may need to be changed to get earlycon to work on
>  	  some hardware, such as those that use AMD Carrizo or later SoCs.
>  
> +config X86_SERIAL_DEFINE_OLD_SERIAL_PORTS
> +	bool "Define un-enumerable serial ports"
> +	default y
> +	help
> +	  Say Y here if you want the kernel to assume the precense of built-in

	                                                  presence

> +	  serial ports that do not have a standard enumeration mechanism.
> +	  Platforms that can find all serial ports via mechanisms like ACPI or
> +	  PCI can set this to N.
> +
> +	  If unsure, say Y.
> +
>  if X86_32
>  config X86_BIGSMP
>  	bool "Support for big SMP systems with more than 8 CPUs"



-- 
~Randy
