Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41811C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A0F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqdhxaXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A0F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeLFOc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:32:28 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:32837 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeLFOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:32:28 -0500
Received: by mail-yb1-f194.google.com with SMTP id f125so535897ybc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 06:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bt24wXJlB3M/lDvnWLoRBJfRvQJynIF1gj//D6t4kE=;
        b=RqdhxaXaklLfJhhFhrxdX9K5yq6mS2gD8V05fAbaHStZNCXxlBQj0Rba103nEt8lLG
         e6FNc9PVakXQAw3cGQGkqic+hVAuYUACuIYzVizlIiKfW3bOEPOxAnE1jHoa8Mqc2Wf/
         7dTcj3XHh6VeiuYOXlv+neq7XwNVb0aXT+O5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bt24wXJlB3M/lDvnWLoRBJfRvQJynIF1gj//D6t4kE=;
        b=Fog6mspouQdR+/tM1vQCaClgxYJrjweAk2i9qal1Lnaz3HJvoh1Z0x5dDMxTk4naZW
         wDC/smtkKtmECyK7n7ghdQwau7JRNZAmtmiTNtlxsdA0L9Bx82L1Z7UGDofTVdUGHF75
         YyA6nUGAKJYkO0ceLTIABnj0Y0e61OpNlH4kp99TV1/xiuNQKRoXN2Bp//AVVCoFClS0
         anZFYRjE16S+1uDb4rafFR1a+lotOYIG3NX8HtMckTgDxIUrD76Don2GvWcAzJAr8Fuz
         o5UYiE8BAPzJ7hPrz3vFMPsCJ1W5IO7Jy0/7sYmKuQWxaJjU8I/RPMSGQTkT6eT9OSsu
         Kgig==
X-Gm-Message-State: AA+aEWYmJNPBrwwH0tJLPJ5uF9ssabnda0XEPHwI+7tlMWGJSVUv7t3h
        snRjl8dIavJa2lP/Lbn4W88EPw0XlKlL21sK0WMhLw==
X-Google-Smtp-Source: AFSGD/Um+cJmXOuxgR3+SYM1Jq+ZoIjCegGDQOkEqD82DXhVmW4upKUoiNAR1zOZCuOdSqKpeQp7CP3blnSKFj0FKXM=
X-Received: by 2002:a25:1e07:: with SMTP id e7mr460831ybe.195.1544106746892;
 Thu, 06 Dec 2018 06:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20181205174852.435233070@goodmis.org> <20181205183303.828422192@goodmis.org>
In-Reply-To: <20181205183303.828422192@goodmis.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 6 Dec 2018 15:32:15 +0100
Message-ID: <CADYN=9LVL-FHvcoeXWvCVGCDvXmgT5mGtEdSm0JSzgeVCJ64qA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ftrace: Allow ftrace_replace_code() to be schedulable
To:     rostedt@goodmis.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 19:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> The function ftrace_replace_code() is the ftrace engine that does the
> work to modify all the nops into the calls to the function callback in
> all the functions being traced.
>
> The generic version which is normally called from stop machine, but an
> architecture can implement a non stop machine version and still use the
> generic ftrace_replace_code(). When an architecture does this,
> ftrace_replace_code() may be called from a schedulable context, where
> it can allow the code to be preemptible, and schedule out.
>
> In order to allow an architecture to make ftrace_replace_code()
> schedulable, a new command flag is added called:
>
>  FTRACE_SCHEDULABLE
>
> Which can be or'd to the command that is passed to
> ftrace_modify_all_code() that calls ftrace_replace_code() and will have
> it call cond_resched() in the loop that modifies the nops into the
> calls to the ftrace trampolines.
>
> Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org
>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

> ---
>  include/linux/ftrace.h |  1 +
>  kernel/trace/ftrace.c  | 19 ++++++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index dd16e8218db3..c281b16baef9 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -389,6 +389,7 @@ enum {
>         FTRACE_UPDATE_TRACE_FUNC        = (1 << 2),
>         FTRACE_START_FUNC_RET           = (1 << 3),
>         FTRACE_STOP_FUNC_RET            = (1 << 4),
> +       FTRACE_SCHEDULABLE              = (1 << 5),
>  };
>
>  /*
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 77734451cb05..74fdcacba514 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -77,6 +77,11 @@
>  #define ASSIGN_OPS_HASH(opsname, val)
>  #endif
>
> +enum {
> +       FTRACE_MODIFY_ENABLE_FL         = (1 << 0),
> +       FTRACE_MODIFY_SCHEDULABLE_FL    = (1 << 1),
> +};
> +
>  static struct ftrace_ops ftrace_list_end __read_mostly = {
>         .func           = ftrace_stub,
>         .flags          = FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_STUB,
> @@ -2415,10 +2420,12 @@ __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
>         return -1; /* unknow ftrace bug */
>  }
>
> -void __weak ftrace_replace_code(int enable)
> +void __weak ftrace_replace_code(int mod_flags)
>  {
>         struct dyn_ftrace *rec;
>         struct ftrace_page *pg;
> +       int enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
> +       int schedulable = mod_flags & FTRACE_MODIFY_SCHEDULABLE_FL;
>         int failed;
>
>         if (unlikely(ftrace_disabled))
> @@ -2435,6 +2442,8 @@ void __weak ftrace_replace_code(int enable)
>                         /* Stop processing */
>                         return;
>                 }
> +               if (schedulable)
> +                       cond_resched();
>         } while_for_each_ftrace_rec();
>  }
>
> @@ -2548,8 +2557,12 @@ int __weak ftrace_arch_code_modify_post_process(void)
>  void ftrace_modify_all_code(int command)
>  {
>         int update = command & FTRACE_UPDATE_TRACE_FUNC;
> +       int mod_flags = 0;
>         int err = 0;
>
> +       if (command & FTRACE_SCHEDULABLE)
> +               mod_flags = FTRACE_MODIFY_SCHEDULABLE_FL;
> +
>         /*
>          * If the ftrace_caller calls a ftrace_ops func directly,
>          * we need to make sure that it only traces functions it
> @@ -2567,9 +2580,9 @@ void ftrace_modify_all_code(int command)
>         }
>
>         if (command & FTRACE_UPDATE_CALLS)
> -               ftrace_replace_code(1);
> +               ftrace_replace_code(mod_flags | FTRACE_MODIFY_ENABLE_FL);
>         else if (command & FTRACE_DISABLE_CALLS)
> -               ftrace_replace_code(0);
> +               ftrace_replace_code(mod_flags);
>
>         if (update && ftrace_trace_function != ftrace_ops_list_func) {
>                 function_trace_op = set_function_trace_op;
> --
> 2.19.1
>
>
