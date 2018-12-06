Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2589FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14EF20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOb/y+96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14EF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeLFOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:09:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37225 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeLFOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:09:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so1171170wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 06:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o+Hi5qCu1RLhwE+bPLc/5fSsJZ+tnZVQIQpuolGNy+I=;
        b=QOb/y+96Q7IteY/fkJLo/FOu/I+/Jb5bFWJhFIHgRf+yYO6ntmupLCcUbcM3sliKY6
         gvn53nnFJIrS2KgQXJGITmUE16w0pz86fzm1ardMfOz/7nb5pt8dv3CeKk3GU4d/ZqoY
         hXXrD5o6czjIspu3J6g/Mr08JNMmh12TmlSqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+Hi5qCu1RLhwE+bPLc/5fSsJZ+tnZVQIQpuolGNy+I=;
        b=Cc83gLfDZBhGNDIQOmVTj5whe/hT4Gom6pmO3gNnmGj8kJEkCrLB02k5jaHS5CHuah
         66hy5uraUiQwYtmMUu2+M9o1p8ERGwDTY3txJ6UgpV2mG/icUgAsn1pKtp8LPWzMB2qK
         Oo/XfAWgUAzRoxrF2ElsEhG6gp0uQ1mB5SiRi6MVIdLRBiG5zzFXn8o9uxiZCboEzDAU
         KADghnJ/yT/kFeUAQEEdMTYY5XtRi3dr9rHlgW2rWgUsM8b0RpVdbx+lYZ+zKtrES69G
         yw8iszwYpz2KbHuJi8BDUQm2QqmLQbTryK21ch66rPicvGnnwn32j5OQH1oHT/uctcyt
         TJpw==
X-Gm-Message-State: AA+aEWa2/wWEk56GXSuhZJ1Jn7GCU0l8yDHugMYrdxOUgyeeVohxjnNj
        AExcAWOaWzfVoXYxvPqP7FnuRw==
X-Google-Smtp-Source: AFSGD/UQuiS5csAvXCzX7Gg/NJF+Mb7FYKtRsrKksKqVmjR5yEOe8mkXTbm+LRpso34mCUfFdz199w==
X-Received: by 2002:a1c:8089:: with SMTP id b131mr20179449wmd.141.1544105346072;
        Thu, 06 Dec 2018 06:09:06 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t5sm1380222wmd.15.2018.12.06.06.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 06:09:05 -0800 (PST)
Date:   Thu, 6 Dec 2018 14:09:02 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
Message-ID: <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:41:09AM +0000, Christophe Leroy wrote:
> MIPS is the only architecture modifying arch_kgdb_ops during init.
> This patch makes the init static, so that it can be changed to
> const in following patch, as recommended by checkpatch.pl
> 
> Suggested-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

From my side this is
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Since this is a dependency for the next patch I'd be happy to take via
my tree... but would need an ack from the MIPS guys to do that.


Daniel.

> ---
>  arch/mips/kernel/kgdb.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index eb6c0d582626..31eff1bec577 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -394,18 +394,16 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  	return -1;
>  }
>  
> -struct kgdb_arch arch_kgdb_ops;
> +struct kgdb_arch arch_kgdb_ops = {
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	.gdb_bpt_instr = { spec_op << 2, 0x00, 0x00, break_op },
> +#else
> +	.gdb_bpt_instr = { break_op, 0x00, 0x00, spec_op << 2 },
> +#endif
> +};
>  
>  int kgdb_arch_init(void)
>  {
> -	union mips_instruction insn = {
> -		.r_format = {
> -			.opcode = spec_op,
> -			.func	= break_op,
> -		}
> -	};
> -	memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
> -
>  	register_die_notifier(&kgdb_notifier);
>  
>  	return 0;
> -- 
> 2.13.3
> 
