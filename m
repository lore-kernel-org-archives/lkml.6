Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEA720840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UoPOHMeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEA720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeKIXT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:19:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39599 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeKIXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:19:58 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so3210344itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 05:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=41kNbker7pjMlSrMXESCPMU6qoot3isUmOITc7YdAuc=;
        b=UoPOHMeA60tmrLPtRQrqJKmsdP4J+jX9orOhFyzJRoTxXxU+CWPtZ5kqK95Gnkmjp9
         n4rzVhKX1bgWNX1CrhQm75CW/OpVpnLPCoB/QwRwOFhf6ytuW/ks7SdWh8s91URW5u0w
         +E0+Jzj3tOifeiH6fUlhakmmkBwqW2k/pufSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=41kNbker7pjMlSrMXESCPMU6qoot3isUmOITc7YdAuc=;
        b=mkUUDFaBP8utLPqGCRSl9QWQfamoeoWMY0zMfOm61hgIxA/2DfmPPH/f2P3ODzDxTA
         IJz15PlYKdA+T5+gzjeoYmTlKDxk03N9txa97RuDn3Tw949sNZqCEa+lmKEXItD6Fqu2
         REsodChaKqMgX85I2MWNcsvsKTPXGaOokjkWZ00bwH3eYnHPwIv5Gypxt3WbVjMXo4Ja
         TWJDbdOxgAO7/3rXVkCRmEK+me4B9iTVANDdTuOSx/x51l1/66ntkkf4xDoa70K9No0D
         qs0hW5CAIq+1eBT+rpWz/r3GUjlbGHLSBjbi/3P3+RxYfkzaCB43MwpR9QxXiRiAFhl5
         eT0A==
X-Gm-Message-State: AGRZ1gLCZ4kgK6EoZ2/WJkJBlA3vKkxO5y/PHWxuX+dBqBaK4zSnbeD8
        sr6gB1ifA7u4YACKnIFvQ84oRsXIjKrCE3RyUeVEQg==
X-Google-Smtp-Source: AJdET5cmaA7gBiiQ16XnYNHEtiKEWZZRKMUaJkAxQycCMVXvUU/wRW7NIBxAU7yDDeLe3eg/bmUH6Uxa5SbJ5TCJXzg=
X-Received: by 2002:a24:7d8d:: with SMTP id b135-v6mr1903970itc.121.1541770757881;
 Fri, 09 Nov 2018 05:39:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 05:39:17 -0800 (PST)
In-Reply-To: <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
References: <cover.1541711457.git.jpoimboe@redhat.com> <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 9 Nov 2018 14:39:17 +0100
Message-ID: <CAKv+Gu9bMkFEx_GxH3uLm0gveQurp7ELDi6C5NvpugufPFMbRA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 November 2018 at 22:15, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> Add a static call infrastructure.  Static calls use code patching to
> hard-code function pointers into direct branch instructions.  They give
> the flexibility of function pointers, but with improved performance.
> This is especially important for cases where retpolines would otherwise
> be used, as retpolines can significantly impact performance.
>
> This code is heavily inspired by the jump label code (aka "static
> jumps"), as some of the concepts are very similar.
>
> There are three implementations, depending on arch support:
>
> 1) optimized: patched call sites (CONFIG_HAVE_STATIC_CALL_OPTIMIZED)
> 2) unoptimized: patched trampolines (CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED)
> 3) basic function pointers
>
> For more details, see the comments in include/linux/static_call.h.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/Kconfig                      |   6 +
>  include/asm-generic/vmlinux.lds.h |  11 ++
>  include/linux/module.h            |  10 +
>  include/linux/static_call.h       | 186 +++++++++++++++++++
>  include/linux/static_call_types.h |  19 ++
>  kernel/Makefile                   |   1 +
>  kernel/module.c                   |   5 +
>  kernel/static_call.c              | 297 ++++++++++++++++++++++++++++++
>  8 files changed, 535 insertions(+)
>  create mode 100644 include/linux/static_call.h
>  create mode 100644 include/linux/static_call_types.h
>  create mode 100644 kernel/static_call.c
>
> diff --git a/kernel/static_call.c b/kernel/static_call.c
> new file mode 100644
> index 000000000000..599ebc6fc4f1
> --- /dev/null
> +++ b/kernel/static_call.c
...
> +static void __init static_call_init(void)
> +{
> +       struct static_call_site *start = __start_static_call_sites;
> +       struct static_call_site *stop  = __stop_static_call_sites;
> +       struct static_call_site *site;
> +
> +       if (start == stop) {
> +               pr_warn("WARNING: empty static call table\n");
> +               return;
> +       }
> +
> +       cpus_read_lock();
> +       static_call_lock();
> +
> +       static_call_sort_entries(start, stop);
> +
> +       for (site = start; site < stop; site++) {
> +               struct static_call_key *key = static_call_key(site);
> +               unsigned long addr = static_call_addr(site);
> +
> +               if (list_empty(&key->site_mods)) {
> +                       struct static_call_mod *mod;
> +
> +                       mod = kzalloc(sizeof(*mod), GFP_KERNEL);
> +                       if (!mod) {
> +                               WARN(1, "Failed to allocate memory for static calls");
> +                               return;
> +                       }
> +
> +                       mod->sites = site;
> +                       list_add_tail(&mod->list, &key->site_mods);
> +
> +                       /*
> +                        * The trampoline should no longer be used.  Poison it
> +                        * it with a BUG() to catch any stray callers.
> +                        */
> +                       arch_static_call_poison_tramp(addr);

This patches the wrong thing: the trampoline is at key->func not addr.

However, patching it here means we poison it before all users are
patched. I added this on top

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 599ebc6fc4f1..d9562329bec6 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -248,6 +248,7 @@ static void __init static_call_init(void)
        struct static_call_site *start = __start_static_call_sites;
        struct static_call_site *stop  = __stop_static_call_sites;
        struct static_call_site *site;
+       struct static_call_key *prev_key = NULL;

        if (start == stop) {
                pr_warn("WARNING: empty static call table\n");
@@ -279,7 +280,9 @@ static void __init static_call_init(void)
                         * The trampoline should no longer be used.  Poison it
                         * it with a BUG() to catch any stray callers.
                         */
-                       arch_static_call_poison_tramp(addr);
+                       if (prev_key)
+
arch_static_call_poison_tramp((unsigned long)prev_key->func);
+                       prev_key = key;
                }

                arch_static_call_transform(addr, key->func);


> +               }
> +
> +               arch_static_call_transform(addr, key->func);
> +       }
> +
> +       static_call_initialized = true;
> +
> +       static_call_unlock();
> +       cpus_read_unlock();
> +
> +#ifdef CONFIG_MODULES
> +       register_module_notifier(&static_call_module_nb);
> +#endif
> +}
> +early_initcall(static_call_init);
> --
> 2.17.2
>
