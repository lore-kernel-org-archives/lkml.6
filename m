Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A16C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3742420862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NATdBx/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3742420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeHAUh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:37:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41951 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbeHAUhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:37:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so8305984pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zH0tq50so2YpVnbKcqMI4M1uhoRhE/vxXTzoc7ONzvY=;
        b=NATdBx/hm6Uk4yPPYpMr/R2D7tUGGH2VIuVLzfWy7Jm9pVgaimNxf8a6+vkYoFzNTm
         H+QOHuEtta6GjznyINinJavS5egXCZm+0PlCx8CSCsjZCt/7X+lbAq7WpQ19mZzc5sKs
         OSsvOmyP93l3cNHpXRUCJPmiH+gITXYB+LHIFeqviWNevn0EDIgoqLmbLPMWqD/qC/7j
         EpTQKuOVqrQV5LzRL2sE68u0KoPNKC2/eE1VurwF/fqBLXh9OgZi+4725RJ1FjMv0U4p
         V7xTRnmNXi0bor54LxyfR8qZelMyyuNg/k5c+0mtqV9LOalaf9NGMo7Ee89uGKH9EVsV
         4f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zH0tq50so2YpVnbKcqMI4M1uhoRhE/vxXTzoc7ONzvY=;
        b=fM8spGqP/zocyBzZKmeHkCZm5bM16NVJlLUD73F5qUDpWmkQ5NOs9YWVCON0/m+XjH
         Bx3W4JkIrUGWZwUUH+mjCBp0uAFjjkkUUOEHuT6KZgIuyFAcSA7zSV+/43fA/guIxye5
         sllYQL6ZuKp6G+zjO02isMP8lhM6VjpEiGmiOBM9xdUtcSeB8+6xP8XGJ0L5o7hkIZAK
         TO+yDS3SgyYSWhsaUTz/AGm1EQUtzAnbK6QpzVff+8CoN2pAPzWFZM1o59tXliv/JYb+
         zYOqRT7qb/rOQenwOnOVriH/tTPAoaJUCrd6bir/cOJOWDpwiEOfryhic+/aUtpudaMY
         7S+g==
X-Gm-Message-State: AOUpUlGuDiUJ++7B/eNfZyjmjZuNPT8nEGwnpBrprbXd/RkrKGhO2d15
        KLh+Dginy/5kp9ydk51BlAj00BoJoenQt0PE1CjqUg==
X-Google-Smtp-Source: AAOMgpeEkJ3kvrd3tRxYtOKPY90LVizz9XcBYjniGcSEhonpahabCdG2AnjgH9vL09Bz/kmSKRcNbYFhKmKKmXBZjbE=
X-Received: by 2002:a62:8d7:: with SMTP id 84-v6mr28091513pfi.172.1533149417492;
 Wed, 01 Aug 2018 11:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180801182943.22176-1-ndesaulniers@google.com>
In-Reply-To: <20180801182943.22176-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 1 Aug 2018 11:50:06 -0700
Message-ID: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
Subject: Re: [PATCH] sh: dwarf: prefer _THIS_IP_ to current_text_addr
To:     Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 11:29 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> As part of the effort to reduce the code duplication between _THIS_IP_
> and current_text_addr(), let's consolidate callers of
> current_text_addr() to use _THIS_IP_.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/sh/kernel/dwarf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
> index 1a2526676a87..bb511e2d9d68 100644
> --- a/arch/sh/kernel/dwarf.c
> +++ b/arch/sh/kernel/dwarf.c
> @@ -599,7 +599,7 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
>          * time this function makes its first function call.
>          */
>         if (!pc || !prev)
> -               pc = (unsigned long)current_text_addr();
> +               pc = _THIS_IP_;
>
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>         /*
> --
> 2.18.0.597.ga71716f1ad-goog
>

Sorry, there's another call site in the arch/sh/ tree
(arch/sh/include/asm/kexec.h#64).  Let me fix both and send as a
single patch in v2.
-- 
Thanks,
~Nick Desaulniers
