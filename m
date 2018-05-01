Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbeEARtP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:49:15 -0400
Received: from foss.arm.com ([217.140.101.70]:49930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932067AbeEARtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:49:11 -0400
Subject: Re: [PATCH v9 06/11] arm64: kexec_file: allow for loading
 Image-format kernel
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-7-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <c604b578-6667-3532-eac9-55c428001025@arm.com>
Date: Tue, 1 May 2018 18:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425062629.29404-7-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 25/04/18 07:26, AKASHI Takahiro wrote:
> This patch provides kexec_file_ops for "Image"-format kernel. In this
> implementation, a binary is always loaded with a fixed offset identified
> in text_offset field of its header.


> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index e4de1223715f..3cba4161818a 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -102,6 +102,56 @@ struct kimage_arch {
>  	void *dtb_buf;
>  };
>  
> +/**
> + * struct arm64_image_header - arm64 kernel image header
> + *
> + * @pe_sig: Optional PE format 'MZ' signature
> + * @branch_code: Instruction to branch to stext
> + * @text_offset: Image load offset, little endian
> + * @image_size: Effective image size, little endian
> + * @flags:
> + *	Bit 0: Kernel endianness. 0=little endian, 1=big endian

Page size? What about 'phys_base'?, (whatever that is...)
Probably best to refer to Documentation/arm64/booting.txt here, its the
authoritative source of what these fields mean.


> + * @reserved: Reserved
> + * @magic: Magic number, "ARM\x64"
> + * @pe_header: Optional offset to a PE format header
> + **/
> +
> +struct arm64_image_header {
> +	u8 pe_sig[2];
> +	u8 pad[2];
> +	u32 branch_code;
> +	u64 text_offset;
> +	u64 image_size;
> +	u64 flags;

__le64 as appropriate here would let tools like sparse catch any missing endian
conversion bugs.


> +	u64 reserved[3];
> +	u8 magic[4];
> +	u32 pe_header;
> +};

I'm surprised we don't have a definition for this already, I guess its always
done in asm. We have kernel/image.h that holds some of this stuff, if we are
going to validate the flags, is it worth adding the code there, (and moving it
to include/asm)?


> +static const u8 arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};

Any chance this magic could be a pre-processor symbol shared with head.S?


> +
> +/**
> + * arm64_header_check_magic - Helper to check the arm64 image header.
> + *
> + * Returns non-zero if header is OK.
> + */
> +
> +static inline int arm64_header_check_magic(const struct arm64_image_header *h)
> +{
> +	if (!h)
> +		return 0;
> +
> +	if (!h->text_offset)
> +		return 0;
> +
> +	return (h->magic[0] == arm64_image_magic[0]
> +		&& h->magic[1] == arm64_image_magic[1]
> +		&& h->magic[2] == arm64_image_magic[2]
> +		&& h->magic[3] == arm64_image_magic[3]);

memcmp()? Or just define it as a 32bit value?
I guess you skip the MZ prefix as its not present for !EFI?

Could we check branch_code is non-zero, and text-offset points within image-size?


We could check that this platform supports the page-size/endian config that this
Image was built with... We get a message from the EFI stub if the page-size
can't be supported, it would be nice to do the same here (as we can).

(no idea if kexec-tool checks this stuff, it probably can't get at the id
registers to know)


> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> new file mode 100644
> index 000000000000..4dd524ad6611
> --- /dev/null
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -0,0 +1,79 @@

> +static void *image_load(struct kimage *image,
> +				char *kernel, unsigned long kernel_len,
> +				char *initrd, unsigned long initrd_len,
> +				char *cmdline, unsigned long cmdline_len)
> +{
> +	struct kexec_buf kbuf;
> +	struct arm64_image_header *h = (struct arm64_image_header *)kernel;
> +	unsigned long text_offset;
> +	int ret;
> +
> +	/* Load the kernel */
> +	kbuf.image = image;
> +	kbuf.buf_min = 0;
> +	kbuf.buf_max = ULONG_MAX;
> +	kbuf.top_down = false;
> +
> +	kbuf.buffer = kernel;
> +	kbuf.bufsz = kernel_len;
> +	kbuf.memsz = le64_to_cpu(h->image_size);
> +	text_offset = le64_to_cpu(h->text_offset);
> +	kbuf.buf_align = SZ_2M;

> +	/* Adjust kernel segment with TEXT_OFFSET */
> +	kbuf.memsz += text_offset;
> +
> +	ret = kexec_add_buffer(&kbuf);
> +	if (ret)
> +		goto out;
> +
> +	image->arch.kern_segment = image->nr_segments - 1;

You only seem to use kern_segment here, and in load_other_segments() called
below. Could it not be a local variable passed in? Instead of arch-specific data
we keep forever?


> +	image->segment[image->arch.kern_segment].mem += text_offset;
> +	image->segment[image->arch.kern_segment].memsz -= text_offset;
> +	image->start = image->segment[image->arch.kern_segment].mem;
> +
> +	pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +				image->segment[image->arch.kern_segment].mem,
> +				kbuf.bufsz, kbuf.memsz);
> +
> +	/* Load additional data */
> +	ret = load_other_segments(image, initrd, initrd_len,
> +				cmdline, cmdline_len);
> +
> +out:
> +	return ERR_PTR(ret);
> +}
Looks good,

Thanks,

James
