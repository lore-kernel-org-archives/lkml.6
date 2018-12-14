Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF0C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCBB2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Seadooz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCBB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeLNAtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:49:02 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46264 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeLNAtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 19:49:02 -0500
Received: by mail-yw1-f67.google.com with SMTP id t13so1610784ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 16:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmIZxpnL4JTy7g64FOKeXzw19PF1rkqROhbiOmZrIR8=;
        b=Seadooz7HTwtN4o1ac5S7dx7Z1kRrtfJqGTq6cZcISouFbTkmRqd+lqgL+o69xLjau
         8V2/nKWCrgwXRnUMqzeavgU35txYg2/s2G5ngwUL4h5uYyXhEzgIeY6MqBjlvY/Cqy9p
         j7M+r3BLF6GtMwZBLwlDPQPeacu6ZCfm3Z+r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmIZxpnL4JTy7g64FOKeXzw19PF1rkqROhbiOmZrIR8=;
        b=O0x49zkAUea5NBit7H+CDa2jA0slLXmx4NZQ6IRy8A+LfhWWIjZDyIvmmJS0cX8Gzl
         E+/T0Hrdfmjo+j7eSjfW4fQsHXRXJh1/lGPlIWQ7U4Aseh1sSrMthrkgvvIUgegyrVt6
         VNvSHGioKK4G+QVuSLGWC9vY4/kgHp/NfzXEaVgoIdT4KTDRrMbfL+dlEH3eA+osVETt
         hu2hRluSPJXONSBoOYe2QWOik+2NojQAvbtndY5dvOxBKVfl6mkubMls2nW55Vyp7ljb
         SNtgLClzGd4C/ImHU6aXf0uVI9TckYO3I/WOTm6gqpl1nBtfhqW+h9vUMdvPOx9xl3bv
         I42Q==
X-Gm-Message-State: AA+aEWYL9uvdElPMTTzNwUlv5p25Odb+48gJteVOlM+f+/rMU5PZ+o5V
        XAd2pyTU8cpgdfvevx78zlAnlsQOytc=
X-Google-Smtp-Source: AFSGD/XooccrFerGOBsypRoIJlbtrM+VzpjtyVKkfnhTsFPRu8dG1IYoERQvcq9khySW7ALMImSWUg==
X-Received: by 2002:a81:451:: with SMTP id 78mr1065619ywe.139.1544748540544;
        Thu, 13 Dec 2018 16:49:00 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id u132sm1000839ywc.11.2018.12.13.16.48.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 16:48:58 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id r11so1594174ybp.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 16:48:58 -0800 (PST)
X-Received: by 2002:a25:a207:: with SMTP id b7mr1060984ybi.209.1544748538185;
 Thu, 13 Dec 2018 16:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20181213024654.7004-1-tycho@tycho.ws>
In-Reply-To: <20181213024654.7004-1-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Dec 2018 16:48:46 -0800
X-Gmail-Original-Message-ID: <CAGXu5jL0L16BNK1SouaG32FJ_mJECUrJfMNRH6pWdG0Be8a-ZQ@mail.gmail.com>
Message-ID: <CAGXu5jL0L16BNK1SouaG32FJ_mJECUrJfMNRH6pWdG0Be8a-ZQ@mail.gmail.com>
Subject: Re: [PATCH] seccomp: fix poor type promotion
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 6:47 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> sparse complains,
>
> kernel/seccomp.c:1172:13: warning: incorrect type in assignment (different base types)
> kernel/seccomp.c:1172:13:    expected restricted __poll_t [usertype] ret
> kernel/seccomp.c:1172:13:    got int
> kernel/seccomp.c:1173:13: warning: restricted __poll_t degrades to integer
>
> Instead of assigning this to ret, since we don't use this anywhere, let's
> just test it against 0 directly.
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> Reported-by: 0day robot <lkp@intel.com>

Thanks! Added to my -next tree.

-Kees

> ---
>  kernel/seccomp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 15b6be97fc09..d7f538847b84 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1169,8 +1169,7 @@ static __poll_t seccomp_notify_poll(struct file *file,
>
>         poll_wait(file, &filter->notif->wqh, poll_tab);
>
> -       ret = mutex_lock_interruptible(&filter->notify_lock);
> -       if (ret < 0)
> +       if (mutex_lock_interruptible(&filter->notify_lock) < 0)
>                 return EPOLLERR;
>
>         list_for_each_entry(cur, &filter->notif->notifications, list) {
> --
> 2.19.1
>


-- 
Kees Cook
