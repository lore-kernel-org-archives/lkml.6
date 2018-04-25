Return-Path: <tkjos@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524671815; cv=none;
        d=google.com; s=arc-20160816;
        b=0UTh2LkkDcZ+BUMWAtSGQxRBiOghJMAxcIHu7YDGa66RhsCZ2Y6fvZLS7HYeJbrecC
         bcLocZJbs92KyzY6XMIXcgzF2EM+uZ1C+BZOVcuv5g9E7lOox9Rewv9IPhGwwAhvlqYS
         zK7yRb/F4nuukJQt04SePRDSm6Q3OLagKxMsEonX0zrBpNvvu4uqGusdSe+0cyEnBeZP
         N8etj2DrYM4YmLGcmMvJvGCWgpHshQvK9rKRBYGzbjcPFWExWAkWbewYCfotm3SsyG7o
         rEAD+9hkRuqqG6o7szWwadM4AGtRemgaPuFl5ZAJNiGL5Od9PLQJuJM8vUC8GBKYGYiB
         vyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=UHdAQ7r98JkFyCoeIxnu063M22oB/ju0iFC24uA+Gs0=;
        b=fbDeqpORAGYdFvnA1Xq4KGv+1A3Sfqhdf5ct5/Yso2EAWIEMDuDKAuvuTV7j4BE1q0
         NkPFJCeyaN5r6Fmf8upNs+gvLOix6mzbvcv7g8wURyHq2RbYqbkmvbte68aS9GWpo3kM
         5/F7pFaI0dG5lx0nZRTaQ9IZhPSX8KdGzxADrZ/5rl8qzlV9ivstEOuXNuU/bu3ROK97
         u2xb5MglLX6431rYXexGft9L+ByTD0Erh+O4GP463EjqoCqCBXCooKSH3d6Yi2ncJF1e
         3zUyPgZemm7dhKvUOA+EEIAPQfbiacqSRZ4GGWPCVabLKbRjnsirudrKLp11pbJRnHyK
         WeLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=BOy+Dzmo;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=BOy+Dzmo;
       spf=pass (google.com: domain of tkjos@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AIpwx49xqnwedhXLiQIQXzAQtKiN3U49oVjzNaCp+yw9R3IL78vKUxCw4SqcpTCSBNHMg2WC6V5yFx8Ys0DtGfhGITM=
MIME-Version: 1.0
In-Reply-To: <1523366506-19832-4-git-send-email-geert+renesas@glider.be>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be> <1523366506-19832-4-git-send-email-geert+renesas@glider.be>
From: Todd Kjos <tkjos@android.com>
Date: Wed, 25 Apr 2018 08:56:54 -0700
Message-ID: <CAD0t5oOmch2YG2Gi9X3VSXt2qLKabjRFKO_8fPFo=O8GEE3hWA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: amba: Don't read past the end of sysfs
 "driver_override" buffer
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>, Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365567393442671?=
X-GMAIL-MSGID: =?utf-8?q?1598734273561618572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reviewed-by: Todd Kjos <tkjos@android.com>

On Tue, Apr 10, 2018 at 6:21 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> When printing the driver_override parameter when it is 4095 and 4094
> bytes long, the printing code would access invalid memory because we
> need count + 1 bytes for printing.
>
> Cfr. commits 4efe874aace57dba ("PCI: Don't read past the end of sysfs
> "driver_override" buffer") and bf563b01c2895a4b ("driver core: platform:
> Don't read past the end of "driver_override" buffer").
>
> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/amba/bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 36c5653ced5742b7..4a3ac31c07d0ee49 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -84,7 +84,8 @@ static ssize_t driver_override_store(struct device *_dev,
>         struct amba_device *dev = to_amba_device(_dev);
>         char *driver_override, *old, *cp;
>
> -       if (count > PATH_MAX)
> +       /* We need to keep extra room for a newline */
> +       if (count >= (PAGE_SIZE - 1))
>                 return -EINVAL;
>
>         driver_override = kstrndup(buf, count, GFP_KERNEL);
> --
> 2.7.4
>
