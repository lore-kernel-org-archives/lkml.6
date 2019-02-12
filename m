Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC71BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B19E222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MX09zkw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfBLUMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:12:14 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34068 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfBLUMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:12:13 -0500
Received: by mail-ua1-f65.google.com with SMTP id x15so1343305uaq.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9/clerorXfiYGGfY341Oqzwshe7dfWfpdKEyM3Y19M=;
        b=MX09zkw5J6BZF54blIcvEPfK+RrDmmr58Mlt321+Mp3rBCn7OFC3l4WdvqTmQX+Duc
         /23j06xsTSb4A/EFQ9n/aTrjGdXVQf7lG9gS76J7lCX5lblr9hFcO4PMdpg+eHXU4Lvr
         jlCec/f02eLAakexIhpeuHAahU6NxCmlfMSvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9/clerorXfiYGGfY341Oqzwshe7dfWfpdKEyM3Y19M=;
        b=p3XRtItbMD7izyKiusWF+NhKR7PjX0sfOD2aVZj8Og96B8pHcTgPyZWpKSUVh72DYp
         mMgnf1c2YN1deeid13TFfKe4YJsC8HjKeZKvyf0PzoFBnDlmcWFQVcbt5eCWaWO+rf/e
         JTNVoyVumX5fpEcJFbAKUthVSLiI6xU8yj6/ucpg8kFLbL3nBZIWdtxoN9gZIQeN1TDQ
         ZP6PoGUk/es0YU73kApW0018RDFKnXiiC5HAYmlVpL151vwWfUL6pVC/LxIlQuqAJ7tn
         TacZbLB12I6oZI3zRZb1rAeaXqZ80L3iJY/VFozgGpVf/rqUot5zvloz5aUjd2IEy1sA
         lVJQ==
X-Gm-Message-State: AHQUAuYazvGj9Zt7DTH0xNRCPLAOkJlWFSjxGXKlu8wuSOsspq9npLoP
        ZfZRy1rMHBWsYgQup7gfgOSjzifu4Fs=
X-Google-Smtp-Source: AHgI3IbH0mVWqLi4X9CsH06mFdRebtGG3j8waQmC8GvGitHZHSyDvL5OKcuid52QFWYF6KV35uw+RQ==
X-Received: by 2002:a9f:3591:: with SMTP id t17mr1361883uad.11.1550002331928;
        Tue, 12 Feb 2019 12:12:11 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id t133sm15967964vsc.8.2019.02.12.12.12.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:12:11 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id k11so2439015vsm.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:12:11 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr2406622vsc.48.1550002330636;
 Tue, 12 Feb 2019 12:12:10 -0800 (PST)
MIME-Version: 1.0
References: <5c4e64db.1c69fb81.5f2dc.bfbaSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c4e64db.1c69fb81.5f2dc.bfbaSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 12:11:59 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKFceOXHtusm9e8qQ_2_ikpFtghmp5ZD9+i9C+aF7200g@mail.gmail.com>
Message-ID: <CAGXu5jKFceOXHtusm9e8qQ_2_ikpFtghmp5ZD9+i9C+aF7200g@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Make initialization check as first one
To:     Yue Hu <huyue2@yulong.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 6:11 PM Yue Hu <huyue2@yulong.com> wrote:
>
> From 4320c0fcb5d685c8099937abce88e0b7fbbfe8dc Mon Sep 17 00:00:00 2001
> From: Yue Hu <huyue2@yulong.com>
> Date: Wed, 23 Jan 2019 16:56:48 +0800
> Subject: [PATCH] pstore/ram: Make initialization check as first one
>
> Since only one single ramoops area allowed at a time, other probes
> include device tree related are meaningless, it will waste cpu
> consumtion. So let's check it firstly.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/pstore/ram.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 1adb5e3..ca01778 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -715,15 +715,6 @@ static int ramoops_probe(struct platform_device *pdev)
>         phys_addr_t paddr;
>         int err = -EINVAL;
>
> -       if (dev_of_node(dev) && !pdata) {
> -               pdata = &pdata_local;
> -               memset(pdata, 0, sizeof(*pdata));
> -
> -               err = ramoops_parse_dt(pdev, pdata);
> -               if (err < 0)
> -                       goto fail_out;
> -       }
> -
>         /*
>          * Only a single ramoops area allowed at a time, so fail extra
>          * probes.
> @@ -733,6 +724,15 @@ static int ramoops_probe(struct platform_device *pdev)
>                 goto fail_out;
>         }
>
> +       if (dev_of_node(dev) && !pdata) {
> +               pdata = &pdata_local;
> +               memset(pdata, 0, sizeof(*pdata));
> +
> +               err = ramoops_parse_dt(pdev, pdata);
> +               if (err < 0)
> +                       goto fail_out;
> +       }
> +
>         /* Make sure we didn't get bogus platform data pointer. */
>         if (!pdata) {
>                 pr_err("NULL platform data\n");
> --
> 1.9.1

Applied, thanks!

-- 
Kees Cook
