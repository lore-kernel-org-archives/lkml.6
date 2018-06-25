Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C64BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18C02602F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18C02602F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964984AbeFYShO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:37:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964851AbeFYShN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:37:13 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CwrO0-X5SQ6F; Mon, 25 Jun 2018 20:37:12 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA5B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:5b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D334E1EC02AE;
        Mon, 25 Jun 2018 20:37:11 +0200 (CEST)
Date:   Mon, 25 Jun 2018 20:37:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/microcode/AMD: Check patch size for all known
 CPU families
Message-ID: <20180625183709.GA3024@zn.tnic>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
 <39d0efb50538e4a1a06da693559bb13b060ad676.1529424596.git.mail@maciej.szmigiero.name>
 <20180621083649.GC12742@zn.tnic>
 <a2275167-f650-b73f-0de8-1aa78b3281ed@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2275167-f650-b73f-0de8-1aa78b3281ed@maciej.szmigiero.name>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 12:33:24AM +0200, Maciej S. Szmigiero wrote:
> Previously, the AMD microcode update driver has only checked the indicated
> microcode patch size for patches for the currently running CPU family.
> Patches for other families had their size trusted without further
> verification.
> 
> Introduce such check for all CPU families known to the driver so if we spot
> a patch that is longer than expected for its family we'll carefully skip
> over only the expected length to make sure we don't miss good patches in
> case the indicated patch size was something nonsensically huge.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
> This is part 2/2 of a replacement for
> "[PATCH v7 3/9] x86/microcode/AMD: Integrate verify_patch_size() into verify_patch()".
> 
>  arch/x86/kernel/cpu/microcode/amd.c | 67 ++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 53820b92aabb..04a298da4c21 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -201,43 +201,31 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
>  	hdr = (const u32 *)buf;
>  	patch_size = hdr[1];
>  
> -	if (buf_size - SECTION_HDR_SIZE < patch_size) {
> +	if (buf_size - SECTION_HDR_SIZE < sizeof(*mc_hdr)) {

This function adds and removes SECTION_HDR_SIZE a bunch of times so that
my head spins trying to remind myself which is which. Please define
properly named local variables.

>  		if (!early)
> -			pr_err("Patch of size %u truncated.\n", patch_size);
> +			pr_err("Truncated patch header.\n");
>  
>  		*crnt_size = buf_size;
>  		return false;
>  	}
>  
> -	/*
> -	 * Set a patch length limit of slightly less than U32_MAX to
> -	 * prevent overflowing 32-bit variables holding the whole
> -	 * patch section size.
> -	 */
> -	if (patch_size > U32_MAX - SECTION_HDR_SIZE) {
> -		if (!early)
> -			pr_err("Patch of size %u too large.\n", patch_size);
> -
> -		*crnt_size = SECTION_HDR_SIZE + PATCH_MAX_SIZE;
> -		return false;
> -	}
> -
> -	*crnt_size = SECTION_HDR_SIZE + patch_size;
> -
>  	mc_hdr = (const struct microcode_header_amd *)(buf + SECTION_HDR_SIZE);
>  	patch_fam = 0xf + (mc_hdr->processor_rev_id >> 12);
>  
> -	/* Is the patch for the proper CPU family? */
> -	if (family != patch_fam)
> -		return false;
> -
> +	/*
> +	 * Check whether patch_size isn't something nonsensically huge so
> +	 * we don't skip over good patches by mistake.
> +	 */
>  #define F1XH_MPB_MAX_SIZE 2048
>  #define F14H_MPB_MAX_SIZE 1824
>  #define F15H_MPB_MAX_SIZE 4096
>  #define F16H_MPB_MAX_SIZE 3458
>  #define F17H_MPB_MAX_SIZE 3200
>  
> -	switch (family) {
> +	switch (patch_fam) {
> +	case 0x10 ... 0x13:
> +		max_size = F1XH_MPB_MAX_SIZE;

I guess this variable should be called fam_size now.

> +		break;
>  	case 0x14:
>  		max_size = F14H_MPB_MAX_SIZE;
>  		break;
> @@ -251,22 +239,41 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
>  		max_size = F17H_MPB_MAX_SIZE;
>  		break;
>  	default:
> -		max_size = F1XH_MPB_MAX_SIZE;
> +		/*
> +		 * Don't know the max size for future families...
> +		 * Set a patch length limit of slightly less than U32_MAX to
> +		 * prevent overflowing 32-bit variables holding the whole
> +		 * patch section size.
> +		 */
> +		max_size = U32_MAX - SECTION_HDR_SIZE;

No, just do a WARN_ON_ONCE here.

>  		break;
>  	}
>  
> -	/*
> -	 * The section header length is not included in this indicated size
> -	 * but is present in the leftover file length so we need to subtract
> -	 * it from the leftover file length.
> -	 */
> -	if (patch_size > min_t(u32, buf_size - SECTION_HDR_SIZE, max_size)) {
> +	if (patch_size > max_size) {
> +		if (!early)
> +			pr_err("Patch of size %u exceeds family %u maximum.\n",
> +			       patch_size, (unsigned int)patch_fam);
> +
> +		*crnt_size = min_t(unsigned int,
> +				   SECTION_HDR_SIZE + max_size,
> +				   buf_size);
> +		return false;
> +	}
> +
> +	if (buf_size - SECTION_HDR_SIZE < patch_size) {
>  		if (!early)
> -			pr_err("Patch of size %u too large.\n", patch_size);
> +			pr_err("Patch of size %u truncated.\n", patch_size);
>  
> +		*crnt_size = buf_size;
>  		return false;
>  	}
>  
> +	*crnt_size = SECTION_HDR_SIZE + patch_size;
> +
> +	/* Is the patch for the proper CPU family? */
> +	if (family != patch_fam)
> +		return false;

Why are you moving the family check down?

What it should do instead is the moment it knows the family, check
whether they're equal. If not, skip over with minimum of the size of the
corresponding patch_fam and buf_size.

And then you do all the remaining checks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
