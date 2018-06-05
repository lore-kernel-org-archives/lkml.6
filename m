Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeFEIyZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:54:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50694 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeFEIyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:54:24 -0400
Date: Tue, 5 Jun 2018 10:54:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] x86/microcode/AMD: Check microcode container data
 in the early loader
Message-ID: <20180605085427.GB1617@zn.tnic>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
 <0c53181bd5eb4e172407d9fde534cedb12e19b98.1526767245.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c53181bd5eb4e172407d9fde534cedb12e19b98.1526767245.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 12:07:17AM +0200, Maciej S. Szmigiero wrote:
> Convert the early loader in the AMD microcode update driver to use the
> container data checking functions introduced by the previous commit.
> 
> We have to be careful to call these functions with 'early' parameter set,
> so they won't try to print errors as the early loader runs too early for
> printk()-style functions to work.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 59 ++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index f9485ff7183c..f4c7479a961c 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -224,29 +224,36 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size, bool early)
>   * Returns the amount of bytes consumed while scanning. @desc contains all the
>   * data we're going to use in later stages of the application.
>   */
> -static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
> +static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
>  {
>  	struct equiv_cpu_entry *eq;
> -	ssize_t orig_size = size;
> +	size_t orig_size = size;
>  	u32 *hdr = (u32 *)ucode;
> +	u32 equiv_tbl_len;
>  	u16 eq_id;
>  	u8 *buf;
>  
> -	/* Am I looking at an equivalence table header? */
> -	if (hdr[0] != UCODE_MAGIC ||
> -	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
> -	    hdr[2] == 0)
> -		return CONTAINER_HDR_SZ;
> +	/*
> +	 * Skip one byte when a container cannot be parsed successfully
> +	 * so the parser will correctly skip unknown data of any size until
> +	 * it hopefully arrives at something that it is able to recognize.
> +	 */
> +	if (!verify_container(ucode, size, true) ||
> +	    !verify_equivalence_table(ucode, size, true))

That function already calls verify_container().

> +		return 1;
>  
>  	buf = ucode;
>  
> +	equiv_tbl_len = hdr[2];
>  	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
>  
>  	/* Find the equivalence ID of our CPU in this table: */
>  	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
>  
> -	buf  += hdr[2] + CONTAINER_HDR_SZ;
> -	size -= hdr[2] + CONTAINER_HDR_SZ;
> +	buf  += CONTAINER_HDR_SZ;
> +	buf  += equiv_tbl_len;
> +	size -= CONTAINER_HDR_SZ;
> +	size -= equiv_tbl_len;
>  
>  	/*
>  	 * Scan through the rest of the container to find where it ends. We do
> @@ -258,25 +265,27 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
>  
>  		hdr = (u32 *)buf;
>  
> -		if (hdr[0] != UCODE_UCODE_TYPE)
> +		if (!verify_patch_section(buf, size, true))
>  			break;
>  
> -		/* Sanity-check patch size. */
>  		patch_size = hdr[1];
> -		if (patch_size > PATCH_MAX_SIZE)
> -			break;
>  
> -		/* Skip patch section header: */
> -		buf  += SECTION_HDR_SIZE;
> -		size -= SECTION_HDR_SIZE;
> +		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
> +		if (eq_id != mc->hdr.processor_rev_id)
> +			goto next_patch;
>  
> -		mc = (struct microcode_amd *)buf;
> -		if (eq_id == mc->hdr.processor_rev_id) {
> -			desc->psize = patch_size;
> -			desc->mc = mc;
> -		}
> +		if (!verify_patch(x86_family(desc->cpuid_1_eax), buf, size,
> +				  true))

Let it stick out.

Ok, so above you do verify_patch_section() and then you take patch_size
without fully verifying it - it can be something non-sensically huge and
thus we might skip over good patches.

What you should do instead is call verify_patch() directly - which
already calls verify_patch_section() and if the patch size exceeds the
per-family maximum, return *that* instead and skip only the per family
maximum inside the buffer so that any patches following can get a chance
to get inspected.

For that you'll have to reshuffle the change of integrating
verify_patch_size() to happen before that change here.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
