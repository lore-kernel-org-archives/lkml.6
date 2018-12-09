Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1C52086E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNjgOlg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1C52086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLIGUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:20:50 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54893 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeLIGUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:20:49 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so12900685ita.4;
        Sat, 08 Dec 2018 22:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ib5jvwf9cWIXq05xPudwRJmlDR7yz2Tfrst7V1mjPLQ=;
        b=KNjgOlg6nHQEf4M5a/fsheYoESoLhVa8TKCwZeU+ohn4KIaAy7t2tVVT88NodlG2lc
         ZTnzjDn9cLUzpWpYOimdJNHGwoIjCmq0eM1rPWGGncI4hCca8gRrgdtQb5+09nDQb80I
         IlyQ9vFsncqVck0IfIlsR+1sjuPk58CQmZnU0UqOerYXEgBYla3yh7Mb0v12vcIj/MqO
         YwIsN9NDI3gygTKlw2ovRIIePVaiprB8QDiApzb+hlC/j+er/77LPTRklDnkVeXbx5BQ
         fmrOqpxIa1CcHw6qIsk4T75u2UrUOU6SIyjw6qYDncIG3LQPBM2qkXReTVsPKPSiV6EK
         b3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ib5jvwf9cWIXq05xPudwRJmlDR7yz2Tfrst7V1mjPLQ=;
        b=NAM5TPvjoj3JNtX5JiESWhaeb3ZnqSwUGy6w/LVBXg8e4yBDIgK17B+pRToCy0KjdM
         WpfUr11aXT1CgaZvDiWrljjBD87EGfOb+7LltUHmMqMHknpxxg2vovmsBlOLxoEz7P5D
         3q5st7lqgA/wTV/eKaSwrbimAb0Mu5zLx5d0+iOfRcd49yGJzqWDpA3Dczc98k5e8vcL
         B57+JFSpPaJhw0MTknjkDiHN7bQAimyHf8pxdOMsR5lmGCz1oY7uvELP5A/NEQKadkOT
         IfgCbUIvKiU5iUyQSKYA3kwlddlsEH4Qaev/GLolSnxjKH3MKtxlWkZePChuwppBMPcf
         k0Cg==
X-Gm-Message-State: AA+aEWYZoX/iUbfeuOGcnTSHBso+GqkBL+AoMpAQA29EspuB1u7906gl
        0noIt57UQy9dbB8p4kdWX+CIW0Ea6MiAJqZ+Md9SK/Wu
X-Google-Smtp-Source: AFSGD/WFz+hHyAbTw6G51bndfJKJpTZinA7Oeb8LgmzOw8RbImWIx3Bp3r6uydNftbAvP+LvFc6FtFDMJ7jYgaZQV7M=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr6908265jak.30.1544336449065;
 Sat, 08 Dec 2018 22:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20181120161451.21149-1-tiny.windzz@gmail.com>
In-Reply-To: <20181120161451.21149-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 9 Dec 2018 14:20:26 +0800
Message-ID: <CAEExFWtiqTgQmMLwvMhx8UvfU9o75jsZkAjBgyHhAOwuemJdNw@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
To:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        lorenzo.pieralisi@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:14 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v3:
> -update changelog
> ---
>  drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index db2ede565f1a..650f063ef809 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
>         /*
>          * Initialize the driver just for a compliant set of machines
>          */
> -       if (!of_match_node(compatible_machine_match, root))
> +       if (!of_match_node(compatible_machine_match, root)){
> +               of_node_put(root);
>                 return -ENODEV;
> +       }
> +
> +       of_node_put(root);
>
>         if (!mcpm_is_available())
>                 return -EUNATCH;
> --
> 2.17.0
>
ping......
