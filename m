Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1932C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D5D214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZBkcw/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D5D214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJJOLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:11:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45650 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeJJOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:11:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id t70-v6so2024044pgd.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 23:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W3KnJTPZGgnsjZSr+RojtISBwkRgCKNrG3T/K+3pqZk=;
        b=DZBkcw/yP2CoIpoOrKiykGe5jPmWr2/fxkdh+Dis490YR3J9imlgjr7cjthVyNTEny
         yUwwy/ZhcAK5miXPylnFvx4qcWDtk8qtB2pGfS3MbY/3UwZwIOk0i+3v3OlXzdeCGzoO
         qW1kKQHBbnfkuQOpjZvY2Csfw7rtonerz15RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=W3KnJTPZGgnsjZSr+RojtISBwkRgCKNrG3T/K+3pqZk=;
        b=rdgc7iuFqCoBYIzMysP2xtt0KZsth0vPIKHEGmjgVAAJH7W5Meu4K3rNban2eLVMEY
         DgGMB0jS9u7yavd2c+vI9iUKmDaZODrx1MAcu88Q+WVN2SZLHKCr8UHaH8839WZE5CFF
         8qLIRHs+wV+BSwGbNbkEnhLO9+3TkP1SR4a3zhu8U0PcpdY8rmJQ4xZuxj/A61d9lo9y
         GUVCR6kOgpk5g3H6Rcz5jpeAytDyYFZKWq7S0YC53bIlV16WsKfe/hFv41b1UQZnfOx6
         hnEKrwkMuewZDIKh5dBvawguZt5OcWf3iJLcyu8Y4PEufUipwOQmeqNEqtJ9lViPmSxK
         uY9w==
X-Gm-Message-State: ABuFfog5S/5SO+fBJp9Tj4jIPQ3k80Lb+bS87jiX+Fddm9N2I7IIxHLT
        GD4GNJneS6orF33KgRxf1ZG2FA==
X-Google-Smtp-Source: ACcGV62lukkYQvg3XhcSEiUR0eqJmfeiHVblUG+2usRvd3omNRV7tpj6i03vw1r3iJN9c5LZvPk/1w==
X-Received: by 2002:a63:4d5b:: with SMTP id n27-v6mr28620795pgl.270.1539154254538;
        Tue, 09 Oct 2018 23:50:54 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id a15-v6sm20892137pff.8.2018.10.09.23.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 23:50:53 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:52:37 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <20181010065235.GY32578@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, prudo@linux.ibm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-12-takahiro.akashi@linaro.org>
 <20181009152759.x24xuiwb3zsg4jx7@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009152759.x24xuiwb3zsg4jx7@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Tue, Oct 09, 2018 at 04:28:00PM +0100, Mark Rutland wrote:
> On Fri, Sep 28, 2018 at 03:48:36PM +0900, AKASHI Takahiro wrote:
> > This patch provides kexec_file_ops for "Image"-format kernel. In this
> > implementation, a binary is always loaded with a fixed offset identified
> > in text_offset field of its header.
> > 
> > Regarding signature verification for trusted boot, this patch doesn't
> > contains CONFIG_KEXEC_VERIFY_SIG support, which is to be added later
> > in this series, but file-attribute-based verification is still a viable
> > option by enabling IMA security subsystem.
> > 
> > You can sign(label) a to-be-kexec'ed kernel image on target file system
> > with:
> >     $ evmctl ima_sign --key /path/to/private_key.pem Image
> > 
> > On live system, you must have IMA enforced with, at least, the following
> > security policy:
> >     "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig"
> > 
> > See more details about IMA here:
> >     https://sourceforge.net/p/linux-ima/wiki/Home/
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Reviewed-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/arm64/include/asm/kexec.h         |  28 +++++++
> >  arch/arm64/kernel/Makefile             |   2 +-
> >  arch/arm64/kernel/kexec_image.c        | 108 +++++++++++++++++++++++++
> >  arch/arm64/kernel/machine_kexec_file.c |   1 +
> >  4 files changed, 138 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/kernel/kexec_image.c
> > 
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index 157b2897d911..5e673481b3a3 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -101,6 +101,34 @@ struct kimage_arch {
> >  	unsigned long dtb_mem;
> >  };
> >  
> > +/**
> > + * struct arm64_image_header - arm64 kernel image header
> > + * See Documentation/arm64/booting.txt for details
> > + *
> > + * @mz_magic: DOS header magic number ('MZ', optional)
> 
> Please just call this code0. If CONFIG_EFI is disabled, it is not 'MZ'.

How about this?
(This definition will go into a new header, asm/image.h.)

---8<---
/*
 * struct arm64_image_header - arm64 kernel image header
 * See Documentation/arm64/booting.txt for details
 *
 * @code0:		Executable code, or
 *   @mz_header		  alternatively used for part of MZ header
 * @code1:		Executable code
 * @text_offset:	Image load offset
 * @image_size:		Effective Image size
 * @flags:		kernel flags
 * @reserved:		reserved
 * @magic:		Magic number
 * @reserved5:		reserved, or
 *   @pe_header:	  alternatively used for PE COFF offset
 */

