Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeCZRsy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:48:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33064 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752627AbeCZRsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:48:52 -0400
Date: Mon, 26 Mar 2018 19:48:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/10] x86/microcode/AMD: Check microcode container
 file size before accessing it
Message-ID: <20180326174759.GD28372@pd.tnic>
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
 <e0376cb1-3eb0-9d37-9097-558f8469e42a@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0376cb1-3eb0-9d37-9097-558f8469e42a@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:08:24AM +0100, Maciej S. Szmigiero wrote:
> The early loader parse_container() function should check whether the
> microcode container file is actually large enough to contain the patch of
> an indicated size, just like the late loader does.
> 
> Also, the request_microcode_amd() function should check whether the
> container file is actually large enough to contain the header magic value.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 4d2116d08754..dc5ed4971879 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -125,6 +125,9 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
>  		struct microcode_amd *mc;
>  		u32 patch_size;
>  
> +		if (size < SECTION_HDR_SIZE)
> +			break;
> +
>  		hdr = (u32 *)buf;
>  
>  		if (hdr[0] != UCODE_UCODE_TYPE)
> @@ -139,6 +142,10 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
>  		buf  += SECTION_HDR_SIZE;
>  		size -= SECTION_HDR_SIZE;
>  
> +		if (size < sizeof(*mc) ||
> +		    size < patch_size)
> +			break;

If you're going to do this here, then call verify_patch_size() but move
the pr_err("patch size mismatch\n") outside of the function because
printk doesn't work that early.

> +
>  		mc = (struct microcode_amd *)buf;
>  		if (eq_id == mc->hdr.processor_rev_id) {
>  			desc->psize = patch_size;
> @@ -794,6 +801,10 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
>  	}
>  
>  	ret = UCODE_ERROR;
> +	if (fw->size < sizeof(u32)) {
> +		pr_err("microcode container far too short\n");
> +		goto fw_release;
> +	}

Instead of doing that here, do the SECTION_HDR_SIZE check above here
directly.

In general, the code is getting interspersed with a lot of checks and
thus becoming unreadable. So instead of doing that, I'd suggest you add
functions doing that checking separately:

verify_container()
verify_equivalence_table()
verify_patch()

and you call those functions in both paths, first when you get a
container, you do verify_container(), then you verify the equivalence
table and then you verify each patch one after the other. And so on.

The early path will not printk because it is too early but you can state
that with a "bool early" argument to those functions.

This way you'll pull all that checking before the code looks at the
binary data and the paths will remain unencumbered by the checking code.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
