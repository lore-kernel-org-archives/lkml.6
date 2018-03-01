Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519901676; cv=none;
        d=google.com; s=arc-20160816;
        b=ZxXfXAQYUFjddTxmTDLCq9F5gLiim2D4mBey4D12Q00+lVyhrM3VUd8w8zSs+Wa285
         VzPeBVlPTw+RV4CbZ1sB/tkHb2YW6Kv20HJTS7P5MQ3onH42tjekE2+j5jGLBw496C4s
         vuYRDlp2jai5xoi6O79Gy3KHRdLI/ia86f4vvIQ1ci56G13LvyEqc9dA+zJKpJ4ZpDmX
         qbVBXwJBuxA0ytKecRc388n/1fo1j5UxQ81r/AvFiHq3Vn2uUKMvQswcXtzQIt2YHOcz
         JQDCg3VoyK+aCPejMm4xEhGdh+c++QX7s2uzdjrM5kKpJJmKcThgHbOYO45rSJeB9kPx
         UkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=xdmIgbpyFvWQsku5Mk0WT70zzrAvXCen5kF9MX5HfHo=;
        b=TZSTprmcpHwvJg1M7GIP3g8DRb+SSW0fsDBp4zvcaWaM0BLrnLP3dg8Q8xb8EIe/L9
         D07ofCln2rs8XMTEf2rgz9XAO8TlzJCl2OqQepsyg9nTcMP2mwOto6PmXN5qj4SuFDMt
         6Qf4/JMD1B3QmWQMSiMS9QsgttBsy3VjubT3UW+LRSPANFc1l67AN6yKN0NQuBzyPOmu
         G1i9Z0MRAz0bwxFwBklUbG++hS29oX7IVuJDk3MbMAJEUztwEjnVYO5JU4Er2BnoIj8u
         QIc1+Z1qhRBsrfc61xJNA1uFVYDPDS8weLCqAmM8irBC6kqdIy1yWVetEYEDGNyfICOi
         FXbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=V9V8Ac9d;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=V9V8Ac9d;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuyBLu32nz8y6NKnaf1LSvyxk6OPJVMxpAxpcXqNlwbGjr4xCJbSZLBnHAUfY4HpMMVcGuEpInAOK9HEehumGk=
MIME-Version: 1.0
In-Reply-To: <55b8ad8c5e7ad38403c34a5d30d49f8aaba37156.1519883835.git.arvind.yadav.cs@gmail.com>
References: <55b8ad8c5e7ad38403c34a5d30d49f8aaba37156.1519883835.git.arvind.yadav.cs@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 12:54:35 +0200
Message-ID: <CAHp75VeiUccZp7fLeRv9d2qt61Ha=CPEo2rwKypY42WGO4Aejw@mail.gmail.com>
Subject: Re: [PATCH] driver core: Free memory obtained by kzalloc
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593713894002392634?=
X-GMAIL-MSGID: =?utf-8?q?1593732420366890777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 7:59 AM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> Here kfree() is taking NULL. So moving 'dev = NULL' after kfree().

Ouch! Does system_root_device_release() code ring a bell? How did you test this?

When you start eventually looking to the code?

NAK.

> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index ef61833..ccb64a0 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -1170,9 +1170,9 @@ static int subsys_register(struct bus_type *subsys,
>
>  err_dev_reg:
>         put_device(dev);
> -       dev = NULL;
>  err_name:
>         kfree(dev);
> +       dev = NULL;
>  err_dev:
>         bus_unregister(subsys);
>         return err;



-- 
With Best Regards,
Andy Shevchenko
