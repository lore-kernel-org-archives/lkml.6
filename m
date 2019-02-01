Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D0FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE6921906
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="NtnQo2if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfBALPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:15:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43340 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfBALPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:15:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so2795271pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 03:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LSzDlZv323/q3C6FtrsuqsUIdqqY+il5tYTL1WWA5tI=;
        b=NtnQo2ifvR49tH9d8k0TDPo41pb8dpEHtdmM/QhHQInVkQjjvRei/9fX7KLl6m135/
         ADzG3ugWRg1HpctZN+QgWVh685h7+r7kWYWAYsGD147YA3hR0DSllp7gkgZwyHi6CoIj
         cpqcgRCpT0No1OUmpbK24PT24/78QcLw80AQfneM5iy00/sNSyr3B7zMYvqmpcUb+dQn
         rKxUggbxS+oN6qMmPNSzK+it4bac3SlCbV9FbwncKa0qkFeVMjVS4llm1pxJy7NI7Hqf
         va7hDun5jrbU4ZsfOpNXVrzd5QfVr/ovwuKnsGV/zbtwNwAdy9id8SnEZpNJmYuKE1Hk
         9F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSzDlZv323/q3C6FtrsuqsUIdqqY+il5tYTL1WWA5tI=;
        b=QD3WhBJXdqCIwqsk+42ES3WBduDh3sSkYTygXDGBG0N0neCWxDXkUF9O3WVk2v7hCQ
         zX/XjvTMCU1HXah+A1pI+U8hSyuliAbytfMxjpHglUVAM8WUq7YrEeUGVsu6Fer3XZ9t
         43xWlx23k5epoJmuwWSEcyNEWn0m1CrTBfxv4GtzUqPPkW1rs9Tt9zG1EsvaiMz85XFx
         xWE6SpnmtH0abq4psYblvotugVJLsfcF+g+LaTciRnuBxhqMSp4wEiNDWNwEhA79ualg
         91Vx32rxfCoNb72GjXEdNhmJkbhHsw20ootGiWU3iyHqPJgH0O+TDdJ2+PScOyn80fR3
         0PUg==
X-Gm-Message-State: AJcUukcEdEphAT7VTA6R0NlkywxKTH8yAqCwIeV12kD5R9byUWoSUbmM
        Nlcph41fyVwA/KJP42QP0ydFMw==
X-Google-Smtp-Source: ALg8bN4bhsOFkj/x9lVReIb8TAwC+EFgT92457UkM5owzRlZmZH9iA9kr63jM0Kiy+NLnMBQZQdA+A==
X-Received: by 2002:a62:178f:: with SMTP id 137mr38496765pfx.226.1549019737256;
        Fri, 01 Feb 2019 03:15:37 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id z10sm10170639pfg.120.2019.02.01.03.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 03:15:36 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 72BEB30A169; Fri,  1 Feb 2019 14:15:32 +0300 (+03)
Date:   Fri, 1 Feb 2019 14:15:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Garnier <thgarnie@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/27] x86/boot/64: Build head64.c as mcmodel large
 when PIE is enabled
Message-ID: <20190201111532.3oszgzj4grdyej5q@kshutemo-mobl1>
References: <20190131192533.34130-1-thgarnie@chromium.org>
 <20190131192533.34130-14-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131192533.34130-14-thgarnie@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:24:20AM -0800, Thomas Garnier wrote:
> The __startup_64 function assumes all symbols have relocated addresses
> instead of the current boot virtual address. PIE generated code favor
> relative addresses making all virtual and physical address math incorrect.
> If PIE is enabled, build head64.c as mcmodel large instead to ensure absolute
> references on all memory access. Add a global __force_order variable required
> when using a large model with read_cr* functions.
> 
> To build head64.c as mcmodel=large, disable the retpoline gcc flags.
> This code is used at early boot and removed later, it doesn't need
> retpoline mitigation.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> ---
>  arch/x86/kernel/Makefile | 6 ++++++
>  arch/x86/kernel/head64.c | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 00b7e27bc2b7..1f98f52eab9f 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -22,6 +22,12 @@ CFLAGS_REMOVE_early_printk.o = -pg
>  CFLAGS_REMOVE_head64.o = -pg
>  endif
>  
> +ifdef CONFIG_X86_PIE
> +# Remove PIE and retpoline flags that are incompatible with mcmodel=large
> +CFLAGS_REMOVE_head64.o += -fPIE -mindirect-branch=thunk-extern -mindirect-branch-register
> +CFLAGS_head64.o = -mcmodel=large
> +endif
> +
>  KASAN_SANITIZE_head$(BITS).o				:= n
>  KASAN_SANITIZE_dumpstack.o				:= n
>  KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 16b1cbd3a61e..22e81275495b 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -63,6 +63,9 @@ EXPORT_SYMBOL(vmemmap_base);
>  
>  #define __head	__section(.head.text)
>  
> +/* Required for read_cr3 when building as PIE */
> +unsigned long __force_order;
> +

I believe it only needed for GCC < 5. Newer GCC can eliminate the
reference. See my comment in arch/x86/boot/compressed/pgtable_64.c.

Maybe we should expand the comment here too?

-- 
 Kirill A. Shutemov
