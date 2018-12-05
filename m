Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43074C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041DD20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9HnlLLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041DD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeLENtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:49:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbeLENtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:49:11 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5572081C;
        Wed,  5 Dec 2018 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544017750;
        bh=t3NuYITez6BCumKON0YXMBsRCi2j7qNU9slpLTviDKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s9HnlLLFN+GtHtEUj+MrZguzMqvn4RW1LppBeirEZT4XirrnrklNFXtQCwTn2MRkr
         M2E6s5dkwiQHgKzgMr5p/EyjyXTLDJxUP63etdD3aQNa5Ry2d+8OhPcWb3BoDyF32Q
         5eXOiFNeItbTXIx1mzbndQ1b6AJj8phAZ8k92aPI=
Date:   Wed, 5 Dec 2018 22:49:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Travis <mike.travis@hpe.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Message-Id: <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
In-Reply-To: <20181205101131.28996-1-bp@alien8.de>
References: <20181205101131.28996-1-bp@alien8.de>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Wed,  5 Dec 2018 11:11:31 +0100
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> ... with the goal of eventually enabling -Wmissing-prototypes by
> default. At least on x86.
> 
> Make functions static where possible, otherwise add prototypes or make
> them visible through includes.

OK, and I have some comments for kprobe's parts.

[...]
> diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
> index 2b949f4fd4d8..f0fc628c4bb7 100644
> --- a/arch/x86/kernel/kprobes/common.h
> +++ b/arch/x86/kernel/kprobes/common.h
> @@ -91,6 +91,8 @@ extern int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn);
>  extern void synthesize_reljump(void *dest, void *from, void *to);
>  extern void synthesize_relcall(void *dest, void *from, void *to);
>  
> +extern void *trampoline_handler(struct pt_regs *regs);
> +

I would like to put this prototype inside arch/x86/kernel/kprobes/core.c,
since that is locally used.

>  #ifdef	CONFIG_OPTPROBES
>  extern int setup_detour_execution(struct kprobe *p, struct pt_regs *regs, int reenter);
>  extern unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsigned long addr);
[...]
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index e909413e4e38..91d19d6a2892 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -379,6 +379,9 @@ int enable_kprobe(struct kprobe *kp);
>  
>  void dump_kprobe(struct kprobe *kp);
>  
> +void __weak *alloc_insn_page(void);
> +void __weak free_insn_page(void *page);

Should we declare prototypes for __weak functions? Anyway, we should remove
__weak from the prototypes.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
