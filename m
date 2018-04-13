Return-Path: <kernel-hardening-return-12983-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+uhGRX1hA/t0leEoFT2fU1GY3eWjX41O00VCn9WQG+tPgiJ7PKYwy8a1qbcugzlqWw3FgK
ARC-Seal: i=1; a=rsa-sha256; t=1523579990; cv=none;
        d=google.com; s=arc-20160816;
        b=VSkYD4OJ6F+5+lWAm+MKAVDoZN9+MJs8VZ4lmLoU2H1YCVYu+1WHq46AI6+JvUuqvK
         vQP6gcgmks9QlkpFbWnxkJmoOdONiitgCTzk2xbgWkHcPEpNVJTv/Dek+4dft+KgQ3Jr
         YLn+DX6fAm9WcHmuIdzNw7PSHkw2FmjoCr41S/3zCHBMloVIfidE7Vv6CEh0qAnXrC+U
         AEWuTds7BqSzs96rU+Ug4Ab8pjiIFHDsPS+xqTv/1j8R62hkQoIXY25Zesjt/cU9pKsU
         EPWhSwBtHOE2fag9vmpDVUW8Mbirrg0mzEtNOuhKsxh0zLaGdPozlXiVKc845A+KErG8
         BRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=b6IN1fYsG2FB4v+y2KzBbKJSlOWV/6RHDhnWwD7/2cw=;
        b=Q4t6ZDruGySTiVwze538aRrR8p4a1/etmhN8WGaPvOxXEjHU/S2y4SoLmdeEWvi3G0
         cc523oqL4ubh1XDQBCczI2IJ236Hpf/UzeUX9WcOkNDL+tsvrKx8khm921YCnQnRh67k
         z4HmFHcIxRtHgFVpV81GUQ1/tLnR3Yo8pAvZZnUTIDWt0qAo0t9NjnzS5dBG/BSAC/q5
         qYNgi8Bal3AfU842RhOK8dp2AX69zgBrMfWTb4T8f+pbeiPhocCDjyBVhHQ3MkEZPGZ8
         E1QyM0idMp1Gbdm7OnuvL+3XaQmJMeu5quDkQEO8Y2Gbev7ibn/ZrG70JrjhIl43LBBm
         5jzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12983-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12983-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12983-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12983-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCHv4] gpio: Remove VLA from gpiolib
To: Linus Walleij <linus.walleij@linaro.org>,
  Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Lukas Wunner <lukas@wunner.de>,
  Rasmus Villemoes <linux@rasmusvillemoes.dk>,
  "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  kernel-hardening@lists.openwall.com
References: <20180411010352.17929-1-labbott@redhat.com>
 <CACRpkdb04=5eHW3xR-qmY6UzOUcAC35mV4eDgHaFn9nQEL_eEw@mail.gmail.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <c618af81-2dbb-1aff-212a-e87e56caa7eb@electromag.com.au>
Date: Fri, 13 Apr 2018 08:39:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb04=5eHW3xR-qmY6UzOUcAC35mV4eDgHaFn9nQEL_eEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409764349726473?=
X-GMAIL-MSGID: =?utf-8?q?1597589412324167825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12/04/2018 16:38, Linus Walleij wrote:
> On Wed, Apr 11, 2018 at 3:03 AM, Laura Abbott <labbott@redhat.com> wrote:
> 
>> The new challenge is to remove VLAs from the kernel
>> (see https://lkml.org/lkml/2018/3/7/621) to eventually
>> turn on -Wvla.
>>
>> Using a kmalloc array is the easy way to fix this but kmalloc is still
>> more expensive than stack allocation. Introduce a fast path with a
>> fixed size stack array to cover most chip with gpios below some fixed
>> amount. The slow path dynamically allocates an array to cover those
>> chips with a large number of gpios.
>>
>> Reviewed-and-tested-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v4: Changed some local variables to avoid coccinelle warnings. Added a
>> warning if the number of GPIOs exceeds the current fast path define.
>>
>> Lukas, I kept your Tested-by because the changes were pretty minimal.
>> Let me know if you want to run the tests again.
> 
> This patch is starting to look really good.
> 
>> +/*
>> + * Number of GPIOs to use for the fast path in set array
>> + */
>> +#define FASTPATH_NGPIO 256
> 
> There is still some comment about this.
> 
> And now that I am also tryint to think I wonder about it, we
> have a global ARCH_NR_GPIOS that is typically 512.
> Some archs set it up.
> 
> This define is something of an abomination, in the ARM
> case it comes from arch/arm/include/asm/gpio.h
> where #define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
> where the latter is a Kconfig option that is mostly 512 for
> most ARM systems.
> 
> Well, ARM looks like this:
> 
> config ARCH_NR_GPIO
>          int
>          default 2048 if ARCH_SOCFPGA
>          default 1024 if ARCH_BRCMSTB || ARCH_SHMOBILE || ARCH_TEGRA || \
>                  ARCH_ZYNQ
>          default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
>                  SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
>          default 416 if ARCH_SUNXI
>          default 392 if ARCH_U8500
>          default 352 if ARCH_VT8500
>          default 288 if ARCH_ROCKCHIP
>          default 264 if MACH_H4700
>          default 0
>          help
>            Maximum number of GPIOs in the system.
> 
>            If unsure, leave the default value.
> 
> So if FASTPATH_NGPIO should be anything else than
> ARCH_NR_GPIO this has to be established somewhere
> as a floor or half or something, but I would just set it as
> the same as ARCH_NR_GPIOS...
> 
> The main reason this define exist is for this function
> from <linux/gpio/consumer.h>:
> 
> /* Convert between the old gpio_ and new gpiod_ interfaces */
> struct gpio_desc *gpio_to_desc(unsigned gpio);
> 
> Nowadays that fact is a bit obscured since the variable is
> only used when assigning the base (in the global GPIO
> number space, which is what we want to get rid of but
> sigh) in gpiochip_find_base() where it attempts to place
> a newly allocated gpiochip in the higher region of this
> numberspace since the embedded SoC GPIO base tends
> to be 0, on old platforms.
> 
> So I don't know about this.
> 
> Can't we just use ARCH_NR_GPIOS?
> 
> Very few systems have more than 512 assigned global
> GPIO numbers and those are FPGA experimental machines.
> 
> In the long run obviously I want to get rid of these defines
> altogether and only allocate GPIO descriptos dynamically
> so as you see I am reluctant to add new numberspace weirdness
> around here.
Isn't that for total GPIO's in the system?
And the arrays just need to cater for max per chip?
 From what I can understand of the code which is admittedly limited.


-- 
Regards
Phil Reid
