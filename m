Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76802133F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XPSmlqgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76802133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeK0K3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:29:22 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49820 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeK0K3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3iSTjG1yC6ch/Dv/OjBPe0aHzhKAk+o2Mq0b66JIxvA=; b=XPSmlqgdChu6pWMj55vCodQd6
        fIUg9p0l6hBVAJrYFZZ0qg97FCatHGfKaJYMnP2ss1vOcGotgLt/b2Owfa/FHTP0b6baY2UfUTaSK
        u4KgGBVK0oVbAVBeHo7NO5AYol/D0HxEV/5JzBvewhtTluCAmYXTlh49S5aitQTfyaHPQ=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:39276)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gRQNO-0003d2-Oz; Mon, 26 Nov 2018 23:33:14 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gRQNI-00048M-7y; Mon, 26 Nov 2018 23:33:08 +0000
Date:   Mon, 26 Nov 2018 23:33:03 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: always update thread_info->syscall
Message-ID: <20181126233303.GZ30658@n2100.armlinux.org.uk>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126225335.10477-1-rafael.tinoco@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 08:53:35PM -0200, Rafael David Tinoco wrote:
> Right now, only way for task->thread_info->syscall to be updated is if
> if _TIF_SYSCALL_WORK is set in current's task thread_info->flags
> (similar to what has_syscall_work() checks for arm64).
> 
> This means that "->syscall" will only be updated if we are tracing the
> syscalls through ptrace, for example. This is NOT the same behavior as
> arm64, when pt_regs->syscallno is updated in the beginning of svc0
> handler for *every* syscall entry.

So when was it decided that the syscall number will always be required
(we need it to know how far back this has to be backported).

> This patch fixes the issue since this behavior is needed for
> /proc/<pid>/syscall 1st argument to be correctly updated.
> 
> Link: https://bugs.linaro.org/show_bug.cgi?id=3783
> Cc: <stable@vger.kernel.org> # v4.4 v4.9 v4.14 v4.19
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
>  arch/arm/kernel/asm-offsets.c  | 1 +
>  arch/arm/kernel/entry-common.S | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 3968d6c22455..bfe68a98e1c6 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -64,6 +64,7 @@ int main(void)
>    DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
>    DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
>    DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
> +  DEFINE(TI_SYSCALL,		offsetof(struct thread_info, syscall));
>  #ifdef CONFIG_VFP
>    DEFINE(TI_VFPSTATE,		offsetof(struct thread_info, vfpstate));
>  #ifdef CONFIG_SMP
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 0465d65d23de..557e2add4e83 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -257,6 +257,8 @@ local_restart:
>  	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
>  	bne	__sys_trace
>  
> +	str	r7, [tsk, #TI_SYSCALL]		@ update thread_info->syscall

"scno" is the systemcall number, not "r7".

> +
>  	invoke_syscall tbl, scno, r10, __ret_fast_syscall
>  
>  	add	r1, sp, #S_OFF
> -- 
> 2.20.0.rc1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
