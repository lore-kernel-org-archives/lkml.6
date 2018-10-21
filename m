Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B8AECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF9520658
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IZdkW6tZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF9520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeJVE6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:58:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59214 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeJVE6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QL+jA+jVMjmOCldDrFZZQUY5L34QyAt5NNuevKFQrd8=; b=IZdkW6tZbbP3Bq5XP4JvhAkio/
        a2322HPfV2fFSJX2j+31pytak3Ti0YnkUTEBUQxQwNd9j0aMSKOB4R3SNoA2ipEnYAZr1BP87xlpw
        IaPS4L+QEkh/riqB56S0C9W6vfanGoo4UAPSeybE659/BOJaWW8E81DKDTkWeMcAkzrbdGMf7omq3
        Zt+tZOkG1OGIdStJnRXEKswk507lA5VPuC625/LrcfqmeIzXjhVJrow+0BnEEfWyyV3AzQMwpe/PD
        4j0YHPsJafEUrQoJgYqvON1wLAwmvtS8O4/h0WsyTdXzoeBb8sQRGgEt00Z5O0i3cmhZk3osMH94p
        gLuo8jPw==;
Received: from [167.98.65.38] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEKYJ-0001oc-EL; Sun, 21 Oct 2018 20:42:23 +0000
Received: by worktop (Postfix, from userid 1000)
        id B72F46E0B3A; Sun, 21 Oct 2018 22:42:29 +0200 (CEST)
Date:   Sun, 21 Oct 2018 22:42:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip] kprobes/x86: Use preempt_enable() in
 optimized_callback()
Message-ID: <20181021204229.GI4931@worktop.programming.kicks-ass.net>
References: <154002887331.7627.10194920925792947001.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154002887331.7627.10194920925792947001.stgit@devbox>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 06:47:53PM +0900, Masami Hiramatsu wrote:
> Since commit a19b2e3d7839 ("kprobes/x86: Remove IRQ disabling from
> ftrace-based/optimized kprobes”) removes local_irq_save/restore()
> from optimized_callback(), the handler does not protected against
> reschedule interrupt. If it is able to be preempted (rescheduled)
> by such interrupt, we don't need to use _no_resched macro.

must not.

> Let's use preempt_enable() instead.
> 
> Fixes: a19b2e3d7839 ("kprobes/x86: Remove IRQ disabling from ftrace-based/optimized kprobes”)
> Link: https://lkml.kernel.org/r/37CB98C2-AF9B-475B-8B2D-7B414DC491F3@vmware.com
> Reported-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/kprobes/opt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index eaf02f2e7300..40b16b270656 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -179,7 +179,7 @@ optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
>  		opt_pre_handler(&op->kp, regs);
>  		__this_cpu_write(current_kprobe, NULL);
>  	}
> -	preempt_enable_no_resched();
> +	preempt_enable();
>  }

Indeed,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
