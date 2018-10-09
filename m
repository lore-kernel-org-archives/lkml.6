Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55867C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC942082B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC942082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJIWpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:45:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40436 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeJIWpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:45:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E9980D;
        Tue,  9 Oct 2018 08:28:05 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84A883F5D3;
        Tue,  9 Oct 2018 08:28:02 -0700 (PDT)
Date:   Tue, 9 Oct 2018 16:28:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 11/16] arm64: kexec_file: allow for loading
 Image-format kernel
Message-ID: <20181009152759.x24xuiwb3zsg4jx7@lakrids.cambridge.arm.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-12-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928064841.14117-12-takahiro.akashi@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 03:48:36PM +0900, AKASHI Takahiro wrote:
> This patch provides kexec_file_ops for "Image"-format kernel. In this
> implementation, a binary is always loaded with a fixed offset identified
> in text_offset field of its header.
> 
> Regarding signature verification for trusted boot, this patch doesn't
> contains CONFIG_KEXEC_VERIFY_SIG support, which is to be added later
> in this series, but file-attribute-based verification is still a viable
> option by enabling IMA security subsystem.
> 
> You can sign(label) a to-be-kexec'ed kernel image on target file system
> with:
>     $ evmctl ima_sign --key /path/to/private_key.pem Image
> 
> On live system, you must have IMA enforced with, at least, the following
> security policy:
>     "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig"
> 
> See more details about IMA here:
>     https://sourceforge.net/p/linux-ima/wiki/Home/
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/kexec.h         |  28 +++++++
>  arch/arm64/kernel/Makefile             |   2 +-
>  arch/arm64/kernel/kexec_image.c        | 108 +++++++++++++++++++++++++
>  arch/arm64/kernel/machine_kexec_file.c |   1 +
>  4 files changed, 138 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/kexec_image.c
> 
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 157b2897d911..5e673481b3a3 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -101,6 +101,34 @@ struct kimage_arch {
>  	unsigned long dtb_mem;
>  };
>  
> +/**
> + * struct arm64_image_header - arm64 kernel image header
> + * See Documentation/arm64/booting.txt for details
> + *
> + * @mz_magic: DOS header magic number ('MZ', optional)

Please just call this code0. If CONFIG_EFI is disabled, it is not 'MZ'.

> + * @code1: Instruction (branch to stext)
> + * @text_offset: Image load offset
> + * @image_size: Effective image size
> + * @flags: Bit-field flags
> + * @reserved: Reserved
> + * @magic: Magic number
> + * @pe_header: Offset to PE COFF header (optional)
> + **/
> +
> +struct arm64_image_header {
> +	__le16 mz_magic; /* also code0 */
> +	__le16 pad;

Likewise, just have __le32 code0 here, please.

> +	__le32 code1;
> +	__le64 text_offset;
> +	__le64 image_size;
> +	__le64 flags;
> +	__le64 reserved[3];
> +	__le32 magic;
> +	__le32 pe_header;
> +};
> +
> +extern const struct kexec_file_ops kexec_image_ops;
> +
>  struct kimage;
>  
>  extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 030a39bff117..48868255f09c 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -51,7 +51,7 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
>  arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
>  arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
>  					   cpu-reset.o
> -arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
> +arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
>  arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
>  arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
>  arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> new file mode 100644
> index 000000000000..d64f5e9f9d22
> --- /dev/null
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kexec image loader
> +
> + * Copyright (C) 2018 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + */
> +
> +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/string.h>
> +#include <asm/boot.h>
> +#include <asm/byteorder.h>
> +#include <asm/cpufeature.h>
> +#include <asm/memory.h>
> +
> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	const struct arm64_image_header *h;
> +
> +	h = (const struct arm64_image_header *)(kernel_buf);
> +
> +	if (!h || (kernel_len < sizeof(*h)) ||
> +			memcmp(&h->magic, ARM64_MAGIC, sizeof(h->magic)))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void *image_load(struct kimage *image,
> +				char *kernel, unsigned long kernel_len,
> +				char *initrd, unsigned long initrd_len,
> +				char *cmdline, unsigned long cmdline_len)
> +{
> +	struct arm64_image_header *h;
> +	u64 flags, value;
> +	struct kexec_buf kbuf;
> +	unsigned long text_offset;
> +	struct kexec_segment *kernel_segment;
> +	int ret;
> +
> +	/* Don't support old kernel */
> +	h = (struct arm64_image_header *)kernel;
> +	if (!h->text_offset)
> +		return ERR_PTR(-EINVAL);

It's entirely valid for TEXT_OFFSET to be zero when
RANDOMIZE_TEXT_OFFSET is selected.

I think you meant to check image_size here.

We could do with a better comment, too, e.g.

	/*
	 * We require a kernel with an unambiguous Image header. Per
	 * Documentation/booting.txt, this is the case when image_size
	 * is non-zero (practically speaking, since v3.17).
	 */
	if (!h->image_size)
		return ERR_PTR(-EINVAL);

> +
> +	/* Check cpu features */
> +	flags = le64_to_cpu(h->flags);
> +	value = head_flag_field(flags, HEAD_FLAG_BE);
> +	if (((value == HEAD_FLAG_BE) && !IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) ||
> +	    ((value != HEAD_FLAG_BE) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)))
> +		if (!system_supports_mixed_endian())
> +			return ERR_PTR(-EINVAL);

I think this can be simplified:

	bool be_image = head_flag_field(flags, HEAD_FLAG_BE);
	bool be_kernel = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);

	if ((be_image != be_kernel) && !system_supports_mixed_endian)
	    		return ERR_PTR(-EINVAL);

... though do we need to police this at all? It's arguably policy given
the new image has to be signed anyway), and there are other fields that
could fall into that category in future.

> +
> +	value = head_flag_field(flags, HEAD_FLAG_PAGE_SIZE);
> +	if (((value == HEAD_FLAG_PAGE_SIZE_4K) &&
> +			!system_supports_4kb_granule()) ||
> +	    ((value == HEAD_FLAG_PAGE_SIZE_64K) &&
> +			!system_supports_64kb_granule()) ||
> +	    ((value == HEAD_FLAG_PAGE_SIZE_16K) &&
> +			!system_supports_16kb_granule()))
> +		return ERR_PTR(-EINVAL);

... likewise here?

> +
> +	/* Load the kernel */
> +	kbuf.image = image;
> +	kbuf.buf_min = 0;
> +	kbuf.buf_max = ULONG_MAX;
> +	kbuf.top_down = false;
> +
> +	kbuf.buffer = kernel;
> +	kbuf.bufsz = kernel_len;
> +	kbuf.mem = 0;
> +	kbuf.memsz = le64_to_cpu(h->image_size);
> +	text_offset = le64_to_cpu(h->text_offset);
> +	kbuf.buf_align = MIN_KIMG_ALIGN;
> +
> +	/* Adjust kernel segment with TEXT_OFFSET */
> +	kbuf.memsz += text_offset;

It's very surprising at first glance to add text_offset here, then undo
that below. This should have a better comment explaining what we're
doing.

> +
> +	ret = kexec_add_buffer(&kbuf);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	kernel_segment = &image->segment[image->nr_segments - 1];

I'm confused here. When/how can the image have muliple segments?

> +	kernel_segment->mem += text_offset;
> +	kernel_segment->memsz -= text_offset;
> +	image->start = kernel_segment->mem;

As above, I don't like the fact that we're altering the result of
kexec_add_buffer here. It feels fragile, even if it works today.

Can we teach the core kexec buffer code that we need an offset from an
aligned base?

Thanks,
Mark.
