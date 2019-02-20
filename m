Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7E6C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503262146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MBrn/36B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfBTVIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:08:49 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45080 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfBTVIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:08:49 -0500
Received: by mail-vs1-f66.google.com with SMTP id u64so14842286vsc.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBCAGUhW5l+Ooty8Gq4PTf9TssSWAHH8S8cAfD5Y1DA=;
        b=MBrn/36BK1xIIwh4TJOoq3MNs4GkFfMGTjKPgG6uJCZ59bPws2nF0RSuEpNjICqudR
         W+/8lf6tP+Emi7gUmqenhTj3MK2xIpG7Lg1zIj2r4FazklGZOCQslm5cw3mT84s+WnYx
         8jxtb3PmNDzF/pjCiunl6UitouFRe5tOaJ2BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBCAGUhW5l+Ooty8Gq4PTf9TssSWAHH8S8cAfD5Y1DA=;
        b=C/r6UKZ/XqdLx8w29E/3yrxeXEUT27ufuEtJmsYSzYP2D+Fszm8nRrVw5y+oXQEofi
         XMT7U4HuTL1eVyq6byUQIytXmpjYL8TeDrlhu7hPL/hz/+/RLPEMBOPAjXyRQxAjhbDJ
         5hpBlNPCsFwqV30jp950ZsqherEl0SNPzBeB4akzM60o1JeTt3nW8jPFrHfwpdmg2UDX
         6lVDw4KZD0esy2+H54gkkIFo6vA/1SGyHIp45MuFuDRobM5HViypeH3s4OVreXYTUIQK
         3WQpa9DMwlxGwdXjnLtCbx4we7+yrWYsi3CXmE3OSk/PmNj1R6aUvYX6lY7Lgoai9Jwo
         PpNA==
X-Gm-Message-State: AHQUAubZ3Tujfa16uUAdjmUL+NXEANzwi5u7LiCLLjXWwNejzTn6pm98
        PXxPwccLlujpNkmgKyciEfuyAON1mFo=
X-Google-Smtp-Source: AHgI3Iat7S819EoIv3WJMdI/nLGO7FwDV+tDVx7jATcuQPO0hxF/RjISRN4yQQWj2x2WWUqnidw5lg==
X-Received: by 2002:a67:f5d9:: with SMTP id t25mr9111646vso.23.1550696926817;
        Wed, 20 Feb 2019 13:08:46 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a68sm17500233vsd.24.2019.02.20.13.08.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 13:08:45 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id e10so14905208vsp.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:08:44 -0800 (PST)
X-Received: by 2002:a67:c00a:: with SMTP id v10mr20437112vsi.66.1550696924229;
 Wed, 20 Feb 2019 13:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20190220204058.11676-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190220204058.11676-1-daniel.vetter@ffwll.ch>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 13:08:30 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLCyQYCrJDXB_jN7cSoEYEqK3PKLBXc64XHicnE48V0bQ@mail.gmail.com>
Message-ID: <CAGXu5jLCyQYCrJDXB_jN7cSoEYEqK3PKLBXc64XHicnE48V0bQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Don't let userspace spam allocations warnings
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jan Stancek <jstancek@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:41 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> memdump_user usually gets fed unchecked userspace input. Blasting a
> full backtrace into dmesg every time is a bit excessive - I'm not sure
> on the kernel rule in general, but at least in drm we're trying not to
> let unpriviledge userspace spam the logs freely. Definitely not entire
> warning backtraces.
>
> It also means more filtering for our CI, because our testsuite
> exercises these corner cases and so hits these a lot.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jan Stancek <jstancek@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-mm@kvack.org
> ---
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/util.c b/mm/util.c
> index 1ea055138043..379319b1bcfd 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -150,7 +150,7 @@ void *memdup_user(const void __user *src, size_t len)
>  {
>         void *p;
>
> -       p = kmalloc_track_caller(len, GFP_USER);
> +       p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
>         if (!p)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.20.1
>


-- 
Kees Cook
