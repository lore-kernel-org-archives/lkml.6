Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeFEIzD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:55:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50748 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbeFEIzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:55:01 -0400
Date: Tue, 5 Jun 2018 10:54:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/8] x86/microcode/AMD: Check microcode container data
 in the late loader
Message-ID: <20180605085453.GA27701@nazgul.tnic>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
 <32c2d5a36010a7e9e538f081d4f3a8e8c94da890.1526767245.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32c2d5a36010a7e9e538f081d4f3a8e8c94da890.1526767245.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 12:07:19AM +0200, Maciej S. Szmigiero wrote:
> Convert the late loader in the AMD microcode update driver to use newly
> introduced microcode container data checking functions as it was previously
> done for the early loader.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 70 +++++++++++++----------------
>  1 file changed, 32 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index f8bd74341ed8..3e10a5920f58 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -693,28 +693,26 @@ static enum ucode_state apply_microcode_amd(int cpu)
>  	return UCODE_UPDATED;
>  }
>  
> -static int install_equiv_cpu_table(const u8 *buf)
> +static unsigned int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
>  {
> -	unsigned int *ibuf = (unsigned int *)buf;
> -	unsigned int type = ibuf[1];
> -	unsigned int size = ibuf[2];
> +	const u32 *hdr;
> +	u32 equiv_tbl_len;
>  
> -	if (type != UCODE_EQUIV_CPU_TABLE_TYPE || !size) {
> -		pr_err("empty section/"
> -		       "invalid type field in container file section header\n");
> -		return -EINVAL;
> -	}
> +	if (!verify_equivalence_table(buf, buf_size, false))
> +		return 0;
> +
> +	hdr = (const u32 *)buf;
> +	equiv_tbl_len = hdr[2];
>  
> -	equiv_cpu_table = vmalloc(size);
> +	equiv_cpu_table = vmalloc(equiv_tbl_len);
>  	if (!equiv_cpu_table) {
>  		pr_err("failed to allocate equivalent CPU table\n");
> -		return -ENOMEM;
> +		return 0;
>  	}
>  
> -	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, size);
> +	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
>  
> -	/* add header length */
> -	return size + CONTAINER_HDR_SZ;
> +	return equiv_tbl_len;
>  }
>  
>  static void free_equiv_cpu_table(void)
> @@ -739,13 +737,19 @@ static void cleanup(void)
>  static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
>  				unsigned int *crnt_size)
>  {
> +	u32 *hdr = (u32 *)fw;
>  	struct microcode_header_amd *mc_hdr;
>  	struct ucode_patch *patch;
> -	unsigned int patch_size, ret;
> +	u32 patch_size;
>  	u32 proc_fam;
>  	u16 proc_id;
>  
> -	patch_size  = *(u32 *)(fw + 4);
> +	if (!verify_patch_section(fw, leftover, false)) {
> +		*crnt_size = leftover;

I'm not sure about this: we verify the patch section and in the error
case we skip over the whole leftover buffer?

Maybe skipping over SECTION_HDR_SIZE or better yet skip 1 byte here
too, like in parse_container() to give us the highest chance of finding
something sensible later...

> +		return 0;
> +	}
> +
> +	patch_size  = hdr[1];

Same comment as before: verify_patch_size()

But I think you can simply do verify_patch() at the beginning of the
function and be done with the verification in that function.

>  	*crnt_size  = patch_size + SECTION_HDR_SIZE;
>  	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
>  	proc_id	    = mc_hdr->processor_rev_id;
> @@ -767,16 +771,8 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
>  		return 0;
>  	}
>  
> -	/*
> -	 * The section header length is not included in this indicated size
> -	 * but is present in the leftover file length so we need to subtract
> -	 * it before passing this value to the function below.
> -	 */
> -	ret = verify_patch_size(family, patch_size, leftover - SECTION_HDR_SIZE);
> -	if (!ret) {
> -		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
> +	if (!verify_patch(family, fw, leftover, false))
>  		return 0;
> -	}
>  
>  	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
>  	if (!patch) {
> @@ -810,21 +806,21 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
>  	enum ucode_state ret = UCODE_ERROR;
>  	unsigned int leftover;
>  	u8 *fw = (u8 *)data;
> -	int offset;
> +	unsigned int offset;
>  
> -	offset = install_equiv_cpu_table(data);
> -	if (offset < 0) {
> +	offset = install_equiv_cpu_table(data, size);
> +	if (!offset) {
>  		pr_err("failed to create equivalent cpu table\n");

No need for that error message anymore I guess -
install_equiv_cpu_table() and verify_equivalence_table() are pretty
vocal in the error case already.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
