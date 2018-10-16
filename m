Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C4EC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E24D205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLvcUXbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E24D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJQFRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbeJQFRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:17:39 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4002421470
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539725121;
        bh=v/Fmzz9EAoi17bs+UG2hEWHX47GLZMTEqbmZso6OjPw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tLvcUXbr5ZQ+XmGKcbaQwLnPp4EXmVlWdi5b3nLmUzWJNiXSRx8eAWzmrRs/FiedX
         60Zqx+66EO/QfHBX9V8+IncWTXeRbs+ADHGwJ+rRPpSYixpMMmwa0y67Bptq+pPOY4
         JHJaDe38w/ngL1kMb0DrQmXPrvHrNYvQF4ddpmek=
Received: by mail-wm1-f54.google.com with SMTP id 189-v6so23889868wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:25:21 -0700 (PDT)
X-Gm-Message-State: ABuFfojfSqhPquxoPMea37rXbX+XbHXFynC//vlt9bGUJVWqdm99kOsU
        7YwpNTWpkieZiFXVNRCQ4INrcJigI91dQfthd9tgqg==
X-Google-Smtp-Source: ACcGV61zzMFyBPmRxVygb2WjI1RiBrdYngffa/8vkWyn6XD2NH1Wb9o+Qh1VUKvrixDMzPoc51f7JFYpgIMxhbC+Qlc=
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr18443248wmf.19.1539725119674;
 Tue, 16 Oct 2018 14:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181016202525.29437-1-bigeasy@linutronix.de> <20181016202525.29437-2-bigeasy@linutronix.de>
In-Reply-To: <20181016202525.29437-2-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Oct 2018 14:25:07 -0700
X-Gmail-Original-Message-ID: <CALCETrWB2kH9d5ui5haY3aRTD9SAU=tcdkTMoAzJ5rhLh3mO3w@mail.gmail.com>
Message-ID: <CALCETrWB2kH9d5ui5haY3aRTD9SAU=tcdkTMoAzJ5rhLh3mO3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/mm/pat: Disable preemption around __flush_tlb_all()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 1:25 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> I've seen the WARN_ON_ONCE(__read_cr3() != build_cr3()) in
> switch_mm_irqs_off() every once in a while during a snapshotted system
> upgrade.
> I also saw the warning early during which was introduced in commit
> decab0888e6e ("x86/mm: Remove preempt_disable/enable() from
> __native_flush_tlb()"). The callchain is
>
>   get_page_from_freelist() -> post_alloc_hook() -> __kernel_map_pages()
>
> with CONFIG_DEBUG_PAGEALLOC enabled.
>
> Turns out, once I disable preemption around __flush_tlb_all() both
> warnings do not appear.
>
> Disable preemption during CR3 reset / __flush_tlb_all().
>
> Fixes: decab0888e6e ("x86/mm: Remove preempt_disable/enable() from __native_flush_tlb()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/mm/pageattr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 51a5a69ecac9f..fe6b21f0a6631 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -2088,7 +2088,9 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
>          * We should perform an IPI and flush all tlbs,
>          * but that can deadlock->flush only current cpu:
>          */
> +       preempt_disable();
>         __flush_tlb_all();
> +       preempt_enable();
>

Depending on your CPU, __flush_tlb_all() is either
__native_flush_tlb_global() or __native_flush_tlb().  Only
__native_flush_tlb() could have any problem with preemption, but it
has a WARN_ON_ONCE(preemptible()); in it.  Can you try to figure out
why that's not firing for you?

I suspect that a better fix would be to put preempt_disable() into
__native_flulsh_tlb(), but I'd still like to understand why the
warning isn't working.
