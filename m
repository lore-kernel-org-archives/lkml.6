Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C880C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008C420651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IEjiVUR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008C420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeJXDwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:52:50 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46751 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:52:50 -0400
Received: by mail-yb1-f196.google.com with SMTP id o8-v6so1053660ybk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4a2jqM3lTjp6nqzy1986zEqtztKHIkw357dzpSSRP/s=;
        b=IEjiVUR4gUGHyGBDhdUsILPziQ4j0v1TzwuMhwCoIsT07lZ6Y20WteLAZidD2eqcit
         fEmCAXQ9JXdRGb5GUQdidDJ7EI+omct2X9vjsJ/ayayaz9sb2NrBmlpbOWFHze4k9mQo
         vfPhGt1VHmyYUcgV6uoLkJQVv+uF4ZLYM8sSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4a2jqM3lTjp6nqzy1986zEqtztKHIkw357dzpSSRP/s=;
        b=kKNU8Mzp/cXJz5hm/mrY7/LrIEFFFnebycHucTL2S6iTNCJFtzmMGDPQR2RsTN3W3d
         td6SQflPw8Sx/9bu0VqDLzwC+ymK61CB6FC5jcq48XDPZVpeflNm5kQIg4i3YtlpqUGA
         Tkti7ug2kIDzHVmexYtJWMsYNli+uJOdPh0VlWdCVWGpuwzoD0Q/eOZw+B4j67peC21l
         jKNyTskSwce7ExmRUwpQhJ2/Isq3kpHlVfYGw2KkZQr/g2kjMaz2KGxGARgmzawAiB3L
         bQRt2ZYu/3AJrYHPJMtYVU6liTvKEMK3DPuo+nm7mDVUQkiY2ijl8adMZC+RL5A4l7Xe
         7E3w==
X-Gm-Message-State: ABuFfojZV2LSIAscYiBd5oK5p3rwX60t9WyyUcG4CO4D8OJpnPUY0hzm
        56/l+GIwnJWQ1NT/RVnso/vlKgceI08=
X-Google-Smtp-Source: ACcGV61QuDrQLfiGXJboBQlW7HWrcfI3sWSnWuEeIlrpmk6pcuB3TvU8Zv2KPhVT2U+gKiu5S2PMCw==
X-Received: by 2002:a25:ba0f:: with SMTP id t15-v6mr35917220ybg.334.1540322883949;
        Tue, 23 Oct 2018 12:28:03 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id p7-v6sm1077343ywd.75.2018.10.23.12.28.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:28:02 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id o8-v6so1053593ybk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:28:02 -0700 (PDT)
X-Received: by 2002:a25:c6c8:: with SMTP id k191-v6mr1008226ybf.171.1540322881687;
 Tue, 23 Oct 2018 12:28:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 12:28:01
 -0700 (PDT)
In-Reply-To: <20181023110837.27840-1-efremov@linux.com>
References: <20181023110837.27840-1-efremov@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Oct 2018 12:28:01 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+nJM6RWZJZNBsvVSbS7=UkyGFEnO_rM+phFtLvxYuRYA@mail.gmail.com>
Message-ID: <CAGXu5j+nJM6RWZJZNBsvVSbS7=UkyGFEnO_rM+phFtLvxYuRYA@mail.gmail.com>
Subject: Re: [PATCH 3/9] security: fix documentation for the
 socket_post_create hook
To:     efremov@linux.com
Cc:     James Morris <jmorris@namei.org>,
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

On Tue, Oct 23, 2018 at 4:08 AM,  <efremov@linux.com> wrote:
> From: Denis Efremov <efremov@linux.com>
>
> This patch slightly fixes the documentation for the
> socket_post_create hook. The documentation states that
> i_security field is accessible through inode field of socket
> structure (i.e., 'sock->inode->i_security'). There is no inode
> field in the socket structure. The i_security field is accessible
> through SOCK_INODE macro. The patch fixes the documentation accordingly.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/lsm_hooks.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 8f84ef819e00..accf6f34ac8e 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -752,9 +752,9 @@
>   *     socket structure, but rather, the socket security information is stored
>   *     in the associated inode.  Typically, the inode alloc_security hook will
>   *     allocate and and attach security information to
> - *     sock->inode->i_security.  This hook may be used to update the
> - *     sock->inode->i_security field with additional information that wasn't
> - *     available when the inode was allocated.
> + *     SOCK_INODE(sock)->i_security.  This hook may be used to update the
> + *     SOCK_INODE(sock)->i_security field with additional information that
> + *     wasn't available when the inode was allocated.
>   *     @sock contains the newly created socket structure.
>   *     @family contains the requested protocol family.
>   *     @type contains the requested communications type.
> --
> 2.17.2
>



-- 
Kees Cook
