Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EB8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CB12145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AlR8khmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CB12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeJAXva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:51:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40043 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeJAXva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:51:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so9911072pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h65zhG+E9ertU7JJGm1OhCYToFzanEl/h/lareKwRF8=;
        b=AlR8khmgdXTJssV88O4F16g6iZU01EQhwu9pLDpi/J7DnV0SN9w1udv40OVooCJuNo
         nwnMKopbgFd3TnDJ+m6JzsGKQQoBFLVTAqLyyrhL+clEaB11lr3xtCR+EYSX3HReIkg4
         7AmXtBcQrvIvQscb7goUwfvTphz3vbA2NVShxXGpK3xckuIqEhR70aIcVYiDga31YOVo
         hEksYae3T//nz5ayQqf40PBzTESwlo70loGm7/cfbezXpwaGQ7TmftSeReXlkDjdmIux
         RsJDIg33rhlWktzymUrgbYK1egWCgliIgm6d6gyPE7Q2fojSZMaK7aaa0htgiaxA2dEJ
         tPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h65zhG+E9ertU7JJGm1OhCYToFzanEl/h/lareKwRF8=;
        b=r7B6jy1Pf1uUHUOEOszjXEA91wos61wvCTuu1prd9Gnq2x8q01aWRvXQ3bQhh7D51+
         5Xj0Z3HFow1ZqjU1YIDHJW9l2FpI6WNUlVqSs92FkXDXCULLACqnbSG5OOeny38v/sYf
         vh0ejEWxfeN/31fsruDIAA8RB5MK3PnMCTrzAQrFUs12hq+/PH3Ib5qtBVATNg+n8yeQ
         bZOnzHt1g/TabsUFV0jCBDh0pNeqrdcIrR0TnZzWJqCLP+pAGwgV9yyLvocL/vBggWEH
         JBh0l52IJIm3EIDnZUV3Pjo8mN1E4Mso0HAWwRXUIUhQXVqXn8JESAYdnXQKk48dPVSP
         wAog==
X-Gm-Message-State: ABuFfogtNVRTC1prqr3jSBhzQfqjpvmgTh04qOS38Wu5Ljgfg+eWaFoy
        K+Gfh6jWgTageUM3hPOo8kG4iGYIZhLiEv0vSoQ8kw==
X-Google-Smtp-Source: ACcGV631uE+J8my6WXqcpQn5qLCTHe4z5yByFP1J0SJHHcRzAMOHJ8fVcdbCZ8tnWpSgnxZ5kQtBfwcC7lRUzNLjL2Y=
X-Received: by 2002:a17:902:bf42:: with SMTP id u2-v6mr10276309pls.13.1538413963544;
 Mon, 01 Oct 2018 10:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181001161506.100284-1-evgreen@chromium.org>
In-Reply-To: <20181001161506.100284-1-evgreen@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Oct 2018 10:12:32 -0700
Message-ID: <CAKwvOdmtF-s4amu-zXbyUNe+jvCuC3hXUez6fVVq0sjuoYc3eg@mail.gmail.com>
Subject: Re: [PATCH RESEND] scsi: sg: Prevent potential double frees in sg driver
To:     hch@infradead.org
Cc:     Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Robb Glasser <rglasser@google.com>, evgreen@chromium.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 9:16 AM Evan Green <evgreen@chromium.org> wrote:
>
> From: Robb Glasser <rglasser@google.com>
>
> sg_ioctl could be spammed by requests, leading to a double free in
> __free_pages. This protects the entry points of sg_ioctl where the
> memory could be corrupted by a double call to __free_pages if multiple
> requests are happening concurrently.
>
> Signed-off-by: Robb Glasser <rglasser@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Cc: stable@vger.kernel.org
>
> ---
> Reposting this patch from last summer, as it looks like it fell in between
> the cracks.

Christoph, do you still feel strongly about: https://lkml.org/lkml/2017/8/5/75 ?

>
>  drivers/scsi/sg.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 8a254bb46a9b..25579d8a16b5 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -924,8 +924,10 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
>                         return -ENXIO;
>                 if (!access_ok(VERIFY_WRITE, p, SZ_SG_IO_HDR))
>                         return -EFAULT;
> +               mutex_lock(&sfp->parentdp->open_rel_lock);
>                 result = sg_new_write(sfp, filp, p, SZ_SG_IO_HDR,
>                                  1, read_only, 1, &srp);
> +               mutex_unlock(&sfp->parentdp->open_rel_lock);
>                 if (result < 0)
>                         return result;
>                 result = wait_event_interruptible(sfp->read_wait,
> --
> 2.19.0.605.g01d371f741-goog
>


-- 
Thanks,
~Nick Desaulniers
