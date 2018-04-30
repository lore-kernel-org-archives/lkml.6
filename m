Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeD3JF0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:05:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59666 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752404AbeD3JFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:05:24 -0400
Date: Mon, 30 Apr 2018 11:04:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] x86/microcode/AMD: Add microcode container data
 checking functions
Message-ID: <20180430090447.GA6509@pd.tnic>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <ea8b42f1d7a0fa75b2a13758f71f6c486862ab47.1524515406.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea8b42f1d7a0fa75b2a13758f71f6c486862ab47.1524515406.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:34:07PM +0200, Maciej S. Szmigiero wrote:
> This commit adds verify_container(), verify_equivalence_table(),

Avoid beginning the commit message of a patch with "This patch" or "This
commit". It is tautologically useless.

> verify_patch_section() and verify_patch() functions to the AMD microcode
> update driver.
> These functions check whether a passed buffer contains the relevant
> structure, whether it isn't truncated and (for actual microcode patches)
> whether the size of a patch is not too large for a particular CPU family.
> By adding these checks as separate functions the actual microcode loading
> code won't get interspersed with a lot of checks and so will be more
> readable.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 140 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index dc8ea9a9d962..4fafaf0852d7 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -73,6 +73,142 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
>  	return 0;
>  }
>  
> +/*
> + * Checks whether there is a valid microcode container file at the beginning
> + * of a passed buffer @buf of size @size.
> + * If @early is set this function does not print errors which makes it
> + * usable by the early microcode loader.
> + */
> +static bool verify_container(const u8 *buf, size_t buf_size, bool early)
> +{
> +	u32 cont_magic;
> +
> +	if (buf_size <= CONTAINER_HDR_SZ) {
> +		if (!early)
> +			pr_err("Truncated microcode container header.\n");
> +
> +		return false;
> +	}
> +
> +	cont_magic = *(const u32 *)buf;
> +	if (cont_magic != UCODE_MAGIC) {
> +		if (!early)
> +			pr_err("Invalid magic value (0x%08x).\n", cont_magic);
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * Checks whether there is a valid, non-truncated CPU equivalence table
> + * at the beginning of a passed buffer @buf of size @size.
> + * If @early is set this function does not print errors which makes it
> + * usable by the early microcode loader.
> + */
> +static bool verify_equivalence_table(const u8 *buf, size_t buf_size, bool early)
> +{
> +	const u32 *hdr = (const u32 *)buf;
> +	u32 cont_type, equiv_tbl_len;
> +
> +	cont_type = hdr[1];

You need to check the size of buf so that there's enough buf passed in
before you index into it like that.

> +	if (cont_type != UCODE_EQUIV_CPU_TABLE_TYPE) {
> +		if (!early)
> +			pr_err("Wrong microcode container equivalence table type: %u.\n",
> +			       cont_type);
> +
> +		return false;
> +	}
> +
> +	equiv_tbl_len = hdr[2];

And that.

> +	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
> +	    buf_size - CONTAINER_HDR_SZ < equiv_tbl_len) {
> +		if (!early)
> +			pr_err("Truncated equivalence table.\n");
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * Checks whether there is a valid, non-truncated microcode patch section
> + * at the beginning of a passed buffer @buf of size @size.
> + * If @early is set this function does not print errors which makes it
> + * usable by the early microcode loader.
> + */
> +static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
> +{
> +	const u32 *hdr = (const u32 *)buf;
> +	u32 patch_type, patch_size;
> +
> +	if (buf_size < SECTION_HDR_SIZE) {
> +		if (!early)
> +			pr_err("Truncated patch section.\n");
> +
> +		return false;
> +	}
> +
> +	patch_type = hdr[0];
> +	patch_size = hdr[1];
> +
> +	if (patch_type != UCODE_UCODE_TYPE) {
> +		if (!early)
> +			pr_err("Invalid type field (%u) in container file section header.\n",
> +				patch_type);
> +
> +		return false;
> +	}
> +
> +	if (patch_size < sizeof(struct microcode_header_amd)) {
> +		if (!early)
> +			pr_err("Patch of size %u too short.\n", patch_size);
> +
> +		return false;
> +	}
> +
> +	if (buf_size - SECTION_HDR_SIZE < patch_size) {
> +		if (!early)
> +			pr_err("Patch of size %u truncated.\n", patch_size);
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static unsigned int verify_patch_size(u8 family, u32 patch_size,
> +				      unsigned int size);

No forward declarations pls.

> +
> +/*
> + * Checks whether a microcode patch located at the beginning of a passed
> + * buffer @buf of size @size is not too large for a particular @family
> + * and is not truncated.
> + * If @early is set this function does not print errors which makes it
> + * usable by the early microcode loader.
> + */
> +static bool verify_patch(u8 family, const u8 *buf, size_t buf_size, bool early)
> +{
> +	const u32 *hdr = (const u32 *)buf;
> +	u32 patch_size = hdr[1];

Just like in the first comment above.

> +
> +	/*
> +	 * The section header length is not included in this indicated size
> +	 * but is present in the leftover file length so we need to subtract
> +	 * it before passing this value to the function below.
> +	 */
> +	if (!verify_patch_size(family, patch_size, buf_size - SECTION_HDR_SIZE)) {
> +		if (!early)
> +			pr_err("Patch of size %u too large.\n", patch_size);
> +
> +		return false;
> +	}
> +
> +	return true;
> +}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
