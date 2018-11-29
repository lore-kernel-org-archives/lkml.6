Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80233C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BEB2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YbLQYNNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BEB2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeK3K3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:29:17 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42464 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeK3K3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:29:17 -0500
Received: by mail-yb1-f194.google.com with SMTP id o204-v6so1480333yba.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AnIlxkjtqtGHVmRvr73Sozy1WM9iPtA7IkS9ZaPRr5s=;
        b=YbLQYNNbpyzyr/iA6zCYgVJvTwYSahanmlPS3wf2bZn1m9PmhRhbJIx1l9COC8xd3T
         rVAKCWvzFXWkMsWyGrXGfCNl3gC8xU3NKbO4RRJTwJoGJ1Rn3fAcLp0T0jku9smLrI2D
         RNQEwBImgTvsBrtfYvmrQXA5gRTp3Vt6niOOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AnIlxkjtqtGHVmRvr73Sozy1WM9iPtA7IkS9ZaPRr5s=;
        b=ev7iyAWxkqYaGbo9kkHgwVXNPpda0/jc6fAE/m6r9vrn1sU3kO+9gLvmdmBaGgZXQr
         8LI7X/N3VwKFxAQbbBLRsrDM51SwcaDL6IHQbjO4rH/8nqqRm8TmoqsySUdcYMWgXKjY
         WQLHP3rZhbTZkkcWQtHyr3AGdmIg9eK2N2dkMu5ZAGt7ewKuhGicEOV+o/9f8Obfb6ai
         uvdiKOuHKwvJPNoZfAGJ7qnIFKs8qve4FLt0dAe44GrodhIdOB8/OKyn+nrahnhAKGqr
         nah1kGGK004uosNQsRJCIz/YlRgO40bPKX9HlQy5dXBVk4PRYdpyrTdGaxc/n0H+d1k3
         ryow==
X-Gm-Message-State: AA+aEWZSpXuviEVQDRpGdcSXDN9Cw9liSUeA+d+HNJ5a8yUfG7R4YAvr
        dK97Ue2ISBD93KLTqb/R22LXl9j4VdQ=
X-Google-Smtp-Source: AFSGD/Vx1tC/Z0j1XIZjUkc2FsCmCpC2+Qh4TK/BsS86eZ4tBNoXugKOcYdiDzgwFUN3iJpvc/caGA==
X-Received: by 2002:a25:d64d:: with SMTP id n74-v6mr3379651ybg.204.1543533725073;
        Thu, 29 Nov 2018 15:22:05 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id g81-v6sm926890ywa.100.2018.11.29.15.22.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 15:22:02 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id u103-v6so1489366ybi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:22:02 -0800 (PST)
X-Received: by 2002:a25:3502:: with SMTP id c2-v6mr3465839yba.410.1543533722025;
 Thu, 29 Nov 2018 15:22:02 -0800 (PST)
MIME-Version: 1.0
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de> <1507383097088-1070743746-13-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1507383097088-1070743746-13-diffsplit-thomas@m3y3r.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 29 Nov 2018 15:21:50 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKpXpcQ4tM+m3Fwk+3CqH-pWF5xme2zgq=ojS=GMzqjQw@mail.gmail.com>
Message-ID: <CAGXu5jKpXpcQ4tM+m3Fwk+3CqH-pWF5xme2zgq=ojS=GMzqjQw@mail.gmail.com>
Subject: Re: [PATCH] pstore: Fix bool initialization/comparison
To:     Thomas Meyer <thomas@m3y3r.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2017 at 7:24 AM Thomas Meyer <thomas@m3y3r.de> wrote:
> Bool initializations should use true and false. Bool tests don't need
> comparisons.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

I totally missed this email (now over a year ago!)

However, since it's still correct and applies, I've taken it for -next
now. :) Thanks!

-Kees

> ---
>
> diff -u -p a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
> --- a/fs/pstore/ftrace.c
> +++ b/fs/pstore/ftrace.c
> @@ -148,7 +148,7 @@ void pstore_unregister_ftrace(void)
>         mutex_lock(&pstore_ftrace_lock);
>         if (pstore_ftrace_enabled) {
>                 unregister_ftrace_function(&pstore_ftrace_ops);
> -               pstore_ftrace_enabled = 0;
> +               pstore_ftrace_enabled = false;
>         }
>         mutex_unlock(&pstore_ftrace_lock);
>


-- 
Kees Cook
