Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26AEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB14A20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T6rfAWHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB14A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbeJXDxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:53:10 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38401 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:53:10 -0400
Received: by mail-yb1-f194.google.com with SMTP id v92-v6so1068751ybi.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mx8zptrrAuodiF6MYRYxCurWvOr1GiSdSxtgIoqoHCE=;
        b=T6rfAWHqZ9Sdz8F8PzKdifB0zw9P/WMuO4YDO8UozJweiEn+rAQzlfPM8AajX2r+Yz
         VpunnynM3wUZR2kSyKauJKOx2a0grB4eAsjjvkFEbkng+edEatXNpARkTWQhhhfpOQZ0
         SF1HVxct+ZLVjnR0dTyOLI+l2vaYVI46fPmLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mx8zptrrAuodiF6MYRYxCurWvOr1GiSdSxtgIoqoHCE=;
        b=AucjP3jea/xruI7k7vUzXdVDHfQB71ji17rmDMzgognq/0RCMioI3DQuXDMRn3dwn+
         WOuAPp2PXR7tBz5x6jHKobocuEmDdaPRqrLCzpFFVUyljMkS8QdQe+pt7nX/Tqk0T6jI
         FIUFP04xvOPpJftygr9a/98UwTq3HA26dSapl2j1I4tHAiSL0CtV8zw/FSQjr5D9zd3A
         AJXkhDDdILIT3VU0vE3nk5IKJ6CuaT5BFXZ1HXwiUoC+SATdnRa/h52cR8rR0psgbHDA
         G9B3ZrdWIk16Yhcde4hiIl+KtjM2OqIBh9T8Pn0tZoCONndU0IpyHr/av3wK5TkGqJiW
         Dn7A==
X-Gm-Message-State: AGRZ1gJA8v2yf9jNO9tj4jQNpenzZ/35bcKaQ1g+jbqiHzQ1ogkCH2uB
        W1egFBWRBNtCpgvn8Pnr4K9Ie4n2S7A=
X-Google-Smtp-Source: AJdET5ekGFPbGwoabLPoMzEUHIiDTDexTwOR9JyG8WY0+OontXOrigTMylgYTfORUA4vrtWdYfjgog==
X-Received: by 2002:a25:ac22:: with SMTP id w34-v6mr2554630ybi.34.1540322904188;
        Tue, 23 Oct 2018 12:28:24 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id p7-v6sm1078676ywd.75.2018.10.23.12.28.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:28:23 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id t78-v6so1036804ywg.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:28:22 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr36464148ywg.47.1540322902344;
 Tue, 23 Oct 2018 12:28:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 12:28:21
 -0700 (PDT)
In-Reply-To: <20181023111255.30446-1-efremov@linux.com>
References: <20181023111255.30446-1-efremov@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Oct 2018 12:28:21 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJp-FeGG37ZqVbaj+Gs6NuJac=Kcs-VAK_X4N5OOU9O=g@mail.gmail.com>
Message-ID: <CAGXu5jJp-FeGG37ZqVbaj+Gs6NuJac=Kcs-VAK_X4N5OOU9O=g@mail.gmail.com>
Subject: Re: [PATCH] security: fix documentation for the task_setscheduler hook
To:     efremov@linux.com
Cc:     KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:12 AM,  <efremov@linux.com> wrote:
> From: Denis Efremov <efremov@linux.com>
>
> The task_setscheduler hook was changed in the commit
> "security: remove unused parameter from security_task_setscheduler()"
> (b0ae19811375). The arguments @policy, @lp were removed from the hook.
> This patch updates the documentation accordingly.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/lsm_hooks.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index accf6f34ac8e..ae3766720264 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -655,10 +655,8 @@
>   *     Return 0 if permission is granted.
>   * @task_setscheduler:
>   *     Check permission before setting scheduling policy and/or parameters of
> - *     process @p based on @policy and @lp.
> + *     process @p.
>   *     @p contains the task_struct for process.
> - *     @policy contains the scheduling policy.
> - *     @lp contains the scheduling parameters.
>   *     Return 0 if permission is granted.
>   * @task_getscheduler:
>   *     Check permission before obtaining scheduling information for process
> --
> 2.17.2
>



-- 
Kees Cook
