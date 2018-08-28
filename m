Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B39FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BFF2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0ebp22GA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BFF2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeH2D01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbeH2D01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:26:27 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9E52087D;
        Tue, 28 Aug 2018 23:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535499149;
        bh=UmL00Yaksy0hl3YcTc1u6uHjx3BKzGNCkF9oYb2qTP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0ebp22GABwKs8oiiujqXRy0aA2rFh9cVP2ZbGmhHRF+cJ7Gp2MVqISPZDmALjopBH
         ZVJE5Dlz7N2m5LfdiIkFwm9QHA9yz0RfViCJKtrpMn513GsKkmymgd/9PANXCEUki+
         +kotR/dPM/GitAB1YZJGBqzkvQeygoe9QRgo7U48=
Date:   Wed, 29 Aug 2018 08:32:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/7] x86: refactor kprobes_fault() like
 kprobe_exceptions_notify()
Message-Id: <20180829083224.6b01b8f04872855d90c4786a@kernel.org>
In-Reply-To: <20180828201421.157735-2-jannh@google.com>
References: <20180828201421.157735-1-jannh@google.com>
        <20180828201421.157735-2-jannh@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 22:14:15 +0200
Jann Horn <jannh@google.com> wrote:

> This is an extension of commit b506a9d08bae ("x86: code clarification patch
> to Kprobes arch code"). As that commit explains, even though
> kprobe_running() can't be called with preemption enabled, you don't have to
> disable preemption - if preemption is on, you can't be in a kprobe.
> 
> Also, use X86_TRAP_PF instead of 14.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> v3:
>  - avoid unnecessary branch on return value and split up the checks
>    (Borislav Petkov)
> 
>  arch/x86/mm/fault.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index b9123c497e0a..bcdaae1d5bf5 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -44,17 +44,19 @@ kmmio_fault(struct pt_regs *regs, unsigned long addr)
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
> +	if (!kprobes_built_in())
> +		return 0;
> +	if (user_mode(regs))
> +		return 0;
> +	/*
> +	 * To be potentially processing a kprobe fault and to be allowed to call
> +	 * kprobe_running(), we have to be non-preemptible.

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> +	 */
> +	if (preemptible())
> +		return 0;
> +	if (!kprobe_running())
> +		return 0;
> +	return kprobe_fault_handler(regs, X86_TRAP_PF);
>  }
>  
>  /*
> -- 
> 2.19.0.rc0.228.g281dcd1b4d0-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
