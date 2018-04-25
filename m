Return-Path: <tkjos@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524671770; cv=none;
        d=google.com; s=arc-20160816;
        b=mPJJr3bQxqbzVbLiW5bZwKEl1SX8pxbOec7ipLrDww1YmkZZrKmbndR8v6X+jaYv5v
         FTY5CsBo4yp4NJMmJCPLA4ugAp8vmhPf1/L5z52li2HZGvvIF/yX+T+tVScwLnV3rO7Y
         ZcE3wSUyPJOas9lc6+p/hSmvJoSvY8igufxrIJ/y97cigourEDo2S3l6laML4XrvFhLl
         umWB/TDJQn57os6J2rSiwZtyZM9Dh7CABDm6HzBZWbYufpfrE5KHWlBGEY3GwXixFluY
         VHOW6ZPv6AZhGuIrDfdOZ4VyxqMSa563PUW1ZS13vb63FetuM3Hkne3x8flYez5SL14g
         WqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=3+FdJP1qLXrXsMILF6YY4ciuj+34BbYQhRH801gUGwA=;
        b=ymYgmWrNJSfcNaw4yiU36W49M8QgE1fsXUE0HANoCnUfSSrQwGhxk5Fl8N43KTvkPP
         dVcBcTm0oRIwPTZbaD1mo3aXqZdeUfOUXR2v4ZehfkPfvoDk28Fx4w2U/LobmXfoepHT
         G/1mZBaNlvyNBVA7CJubfVZX1z6o8HsUgwS46pGanEiPMK/ot2LmcpXcZ4XkIls5aiUL
         GIr5LCv22eQR9O0vfDYMd07jo2l0jLTun0aTZhuio8E00cS5qQpo8luzB0oiZW0P2FYn
         fegwd/mUZ7w1AuKOnXoGximAqe32sAPYqmfQb47+rLo89x+H+djHkVDE7RvSZkjnmyie
         TD9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=rydZ5Woj;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=rydZ5Woj;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AIpwx49LUxh/h/IHzfpyD2tPXHT8CRTNhbPPFxu0bnb2wieTbTXyguMg328UwK9QtEIONIgmZuY5AtqRBcR7nfXFpQA=
MIME-Version: 1.0
In-Reply-To: <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be> <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
From: Todd Kjos <tkjos@android.com>
Date: Wed, 25 Apr 2018 08:56:09 -0700
Message-ID: <CAD0t5oPbMFMgxvePX=qu3aq-L0nPqwC9MJmyXoQRaW85+HK75w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: amba: Fix race condition with driver_override
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>, Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365566189003865?=
X-GMAIL-MSGID: =?utf-8?q?1598734226056005068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reviewed-by: Todd Kjos <tkjos@android.com>

On Tue, Apr 10, 2018 at 6:21 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The driver_override implementation is susceptible to a race condition
> when different threads are reading vs storing a different driver
> override.  Add locking to avoid this race condition.
>
> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
> condition with driver_override").
>
> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/amba/bus.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 6ffd778352e6d953..36c5653ced5742b7 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -69,8 +69,12 @@ static ssize_t driver_override_show(struct device *_dev,
>                                     struct device_attribute *attr, char *buf)
>  {
>         struct amba_device *dev = to_amba_device(_dev);
> +       ssize_t len;
>
> -       return sprintf(buf, "%s\n", dev->driver_override);
> +       device_lock(_dev);
> +       len = sprintf(buf, "%s\n", dev->driver_override);
> +       device_unlock(_dev);
> +       return len;
>  }
>
>  static ssize_t driver_override_store(struct device *_dev,
> @@ -78,7 +82,7 @@ static ssize_t driver_override_store(struct device *_dev,
>                                      const char *buf, size_t count)
>  {
>         struct amba_device *dev = to_amba_device(_dev);
> -       char *driver_override, *old = dev->driver_override, *cp;
> +       char *driver_override, *old, *cp;
>
>         if (count > PATH_MAX)
>                 return -EINVAL;
> @@ -91,12 +95,15 @@ static ssize_t driver_override_store(struct device *_dev,
>         if (cp)
>                 *cp = '\0';
>
> +       device_lock(_dev);
> +       old = dev->driver_override;
>         if (strlen(driver_override)) {
>                 dev->driver_override = driver_override;
>         } else {
>                kfree(driver_override);
>                dev->driver_override = NULL;
>         }
> +       device_unlock(_dev);
>
>         kfree(old);
>
> --
> 2.7.4
>
