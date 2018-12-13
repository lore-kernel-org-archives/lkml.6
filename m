Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1CEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E2D20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pGrQuUf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E2D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbeLMNoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:44:23 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42655 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbeLMNoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:44:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so2106787qtq.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 05:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcHOTrwef+d/3NpOnG6UkJ2OjWRwDQnbxAR+dweCJqY=;
        b=pGrQuUf70QYOWnWOFy9glld1HmxOl/YGxEUye4D3XR+1FNeKiWP0QcqC4QMo57cvwn
         1Mo2b3blWZUzwONJpWyoE0ujYnqqNaywUdEMk0rhzNA2AUm9AxAokVNsT+V1f6R0pZjy
         i6yOUlC8tdbsmimlL3BZ/FsD4hDei1Z1rT6VkCbGQs9g7JESooDfLxxP/9iTjREckNUS
         60e+NPUTpcydL6Md+CuxX1l4b79nSDMJtSWwHhEJKKLQL2PaaE0mrNOc+dLrcXmj1X0C
         NjsxNAZdnO8YMMUb/OWt2sN4bOcdZlyeENxDmD82ywPoRGIPRFDyiHzI+w+CwzxDja14
         biYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcHOTrwef+d/3NpOnG6UkJ2OjWRwDQnbxAR+dweCJqY=;
        b=Y3pNciZQFHt1ArMlZI4rAoG1YOSmeZ2rzcufCgJe4Iz6glBVotYuLZeb4wbiDiV1uS
         jGyvOc9xjqRhQ1d+ELHxH0Bv11zevspgFELrnuipPHXMS2TVsNLip40KUm4ScFg/8iEC
         ChhgzGOh0I7dTLTog8I43jcDqCFqZicZSa5I8DhQImXfqoSzutC505H4SuyJcGQOffuo
         2k6ZO9nwXLYng+6bOJFYWN5JjB2w+5+wnmKPsYn9jQbNaNTkTO/7b9YpjFqaLOrLdywn
         D4HuGQ3qjXa0ae6bwJftQ5vI55s7+TYWjcwxtp9+rY9RtzGmwmqpno9FR3Qszh6AWmYw
         G04A==
X-Gm-Message-State: AA+aEWaAIKxsbevNsTWpxgI59v5RqFjgMq3Oj6In7AO63FXSxyvp2Wwj
        2Vlo/ryCyO1tPKSlfEErk+96fg==
X-Google-Smtp-Source: AFSGD/XoYJwUHe6CpH+VfdlXpO3DqTs34O79NBy+a+LVOi2KsrmPz4ZVLzDCa9JhZJupr9LOseuBjw==
X-Received: by 2002:a0c:d033:: with SMTP id u48mr22856833qvg.146.1544708662064;
        Thu, 13 Dec 2018 05:44:22 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b20sm1513077qkb.17.2018.12.13.05.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:44:21 -0800 (PST)
Message-ID: <1544708660.18411.15.camel@lca.pw>
Subject: Re: [PATCH] arm64: invalidate TLB before turning MMU on
From:   Qian Cai <cai@lca.pw>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        takahiro.akashi@linaro.org, ard.biesheuvel@linaro.org,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Dec 2018 08:44:20 -0500
In-Reply-To: <1b150a95-2b80-2be3-0b77-599404f882dc@arm.com>
References: <1544654224.18411.11.camel@lca.pw>
         <20181213052259.56352-1-cai@lca.pw>
         <1b150a95-2b80-2be3-0b77-599404f882dc@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 10:44 +0000, James Morse wrote:
> The kernel should already handle this, as we don't trust the bootloader to
> clean
> up either.
> 
> In arch/arm64/mm/proc.S::__cpu_setup()
> > /*
> > *	__cpu_setup
> > *
> > *	Initialise the processor for turning the MMU on.  Return in x0 the
> > *	value of the SCTLR_EL1 register.
> > */
> > 	.pushsection ".idmap.text", "awx"
> > ENTRY(__cpu_setup)
> > 	tlbi	vmalle1				// Invalidate local
> > TLB
> > 	dsb	nsh
> 
> This is called from stext, which then branches to __primary_switch(), which
> calls __enable_mmu() where you see this problem. It shouldn't not be possible
> to
> allocate new tlb entries between these points...
> 
> Do you have CONFIG_RANDOMIZE_BASE disabled? This causes enable_mmu() to be
> called twice, the extra tlb maintenance is in __primary_switch.
> (if it works with this turned off, it points to the extra off/tlbi/on
> sequence).

Yes, CONFIG_RANDOMIZE_BASE is NOT set.

> 
> 
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 4471f570a295..5196f3d729de 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
> >  	msr	ttbr0_el1, x2			// load TTBR0
> >  	msr	ttbr1_el1, x1			// load TTBR1
> >  	isb
> > +	dsb	nshst
> > +	tlbi	vmalle1				// invalidate
> > TLB
> > +	dsb	nsh
> > +	isb
> >  	msr	sctlr_el1, x0
> >  	isb
> 
> The overall change here is that we do extra maintenance later.
> 
> Can move this around to bisect where the TLB entries are either coming from,
> or
> failing-to-be invalidated?
> Do your first and kdump kernels have the same VA_BITS/PAGE_SIZE?

Yes,

CONFIG_ARM64_VA_BITS=48
CONFIG_ARM64_PAGE_SHIFT=16
# CONFIG_ARM64_4K_PAGES is not set
# CONFIG_ARM64_16K_PAGES is not set
CONFIG_ARM64_64K_PAGES=y

> As a stab in the dark, (totally untested):
> ------------------------------%<------------------------------
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 2c75b0b903ae..a5f3b7314bda 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -406,9 +406,6 @@ ENDPROC(idmap_kpti_install_ng_mappings)
>   */
>         .pushsection ".idmap.text", "awx"
>  ENTRY(__cpu_setup)
> -       tlbi    vmalle1                         // Invalidate local TLB
> -       dsb     nsh
> -
>         mov     x0, #3 << 20
>         msr     cpacr_el1, x0                   // Enable FP/ASIMD
>         mov     x0, #1 << 12                    // Reset mdscr_el1 and disable
> @@ -465,5 +462,10 @@ ENTRY(__cpu_setup)
>  1:
>  #endif /* CONFIG_ARM64_HW_AFDBM */
>         msr     tcr_el1, x10
> +       isb
> +
> +       tlbi    vmalle1                         // Invalidate local TLB
> +       dsb     nsh
> +
>         ret                                     // return to head.S
>  ENDPROC(__cpu_setup)
> ------------------------------%<------------------------------
> 

This patch works well too.
