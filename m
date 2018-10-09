Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91467C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5223C214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KcgiNZcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5223C214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJJEcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:32:09 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37003 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeJJEcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:32:09 -0400
Received: by mail-yb1-f194.google.com with SMTP id h1-v6so1308681ybm.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MkX/Wx7rtRmIqH07kFue+9OB4UgcdPCNJdyqGn/+EL4=;
        b=KcgiNZcKNQHUDmUJQmVY9UJhz22NGGLZLJhWZzzT386kDlkr+RJGGWmg93sF3Sop9G
         lMTNtGk7pMRGxUKr7oNPCZIf8AKlanqpXnCX8Hj80uTdV1t1mbudbS56FTe5HZEdfui1
         Xj1aWXZ6jc4mzkQloHdlKy2H1kh9jdMtlqZMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MkX/Wx7rtRmIqH07kFue+9OB4UgcdPCNJdyqGn/+EL4=;
        b=B8VlNF2P2b10AfVvc/slfC7XzjfKQuzJew4Cw5eq7pYPwLmQZ9b78a4AEW+10xUOYt
         RO8/VYiydqZ+wi5QhMq4qqioIQ6lLNoA2bcDi+Z+ETQwyRwarch5L4giAynQQr9CzlGz
         yeV3BOdpErXMA4QQWh8XuLEmlChGMujsol4kDyMTRydFrJJhmRod6ckDH3f+SIHPWVHQ
         ciIcejXrq27NoT4Oc3lNdZEF+EavX1OLJU4xq3A0vNlc8wcM/MP9KN7a3IP/bOtaZqKp
         Ui90okN9PV8AVJ90QQsO84utRYPrdr2jrTfHH9JDBUvq1w4zztHOmyk9qFzQZhzxo+ep
         ERnQ==
X-Gm-Message-State: ABuFfoiGIYfUM5JV1hexLHEIt2rbRZzJlFyhQnYkTn92X+WWalQhZ8in
        4dMRZBjFuh6WjRcgK7be1CiIVDmFixg=
X-Google-Smtp-Source: ACcGV61u9da1frG2WS7HKWy6ufnDkyJtHXPFnZBkTpIZPRd5X7o9WqwpnpETuyjxpog5VRpd+OqyDw==
X-Received: by 2002:a25:4155:: with SMTP id o82-v6mr16347749yba.310.1539119597965;
        Tue, 09 Oct 2018 14:13:17 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id k2-v6sm24876666ywh.52.2018.10.09.14.13.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:13:16 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 5-v6so1311704ybf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 14:13:16 -0700 (PDT)
X-Received: by 2002:a5b:d:: with SMTP id a13-v6mr4910340ybp.171.1539119596067;
 Tue, 09 Oct 2018 14:13:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 9 Oct 2018 14:13:14 -0700 (PDT)
In-Reply-To: <20181009205019.2786-1-bp@alien8.de>
References: <20181009205019.2786-1-bp@alien8.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 9 Oct 2018 14:13:14 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+=pkdaCvXxao=Y2XMzMAsy_ByA6PMnmK2cuQVpU41SEQ@mail.gmail.com>
Message-ID: <CAGXu5j+=pkdaCvXxao=Y2XMzMAsy_ByA6PMnmK2cuQVpU41SEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kernel/panic: Filter out a potential trailing newline
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 1:50 PM, Borislav Petkov <bp@alien8.de> wrote:
> From: Borislav Petkov <bp@suse.de>
>
> If a call to panic() terminates the string with a \n, the result puts
> the closing brace ']---' on a newline because panic() itself adds \n
> too.
>
> Now, if one goes and removes the newline chars from all panic()
> invocations - and the stats right now look like this:
>
> ~300 calls with an \n
> ~500 calls without a \n
>
> one is destined to a neverending game of whack-a-mole because the usual
> thing to do is add a newline at the end of a string a function is
> supposed to print.
>
> Therefore, simply zap any \n at the end of the panic string to avoid
> touching so many places in the kernel.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: x86@kernel.org

Ah yes, I like this. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/panic.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 8b2e002d52eb..5776d2879650 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -136,7 +136,7 @@ void panic(const char *fmt, ...)
>  {
>         static char buf[1024];
>         va_list args;
> -       long i, i_next = 0;
> +       long i, i_next = 0, len;
>         int state = 0;
>         int old_cpu, this_cpu;
>         bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
> @@ -173,8 +173,12 @@ void panic(const char *fmt, ...)
>         console_verbose();
>         bust_spinlocks(1);
>         va_start(args, fmt);
> -       vsnprintf(buf, sizeof(buf), fmt, args);
> +       len = vscnprintf(buf, sizeof(buf), fmt, args);
>         va_end(args);
> +
> +       if (len && buf[len - 1] == '\n')
> +               buf[len - 1] = '\0';
> +
>         pr_emerg("Kernel panic - not syncing: %s\n", buf);
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>         /*
> --
> 2.19.0.271.gfe8321ec057f
>



-- 
Kees Cook
Pixel Security
