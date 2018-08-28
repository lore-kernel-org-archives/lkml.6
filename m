Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DCCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CA42087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CA42087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH1P3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:29:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33086 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH1P3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:29:31 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rcQ7ZrI5rsLJ; Tue, 28 Aug 2018 13:37:57 +0200 (CEST)
Received: from nazgul.tnic (46-10-68-224.ip.btc-net.bg [46.10.68.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 439051EC02D1;
        Tue, 28 Aug 2018 13:37:57 +0200 (CEST)
Date:   Tue, 28 Aug 2018 13:36:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        dvyukov@google.com, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 1/7] x86: refactor kprobes_fault() like
 kprobe_exceptions_notify()
Message-ID: <20180828113611.GC32231@nazgul.tnic>
References: <20180827185631.163506-1-jannh@google.com>
 <20180827185631.163506-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827185631.163506-2-jannh@google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:56:25PM +0200, Jann Horn wrote:
> This is an extension of commit b506a9d08bae ("x86: code clarification patch
> to Kprobes arch code"). As that commit explains, even though
> kprobe_running() can't be called with preemption enabled, you don't have to
> disable preemption - if preemption is on, you can't be in a kprobe.
> 
> Also, use X86_TRAP_PF instead of 14.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/x86/mm/fault.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index b9123c497e0a..2254a30533b9 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -44,17 +44,14 @@ kmmio_fault(struct pt_regs *regs, unsigned long addr)
>  
>  static nokprobe_inline int kprobes_fault(struct pt_regs *regs)
>  {
> -	int ret = 0;
> -
> -	/* kprobe_running() needs smp_processor_id() */
> -	if (kprobes_built_in() && !user_mode(regs)) {
> -		preempt_disable();
> -		if (kprobe_running() && kprobe_fault_handler(regs, 14))
> -			ret = 1;
> -		preempt_enable();
> -	}
> -
> -	return ret;
> +	/*
> +	 * To be potentially processing a kprobe fault and to be allowed to call
> +	 * kprobe_running(), we have to be non-preemptible.
> +	 */
> +	if (kprobes_built_in() && !user_mode(regs) && !preemptible() &&
> +	    kprobe_running() && kprobe_fault_handler(regs, X86_TRAP_PF))
> +		return 1;
> +	return 0;

Maybe even:

	return (kprobes_built_in() &&
		!user_mode(regs) &&
		!preemptible() &&
		kprobe_running() &&
		kprobe_fault_handler(regs, X86_TRAP_PF));

Although I'd do it a bit more readable by flipping the checks and
splitting them:

	if (!kprobes_built_in())
		return 0;

	if (user_mode(regs))
		return 0;

	...

	return kprobe_fault_handler(regs, X86_TRAP_PF);
}

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
