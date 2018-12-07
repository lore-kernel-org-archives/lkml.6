Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E38C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3C02146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544194056;
	bh=FntOFJdPJH20mUtvdxKHhnRbrohNDbfRQwkMEag/mi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=l3bc9wkRcVPyWRvPUW29YHVwI1EUTyIZidyxAqRmRvSOT8tpfeVX0rCUC5tXdm7Wl
	 SIJb1cww58BLd+s24IYWroXU0Dup/lczEaj8zn5IuI9c3DjM0QAU/7eAiWMi6d66wh
	 OuqhORwgsQK+yWXcKJfmDw/rKUTCcDV9/qU5ue9I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3C02146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLGOrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeLGOrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:47:35 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A023420989;
        Fri,  7 Dec 2018 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544194054;
        bh=FntOFJdPJH20mUtvdxKHhnRbrohNDbfRQwkMEag/mi0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TJYmQwEuPWQLc1vJcV6zBxxatsGiwrsMJBplrMPvfzBpS0IQlX41M+QxpOHKzeLWB
         tw1JrcOu697aE8p/VTfKmOi4cuumOfq7rUts1KJbnUxnl0eS9+kNHWZQrwb73ENX0f
         Y49VJMoaoEpO/1YVu49L7Gj7REP1la8ya6TpFv+4=
Date:   Fri, 7 Dec 2018 23:47:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: x86_64: blacklist non-attachable interrupt
 functions
Message-Id: <20181207234731.f52a8c1eff6c0e72c073ad40@kernel.org>
In-Reply-To: <20181206095648.GA8249@Dell>
References: <20181206095648.GA8249@Dell>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 10:56:48 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> These interrupt functions are already non-attachable by kprobes.
> Blacklist them explicitly so that they can show up in
> /sys/kernel/debug/kprobes/blacklist and tools like BCC can use this
> additional information.
> 
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>

For the short term, this is OK. But this is not the best way to cover
other functions which are also prohibited by arch_within_kprobe_blacklist().
I'll fix this issue later.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  arch/x86/entry/entry_64.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index ce25d84023c0..1f0efdb7b629 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -566,6 +566,7 @@ ENTRY(interrupt_entry)
>  
>  	ret
>  END(interrupt_entry)
> +_ASM_NOKPROBE(interrupt_entry)
>  
>  
>  /* Interrupt entry/exit. */
> @@ -766,6 +767,7 @@ native_irq_return_ldt:
>  	jmp	native_irq_return_iret
>  #endif
>  END(common_interrupt)
> +_ASM_NOKPROBE(common_interrupt)
>  
>  /*
>   * APIC interrupts.
> @@ -780,6 +782,7 @@ ENTRY(\sym)
>  	call	\do_sym	/* rdi points to pt_regs */
>  	jmp	ret_from_intr
>  END(\sym)
> +_ASM_NOKPROBE(\sym)
>  .endm
>  
>  /* Make sure APIC interrupt handlers end up in the irqentry section: */
> @@ -960,6 +963,7 @@ ENTRY(\sym)
>  
>  	jmp	error_exit
>  	.endif
> +_ASM_NOKPROBE(\sym)
>  END(\sym)
>  .endm
>  
> -- 
> 2.17.1


-- 
Masami Hiramatsu <mhiramat@kernel.org>
