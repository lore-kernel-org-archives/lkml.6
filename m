Return-Path: <kernel-hardening-return-12702-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuB8vVqpGVqbZkw22Vhz0NmarsFTWSYClfJLyv0ObIND4uYjR9uRfbOqwFLaCuHqLEiIoaJ
ARC-Seal: i=1; a=rsa-sha256; t=1521470351; cv=none;
        d=google.com; s=arc-20160816;
        b=IGtlnL5VsUGvTAZtDTsXjVZ81wMDocF6L9s70bfX/cfCtQIQRP0qkD3PTFGH/qCAlQ
         idEDfS4yfmXhIC42Wbv4pHAlrzq1tF9rr0WNXWl+VzDQtx/G4apQy3IRVKdJQZ1iBBl2
         oClllEI78Wd/oy+/YZUiuJF68xJlC91lR1STivsgLKJqKC1SXndIyDAEFz7nJ2MCl6XX
         DmymQy1RLzdT84Gnkl0OJyGWlmzSg2e/2nwwpREDa29h1PhqlzaYB2tv+Y8rg6h1SOyK
         0++6KmTnM22p+V/5n/MUGJ0GwSJlgsNNwP8VVYh0PgBfbug1XekoDBkjsBkqS5viCQXK
         i0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=TVNUGw/2FicYi/PP7br2jI62kN7fxBS8Q/Y12Z9n1/Y=;
        b=KP+ToYXkCmsJvPrwJpxdR27WWBOamqx17otx7lfm3RLt4Bd76MxzYSCOttm0pGO6uN
         TIrQ7zUxKtBFiesipF3T+nS4IOKAVDJ4TPPFLgqoSdGq2IEO28eO48tleUxWj0RkTjVd
         G/cKwFkf+0vzx7zFMzi++PrZh3axsPixEbnbzyxqXZNLVP36QYWHwrgcVXenPsWIr1N2
         TG8loHYMZvecFpfajXGlkb7DB3Vf79PvacmZI85smFe4V2jQxOqDBMY2rQ4WgtCVJqKe
         GXjp9IoSzZVKByyy4s9w+ku1ywhE0HeAV1DhVsizzFNJm1Dfcp9rhqQRm7GjQiv+Tu5s
         Fneg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12702-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12702-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12702-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12702-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 19 Mar 2018 15:38:51 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Laura Abbott <labbott@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <keescook@chromium.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Mathias Duckeck <m.duckeck@kunbus.de>
Subject: Re: [PATCHv2 2/4] gpio: Remove VLA from MAX3191X driver
Message-ID: <20180319143851.GA24209@wunner.de>
References: <20180315180030.20001-1-labbott@redhat.com>
 <20180315180030.20001-3-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315180030.20001-3-labbott@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595027631574096060?=
X-GMAIL-MSGID: =?utf-8?q?1595377294622953712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:00:28AM -0700, Laura Abbott wrote:
> 
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621)
> 
> This patch replaces several a VLA with an appropriate call to
> kmalloc_array.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Reviewed-and-tested-by: Lukas Wunner <lukas@wunner.de>

This one isn't a hotpath, so the kmalloc overhead is negligible.
Did a quick test on a single-chip MAX31913 with no apparent issues.

> ---
> v2: No changes
> ---
>  drivers/gpio/gpio-max3191x.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
> index f74b1072e84b..b5b9cb1fda50 100644
> --- a/drivers/gpio/gpio-max3191x.c
> +++ b/drivers/gpio/gpio-max3191x.c
> @@ -315,12 +315,17 @@ static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
>  						  struct gpio_desc **desc,
>  						  int value)
>  {
> -	int i, values[ndescs];
> +	int i, *values;
> +
> +	values = kmalloc_array(ndescs, sizeof(*values), GFP_KERNEL);
> +	if (!values)
> +		return;
>  
>  	for (i = 0; i < ndescs; i++)
>  		values[i] = value;
>  
>  	gpiod_set_array_value_cansleep(ndescs, desc, values);
> +	kfree(values);
>  }
>  
>  static struct gpio_descs *devm_gpiod_get_array_optional_count(
> -- 
> 2.14.3
> 
