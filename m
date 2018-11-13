Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE523C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05C02243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jw7cO068"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05C02243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeKNGGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:06:41 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43573 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNGGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:06:41 -0500
Received: by mail-yw1-f67.google.com with SMTP id l200so731833ywe.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 12:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RTO61L+kG+makdsrA5/OtWEuhnz9rHNDoeryJiudz+Y=;
        b=jw7cO068mMbkhhWPLC3B7OriZJ/mCixGjxxlviueNCDTtQKLpaRTtiUG7MOycMjfSy
         wKz2v6c0Ma99lfHcGktJvUFyWwmnIZa/2iCo+d3t4wQH9CRNoIjB3YF+FTZLkrWMIv7T
         8azHKF92eQo8PE7C6zrRAqCen5HsVtfQcjod8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RTO61L+kG+makdsrA5/OtWEuhnz9rHNDoeryJiudz+Y=;
        b=i9GrCZwfWxQLB1GH6UvdfOghWcl4hver6UZH0Mrvlo/FXAm5pnsrLGL+MkR6E+VMRC
         wSvf2QM/z1cyesH7en43crRSYbxe8kUKRtSjMaYyUNLOm9Yr9pUFjzYGaF1HRldpto+v
         wppUj/Qp4e3aUu8OUNmsXOzALUxA5cZofz6/WX1ThzBGnP/zDWAMz9OuCe7IeJHQuxj7
         a71Di0yC+N0zmRWuNUDIfVmrMAkto+rXj7AkBAgJgSrdt7FwOXHiHEAcHGn1rcwQ+QS6
         q7QXTgNPDlSjMyvgY3Oaz7vgFZ9FIQdBdwgjp7xI0jRmUjiuR+F5IUaQ8d+YQTi5R+Yn
         QDzg==
X-Gm-Message-State: AGRZ1gLuHNg5q/8WK+hchRQSFaftYXP5VL+kUK0tZcrPnChV1EQUat48
        +jscVv8JgVzJfhFPt20nPDPTTxNprK0=
X-Google-Smtp-Source: AJdET5dtaxokcinS/hGZ3aWMY7DDAdfXhLpbUgMNUS9uVUEQXg5MtVHNCB4cQA1f2/s0Xo33rdM46A==
X-Received: by 2002:a81:5946:: with SMTP id n67-v6mr6247781ywb.351.1542139618359;
        Tue, 13 Nov 2018 12:06:58 -0800 (PST)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id l6-v6sm715585ywm.51.2018.11.13.12.06.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 12:06:56 -0800 (PST)
Received: by mail-yw1-f53.google.com with SMTP id h32so230255ywk.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 12:06:55 -0800 (PST)
X-Received: by 2002:a0d:e984:: with SMTP id s126-v6mr6232284ywe.47.1542139614653;
 Tue, 13 Nov 2018 12:06:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 13 Nov 2018 12:06:53
 -0800 (PST)
In-Reply-To: <1542056928-10917-1-git-send-email-alex.popov@linux.com>
References: <1542056928-10917-1-git-send-email-alex.popov@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 13 Nov 2018 14:06:53 -0600
X-Gmail-Original-Message-ID: <CAGXu5jK-sQ4tAs0k-SST0NCoW8RgTmq9KHo97eGdN+57at5qQg@mail.gmail.com>
Message-ID: <CAGXu5jK-sQ4tAs0k-SST0NCoW8RgTmq9KHo97eGdN+57at5qQg@mail.gmail.com>
Subject: Re: [PATCH 1/1] stackleak: Disable function tracing and kprobes for stackleak_erase()
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 3:08 PM, Alexander Popov <alex.popov@linux.com> wrote:
> The stackleak_erase() function is called on the trampoline stack at the end
> of syscall. This stack is not big enough for ftrace and kprobes operations,
> e.g. it can be exhausted if we use kprobe_events for stackleak_erase().
>
> So let's disable function tracing and kprobes for stackleak_erase().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Thanks! I'll get this into my tree.

-Kees

> ---
>  kernel/stackleak.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index e428929..08cb57e 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include <linux/stackleak.h>
> +#include <linux/kprobes.h>
>
>  #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
>  #include <linux/jump_label.h>
> @@ -47,7 +48,7 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
>  #define skip_erasing() false
>  #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
>
> -asmlinkage void stackleak_erase(void)
> +asmlinkage void notrace stackleak_erase(void)
>  {
>         /* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
>         unsigned long kstack_ptr = current->lowest_stack;
> @@ -101,6 +102,7 @@ asmlinkage void stackleak_erase(void)
>         /* Reset the 'lowest_stack' value for the next syscall */
>         current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
>  }
> +NOKPROBE_SYMBOL(stackleak_erase);
>
>  void __used stackleak_track_stack(void)
>  {
> --
> 2.7.4
>



-- 
Kees Cook
