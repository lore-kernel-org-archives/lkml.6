Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeEGHU5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:20:57 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37705 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeEGHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:20:55 -0400
X-Google-Smtp-Source: AB8JxZpGO5w+JSkuyx09uXY7KEqlhuVFg5hdxEIGYDTvNC8EZO6lQDOR8ayYr+lTHJ5ryej6k1isGQ==
Date: Mon, 7 May 2018 16:21:41 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 06/11] arm64: kexec_file: allow for loading
 Image-format kernel
Message-ID: <20180507072139.GF11326@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-7-takahiro.akashi@linaro.org>
 <c604b578-6667-3532-eac9-55c428001025@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c604b578-6667-3532-eac9-55c428001025@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Tue, May 01, 2018 at 06:46:11PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 25/04/18 07:26, AKASHI Takahiro wrote:
> > This patch provides kexec_file_ops for "Image"-format kernel. In this
> > implementation, a binary is always loaded with a fixed offset identified
> > in text_offset field of its header.
> 
> 
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index e4de1223715f..3cba4161818a 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -102,6 +102,56 @@ struct kimage_arch {
> >  	void *dtb_buf;
> >  };
> >  
> > +/**
> > + * struct arm64_image_header - arm64 kernel image header
> > + *
> > + * @pe_sig: Optional PE format 'MZ' signature
> > + * @branch_code: Instruction to branch to stext
> > + * @text_offset: Image load offset, little endian
> > + * @image_size: Effective image size, little endian
> > + * @flags:
> > + *	Bit 0: Kernel endianness. 0=little endian, 1=big endian
> 
> Page size? What about 'phys_base'?, (whatever that is...)
> Probably best to refer to Documentation/arm64/booting.txt here, its the
> authoritative source of what these fields mean.

While we don't care other bit fields for now, I will add the reference
to the Documentation file.

> 
> > + * @reserved: Reserved
> > + * @magic: Magic number, "ARM\x64"
> > + * @pe_header: Optional offset to a PE format header
> > + **/
> > +
> > +struct arm64_image_header {
> > +	u8 pe_sig[2];
> > +	u8 pad[2];
> > +	u32 branch_code;
> > +	u64 text_offset;
> > +	u64 image_size;
> > +	u64 flags;
> 
> __le64 as appropriate here would let tools like sparse catch any missing endian
> conversion bugs.

OK.

> 
> > +	u64 reserved[3];
> > +	u8 magic[4];
> > +	u32 pe_header;
> > +};
> 
> I'm surprised we don't have a definition for this already, I guess its always
> done in asm. We have kernel/image.h that holds some of this stuff, if we are
> going to validate the flags, is it worth adding the code there, (and moving it
> to include/asm)?

A comment at the beginning of this file says,
    #ifndef LINKER_SCRIPT
    #error This file should only be included in vmlinux.lds.S
    #endif
Let me think about.

> 
> > +static const u8 arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
> 
> Any chance this magic could be a pre-processor symbol shared with head.S?

OK.

> 
> > +
> > +/**
> > + * arm64_header_check_magic - Helper to check the arm64 image header.
> > + *
> > + * Returns non-zero if header is OK.
> > + */
> > +
> > +static inline int arm64_header_check_magic(const struct arm64_image_header *h)
> > +{
> > +	if (!h)
> > +		return 0;
> > +
> > +	if (!h->text_offset)
> > +		return 0;
> > +
> > +	return (h->magic[0] == arm64_image_magic[0]
> > +		&& h->magic[1] == arm64_image_magic[1]
> > +		&& h->magic[2] == arm64_image_magic[2]
> > +		&& h->magic[3] == arm64_image_magic[3]);
> 
> memcmp()? Or just define it as a 32bit value?

OK. As you know, I always tried to keep the code not diverted
from kexec-tools for maintainability reason.

> I guess you skip the MZ prefix as its not present for !EFI?

CONFIG_KEXEC_IMAGE_VERIFY_SIG depends on the fact that the file
format is PE (that is, EFI is enabled).


> Could we check branch_code is non-zero, and text-offset points within image-size?

We could do it, but I don't think this check is very useful.

> 
> We could check that this platform supports the page-size/endian config that this
> Image was built with... We get a message from the EFI stub if the page-size
> can't be supported, it would be nice to do the same here (as we can).

There is no restriction on page-size or endianness for kexec.
What will be the purpose of this check?

> (no idea if kexec-tool checks this stuff, it probably can't get at the id
> registers to know)
> 
> 
> > diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> > new file mode 100644
> > index 000000000000..4dd524ad6611
> > --- /dev/null
> > +++ b/arch/arm64/kernel/kexec_image.c
> > @@ -0,0 +1,79 @@
> 
> > +static void *image_load(struct kimage *image,
> > +				char *kernel, unsigned long kernel_len,
> > +				char *initrd, unsigned long initrd_len,
> > +				char *cmdline, unsigned long cmdline_len)
> > +{
> > +	struct kexec_buf kbuf;
> > +	struct arm64_image_header *h = (struct arm64_image_header *)kernel;
> > +	unsigned long text_offset;
> > +	int ret;
> > +
> > +	/* Load the kernel */
> > +	kbuf.image = image;
> > +	kbuf.buf_min = 0;
> > +	kbuf.buf_max = ULONG_MAX;
> > +	kbuf.top_down = false;
> > +
> > +	kbuf.buffer = kernel;
> > +	kbuf.bufsz = kernel_len;
> > +	kbuf.memsz = le64_to_cpu(h->image_size);
> > +	text_offset = le64_to_cpu(h->text_offset);
> > +	kbuf.buf_align = SZ_2M;
> 
> > +	/* Adjust kernel segment with TEXT_OFFSET */
> > +	kbuf.memsz += text_offset;
> > +
> > +	ret = kexec_add_buffer(&kbuf);
> > +	if (ret)
> > +		goto out;
> > +
> > +	image->arch.kern_segment = image->nr_segments - 1;
> 
> You only seem to use kern_segment here, and in load_other_segments() called
> below. Could it not be a local variable passed in? Instead of arch-specific data
> we keep forever?

No, kern_segment is also used in load_other_segments() in machine_kexec_file.c.
To optimize memory hole allocation logic in locate_mem_hole_callback(),
we need to know the exact range of kernel image (start and end).

(Known drawback in this code is that Image only occupies one segment, but
once vmlinux might be supported, it would occupy two segments for text and
data.)

> 
> > +	image->segment[image->arch.kern_segment].mem += text_offset;
> > +	image->segment[image->arch.kern_segment].memsz -= text_offset;
> > +	image->start = image->segment[image->arch.kern_segment].mem;
> > +
> > +	pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > +				image->segment[image->arch.kern_segment].mem,
> > +				kbuf.bufsz, kbuf.memsz);
> > +
> > +	/* Load additional data */
> > +	ret = load_other_segments(image, initrd, initrd_len,
> > +				cmdline, cmdline_len);
> > +
> > +out:
> > +	return ERR_PTR(ret);
> > +}
> Looks good,

Thank you for thorough review.

-Takahiro AKASHI


> Thanks,
> 
> James
