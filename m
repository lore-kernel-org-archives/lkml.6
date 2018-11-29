Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641DEC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2317720989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HiuXfD0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2317720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeK3KeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:34:18 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42751 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3KeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:34:17 -0500
Received: by mail-yb1-f193.google.com with SMTP id o204-v6so1484628yba.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zl5fPoC1NuO+flCl7vF84WF/Jg9hKcYZQ8HZLC6wvPA=;
        b=HiuXfD0Q5KHE/jwMpvTffEyVtbFoHdqJAT6vlyIP66YJczO+M3EuOPZqg8jzHjt4wH
         oObUIudcrRjP/ogYM+XANu8mRcD4gXkXLM9sYI8rKR5xTWaRLDtm4rAYfGuAtwcoecwc
         RV7PlZPay0axjDCdGSLUfBHmCYrMO5Nlf1NMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zl5fPoC1NuO+flCl7vF84WF/Jg9hKcYZQ8HZLC6wvPA=;
        b=SDuQdyUAccAK3zfdVL+R9QpgCWzJWR+eHGjWqMIl+Zheq50XjSCpDkop63s3VuU3NJ
         GuGB9vIIi87QnNRMHE3EiG71se9TU/hiWN6Xa+Xi/bEBSGGr2hOPg8Wd4gDr1i0DkP9d
         kHLPCB8sKXgrNA0pSMeklIDxJ0mZ9uWEKI/DVnUxH/SFDrtyrGDzRg19c7t4yFV8Lz5v
         s1OsM/bqWlAGgSqjhHI7mHiJG+50Ms92oYV2QFreAIVZCO9yUXaSD5Otj9aDNM8v2vmh
         hIn32i1uPOf9jJ3iGB6NatyyuY5etCspJHJTpJ5Wt7nA0eJsA0fsEIar51PZWYQTa766
         HCgw==
X-Gm-Message-State: AA+aEWb3u0V/ZN6Jldqls5Dujg22/dyz5YmtkM/+AZpiHKaq0+Inauar
        RtM2pOdu14yb33qmqqVVN3H2kDINwK4=
X-Google-Smtp-Source: AFSGD/X1noP5KpslbVOejb+1GstaRFUx3kGK1Be25Wykj5/gK/YAaB8NXIarOOYv7Iw0Aju5QUMtbQ==
X-Received: by 2002:a5b:587:: with SMTP id l7-v6mr3373638ybp.76.1543534024820;
        Thu, 29 Nov 2018 15:27:04 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id w2sm2603854ywl.10.2018.11.29.15.27.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 15:27:04 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id z2-v6so1495390ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:27:03 -0800 (PST)
X-Received: by 2002:a25:3502:: with SMTP id c2-v6mr3480754yba.410.1543534023393;
 Thu, 29 Nov 2018 15:27:03 -0800 (PST)
MIME-Version: 1.0
References: <1504729681-3504-1-git-send-email-deller@gmx.de> <1504729681-3504-10-git-send-email-deller@gmx.de>
In-Reply-To: <1504729681-3504-10-git-send-email-deller@gmx.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 29 Nov 2018 15:26:51 -0800
X-Gmail-Original-Message-ID: <CAGXu5jL3qs=YrXWesOueaZYZ8k1qjJ=1HYb9Rmfry8tzvaGY8w@mail.gmail.com>
Message-ID: <CAGXu5jL3qs=YrXWesOueaZYZ8k1qjJ=1HYb9Rmfry8tzvaGY8w@mail.gmail.com>
Subject: Re: [PATCH 09/14] fs/pstore: Use %pS printk format for direct addresses
To:     Helge Deller <deller@gmx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2017 at 1:28 PM Helge Deller <deller@gmx.de> wrote:
>
> Use the %pS instead of the %pF printk format specifier for printing symbols
> from direct addresses. This is needed for the ia64, ppc64 and parisc64
> architectures.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tony Luck <tony.luck@intel.com>

I missed this email from some time ago. I've now applied it, thanks!

-Kees

> ---
>  fs/pstore/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index fefd226..59f65d7 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -116,7 +116,7 @@ static int pstore_ftrace_seq_show(struct seq_file *s, void *v)
>
>         rec = (struct pstore_ftrace_record *)(ps->record->buf + data->off);
>
> -       seq_printf(s, "CPU:%d ts:%llu %08lx  %08lx  %pf <- %pF\n",
> +       seq_printf(s, "CPU:%d ts:%llu %08lx  %08lx  %ps <- %pS\n",
>                    pstore_ftrace_decode_cpu(rec),
>                    pstore_ftrace_read_timestamp(rec),
>                    rec->ip, rec->parent_ip, (void *)rec->ip,
> --
> 2.1.0
>


-- 
Kees Cook
