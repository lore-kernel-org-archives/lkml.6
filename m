Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12704C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B283120671
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lp3g6lCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B283120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeI2EoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:44:12 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44739 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeI2EoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:44:11 -0400
Received: by mail-yw1-f65.google.com with SMTP id s73-v6so3270909ywg.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gtLPTQsJ1Y0ywvlsMAJhLgYov1Y0jAnFUB1dJhoTGmg=;
        b=lp3g6lCcwcpTQC5Hasszi/ii/w+Qu/1Asq5Q0+BE5i0dxWqBnDiuZZqiixG36vP6pT
         ckdHyM5MNtLKSFFJXyad+GlEtNunqB0zl6eXm2iWuET7ozk9kjM3gIPKD7qWo7a8JpMW
         zKt/v1GH19CosKMOZjRrv8QGnERg2a+ZbyaOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gtLPTQsJ1Y0ywvlsMAJhLgYov1Y0jAnFUB1dJhoTGmg=;
        b=rotcxShBWtJZfdDM80iwLlJBCPPEUa3iFIdafYhjUxDFMA3rClFT5mq/jeHnAHhf0J
         l0sL/OXvS37mUimXBvZ5Ua7Zle6saqtRzPW0ocmSh0WGgJMFUbwjyVMO1CaMDAiFRliL
         yGBi6D2EVG6xZthfFlFa6UQIy5bMGl9wx+x4n5yMLsvz14IqyVmZgesNszl0MZXkONXa
         v+989BXVUiI+BoUmSyiBMP2Hm4Zoj6pKstMUtKm5Z3BRDT9TgsvkIpY99tCxprED35t2
         +3QCgg6mL5sek3k/rlgeVX5CO4727I4zPD163RAX874NNRJnLEFU75eyV6HAjdpbYPz6
         FOkg==
X-Gm-Message-State: ABuFfog8J4YtwoLtbTfi2C9l8ygPj0KMAzU6GwmfvSuZ9QT5ScwFFYQb
        B0Z98Q1bxZVvPpphyYWnLUi8Z0RzZ9Y=
X-Google-Smtp-Source: ACcGV63G1q1x+1ZTP6l9Bcoojo3bCrJyKn3ASuPgYdcrAK4CEtLj16jl29SfVOJ4HrSQeuXKHDcRig==
X-Received: by 2002:a81:5908:: with SMTP id n8-v6mr368003ywb.354.1538173102279;
        Fri, 28 Sep 2018 15:18:22 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 124-v6sm2419727yws.25.2018.09.28.15.18.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:18:21 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 5-v6so3327359ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:18:21 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr365705ybg.171.1538173100665;
 Fri, 28 Sep 2018 15:18:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 15:18:19
 -0700 (PDT)
In-Reply-To: <20180917091531.21356-1-nixiaoming@huawei.com>
References: <20180917091531.21356-1-nixiaoming@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 28 Sep 2018 15:18:19 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKfZbRC2t0b6RnFmS2buhP-bvTO0aFSkR8knPXZFnDCsA@mail.gmail.com>
Message-ID: <CAGXu5jKfZbRC2t0b6RnFmS2buhP-bvTO0aFSkR8knPXZFnDCsA@mail.gmail.com>
Subject: Re: [PATCH] fix memory leak in ramoops_init
To:     nixiaoming <nixiaoming@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the future, please use scripts/get_maintainer.pl to find your To/Cc list. :)

On Mon, Sep 17, 2018 at 2:15 AM, nixiaoming <nixiaoming@huawei.com> wrote:
> 1, memory leak in ramoops_register_dummy.
>    dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
>    but no free when platform_device_register_data return fail

Yup, that's a problem.

> 2, if kzalloc(sizeof(*dummy_data), GFP_KERNEL) return NULL,
>     but platform_driver_register(&ramoops_driver) return 0
>    kfree(NULL) in ramoops_exit
> so, add return val for ramoops_register_dummy, and check it in ramoops_init

The kfree(NULL) isn't a problem, but a NULL platform_data implies
device tree data is expected, so it'll just confuse things. However,
since the dummy platform data is optional, there's no need to plumb
the return value back up. Either it gets set up correctly, or there is
a pr_info() about why it has been ignored.

> 3, memory leak in ramoops_init.
>    miss platform_device_unregister(dummy) and kfree(dummy_data)
>    when platform_driver_register(&ramoops_driver) return fail

Agreed.

> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>  fs/pstore/ram.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index bd9812e..331b600 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -604,17 +604,17 @@ static struct platform_driver ramoops_driver = {
>         },
>  };
>
> -static void ramoops_register_dummy(void)
> +static int ramoops_register_dummy(void)

Another bug is that this should actually be __init (it's only called
by an __init).

>  {
>         if (!mem_size)
> -               return;
> +               return -EINVAL;
>
>         pr_info("using module parameters\n");
>
>         dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
>         if (!dummy_data) {
>                 pr_info("could not allocate pdata\n");
> -               return;
> +               return -ENOMEM;
>         }
>
>         dummy_data->mem_size = mem_size;
> @@ -636,13 +636,25 @@ static void ramoops_register_dummy(void)
>         if (IS_ERR(dummy)) {
>                 pr_info("could not create platform device: %ld\n",
>                         PTR_ERR(dummy));
> +               kfree(dummy_data);
> +               return PTR_ERR(dummy);
>         }
> +       return 0;
>  }
>
>  static int __init ramoops_init(void)
>  {
> -       ramoops_register_dummy();
> -       return platform_driver_register(&ramoops_driver);
> +       int ret = ramoops_register_dummy();
> +
> +       if (ret != 0)
> +               return ret;
> +
> +       ret = platform_driver_register(&ramoops_driver);
> +       if (ret != 0) {
> +               platform_device_unregister(dummy);
> +               kfree(dummy_data);
> +       }
> +       return ret;
>  }
>  postcore_initcall(ramoops_init);
>
> --
> 1.9.0
>

I'll send an updated patch with a similar fix...

-Kees

-- 
Kees Cook
Pixel Security
