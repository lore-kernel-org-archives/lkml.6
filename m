Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71FEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A52F2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A52F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeJBGAC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:00:02 -0400
Received: from ozlabs.org ([203.11.71.1]:58571 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeJBGAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:00:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 42PJCV4K3Sz9s3l;
        Tue,  2 Oct 2018 09:19:50 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 872E9EE78BF; Tue,  2 Oct 2018 09:19:50 +1000 (AEST)
Message-ID: <095ba37e883c0d2d13b442185289552ab6cd7107.camel@neuling.org>
Subject: Re: [PATCH] powerpc/lib: fix book3s/32 boot failure due to code
 patching
From:   Michael Neuling <mikey@neuling.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 02 Oct 2018 09:19:50 +1000
In-Reply-To: <6acad0a13b7f6c2845b2022737c6a11a445ed3c2.1538394860.git.christophe.leroy@c-s.fr>
References: <6acad0a13b7f6c2845b2022737c6a11a445ed3c2.1538394860.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-01 at 12:21 +0000, Christophe Leroy wrote:
> Commit 51c3c62b58b3 ("powerpc: Avoid code patching freed init
> sections") accesses 'init_mem_is_free' flag too early, before the
> kernel is relocated. This provokes early boot failure (before the
> console is active).
> 
> As it is not necessary to do this verification that early, this
> patch moves the test into patch_instruction() instead of
> __patch_instruction().
> 
> This modification also has the advantage of avoiding unnecessary
> remappings.
> 
> Fixes: 51c3c62b58b3 ("powerpc: Avoid code patching freed init sections")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Thanks

Acked-by: Michael Neuling <mikey@neuling.org>

The original patch was also marked for stable so we should do the same here.

Cc: stable@vger.kernel.org # 4.13+

> ---
>  arch/powerpc/lib/code-patching.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-
> patching.c
> index 6ae2777c220d..5ffee298745f 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -28,12 +28,6 @@ static int __patch_instruction(unsigned int *exec_addr,
> unsigned int instr,
>  {
>  	int err;
>  
> -	/* Make sure we aren't patching a freed init section */
> -	if (init_mem_is_free && init_section_contains(exec_addr, 4)) {
> -		pr_debug("Skipping init section patching addr: 0x%px\n",
> exec_addr);
> -		return 0;
> -	}
> -
>  	__put_user_size(instr, patch_addr, 4, err);
>  	if (err)
>  		return err;
> @@ -148,7 +142,7 @@ static inline int unmap_patch_area(unsigned long addr)
>  	return 0;
>  }
>  
> -int patch_instruction(unsigned int *addr, unsigned int instr)
> +static int do_patch_instruction(unsigned int *addr, unsigned int instr)
>  {
>  	int err;
>  	unsigned int *patch_addr = NULL;
> @@ -188,12 +182,22 @@ int patch_instruction(unsigned int *addr, unsigned int
> instr)
>  }
>  #else /* !CONFIG_STRICT_KERNEL_RWX */
>  
> -int patch_instruction(unsigned int *addr, unsigned int instr)
> +static int do_patch_instruction(unsigned int *addr, unsigned int instr)
>  {
>  	return raw_patch_instruction(addr, instr);
>  }
>  
>  #endif /* CONFIG_STRICT_KERNEL_RWX */
> +
> +int patch_instruction(unsigned int *addr, unsigned int instr)
> +{
> +	/* Make sure we aren't patching a freed init section */
> +	if (init_mem_is_free && init_section_contains(addr, 4)) {
> +		pr_debug("Skipping init section patching addr: 0x%px\n", addr);
> +		return 0;
> +	}
> +	return do_patch_instruction(addr, instr);
> +}
>  NOKPROBE_SYMBOL(patch_instruction);
>  
>  int patch_branch(unsigned int *addr, unsigned long target, int flags)
