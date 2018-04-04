Return-Path: <kernel-hardening-return-12849-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48H4aqybco/6zT0jTZykUrmWwFa1kUkLTXw6dZDdvH5kDbKnNKs6C1YYJRxG6CGSyAgXPsR
ARC-Seal: i=1; a=rsa-sha256; t=1522846656; cv=none;
        d=google.com; s=arc-20160816;
        b=pX5nFHG1KH7p4wA5XQZ1mxPscEObJp5aUR6zkILmE+4qxFrJm5pUu63mrw3qZRi0pH
         MfdkxZ+0NdHGAJW9Sg7y5hneTWHC6XvcgYtuVpwHNO5jn/pTk/EHVU6zkQh++5mmO3G2
         BgU1PnPAi4KLqgEpC2afBa/4IxAxKAW34fOX1V6G2VMUuQcc+tpMz1ww0QN/9tChrNwt
         1x/ZgjcB4/9FnMwx4J6+Poq2N8ZhcZMeuEfv/2fQ/569yzuSy2NSEDX6Xznxqr7Cwb3j
         NtazdV4BE5Um462Isx1DQGSYZ0FV/lj9Z45cY5vFoU85vBfZcK+OzCwzm91fvVJ+zfa6
         kheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=xRAObPQub1H6AuquoGhwmEBPv2KkvbzJNUKAsXuiTa4=;
        b=CC0Qu6GLkUaI/7e6M2RmVl3LfxqSzkybo406UkijJL1xaCnUp7e1HHYGmhiEGJag9O
         GImXc3/NwsLdqi79y39/K4Og00r54SeNDoQVFvV5K/dvjV8cIj4gsiDGc4WL2cYbWOBs
         bU5ZDNZ4VvjAr4STBlOPvjFtOLtDU+6zs4ilH2O8SWyjh47KMTk8n9HmfmuvMh106yXW
         dWgE+8SE4WUiCy9E8KZ192XBJfjGB1k4ZZ5NHZPoVEJyGncZxSnKrX6tfJ7kjuPAmnTg
         R5nQSDVZx20/FGZxqvAUDzv1ZnxcGiKM04LNh+OGrHC4Gf3YCbxpQxetdkUMj6bp/esp
         J0kQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=N1UaOiZO;
       spf=pass (google.com: domain of kernel-hardening-return-12849-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12849-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=N1UaOiZO;
       spf=pass (google.com: domain of kernel-hardening-return-12849-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12849-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <1522045994-21913-1-git-send-email-me@tobin.cc>
References: <1522045994-21913-1-git-send-email-me@tobin.cc>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Apr 2018 14:45:31 +0200
Message-ID: <CAPDyKFobX6U4_st0nE7-yHt1SPFu4diLhzTaswY6Xt3BrruvAA@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq: Use kmalloc_array instead of stack VLA
To: "Tobin C. Harding" <me@tobin.cc>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com,
	Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595980934577926333?=
X-GMAIL-MSGID: =?utf-8?q?1596820455331382848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26 March 2018 at 08:33, Tobin C. Harding <me@tobin.cc> wrote:
> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> (kernel Oops) or a security flaw (overwriting memory beyond the
> stack). Also, in general, as code evolves it is easy to lose track of
> how big a VLA can get. Thus, we can end up having runtime failures
> that are hard to debug. As part of the directive[1] to remove all VLAs
> from the kernel, and build with -Wvla.
>
> Currently driver is using a VLA declared using the number of descriptors.  This
> array is used to store integer values and is later used as an argument to
> `gpiod_set_array_value_cansleep()` This can be avoided by using
> `kmalloc_array()` to allocate memory for the array of integer values.  Memory is
> free'd before return from function.
>
> From the code it appears that it is safe to sleep so we can use GFP_KERNEL
> (based _cansleep() suffix of function `gpiod_set_array_value_cansleep()`.
>
> It can be expected that this patch will result in a small increase in overhead
> due to the use of `kmalloc_array()`
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Thanks, queued for 3.18!

Kind regards
Uffe

> ---
>
> Patch is untested.  I was not able to fully grok the call chain involved
> with this change so was unable to quantify the total degradation
> of performance.
>
> Line calling to gpiod_set_array_value_cansleep() is 83 characters long,
> patch attempts to leave the code as clean as possible.  Open to
> suggestions for improvement.  I tried various forms of while loop and
> pointer arithmetic for the setting of `values` but in the end settled
> for array indexing, again open to suggestions.
>
> thanks,
> Tobin.
>
>  drivers/mmc/core/pwrseq_simple.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 13ef162cf066..a8b9fee4d62a 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -40,14 +40,18 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>         struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
>
>         if (!IS_ERR(reset_gpios)) {
> -               int i;
> -               int values[reset_gpios->ndescs];
> +               int i, *values;
> +               int nvalues = reset_gpios->ndescs;
>
> -               for (i = 0; i < reset_gpios->ndescs; i++)
> +               values = kmalloc_array(nvalues, sizeof(int), GFP_KERNEL);
> +               if (!values)
> +                       return;
> +
> +               for (i = 0; i < nvalues; i++)
>                         values[i] = value;
>
> -               gpiod_set_array_value_cansleep(
> -                       reset_gpios->ndescs, reset_gpios->desc, values);
> +               gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc, values);
> +               kfree(values);
>         }
>  }
>
> --
> 2.7.4
>
