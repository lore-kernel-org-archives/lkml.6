Return-Path: <drustafa@yandex.ru>
X-Google-Smtp-Source: AB8JxZpe9kSTVUMfUQiQ1kMa8YvHocJJO7k2g6/USYVO6Ik8bN7pLimw19pl6Y5V1CDcUzu9Aw+A
ARC-Seal: i=1; a=rsa-sha256; t=1525100578; cv=none;
        d=google.com; s=arc-20160816;
        b=QNSOEne/p139QPtORxgmy5Iqx4gd3SkK4cNDwXkRfkQ9QrWQf6J6lOlv9/sIHoFMzj
         iN9elCck0HKvvTUBcDUtM2IxYhkulDDZX4Cf35IPd5uNLHNhCa57oWb8WbihDvcXpTk9
         K9dtwW+hqQEsy1reYjNUS3Z/9X0md0KPCmckblNExHaaaNbM6MXhz47GgrIefxedY/AF
         mcFVjuV0vH8TiuKSn409JoJtDUmUElhYR2CwHCQvJMQtQeKwX8dNwAbOVR5nsrRjeyPa
         39JkHGPq1vzYM3/wl4IVUA5zN6tGoWWW3mN1ukFihTqYrGiZ8VS2tDwzCrbGR6csLSsc
         31KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:date:message-id:mime-version:subject
         :references:in-reply-to:cc:to:envelope-from:from:dkim-signature
         :arc-authentication-results;
        bh=LwCXQ+BQma9Z/1SwUG8lHNGZjZADMXquWzgZ1L+BrSg=;
        b=PJTiTkd1RRqlLrDNHnFr46zQaY6LCFw8x12nyup44gvMp2/cmy0RY07MEVGYuTbROq
         vFlyeNNMgmyiJH40bEPDOE5eEXIep+6t3NPXLdlQFd99wGO+N9zoQfFeLvJbl6bGWgYR
         hNO//aO0WwCRDOnNgKJD1WpwOS8Wlkci9JrBgmFFOdDHZRehCrHicPF4lNG/4cgo2b3U
         au8hcfokhyCXosOuFnS2pfMooo2Kw4IKUgOtUgTE68ztW9mTqWlw9UvuSkcmsqYqURUu
         rzsK0k/hdaUwhvFBvstMp4/s4Pljb9bHOsuQ+L8AMz7jF4esDHrjObQKtlmHcpEKlR2G
         G+SA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yandex.ru header.s=mail header.b=HYPY7PXH;
       spf=pass (google.com: domain of drustafa@yandex.ru designates 2a02:6b8:0:1630::17 as permitted sender) smtp.mailfrom=drustafa@yandex.ru
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yandex.ru header.s=mail header.b=HYPY7PXH;
       spf=pass (google.com: domain of drustafa@yandex.ru designates 2a02:6b8:0:1630::17 as permitted sender) smtp.mailfrom=drustafa@yandex.ru
Authentication-Results: mxback1g.mail.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To: Stefan Potyra <stefan.potyra@elektrobit.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>,
	"sil2review@lists.osadl.org" <sil2review@lists.osadl.org>
In-Reply-To: <20180419130254.7nriykiybpyi6j2g@agrajag.zerfleddert.de>
References: <20180419130254.7nriykiybpyi6j2g@agrajag.zerfleddert.de>
Subject: Re: [PATCH] Enable clock before calling clk_get_rate() on it.
MIME-Version: 1.0
Message-Id: <4863111525100577@web2o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 30 Apr 2018 18:02:57 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599183864651429148?=
X-GMAIL-MSGID: =?utf-8?q?1599183864651429148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Stefan

Nice catch, thank you!

19.04.2018, 16:02, "Stefan Potyra" <stefan.potyra@elektrobit.com>:
> According to the API, you may only call clk_get_rate() after actually
> enabling it.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Fixes: a5fd9139f74c w1: add 1-wire master driver for i.MX27 / i.MX31
> Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

Greg, please pull it into your tree. Is this a stable material?

> ---
>  drivers/w1/masters/mxc_w1.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
> index 74f2e6e6202a..a9599027d4ef 100644
> --- a/drivers/w1/masters/mxc_w1.c
> +++ b/drivers/w1/masters/mxc_w1.c
> @@ -112,6 +112,10 @@ static int mxc_w1_probe(struct platform_device *pdev)
>          if (IS_ERR(mdev->clk))
>                  return PTR_ERR(mdev->clk);
>
> + err = clk_prepare_enable(mdev->clk);
> + if (err)
> + return err;
> +
>          clkrate = clk_get_rate(mdev->clk);
>          if (clkrate < 10000000)
>                  dev_warn(&pdev->dev,
> @@ -128,10 +132,6 @@ static int mxc_w1_probe(struct platform_device *pdev)
>          if (IS_ERR(mdev->regs))
>                  return PTR_ERR(mdev->regs);
>
> - err = clk_prepare_enable(mdev->clk);
> - if (err)
> - return err;
> -
>          /* Software reset 1-Wire module */
>          writeb(MXC_W1_RESET_RST, mdev->regs + MXC_W1_RESET);
>          writeb(0, mdev->regs + MXC_W1_RESET);
> --
> 2.17.0
