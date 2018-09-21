Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846CBECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5FD21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOi3rduo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5FD21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391243AbeIVAq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:46:57 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46153 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVAq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:46:57 -0400
Received: by mail-yw1-f65.google.com with SMTP id j131-v6so5577326ywc.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fb2t100j7WPI9DGriKlqgPzGdrrdg+bjdrKHlZvMeKY=;
        b=dOi3rduo6s4ThU1tl9Zv6wEAMSExZgFO/FoXyE1VzL9Slnk+ZihD8VhbAIfkD2672c
         UBx+TXSDuZtIN88BJDZagiF0rBGteX3JWqmHvYWsAmx7imc0PRYDvSzq78JGdT38LLPZ
         S8pyr98sUU2g2MiqjmEnv+GwbMC1LwjyEgiRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fb2t100j7WPI9DGriKlqgPzGdrrdg+bjdrKHlZvMeKY=;
        b=d2yHyzUcoVvyNDbXeUkmiRaboy9ZFlTQ3YxJaVJLwbX+hYeVy5rgknqScTd989izec
         KgA/VaS/f0zxDVJt+ObeEvhVRsZKng+9djzy+OkpIRtJdjfs5NdlZohsFTb/adTEoRjh
         tTRoBzEJn10s5llxRxxuUx13SEkUTh+Z7HmRuHOd2o3G6fiiISzxxL3qNk20oBbLqZL4
         huelLW8etEJpcd4E6PNi/CqhWLPOtVzaTjW5Z+x0qnHFsl8cJP7+v1hk4g+jH6saw04/
         OUZma6KwgfC6nJgaHejTRKPuN4y2/Ya9nLAFHep7v2+mx4F4c7sVs4CdAmG4Aaaw1Wrh
         cLag==
X-Gm-Message-State: APzg51ACPeRBAqoXP/d5RzGtLmMP6XhTE8Fvb3Hic93cBsU9oGypx4Qo
        oX+CUrNmAh902bQbcDREf3pRWFx91dM=
X-Google-Smtp-Source: ANB0VdZFsqjKVya8ISS4luU2x6waL0snm8zNbDO5EO3gOibq4RXZ1E5zNULkRPZF51N8Cb5Gak+JqA==
X-Received: by 2002:a81:9106:: with SMTP id i6-v6mr21419522ywg.371.1537556204986;
        Fri, 21 Sep 2018 11:56:44 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id f82-v6sm8025108ywf.58.2018.09.21.11.56.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 11:56:43 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id y12-v6so2631354ybj.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:56:43 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr21539573ybz.410.1537556202631;
 Fri, 21 Sep 2018 11:56:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 11:56:41
 -0700 (PDT)
In-Reply-To: <1536874298-23492-4-git-send-email-rick.p.edgecombe@intel.com>
References: <1536874298-23492-1-git-send-email-rick.p.edgecombe@intel.com> <1536874298-23492-4-git-send-email-rick.p.edgecombe@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 11:56:41 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJj+08J9UeyQs5ku8CziYWA72iJ+hxMR2Z2tLiVwvU8MA@mail.gmail.com>
Message-ID: <CAGXu5jJj+08J9UeyQs5ku8CziYWA72iJ+hxMR2Z2tLiVwvU8MA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] vmalloc: Add debugfs modfraginfo
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 2:31 PM, Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> Add debugfs file "modfraginfo" for providing info on module space fragmentation.
> This can be used for determining if loadable module randomization is causing any
> problems for extreme module loading situations, like huge numbers of modules or
> extremely large modules.
>
> Sample output when KASLR is enabled and X86_64 is configured:
>         Largest free space:     897912 kB
>           Total free space:     1025424 kB
> Allocations in backup area:     0
>
> Sample output when just X86_64:
>         Largest free space:     897912 kB
>           Total free space:     1025424 kB
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

I like having these statistics available!

> ---
>  mm/vmalloc.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 101 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 1954458..a44b902 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
> +#include <linux/debugfs.h>
>  #include <linux/debugobjects.h>
>  #include <linux/kallsyms.h>
>  #include <linux/list.h>
> @@ -33,6 +34,7 @@
>  #include <linux/bitops.h>
>
>  #include <linux/uaccess.h>
> +#include <asm/setup.h>
>  #include <asm/tlbflush.h>
>  #include <asm/shmparam.h>
>
> @@ -2919,7 +2921,105 @@ static int __init proc_vmalloc_init(void)
>                 proc_create_seq("vmallocinfo", 0400, NULL, &vmalloc_op);
>         return 0;
>  }
> -module_init(proc_vmalloc_init);
> +#else
> +static int __init proc_vmalloc_init(void)
> +{
> +       return 0;
> +}
> +#endif
> +
> +#if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_X86_64)
> +static inline unsigned long is_in_backup(unsigned long addr)
> +{
> +       return addr >= MODULES_VADDR + MODULES_RAND_LEN;
> +}
> +#else
> +static inline unsigned long is_in_backup(unsigned long addr)
> +{
> +       return 0;
> +}
>
> +inline bool kaslr_enabled(void);
>  #endif
>
> +
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_X86_64)
> +static int modulefraginfo_debug_show(struct seq_file *m, void *v)
> +{
> +       unsigned long last_end = MODULES_VADDR;
> +       unsigned long total_free = 0;
> +       unsigned long largest_free = 0;
> +       unsigned long backup_cnt = 0;
> +       unsigned long gap;
> +       struct vmap_area *prev, *cur = NULL;
> +
> +       spin_lock(&vmap_area_lock);
> +
> +       if (!pvm_find_next_prev(MODULES_VADDR, &cur, &prev) || !cur)
> +               goto done;
> +
> +       for (; cur->va_end <= MODULES_END; cur = list_next_entry(cur, list)) {
> +               /* Don't count areas that are marked to be lazily freed */
> +               if (!(cur->flags & VM_LAZY_FREE)) {
> +                       backup_cnt += is_in_backup(cur->va_start);
> +                       gap = cur->va_start - last_end;
> +                       if (gap > largest_free)
> +                               largest_free = gap;
> +                       total_free += gap;
> +                       last_end = cur->va_end;
> +               }
> +
> +               if (list_is_last(&cur->list, &vmap_area_list))
> +                       break;
> +       }
> +
> +done:
> +       gap = (MODULES_END - last_end);
> +       if (gap > largest_free)
> +               largest_free = gap;
> +       total_free += gap;
> +
> +       spin_unlock(&vmap_area_lock);
> +
> +       seq_printf(m, "\tLargest free space:\t%lu kB\n", largest_free / 1024);
> +       seq_printf(m, "\t  Total free space:\t%lu kB\n", total_free / 1024);
> +
> +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
> +               seq_printf(m, "Allocations in backup area:\t%lu\n", backup_cnt);

I don't think the IS_ENABLED is needed here?

I wonder if there is a better way to arrange this code that uses fewer
ifdefs, etc. Maybe a single CONFIG that capture whether or not
fine-grained module randomization is built in, like:

config RANDOMIZE_FINE_MODULE
    def_bool y if RANDOMIZE_BASE && X86_64

#ifdef CONFIG_RANDOMIZE_FINE_MODULE
...
#endif

But that doesn't capture the DEBUG_FS and PROC_FS bits ... so ...
maybe not worth it. I guess, either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
