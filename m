Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E09ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9E220873
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kFOVZMF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9E220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeGNIdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 04:33:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33306 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbeGNIdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 04:33:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so22602058edr.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCaNO9JYVlWLaA1L1s0sfYz8CW51ujp3r+vifN/+eng=;
        b=kFOVZMF1BAHObfVBDsn1HBgMcg2HxdwqeiqQ+ROuxGI9v2zi4awBLFTFfxF0kSf6wi
         uzJzl5j/reP5LYpRT0znpEfP+rbDnBd7afuFids1enz/2DrChEEp0wOZiJTebg4K3udG
         Ne91nmX+OfbxD70+WW3jbwaqA0eG9yRUPzCsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCaNO9JYVlWLaA1L1s0sfYz8CW51ujp3r+vifN/+eng=;
        b=r15EdKRs85Qj6mOHHxZ1uKGtSJuVzF0TO+ki1ejqZCKIN1hfL3CaZaH9CoQF77WH/8
         agEw3tstjbHfUhll4ZA63vmVpiAKRBKJP4gU0o6m+qzPriOsVc9HWJRI9qAvWqxm7IGX
         m32XqIFbySrd9n7lFobW7RVkuyqcpYoXoJSfFE4YRaRDLV4ox9auRHI30IEp60tDyk++
         /y/c2PD8BluRF2K0IcOVycLiBak3ISt5HO+n6QYAmNREDAlEqYVJ6FYJDzAPrJdlMldL
         2Zjn6vV6XSviTsCa1hbZJ8uJ/cYFrjBOLbTwVbv52hURKkeSZLvoMx55FSJO0CDBMrxf
         bAJg==
X-Gm-Message-State: AOUpUlFCBle5qZ78qY82hlgFO6LCOxFQ2B8uBsAj7Xt7QhmZLXeRV0cO
        hmD1TUmkIA0kXGy6mHmoFyWpb/JCkZ+jCg==
X-Google-Smtp-Source: AAOMgpfflJu6Kh9LWDVX9cjzAQ63Z1jyOtO985jlYs9SgFlfixZ3Ktyr1TnWtKBfnGKpXfOfk2qkqQ==
X-Received: by 2002:a50:94c4:: with SMTP id t4-v6mr9766702eda.128.1531556114824;
        Sat, 14 Jul 2018 01:15:14 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id h4-v6sm7847238edq.89.2018.07.14.01.15.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 01:15:12 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id m1-v6so14404766wrg.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 01:15:12 -0700 (PDT)
X-Received: by 2002:adf:a197:: with SMTP id u23-v6mr7488077wru.50.1531556112534;
 Sat, 14 Jul 2018 01:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-11-toddpoynor@gmail.com>
In-Reply-To: <20180714055816.223754-11-toddpoynor@gmail.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Sat, 14 Jul 2018 11:15:00 +0300
X-Gmail-Original-Message-ID: <CAE_wzQ_b5QLn7Fs_YDoOXSt=c+_uJobtG=fSda84qcwWfe2fTQ@mail.gmail.com>
Message-ID: <CAE_wzQ_b5QLn7Fs_YDoOXSt=c+_uJobtG=fSda84qcwWfe2fTQ@mail.gmail.com>
Subject: Re: [PATCH 10/18] staging: gasket: gasket_open use container_of()
To:     toddpoynor@gmail.com
Cc:     rspringer@google.com, jnjoseph@google.com, benchan@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        frankhu@chromium.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        toddpoynor@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 8:58 AM Todd Poynor <toddpoynor@gmail.com> wrote:
>
> From: Todd Poynor <toddpoynor@google.com>
>
> Use container_of(), drop unnecessary NULL check.
>
> Reported-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index ffd6ce801313..0c45c54254fb 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -1099,12 +1099,9 @@ static int gasket_open(struct inode *inode, struct file *filp)
>         const struct gasket_driver_desc *driver_desc;
>         struct gasket_ownership *ownership;
>         char task_name[TASK_COMM_LEN];
> -       struct gasket_cdev_info *dev_info = gasket_cdev_get_info(inode->i_cdev);

Are there other users of gasket_cdev_get_info()? if this was the only
one we should remove the macro,otherwise we should convert them as
well.

> +       struct gasket_cdev_info *dev_info =
> +           container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
>
> -       if (!dev_info) {
> -               gasket_nodev_error("Unable to retrieve device data");
> -               return -EINVAL;
> -       }
>         gasket_dev = dev_info->gasket_dev_ptr;
>         driver_desc = gasket_dev->internal_desc->driver_desc;
>         ownership = &dev_info->ownership;
> --
> 2.18.0.203.gfac676dfb9-goog
>
