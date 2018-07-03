Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DC7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E0024D34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VFi4dcSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E0024D34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933290AbeGCHe7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:34:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39240 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeGCHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:34:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id w14-v6so882611eds.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mB53gJ91j8FOITUcvkI07qBBdMqsZk+hAzRvB/uDde4=;
        b=VFi4dcSDoqTmWFrTuyDjn4mHGQN+1QYHR4sdRKDk1rS2BVM3NlGQvmOZrdWhUTVhYY
         xCp7siLc35XQT9Mt8qyoJGHf6/rgZLwFOztqek8qIUhE2uxAiS7zOpkhTfW1wOKErbYW
         PJiMAB9E5PLQWoHu8yrUBJ9Rqupdo1vpOE37Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mB53gJ91j8FOITUcvkI07qBBdMqsZk+hAzRvB/uDde4=;
        b=D6aWwvfP6u2NGuDdshK0byiaKRIntz/V+ncAe0hEzdc4zkmMqWugAUN+wsGB+qWDtG
         p8qdz0LGCprpnFQ/OU85iEeM6Uu4GFMJzx8Lt/OqALJQr2lo3Ar4cE97PNrZg0pogwM7
         JXNyfspTnnECw0pGO0NTVjQM4WF+09//xKqZjCA3trtKtlVqhMPpqDFvtyVcbsiK5iPo
         y7aVtIDCYfLJNIZBLmp0tAyFWod5h4lF5Ky/4sJbf/zK6u8AApKyWRK8LTkgQ45ZSXVT
         5nDz/6VxYk6ZwvMK8gJ6bzuX4Mm6K0Gl3cLQYJvhMmqIlUkjgrs5xzRhd27n/xayrSlu
         tYLg==
X-Gm-Message-State: APt69E1RwafARLt32fih1GL+Jmtnsuo/O1P9QB7pwFxCc5tq1auUz7ul
        Ai77Iugb56ryQmt6arJLhWW2SA==
X-Google-Smtp-Source: AAOMgpdy4BioJyvM6uWk498F+eIER2DbvjR9vSIgjo1Z153L+K5VcWocRsyiPIAILQ8F04/+8UQgLQ==
X-Received: by 2002:aa7:c396:: with SMTP id k22-v6mr27573108edq.149.1530603295331;
        Tue, 03 Jul 2018 00:34:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id j7-v6sm395007edh.76.2018.07.03.00.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:34:54 -0700 (PDT)
Date:   Tue, 3 Jul 2018 09:34:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] video/console/vgacon: Print big fat warning with
 nomodeset
Message-ID: <20180703073452.GD7880@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20180702210442.18648-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702210442.18648-1-lyude@redhat.com>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 05:04:40PM -0400, Lyude Paul wrote:
> It's been a pretty good while since kernel modesetting was introduced.
> It has almost entirely replaced previous solutions which required
> userspace modesetting, and I can't even recall any drivers off the top
> of my head for modern day hardware that don't only support one or the
> other. Even nvidia's ugly blob does not require the use of nomodeset,
> and only requires that nouveau be blacklisted.
> 
> Effectively, the only thing nomodeset does in the year 2018 is disable
> your graphics drivers. Since VESA is a thing, this will give many users
> the false impression that they've actually fixed an issue they were
> having with their machine simply because the laptop will boot up to a
> degraded GUI. This of course, is never actually the case.
> 
> Things get even worse when you consider that there's still an enormous
> amount of tutorials users find on the internet that still suggest adding
> nomodeset, along with various users who have been around long enough to
> still suggest it.
> 
> There really isn't any legitimate reason I can see for this to be an
> option that's used by anyone else other then developers, or properly
> informed users. So, let's end the confusion and start printing warnings
> whenever it's enabled.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Yeah makes tons of sense. I think we should also perhaps mark the option
as a tainting one, but I think that's only wired up for module option.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/console/vgacon.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index f09e17b60e45..09731b2f6815 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -112,6 +112,11 @@ EXPORT_SYMBOL(vgacon_text_force);
>  static int __init text_mode(char *str)
>  {
>  	vgacon_text_mode_force = true;
> +
> +	pr_warning("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
> +	pr_warning("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
> +	pr_warning("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
> +
>  	return 1;
>  }
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
