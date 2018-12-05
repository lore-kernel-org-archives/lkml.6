Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C46C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EF5208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jVY9sw8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EF5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbeLEW53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:57:29 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45605 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbeLEW52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:57:28 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so7724779uam.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dytYqQ8H+2Qo4+mnYnqtUAAUisFwpo87CzvdCi+khvE=;
        b=jVY9sw8TZSA8M89pM5bOVfcLyUC7u5GPgF1YCYC8bwMgTLhIpEQ4bWJ9Zx2k8YuYQi
         1HlkfbYYp7Gfe2eFztpQEAvRABQb5LWQ5SVnYZdshqC1qtiFnRwUoHefiAM1o0dIxdZv
         EUNlDUCzck2XYRT/2/nxUZCSV8jM3+h9jw420=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dytYqQ8H+2Qo4+mnYnqtUAAUisFwpo87CzvdCi+khvE=;
        b=gG9K+Yw5IYn/jrOmp357TiwqYEpopt2erGFi1745tn3LORrTFsBPg00tP3UXu7iErR
         7TRG/V6GdSKSxCYZhlKl0B4EsvXSFi49STbA/hwQtP1+S297zRe9nz1q66L8yj83q0VW
         tVbRexMRLj+jLdGfxi0a8V9UJdsr/wPBPITGtm/Q7y94riQoijsBQ0wMtcLH12gfYeZ3
         7ifCqTXR4yxuuu7ucqj/mX3mP1G29CmY5sPvaSEmr4tOwx2GUr+QZT69KgOOWHd2NoZ7
         R4dpxOaQHT764vwdppKhiV4AdPnK3rf+QD9WKFQhxlXDeElqjveJTxniz0GA85CugWWn
         y3VA==
X-Gm-Message-State: AA+aEWYbBIda8MjK40bNbKsrRCrbvvgg0dZaejLuBGVhAcsuuHNjHLDN
        F97b3Hi40iAKkyRVLLuUtpOuEJmyxio=
X-Google-Smtp-Source: AFSGD/XApVo70X0584ajBuCLI+EgoSy99KC+xTrHpQqWVw7BX49s9e+rY6PMr1ONi4tZOIkOZY33xg==
X-Received: by 2002:ab0:550b:: with SMTP id t11mr12591928uaa.31.1544050646159;
        Wed, 05 Dec 2018 14:57:26 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id f68sm5587788uaf.9.2018.12.05.14.57.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 14:57:25 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id z3so13152832vsf.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:57:24 -0800 (PST)
X-Received: by 2002:a67:208:: with SMTP id 8mr11630548vsc.48.1544050644280;
 Wed, 05 Dec 2018 14:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20181205093555.5386-1-sashal@kernel.org> <20181205093555.5386-104-sashal@kernel.org>
In-Reply-To: <20181205093555.5386-104-sashal@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 14:57:08 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJuH+Nwh5J=-efDmH__GN9_wPLuX6FoJTUP8CwTxLnHGg@mail.gmail.com>
Message-ID: <CAGXu5jJuH+Nwh5J=-efDmH__GN9_wPLuX6FoJTUP8CwTxLnHGg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 104/123] pstore/ram: Correctly calculate
 usable PRZ bytes
To:     Sasha Levin <sashal@kernel.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 1:41 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Kees Cook <keescook@chromium.org>
>
> [ Upstream commit 89d328f637b9904b6d4c9af73c8a608b8dd4d6f8 ]
>
> The actual number of bytes stored in a PRZ is smaller than the
> bytes requested by platform data, since there is a header on each
> PRZ. Additionally, if ECC is enabled, there are trailing bytes used
> as well. Normally this mismatch doesn't matter since PRZs are circular
> buffers and the leading "overflow" bytes are just thrown away. However, in
> the case of a compressed record, this rather badly corrupts the results.
>
> This corruption was visible with "ramoops.mem_size=204800 ramoops.ecc=1".
> Any stored crashes would not be uncompressable (producing a pstorefs
> "dmesg-*.enc.z" file), and triggering errors at boot:
>
>   [    2.790759] pstore: crypto_comp_decompress failed, ret = -22!
>
> Backporting this depends on commit 70ad35db3321 ("pstore: Convert console
> write to use ->write_buf")

Please note the above. If this gets backported, this one is needed too.

-Kees

>
> Reported-by: Joel Fernandes <joel@joelfernandes.org>
> Fixes: b0aad7a99c1d ("pstore: Add compression support to pstore")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/pstore/ram.c        | 15 ++++++---------
>  include/linux/pstore.h |  5 ++++-
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index f4fd2e72add4..03cd59375abe 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -806,17 +806,14 @@ static int ramoops_probe(struct platform_device *pdev)
>
>         cxt->pstore.data = cxt;
>         /*
> -        * Console can handle any buffer size, so prefer LOG_LINE_MAX. If we
> -        * have to handle dumps, we must have at least record_size buffer. And
> -        * for ftrace, bufsize is irrelevant (if bufsize is 0, buf will be
> -        * ZERO_SIZE_PTR).
> +        * Since bufsize is only used for dmesg crash dumps, it
> +        * must match the size of the dprz record (after PRZ header
> +        * and ECC bytes have been accounted for).
>          */
> -       if (cxt->console_size)
> -               cxt->pstore.bufsize = 1024; /* LOG_LINE_MAX */
> -       cxt->pstore.bufsize = max(cxt->record_size, cxt->pstore.bufsize);
> -       cxt->pstore.buf = kmalloc(cxt->pstore.bufsize, GFP_KERNEL);
> +       cxt->pstore.bufsize = cxt->dprzs[0]->buffer_size;
> +       cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
>         if (!cxt->pstore.buf) {
> -               pr_err("cannot allocate pstore buffer\n");
> +               pr_err("cannot allocate pstore crash dump buffer\n");
>                 err = -ENOMEM;
>                 goto fail_clear;
>         }
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index a15bc4d48752..30fcec375a3a 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -90,7 +90,10 @@ struct pstore_record {
>   *
>   * @buf_lock:  spinlock to serialize access to @buf
>   * @buf:       preallocated crash dump buffer
> - * @bufsize:   size of @buf available for crash dump writes
> + * @bufsize:   size of @buf available for crash dump bytes (must match
> + *             smallest number of bytes available for writing to a
> + *             backend entry, since compressed bytes don't take kindly
> + *             to being truncated)
>   *
>   * @read_mutex:        serializes @open, @read, @close, and @erase callbacks
>   * @flags:     bitfield of frontends the backend can accept writes for
> --
> 2.17.1
>


-- 
Kees Cook
