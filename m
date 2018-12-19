Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCF4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C45F217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdUJ7NxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbeLSQ5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:57:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34487 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeLSQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:57:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so9975048wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+bPgt6SnPDP0a4iYjPYGvwAQx/u+oM+zOzt+Sj62ZI=;
        b=TdUJ7NxQU18/CR8M37OgvTsSJnNBt8JiTVfWx+XFGuv2kFDhUzRIOLKtLp4+yD6Xwc
         2oydFOVxuY8MA1x43P7gMgXV6dwt/SxlX1uV1mzJkUoeplJFbAFqywD2cAOKH88ZjAho
         1vQW45WF0HsRCqVNO1Pc7MeteQj97v+P4f78I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y+bPgt6SnPDP0a4iYjPYGvwAQx/u+oM+zOzt+Sj62ZI=;
        b=ruIpNs4Oi34vN2z99dWRc6lA9uHrCaynAvb7gQ50xfviTOmvUO057Nh8IZdGtVNeZx
         wk729WBFnobo05m6JNDCpE2nOKJHvn2NRBmsTdF/qjZvrPyrBpnW9ksPULNMSKVIU62a
         1dla24BRJ9u1K38qSDShD7dBJMKwvvDRMIiZcjttI5UKf4ba6KKAbdAHF7ieVcAv4IB/
         UPJoGPzcBTht3glOWVldqGUedR1G9vucBj3+jRrywqH2Fk8OKT3J0KTm4ZRZ9GI2mlBc
         jTn/U5w5PwshIrbCp4nlQ/yCHhJIQgdqsYrNtTzo4ZJkKaGZ1yS2jHcu3Pt2orS41VNn
         mSTg==
X-Gm-Message-State: AA+aEWYRTLAeFgRl3aNvtV3/ahPsn9fABl1cOxRJ0GjpQBWTXxW/idV6
        1GkIPG27KuxEuA08sCWx1PVe8g==
X-Google-Smtp-Source: AFSGD/Weig2beB3bbklgteert1ntuMy9qPH6WUTndGEM3nzDLBKHSvnwFBVV8vJQtAjgE/o+rTWxSQ==
X-Received: by 2002:a1c:8089:: with SMTP id b131mr8035753wmd.141.1545238641603;
        Wed, 19 Dec 2018 08:57:21 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a17sm6236218wrs.58.2018.12.19.08.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 08:57:20 -0800 (PST)
Date:   Wed, 19 Dec 2018 16:57:18 +0000
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
Subject: Re: [PATCH v2 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
Message-ID: <20181219165718.tf5ly7yg5es7bvum@holly.lan>
References: <030d63848e4b0ef4d76ca24597ab8302a393d692.1544083483.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030d63848e4b0ef4d76ca24597ab8302a393d692.1544083483.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:07:38PM +0000, Christophe Leroy wrote:
> MIPS is the only architecture modifying arch_kgdb_ops during init.
> This patch makes the init static, so that it can be changed to
> const in following patch, as recommended by checkpatch.pl
> 
> Suggested-by: Paul Burton <paul.burton@mips.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied! Thanks.


> -
> ---
>  v2: Added acks from Daniel and Paul.
> 
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
