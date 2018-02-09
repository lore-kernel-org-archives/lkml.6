Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518184702; cv=none;
        d=google.com; s=arc-20160816;
        b=UfspmWXdJVh/sr9n10Vfc4pkzPf96gtPJWqL9BTUUUOn20RkENKMYvkxZUVgJ67ILa
         iB473wAfIrFVGpf71jDT+S98PfU8aJqGER5Elv8t15P1Sl5EqPd5c6Mkj7AVL4uOdWbC
         7beVd7f6nre1I0ce2Nrx6Ca+ekLUV9UBYyQbyiOg4ezSEZl7I2vzzP9rG4kHQQ/hU2Vg
         F+GBymC17KtGQigE1xEO4wULbBSXBAeMpVYcEli9U+w2JwOrTlhFUlP7gVIslr4H+csy
         n0+xkIbkBhB9sCaUtAq7Yua5ToA51GMnUkErUhC28VP+EfpWxwk4a8hZjPr5mJ8WxYqO
         udSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yHjv6q/LB0SCExse0vKCNZlmF5eLadKBQ8oomnluWck=;
        b=rQGnZKbJDMV7ASMsQZCoJRgp6pwP7ZSK5LnaFQoXIedSFI8bPYGGgu+TWwjAwcVg0u
         QzW5gwNL29d6/FMIPC4uk+y2PwTxoRsGPpJJ6hCvCa7g0cU+eV+CR6yFOqgPh/5yLiK7
         FT7zbo99WnNAo8yRdJ0O6naYZpGXegUxrFNRsiZxUdvJj+Bvx7Mdvx0MBll/wikASvnY
         pvOaXjkuWSAeK9oHVeTJsljgbXQ6Tvi0/IEC7qQxApcnYDiZ2mrhhQLRaKaefZ7nkjv6
         gI9Gv9TXmaK4sfU8EPABZcinwTL+ZLqZHwvR9CKzeU94aKjYPTtIQgS8gM6NCeAca+ML
         D5AA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=N14ahWjS;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=N14ahWjS;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x227C5oGeve55iGALheMWeWk4F2FCwYqUtFLXpN4pU1YYXQwDovtvVmcYTZC7/mfVknEbOWZo/rTQ3NjRhvISn+o=
MIME-Version: 1.0
In-Reply-To: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
References: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 9 Feb 2018 14:58:21 +0100
Message-ID: <CAPDyKFoft7aCoKtODz66AAjpDQELVhqGurFYBV6FHP9hzhy-Ug@mail.gmail.com>
Subject: Re: [PATCH] base: power: domain: Replace mdelay with msleep
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590643262439305991?=
X-GMAIL-MSGID: =?utf-8?q?1591932042109662085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26 January 2018 at 09:38, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> After checking all possible call chains to genpd_dev_pm_detach() and
> genpd_dev_pm_attach() here,
> my tool finds that these functions are never called in atomic context,
> namely never in an interrupt handler or holding a spinlock.
> Thus mdelay can be replaced with msleep to avoid busy wait.
>
> This is found by a static analysis tool named DCNS written by myself.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/base/power/domain.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0c80bea..f84ac72 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2144,7 +2144,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>                 if (ret != -EAGAIN)
>                         break;
>
> -               mdelay(i);
> +               msleep(i);

This looks like a nice improvement, however moving to msleep() makes
the call to cond_resched() below a bit superfluous. Perhaps remove
that as well.

>                 cond_resched();
>         }
>
> @@ -2231,7 +2231,7 @@ int genpd_dev_pm_attach(struct device *dev)
>                 if (ret != -EAGAIN)
>                         break;
>
> -               mdelay(i);
> +               msleep(i);

Ditto.

>                 cond_resched();
>         }
>         mutex_unlock(&gpd_list_lock);
> --
> 1.7.9.5
>

Kind regards
Uffe
