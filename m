Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD1AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6678120647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzjhrb8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6678120647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeH2Toa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbeH2Toa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:44:30 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A87D206B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535557617;
        bh=zjf/EKoxje99OaOSNSksrP57Sa/nknvwGUwmDpHARXc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=uzjhrb8BEvjFkfWSLr7vAMky2n7rrPHwQkmw3N2OBHS1alCdsguFqcc0AvkzdPsL5
         ZtWjy5+LFYc+GJSmlGNUjMRxLT7OSbUKzBijDjgaSgo615n63D/eChHxKmtX6zsn0r
         sDrbb53hdX3NhhDMCHotyFtTnDjvaALTPTLNZZE4=
Received: by mail-wm0-f53.google.com with SMTP id y139-v6so5727831wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:46:57 -0700 (PDT)
X-Gm-Message-State: APzg51A7KEGNpi98LIrL3ylSIHevKU0WccFKTioBlTqRH3qSClmBY2ho
        QfKeWdnIiaWk52Ybtx1xbVQbTJaO88CRkLubjnJqSQ==
X-Google-Smtp-Source: ANB0VdaxU9B0HSCfT27iojDx634HU+v1L/no1vKjVbgCwGtJfChoMruyHg8mdGzk+3xARYdBzDpHPDey7qtLH3JrTFw=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr4387701wmd.144.1535557615692;
 Wed, 29 Aug 2018 08:46:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 08:46:35 -0700 (PDT)
In-Reply-To: <20180829081147.184610-3-namit@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com> <20180829081147.184610-3-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 29 Aug 2018 08:46:35 -0700
X-Gmail-Original-Message-ID: <CALCETrX39hY28W9aFsFHGWO7f0qjzpwk5YDMFvfzLXON=PqPdw@mail.gmail.com>
Message-ID: <CALCETrX39hY28W9aFsFHGWO7f0qjzpwk5YDMFvfzLXON=PqPdw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] x86/mm: temporary mm struct
To:     Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rik, this is the patch I was referring to.

On Wed, Aug 29, 2018 at 1:11 AM, Nadav Amit <namit@vmware.com> wrote:
> From: Andy Lutomirski <luto@kernel.org>
>
> Sometimes we want to set a temporary page-table entries (PTEs) in one of
> the cores, without allowing other cores to use - even speculatively -
> these mappings. There are two benefits for doing so:
>
> (1) Security: if sensitive PTEs are set, temporary mm prevents their use
> in other cores. This hardens the security as it prevents exploding a
> dangling pointer to overwrite sensitive data using the sensitive PTE.
>
> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
> remote page-tables.
>
> To do so a temporary mm_struct can be used. Mappings which are private
> for this mm can be set in the userspace part of the address-space.
> During the whole time in which the temporary mm is loaded, interrupts
> must be disabled.
>
> The first use-case for temporary PTEs, which will follow, is for poking
> the kernel text.
>
> [ Commit message was written by Nadav ]
>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/mmu_context.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index eeeb9289c764..96afc8c0cf15 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -338,4 +338,24 @@ static inline unsigned long __get_current_cr3_fast(void)
>         return cr3;
>  }
>
> +typedef struct {
> +       struct mm_struct *prev;
> +} temporary_mm_state_t;
> +
> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *mm)
> +{
> +       temporary_mm_state_t state;
> +
> +       lockdep_assert_irqs_disabled();
> +       state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> +       switch_mm_irqs_off(NULL, mm, current);
> +       return state;
> +}
> +
> +static inline void unuse_temporary_mm(temporary_mm_state_t prev)
> +{
> +       lockdep_assert_irqs_disabled();
> +       switch_mm_irqs_off(NULL, prev.prev, current);
> +}
> +
>  #endif /* _ASM_X86_MMU_CONTEXT_H */
> --
> 2.17.1
>