struct arm64_image_header {
	union {
		__le32 code0;
		struct {
			__le16 magic;
			__le16 pad;
		} mz_header;
	};
	__le32 code1;
	__le64 text_offset;
	__le64 image_size;
	__le64 flags;
	__le64 reserved[3];
	__le32 magic;
	union {
		__le32 reserved5;
		__le32 pe_header;
	};
};
--->8---

> > + * @code1: Instruction (branch to stext)
> > + * @text_offset: Image load offset
> > + * @image_size: Effective image size
> > + * @flags: Bit-field flags
> > + * @reserved: Reserved
> > + * @magic: Magic number
> > + * @pe_header: Offset to PE COFF header (optional)
> > + **/
> > +
> > +struct arm64_image_header {
> > +	__le16 mz_magic; /* also code0 */
> > +	__le16 pad;
> 
> Likewise, just have __le32 code0 here, please.
> 
> > +	__le32 code1;
> > +	__le64 text_offset;
> > +	__le64 image_size;
> > +	__le64 flags;
> > +	__le64 reserved[3];
> > +	__le32 magic;
> > +	__le32 pe_header;
> > +};
> > +
> > +extern const struct kexec_file_ops kexec_image_ops;
> > +
> >  struct kimage;
> >  
> >  extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index 030a39bff117..48868255f09c 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -51,7 +51,7 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
> >  arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
> >  arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
> >  					   cpu-reset.o
> > -arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
> > +arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
> >  arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
> >  arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
> >  arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
> > diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> > new file mode 100644
> > index 000000000000..d64f5e9f9d22
> > --- /dev/null
> > +++ b/arch/arm64/kernel/kexec_image.c
> > @@ -0,0 +1,108 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Kexec image loader
> > +
> > + * Copyright (C) 2018 Linaro Limited
> > + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + */
> > +
> > +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
> > +
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kexec.h>
> > +#include <linux/string.h>
> > +#include <asm/boot.h>
> > +#include <asm/byteorder.h>
> > +#include <asm/cpufeature.h>
> > +#include <asm/memory.h>
> > +
> > +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> > +{
> > +	const struct arm64_image_header *h;
> > +
> > +	h = (const struct arm64_image_header *)(kernel_buf);
> > +
> > +	if (!h || (kernel_len < sizeof(*h)) ||
> > +			memcmp(&h->magic, ARM64_MAGIC, sizeof(h->magic)))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static void *image_load(struct kimage *image,
> > +				char *kernel, unsigned long kernel_len,
> > +				char *initrd, unsigned long initrd_len,
> > +				char *cmdline, unsigned long cmdline_len)
> > +{
> > +	struct arm64_image_header *h;
> > +	u64 flags, value;
> > +	struct kexec_buf kbuf;
> > +	unsigned long text_offset;
> > +	struct kexec_segment *kernel_segment;
> > +	int ret;
> > +
> > +	/* Don't support old kernel */
> > +	h = (struct arm64_image_header *)kernel;
> > +	if (!h->text_offset)
> > +		return ERR_PTR(-EINVAL);
> 
> It's entirely valid for TEXT_OFFSET to be zero when
> RANDOMIZE_TEXT_OFFSET is selected.
> 
> I think you meant to check image_size here.

Right, it's been a bug since the first appearance in v10.

> We could do with a better comment, too, e.g.
> 
> 	/*
> 	 * We require a kernel with an unambiguous Image header. Per
> 	 * Documentation/booting.txt, this is the case when image_size
> 	 * is non-zero (practically speaking, since v3.17).
> 	 */
> 	if (!h->image_size)
> 		return ERR_PTR(-EINVAL);
> 
> > +
> > +	/* Check cpu features */
> > +	flags = le64_to_cpu(h->flags);
> > +	value = head_flag_field(flags, HEAD_FLAG_BE);
> > +	if (((value == HEAD_FLAG_BE) && !IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) ||
> > +	    ((value != HEAD_FLAG_BE) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)))
> > +		if (!system_supports_mixed_endian())
> > +			return ERR_PTR(-EINVAL);
> 
> I think this can be simplified:
> 
> 	bool be_image = head_flag_field(flags, HEAD_FLAG_BE);
> 	bool be_kernel = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> 
> 	if ((be_image != be_kernel) && !system_supports_mixed_endian)
> 	    		return ERR_PTR(-EINVAL);

Okay.

> ... though do we need to police this at all? It's arguably policy given
> the new image has to be signed anyway), and there are other fields that
> could fall into that category in future.

