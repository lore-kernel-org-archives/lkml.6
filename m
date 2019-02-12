Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD836C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88973222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P89rAedP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfBLUQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:16:48 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39737 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfBLUQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:16:48 -0500
Received: by mail-ua1-f68.google.com with SMTP id s15so928036uap.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsT9lTazIoqAh8I9pic/6Y4C6SpeYbNIDhuKLVt2oXk=;
        b=P89rAedPAKJOUaGsckZQcjcPby8umV2OceCM+BeaFWar7sGrmw+x5M6iwu2CnqwVWr
         QSttQodwZaNHJSm9AmEEmJmYBjYFVVzpne9qn+T2SF2ZLQX/aVGt01fCX2UFiqDv6Bqo
         Xc6XO7n4zHNUAUR+EHIfQktIHC3Ih4gPWVfPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsT9lTazIoqAh8I9pic/6Y4C6SpeYbNIDhuKLVt2oXk=;
        b=bLHrb3hpa0ljz73/qUjyFEExFSbujiJEFUb18glh4Kmbvb3bKIZk4xb6aQKNgZ6Nah
         bXP+l0oYX8zijQ64C8IEvUkBNqzqacm0i4Fw/IGltnlTpulZXV++F5hTE/8dF+ncHY1u
         KoSlIomF/c48mFPiDt9rbwimnuqmfF4s9UceGRDHQzcsvPcLKHIIZc1LjONvN+lC1WoO
         e7r3R4L1cyiaquU3IOfBvjNQoVq4GPB4SICXAzOaWYQnxaxOQGt54TXRmWa0LlxIhOVu
         S9/CHg1VcoGZk20iMWNUu8GDot/FZQcWixZsE24Sd01LggeBTBWFRS0JTdhwHvYeFXPH
         sl/Q==
X-Gm-Message-State: AHQUAubuZw7ClVrMBVDaurxuCqtZsJAm5G7YiC9cvBt5lT8lj+P41Ouj
        U0G5+VgjjATXNNHNp76baZHaXSAvFE8=
X-Google-Smtp-Source: AHgI3IZ4PmtEvONXuNgHWxoVlZAs5ZdXdpMWSr0kenRMB8CaEbk77ZwReSgCTsRLF7IGKbTvPfcNJg==
X-Received: by 2002:ab0:5a71:: with SMTP id m46mr2278157uad.123.1550002606798;
        Tue, 12 Feb 2019 12:16:46 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id n206sm17833327vkn.36.2019.02.12.12.16.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:16:45 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id t13so2429651vsk.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:16:45 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr2281652vsd.222.1550002605286;
 Tue, 12 Feb 2019 12:16:45 -0800 (PST)
MIME-Version: 1.0
References: <5c46c41c.1c69fb81.13fc6.834eSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c46c41c.1c69fb81.13fc6.834eSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 12:16:33 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKaOuh_TXQV3gA4pbzORUjNNMh1-4MvzkLcp3AQDvhwjA@mail.gmail.com>
Message-ID: <CAGXu5jKaOuh_TXQV3gA4pbzORUjNNMh1-4MvzkLcp3AQDvhwjA@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Avoid possible failure of dummy device unregister
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

On Mon, Jan 21, 2019 at 11:19 PM Yue Hu <huyue2@yulong.com> wrote:
>
> From 7c1f672a2d7b7c2cfef313060bd429afc4af995b Mon Sep 17 00:00:00 2001
> From: Yue Hu <huyue2@yulong.com>
> Date: Tue, 22 Jan 2019 14:47:00 +0800
> Subject: [PATCH] pstore/ram: Avoid possible failure of dummy device unregister
>
> In ramoops_register_dummy() if create platform device of dummy
> failed, the problem is following code called:
>
>     dummy = NULL;
>     ramoops_unregister_dummy();
>
> However platform_device_unregister() will check the pointer:
>
>     void platform_device_del(struct platform_device *pdev)
>     {
>             int i;
>
>             if (pdev) {
>                     ...
>             }
>     }
>     void platform_device_put(struct platform_device *pdev)
>     {
>             if (pdev)
>                     put_device(&pdev->dev);
>     }
>     void platform_device_unregister(struct platform_device *pdev)
>     {
>             platform_device_del(pdev);
>             platform_device_put(pdev);
>     }
>
> So the dummy device maybe always exists in the system, this is bad
> case, we need to avoid it.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/pstore/ram.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 8db1f7f..1d56a20 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -932,7 +932,6 @@ static void __init ramoops_register_dummy(void)
>         if (IS_ERR(dummy)) {
>                 pr_info("could not create platform device: %ld\n",
>                         PTR_ERR(dummy));
> -               dummy = NULL;
>                 ramoops_unregister_dummy();

No, this needs to be cleared to NULL to avoid leaving a ERR_PTR (which
are non-NULL, see IS_ERR() above it), so that it can be safe to
unconditionally call platform_device_unregister().

-- 
Kees Cook
