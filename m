Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFAFC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932B620837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932B620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeFUIg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:36:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49746 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeFUIgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:36:54 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c1rO207jt-lP; Thu, 21 Jun 2018 10:36:52 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD18C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 774AD1EC00E4;
        Thu, 21 Jun 2018 10:36:52 +0200 (CEST)
Date:   Thu, 21 Jun 2018 10:36:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/9] x86/microcode/AMD: Integrate verify_patch_size()
 into verify_patch()
Message-ID: <20180621083649.GC12742@zn.tnic>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
 <39d0efb50538e4a1a06da693559bb13b060ad676.1529424596.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39d0efb50538e4a1a06da693559bb13b060ad676.1529424596.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 08:47:33PM +0200, Maciej S. Szmigiero wrote:
> Integrating verify_patch_size() into verify_patch() allows us to check
> whether the indicated patch size makes sense for its indicated CPU family -
> for all CPU families known to the driver.
> 
> If we spot a patch that is longer than expected for its family we'll
> carefully skip over only the expected length to make sure we don't miss
> good patches in case the indicated patch size was something nonsensically
> huge.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 131 ++++++++++++----------------
>  1 file changed, 57 insertions(+), 74 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 120778771909..67147e784c0e 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -176,9 +176,6 @@ static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
>  	return true;
>  }
>  
> -static unsigned int verify_patch_size(u8 family, u32 patch_size,
> -				      unsigned int size);
> -
>  /*
>   * Check whether there is a valid, non-truncated microcode patch of the
>   * right size for a particular family @family at the beginning of a passed
> @@ -192,7 +189,7 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
>  			 unsigned int *crnt_size, bool early)
>  {
>  	const u32 *hdr;
> -	u32 patch_size;
> +	u32 patch_size, max_size;
>  	const struct microcode_header_amd *mc_hdr;
>  	u8 patch_fam;
>  
> @@ -204,48 +201,79 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
>  	hdr = (const u32 *)buf;
>  	patch_size = hdr[1];
>  
> -	if (buf_size - SECTION_HDR_SIZE < patch_size) {
> +	if (buf_size - SECTION_HDR_SIZE < sizeof(*mc_hdr)) {
>  		if (!early)
> -			pr_err("Patch of size %u truncated.\n", patch_size);
> +			pr_err("Truncated patch header.\n");
>  
>  		*crnt_size = buf_size;
>  		return false;
>  	}
>  
> +	mc_hdr = (const struct microcode_header_amd *)(buf + SECTION_HDR_SIZE);
> +	patch_fam = 0xf + (mc_hdr->processor_rev_id >> 12);
> +
>  	/*
> -	 * Set a patch length limit of slightly less than U32_MAX to
> -	 * prevent overflowing 32-bit variables holding the whole
> -	 * patch section size.
> +	 * Check whether patch_size isn't something nonsensically huge so
> +	 * we don't skip over good patches by mistake.
>  	 */
> -	if (patch_size > U32_MAX - SECTION_HDR_SIZE) {
> -		if (!early)
> -			pr_err("Patch of size %u too large.\n", patch_size);
> +#define F1XH_MPB_MAX_SIZE 2048
> +#define F14H_MPB_MAX_SIZE 1824
> +#define F15H_MPB_MAX_SIZE 4096
> +#define F16H_MPB_MAX_SIZE 3458
> +#define F17H_MPB_MAX_SIZE 3200
>  
> -		*crnt_size = SECTION_HDR_SIZE + PATCH_MAX_SIZE;
> -		return false;
> +	switch (patch_fam) {
> +	case 0x10 ... 0x13:

This is not how you integrate a function into another one.

In the first patch, you move the code verbatim to the place where you
want it to be, without adding any other changes whatsoever. The diff
needs to show code movement only.

In follow-on patches you do the other changes you've done and you
explain why.

But no need to resend the whole series - just split this patch as
suggested and send the new ones as a reply to this subthread.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
