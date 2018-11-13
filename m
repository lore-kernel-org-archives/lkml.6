Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC239C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9853820811
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9853820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeKMUO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:14:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59906 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731708AbeKMUO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:14:28 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c-rJV_2d9e5V; Tue, 13 Nov 2018 11:17:01 +0100 (CET)
Received: from zn.tnic (p200300EC2BE56F00D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:6f00:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 960C01EC00CD;
        Tue, 13 Nov 2018 11:17:01 +0100 (CET)
Date:   Tue, 13 Nov 2018 11:17:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, bp@suse.de
Subject: Re: [PATCH] x86/irq: Fix -Wmissing-prototypes warning for init_IRQ()
Message-ID: <20181113101701.GB10502@zn.tnic>
References: <1542074189-3208-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1542074189-3208-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 09:56:29AM +0800, Yi Wang wrote:
> We get a warning when building kernel with W=1:
> arch/x86/kernel/irqinit.c:79:13: warning: no previous prototype for ‘init_IRQ’ [-Wmissing-prototypes]
>  void __init init_IRQ(void)
>              ^
> 
> Add the missing declaration in head file to fix this.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  arch/x86/include/asm/irq.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
> index 2395bb7..399a9c5 100644
> --- a/arch/x86/include/asm/irq.h
> +++ b/arch/x86/include/asm/irq.h
> @@ -41,6 +41,8 @@ static inline int irq_canonicalize(int irq)
>  
>  extern void init_ISA_irqs(void);
>  
> +extern void __init init_IRQ(void);
> +
>  #ifdef CONFIG_X86_LOCAL_APIC
>  void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
>  				    bool exclude_self);
> -- 

I'm not sure we should do one patch per warning - that's too granulary.
What I did earlier was this:

make allmodconfig
make W=1 arch/x86/kernel/apic/

and then looked at all those -Wmissing-prototypes warnings.

Once I've fixed them, I commit the result as a

  x86/apic: Fix -Wmissing-prototypes warnings

and this way it is more or less per subsystem or folder or whatever,
which still keeps the amount of patches sane for further handling.

Now, I did some fixes here so I'd suggest you do all your patches ontop
of tip/master after merging this branch into it:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-ras-core

I'll push it into tip the next days.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
