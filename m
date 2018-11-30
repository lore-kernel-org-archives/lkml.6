Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08526C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19252145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nV05wTbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19252145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeLAEZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:25:02 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42981 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeLAEZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:25:01 -0500
Received: by mail-yb1-f194.google.com with SMTP id s8so334769ybe.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eA8RA4BMCo4J6Tj7FedpLFV8GAZ8Ue1y/wfOuYx7IRw=;
        b=nV05wTbR9GdI2h4En2tMC6ecY9fatk6N+XQPboTAptZvLo8XtMgte+MdmEMglze9Dt
         /y2dVXn4NidmLvTt6UE6aHbl2ZbMqht0r2NVBicchD71ylSLz4rzd1+Ldt0HqCr611C7
         2TarH69sIG6gt1L5N0uVfc3y4G5guz1BelI3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eA8RA4BMCo4J6Tj7FedpLFV8GAZ8Ue1y/wfOuYx7IRw=;
        b=qR5CMqsFzDjYtqYgo2WIZuhMXsQyxwubJqjhlfkjNqdLh0/9jgxj6C9CU3o4uCA0i5
         x19cLH3E1e8GD1XK1ITk8mzWbHZt8kBmplg5kRG2PWDW11uxlVXOCYeaMCEE69io+SPA
         PkJgbvqAzMDHGcOjq+t19eSDMH+lEWOK6+RJB+qRd3xkw0NPPaSQ2k+OIHbAnfn23F5a
         DkIdPT2ZOvHjnEfPY/Vj4ArmNFbTdAqWe7flqQ0gcyuowrombxHaxMd3ccQ0ToWHzFfz
         5LR6+Gnb49THUDM9WVnAh6D3DKvTC6kCAnROC+oqZky8EGemzCDgbPWAywgeqpW2v5wx
         lEMA==
X-Gm-Message-State: AA+aEWYBevOD06j+ezPxYe+HgK7NwzqbaR3Khc31Sar6BBCRDKUT6stm
        q71D9IUbV4KPgzs9eMd98VcpQH7P7yU=
X-Google-Smtp-Source: AFSGD/VOYL6g+HLuEkXi2tLpfZRAdhtZQmLsnqbp1rdZ/wVPgUoRXtWyZaIKfmhTllquZdQKkLSD9A==
X-Received: by 2002:a25:3005:: with SMTP id w5-v6mr6241277ybw.365.1543598102314;
        Fri, 30 Nov 2018 09:15:02 -0800 (PST)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id p201sm2050170ywe.45.2018.11.30.09.15.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:15:02 -0800 (PST)
Received: by mail-yw1-f54.google.com with SMTP id h193so2561796ywc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:15:01 -0800 (PST)
X-Received: by 2002:a81:2890:: with SMTP id o138mr6717118ywo.168.1543597754077;
 Fri, 30 Nov 2018 09:09:14 -0800 (PST)
MIME-Version: 1.0
References: <1543583987-27948-1-git-send-email-alex.popov@linux.com>
In-Reply-To: <1543583987-27948-1-git-send-email-alex.popov@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 30 Nov 2018 09:09:02 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ7LmHRJJxtH2HD4XEu5hPLtAe=koJbaCmqF9qoSw=sVw@mail.gmail.com>
Message-ID: <CAGXu5jJ7LmHRJJxtH2HD4XEu5hPLtAe=koJbaCmqF9qoSw=sVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] stackleak: Register the 'stackleak_cleanup' pass
 before the 'mach' pass
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        amonakov@ispras.ru, Tycho Andersen <tycho@tycho.ws>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Emese Revfy <re.emese@gmail.com>,
        Thomas Garnier <thgarnie@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        gcc@gcc.gnu.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:20 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> Currently the 'stackleak_cleanup' pass deleting a CALL insn is executed
> after the 'reload' pass. That allows gcc to do some weird optimization in
> function prologues and epilogues, which are generated later [1].
>
> Let's avoid that by registering the 'stackleak_cleanup' pass before
> the 'mach' pass, which performs the machine dependent code transformations.
> It's the moment when the stack frame size is final and function prologues
> and epilogues are already generated.
>
> [1] https://www.openwall.com/lists/kernel-hardening/2018/11/23/2
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Thanks, applied!

-Kees

> ---
>  scripts/gcc-plugins/stackleak_plugin.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index 2f48da9..6f41b32 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -363,10 +363,12 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
>                                                 PASS_POS_INSERT_BEFORE);
>
>         /*
> -        * The stackleak_cleanup pass should be executed after the
> -        * "reload" pass, when the stack frame size is final.
> +        * The stackleak_cleanup pass should be executed before the "mach"
> +        * pass, which performs the machine dependent code transformations.
> +        * It's the moment when the stack frame size is already final and
> +        * function prologues and epilogues are generated.
>          */
> -       PASS_INFO(stackleak_cleanup, "reload", 1, PASS_POS_INSERT_AFTER);
> +       PASS_INFO(stackleak_cleanup, "mach", 1, PASS_POS_INSERT_BEFORE);
>
>         if (!plugin_default_version_check(version, &gcc_version)) {
>                 error(G_("incompatible gcc/plugin versions"));
> --
> 2.7.4
>


-- 
Kees Cook
