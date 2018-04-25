Return-Path: <tkjos@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524671618; cv=none;
        d=google.com; s=arc-20160816;
        b=iAR/6a42B0XMYF9M7dHY7ouIAtC2TJPh5QmK4OHIE/tNsQJfdTTQUImgewwctzqYMA
         XTTTS6t7Uta7TWeUyQcctJ6HcsnmLO+A5K1kAkVfHh+MSgH8IY44JN74ioBjR0k4gUzs
         ZmYwcfKg0l8QReb1UQ/fwCX8jlo+kzaTI/3ODMlXuMU0LHyysrOWPVQiKOi7S2DFoIvo
         QbRnUJjuJVZXun93wlhzT6PUZH+yKnyeti33F+QWJ+zTaqCwaZNFMy4ETV2/Lq1CN5t0
         oh/oXzbz0OFDco5RR7CFHX5/hmROyyzK1rNSwa6PgRBo35VUeVk63qJ1FEFoAWzN/5qe
         lHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Y1FzNeJ0+g7UF76m6GSQGUuKll28ZO1Osu0vjbkdSzw=;
        b=If410HoREZKe+Yly1In1XBWZChFUI1lkoVhi4ptD5THcVhDynlnIFu7R09je1K9ugq
         gpSZqm9FACOKIJ3317y/1l3u5oQi4B0rchWG6AUrCoUIP6fH/8lcN88oaEQ4gEYHXf1e
         fok+8zOKlLr81vLDLbuxbpIDGJss0wii/TmJxooDCUcxfLfvKaLivgdwDWo653gMJg73
         T/RBy94kNHm9eEP9ugK9Gf2S8a65r/62QpdKqb3iEcgALw1fLUMuaejwsXnN8BMEeet3
         SBLX2Pn5NLpM5N1Z6lmpB/CMhLJ9nBnzreZv7s69e/yN7JL+xZZdo5FE1wK/MYlXlkKP
         BUTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=pd/Pml0V;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=pd/Pml0V;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AB8JxZp6MfyfKyfMYax2/+k7j+aABrTyFbtHcHZTbdiQidbJYa76bafcPCCiNiAN4Kint0cOaXkT/2uqf3AzrYTBnUg=
MIME-Version: 1.0
In-Reply-To: <1523366506-19832-2-git-send-email-geert+renesas@glider.be>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be> <1523366506-19832-2-git-send-email-geert+renesas@glider.be>
From: Todd Kjos <tkjos@android.com>
Date: Wed, 25 Apr 2018 08:53:37 -0700
Message-ID: <CAD0t5oN8M4yj1=9cbZQ6NUC8paHMYyTcQ7yL9oAP4AvFD22nTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: amba: Make driver_override output consistent
 with other buses
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>, Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365567321703916?=
X-GMAIL-MSGID: =?utf-8?q?1598734066652455216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reviewed-by: Todd Kjos <tkjos@google.com>

On Tue, Apr 10, 2018 at 6:21 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> For AMBA devices with unconfigured driver override, the
> "driver_override" sysfs virtual file is empty, while it contains
> "(null)" for platform and PCI devices.
>
> Make AMBA consistent with other buses by dropping the test for a NULL
> pointer.
>
> Note that contrary to popular belief, sprintf() handles NULL pointers
> fine; they are printed as "(null)".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/amba/bus.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 594c228d2f021123..6ffd778352e6d953 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -70,9 +70,6 @@ static ssize_t driver_override_show(struct device *_dev,
>  {
>         struct amba_device *dev = to_amba_device(_dev);
>
> -       if (!dev->driver_override)
> -               return 0;
> -
>         return sprintf(buf, "%s\n", dev->driver_override);
>  }
>
> --
> 2.7.4
>
