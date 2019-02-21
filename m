Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75078C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD4F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D6IFQ37m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfBURNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:13:51 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42969 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfBURNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:13:51 -0500
Received: by mail-vk1-f195.google.com with SMTP id j195so2855063vkj.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUNnN+/ji8nzrv3GmXF8Tl3AdC7Sp5oHC9qFThiiFP4=;
        b=D6IFQ37mn8qUvk22wINGvPB/1t9wJY3C/s/rv3/2f1n8C8bhYTvbna2qn7jAJTwe07
         riJoB4Ynj0z/ek5PIoHch83dUZKNNh8tL602OJHawgvzE4KbhZqGn43A2OCdVYtv+T6t
         ymnwVDQm13dkm0egJBHB1Aeyu9vpby8D451lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUNnN+/ji8nzrv3GmXF8Tl3AdC7Sp5oHC9qFThiiFP4=;
        b=jwNLy9WvLLD2DXcu3sJFsnhprF2UIvO/9fFsMRKKXXWhbfkGclRYZsm7/Hs/sN7nKf
         Y1/uUyg1zXC4absBmKcxo4sceb9jDjrhIPUcKQwa9Yxz9r2jposn9eOoXdWHQZvKt64L
         UVHvANlEBboQDbsZ8iO2i2gxeJSA2ECVp/OE3A2QU8YSkeJf4tWfWSfl5WLrLBY727Rs
         ifLeIZUAzqD+xlvGC0djZlSXzPHMn5N0+UFBYppATHJvB0Zu0Vapn9F2p06RZ7jz2yph
         H0iyk+Nj3xWOh6F+wLSmgHT6vp6flEXvSsi7cJnPGzpMGa20JJQydehmCnKFYI7AQ9Q3
         SOzA==
X-Gm-Message-State: AHQUAuZJwmgiifhil2UyQE0uEBA2ltAOXxwa0EIhgXex7ivrPZ8v1VNG
        efDXHD78bHyljyGzatGVAa0XadkM6cE=
X-Google-Smtp-Source: AHgI3Ib0kjfxKHjwBqMPsN7QEUtm9iYS4VYQl+UcnSpKxxNMCXdWv8sINwxkMM5KkUuR+F0Jtyae/w==
X-Received: by 2002:ac5:c30b:: with SMTP id j11mr22330718vkk.46.1550769229287;
        Thu, 21 Feb 2019 09:13:49 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id q199sm5290285vke.23.2019.02.21.09.13.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 09:13:47 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id z24so9931189ual.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:13:47 -0800 (PST)
X-Received: by 2002:a67:ec81:: with SMTP id h1mr21265168vsp.188.1550769227265;
 Thu, 21 Feb 2019 09:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20190218181819.20524-1-helen.koike@collabora.com> <20190221155032.GA3155@redhat.com>
In-Reply-To: <20190221155032.GA3155@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 09:13:34 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKiEmmpVE0f_9r4Wop8c11skcsgAruGr2UbOiAof8T7DA@mail.gmail.com>
Message-ID: <CAGXu5jKiEmmpVE0f_9r4Wop8c11skcsgAruGr2UbOiAof8T7DA@mail.gmail.com>
Subject: Re: [PATCH v11] dm: add support to directly boot to a mapped device
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Helen Koike <helen.koike@collabora.com>,
        device-mapper development <dm-devel@redhat.com>,
        Will Drewry <wad@chromium.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        richard -rw- weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-lvm@redhat.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kernel@collabora.com, Alasdair G Kergon <agk@redhat.com>,
        David Zeuthen <zeuthen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 7:50 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Mon, Feb 18 2019 at  1:18pm -0500,
> Helen Koike <helen.koike@collabora.com> wrote:
>
> > Add a dm-mod.create= kernel module parameter.
> > It allows device-mapper targets to be configured at boot time for use early
> > in the boot process (as the root device or otherwise).
> >
> > Signed-off-by: Will Drewry <wad@chromium.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > [rework to use dm_ioctl calls]
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > [refactored for upstream]
> > Signed-off-by: Helen Koike <helen.koike@collabora.com>
>
> Can I get confirmation from Will and Kees that this v11 is safe to carry
> their Signed-off-by?  Are you guys "happy" with this patch?

I think those should be "Co-developed-by:" to more correctly capture
the intent. At this point I think Helen is the primary author. Or at
least, Will and I aren't anymore. :)

At first pass, yes, this patch does what's needed for Chrome OS and
Android, but I'll take a closer look shortly (and I've added David who
has looked at this most recently).

Thanks!

-- 
Kees Cook