The aim here is to prevent any images from being loaded
when there is no question that a new image will never be successfully
kexec'ed since the core on a given SoC obviously doesn't support cpu
features that are assumed and required by a image.

I believe that this check is a good and easy practice to avoid possible
failures before execution.

> > +
> > +	value = head_flag_field(flags, HEAD_FLAG_PAGE_SIZE);
> > +	if (((value == HEAD_FLAG_PAGE_SIZE_4K) &&
> > +			!system_supports_4kb_granule()) ||
> > +	    ((value == HEAD_FLAG_PAGE_SIZE_64K) &&
> > +			!system_supports_64kb_granule()) ||
> > +	    ((value == HEAD_FLAG_PAGE_SIZE_16K) &&
> > +			!system_supports_16kb_granule()))
> > +		return ERR_PTR(-EINVAL);
> 
> ... likewise here?
> 
> > +
> > +	/* Load the kernel */
> > +	kbuf.image = image;
> > +	kbuf.buf_min = 0;
> > +	kbuf.buf_max = ULONG_MAX;
> > +	kbuf.top_down = false;
> > +
> > +	kbuf.buffer = kernel;
> > +	kbuf.bufsz = kernel_len;
> > +	kbuf.mem = 0;
> > +	kbuf.memsz = le64_to_cpu(h->image_size);
> > +	text_offset = le64_to_cpu(h->text_offset);
> > +	kbuf.buf_align = MIN_KIMG_ALIGN;
> > +
> > +	/* Adjust kernel segment with TEXT_OFFSET */
> > +	kbuf.memsz += text_offset;
> 
> It's very surprising at first glance to add text_offset here, then undo
> that below. This should have a better comment explaining what we're
> doing.

To respect TEXT_OFFSET particularly for older kernels.
Will add some comments here.

> > +
> > +	ret = kexec_add_buffer(&kbuf);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	kernel_segment = &image->segment[image->nr_segments - 1];
> 
> I'm confused here. When/how can the image have muliple segments?

kexec_add_buffer() allocates one contiguous region, and
so nr_segments should be 1. But I think using nr_segments is resilient
if some buffer may be added before this line.
(Historically, in my old patches, a buffer for elfcoreheader was added
before a kernel segument was added to image->segment[].)

> > +	kernel_segment->mem += text_offset;
> > +	kernel_segment->memsz -= text_offset;
> > +	image->start = kernel_segment->mem;
> 
> As above, I don't like the fact that we're altering the result of
> kexec_add_buffer here. It feels fragile, even if it works today.
> 
> Can we teach the core kexec buffer code that we need an offset from an
> aligned base?

Adding another parameter to kexec_add_buffer() would be simple to do,
but I doubt that there is any difference since how to fill an allocated
segment with some data is totally up to the caller (arch-specific).

(That said, let me think twice.)

Thanks,
-Takahiro Akashi


> Thanks,
> Mark.
