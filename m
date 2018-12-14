Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742D3C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EC420811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EC420811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeLNFCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:02:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46394 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeLNFCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:02:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so3764157ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 21:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCaMjQoJF+/9nPt+yVRblwzG43JzuBI6czYr/M1JOog=;
        b=DeiMmDuk2IE67kTbWKOHguDuZ5qLFxNDHhBD4WBH4UYLm/KhRz43peXZMKtl1huSfU
         +kG9FbiTcSqYahxOTGeZUj8wz7zVywi9j3/10M2eogj+N3CT5OCOTJBeOX6/5LcRfpw2
         huvNChG9NR31qA8/X+Jg7ruaOZRofkHtL4+Ei2w8YMb4cG8A6+iHWoGzmrLCGznDBj6Z
         Y4yYRSjmUGHPFrUpbrWw3V9a85s4WQklU5NUtUmcBWGO3INYLtixc8WqQCleZsvuw/Cl
         6Wr973i4sictuFT6Gjyluj4kQMJDubRARhXmz9NwHkGfdO5g4GxbX6SjESmfnsSg6G3/
         I25g==
X-Gm-Message-State: AA+aEWaxB4BcEk3auwFr6cHd84GhIOkdRUgfwbvTF1nrEC6Rhoo0OohY
        u/n8u7OF5E9sp8SJHLbSllIUgxit/SexzAosOZdl7A==
X-Google-Smtp-Source: AFSGD/WAcqcCXczhW/n2ORIL+U6gvQCHO2YVZ/hdKEffT5iZLZ3A/fkzvZ0r2wWl++yxve3n0NM/n1xIhQzsgbxszjA=
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr802675ljh.63.1544763725591;
 Thu, 13 Dec 2018 21:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20181213052259.56352-1-cai@lca.pw> <20181214040819.58625-1-cai@lca.pw>
In-Reply-To: <20181214040819.58625-1-cai@lca.pw>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 14 Dec 2018 10:31:52 +0530
Message-ID: <CACi5LpNQ1WGE54uv35OwNmJkKR_xnqTNqFK+R9oFBVkb683z_Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
To:     cai@lca.pw
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 9:39 AM Qian Cai <cai@lca.pw> wrote:
>
> On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
> dump just hung. It has 4 threads on each core. Each 2-core share a same
> L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
> L3 cache.
>
> It turned out that this was due to the TLB contained stale entries (or
> uninitialized junk which just happened to look valid) before turning the
> MMU on in the second kernel which caused this instruction hung,
>
> msr     sctlr_el1, x0
>
> Although there is a local TLB flush in the second kernel in
> __cpu_setup(), it is called too early. When the time to turn the MMU on
> later, the TLB is dirty again from some reasons.
>
> Also tried to move the local TLB flush part around a bit inside
> __cpu_setup(), although it did complete kdump some times, it did trigger
> "Synchronous Exception" in EFI after a cold-reboot fairly often that
> seems no way to recover remotely without reinstalling the OS. For
> example, in those places,
>
> ENTRY(__cpu_setup)
> +       isb
>         tlbi    vmalle1
>         dsb     nsh
>
> or
>
>         mov     x0, #3 << 20
>         msr     cpacr_el1, x0
> +       tlbi    vmalle1
> +       dsb     nsh
>
> Since it is only necessary to flush local TLB right before turning the
> MMU on, just re-arrage the part a bit like the one in __primary_switch()
> within CONFIG_RANDOMIZE_BASE path, so it does not depends on other
> instructions in between that could pollute the TLB, and it no longer
> trigger "Synchronous Exception" as well.
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> v2: merge the similar part from __cpu_setup() pointed out by James.
>
>  arch/arm64/kernel/head.S | 4 ++++
>  arch/arm64/mm/proc.S     | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4471f570a295..7f555dd4577e 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
>         msr     ttbr0_el1, x2                   // load TTBR0
>         msr     ttbr1_el1, x1                   // load TTBR1
>         isb
> +
> +       tlbi    vmalle1                         // invalidate TLB
> +       dsb     nsh
> +
>         msr     sctlr_el1, x0
>         isb
>         /*
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 2c75b0b903ae..14f68afdd57f 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -406,9 +406,6 @@ ENDPROC(idmap_kpti_install_ng_mappings)
>   */
>         .pushsection ".idmap.text", "awx"
>  ENTRY(__cpu_setup)
> -       tlbi    vmalle1                         // Invalidate local TLB
> -       dsb     nsh
> -
>         mov     x0, #3 << 20
>         msr     cpacr_el1, x0                   // Enable FP/ASIMD
>         mov     x0, #1 << 12                    // Reset mdscr_el1 and disable
> --
> 2.17.2 (Apple Git-113)
>

Not sure why I can't reproduce on my HPE Apollo machine, so a couple
of questions:
1. How many CPUs do you enable in the kdump kernel - do you pass
'nr_cpus=1' to the kdump kernel to limit the maximum number of cores
to 1 in the kdump kernel?
2. Which firmware version do you use on your board?

Thanks,
Bhupesh
