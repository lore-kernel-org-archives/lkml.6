Return-Path: <kernel-hardening-return-12974-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+fv2apFR7m6iApO01kTvpn2Rna2QuS27iAbyxvvtkx2YeOMjWNKbSJnX4ie/0E5DPSxLNb
ARC-Seal: i=1; a=rsa-sha256; t=1523459001; cv=none;
        d=google.com; s=arc-20160816;
        b=lI0MPRlzMj9qzQtfOSMUFeY9b6KjXDwhWX28FImTUMkYApibxlsXWWMk5/KgYOd3XB
         Y+4IHteospQ2/vshfEsiC0hS4OAWO2l1UYj3rUpG2NMvwMC/UddjtbHc27HZ+3Ztt9qC
         ZofjjbMYAy300vPhW70QUJoLin9hJji4ymX8yqI8C3zE49kH0yCMUe8OfnBWJ+QzqfuU
         mPuZMOLrjxsua1n0SkjmrWFG3wH0wnTrazHRGECRZ++HliIhE13rJL0/6GSdWctbE6Wj
         4IcHMJGRfqwjZFcpAz7BvkaOWeF4LWG2UMUzk2Fcjtc3Jd8wz6uApDRQPSVJL47LIApR
         OR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=pc67JXIvAEWJq3n2JPyRUQUUh8vX6S3sDYTYXL6cyYk=;
        b=CieuBcnxl9TiO2T0Of7UINjkmxl6sbNLA1XfWB/VBZArAvwCllAHVD8xpFoPZLi81m
         43h29pDa20zVSFFG4e5JndIWc5QibHvVDHb8QvaCFGDA6SdZMDtcz4MBa69WfblFJiDO
         HWSw3prwRDf/Joud08YFPB1rXwe32JA4LJnHg70DLgs41vg0qsUP/t6k0RnGWY3k7OET
         zbG3ZdLN8hyKWJ64nNo+PzRbUIzdh0fjtBiOX9apsA+SpkR0UPE72XOV94zc3RdnQlle
         Y12ooU4GQvEjzRpMaeugyL5lM1qqg0thrJL+rTDt9h9YdbCBPOPK6pZYET/bdT/seuhL
         gPJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12974-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12974-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12974-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12974-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 11 Apr 2018 17:03:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Laura Abbott <labbott@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCHv4] gpio: Remove VLA from gpiolib
Message-ID: <20180411150300.GA32719@wunner.de>
References: <20180411010352.17929-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411010352.17929-1-labbott@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409764349726473?=
X-GMAIL-MSGID: =?utf-8?q?1597462545802569320?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 06:03:52PM -0700, Laura Abbott wrote:
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -61,6 +61,11 @@ static struct bus_type gpio_bus_type = {
>  	.name = "gpio",
>  };
>  
> +/*
> + * Number of GPIOs to use for the fast path in set array
> + */
> +#define FASTPATH_NGPIO 256

Hm, this has regressed from 384 back to 256 since v3.


> @@ -2653,6 +2661,7 @@ static int gpio_chip_get_multiple(struct gpio_chip *chip,
>  	return -EIO;
>  }
>  
> +
>  int gpiod_get_array_value_complex(bool raw, bool can_sleep,

Spurious newline.  (In v3 this was the place where FASTPATH_NGPIO was
defined, this is a leftover from when you moved it further up.)

I've given this another quick test with gpio-hammer and it worked fine,
so this is still
Reviewed-and-tested-by: Lukas Wunner <lukas@wunner.de>

Thanks a lot!

Lukas
