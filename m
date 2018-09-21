Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB7CECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACDF2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e4NoLzMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACDF2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbeIUKgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:36:20 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41513 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIUKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:36:19 -0400
Received: by mail-yb1-f193.google.com with SMTP id v10-v6so4923419ybm.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 21:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0TRl4AIfe8CP0g/UEVTNb7bi0wZZ2TU4oIw8WxCT2uM=;
        b=e4NoLzMKmyxVmRWLbwZr+PGEGPu/M0L6+AeglJhaBfSW+Q6ET4LJYxTR+OBtcxrfS4
         lOToRKngS99wWUrQVAVlOlAFwBRVHqQ1JlLRcJo4Mmsk5xclK+ybgv41it/GlCI+3Ncq
         kMGL3jiZc90E/lvWqdXleBKwu5r8/IpuDJ1+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0TRl4AIfe8CP0g/UEVTNb7bi0wZZ2TU4oIw8WxCT2uM=;
        b=tinJbOEbsqT8qZegWiuMK1mrRuDYh/CUwPCjljlAg+wAZiBfm+RbMdEqCF9HDl1Cmi
         uWxM5ppWy1S/kadebW+/XXASsh6/OiL9Yzsq63I1BEac9y+2k4uN9Wgl1IfgfhIWSDY4
         k2U3UGkimF0ZgedcmXziJlMno2Yv4Os4+5h7u+rN03rQQJn9TQ9hnmSQWkmNlQzObfxo
         ueUg9HA4CWq8V1Q9sxzrNrxEoV0yQQDwT0vHoLl+ldZmEC0DulJ6VbmxoRODgVXEIiFc
         uDwtjftNNfmrJQAVb9Mea2TWxEeTTrnDsj+Hxke70r3A/ViF7CLYuBe2v3UuZTX8otzI
         4R2Q==
X-Gm-Message-State: APzg51DB5YONXTYDQCEyP4ynVaRIG7GFtcCw78GpjC6O474++8wmU7Ml
        GMxaOycA1iCxPCWCmhQXFWuvyHBqV0E=
X-Google-Smtp-Source: ANB0VdbNZkixtDC9A5DKEPNqBQ64ice/DK3SOpeyhPD6Uu8L0OQYz+81AYqXwLbct0j/4jWHwGYKWQ==
X-Received: by 2002:a25:a2d1:: with SMTP id c17-v6mr6472975ybn.400.1537505355576;
        Thu, 20 Sep 2018 21:49:15 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id t2-v6sm5845223ywd.99.2018.09.20.21.49.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 21:49:14 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id q129-v6so4707626ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 21:49:13 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr193600ywp.407.1537505353513;
 Thu, 20 Sep 2018 21:49:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 21:49:12
 -0700 (PDT)
In-Reply-To: <1537494404-16473-1-git-send-email-zhongjiang@huawei.com>
References: <1537494404-16473-1-git-send-email-zhongjiang@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 21:49:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ_XoDRJXhE1OpCFxn6LGaNjRHFvYupeUjyqgzDZg=gXg@mail.gmail.com>
Message-ID: <CAGXu5jJ_XoDRJXhE1OpCFxn6LGaNjRHFvYupeUjyqgzDZg=gXg@mail.gmail.com>
Subject: Re: [RESEND PATCH] error-injection: remove meaningless null pointer
 check before debugfs_remove_recursive
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 6:46 PM, zhong jiang <zhongjiang@huawei.com> wrote:
> debugfs_remove_recursive has taken the null pointer into account.
> just remove the null check before debugfs_remove_recursive.
>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/fail_function.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index bc80a4e..17f75b5 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c
> @@ -173,8 +173,7 @@ static void fei_debugfs_remove_attr(struct fei_attr *attr)
>         struct dentry *dir;
>
>         dir = debugfs_lookup(attr->kp.symbol_name, fei_debugfs_dir);
> -       if (dir)
> -               debugfs_remove_recursive(dir);
> +       debugfs_remove_recursive(dir);
>  }
>
>  static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
> --
> 1.7.12.4
>



-- 
Kees Cook
Pixel Security
