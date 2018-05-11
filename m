Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeEKRKL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:10:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44990 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeEKRKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:10:09 -0400
Subject: Re: [PATCH v9 06/11] arm64: kexec_file: allow for loading
 Image-format kernel
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-7-takahiro.akashi@linaro.org>
 <c604b578-6667-3532-eac9-55c428001025@arm.com>
 <20180507072139.GF11326@linaro.org>
From: James Morse <james.morse@arm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-ID: <6f0df3a8-a691-80f1-85de-3e0ead852f12@arm.com>
Date: Fri, 11 May 2018 18:07:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180507072139.GF11326@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 07/05/18 08:21, AKASHI Takahiro wrote:
> On Tue, May 01, 2018 at 06:46:11PM +0100, James Morse wrote:
>> On 25/04/18 07:26, AKASHI Takahiro wrote:
>>> This patch provides kexec_file_ops for "Image"-format kernel. In this
>>> implementation, a binary is always loaded with a fixed offset identified
>>> in text_offset field of its header.

>>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>>> index e4de1223715f..3cba4161818a 100644
>>> --- a/arch/arm64/include/asm/kexec.h
>>> +++ b/arch/arm64/include/asm/kexec.h
>>> @@ -102,6 +102,56 @@ struct kimage_arch {
>>>  	void *dtb_buf;
>>>  };
>>>  
>>> +/**
>>> + * struct arm64_image_header - arm64 kernel image header
>>> + *
>>> + * @pe_sig: Optional PE format 'MZ' signature
>>> + * @branch_code: Instruction to branch to stext
>>> + * @text_offset: Image load offset, little endian
>>> + * @image_size: Effective image size, little endian
>>> + * @flags:
>>> + *	Bit 0: Kernel endianness. 0=little endian, 1=big endian
>>
>> Page size? What about 'phys_base'?, (whatever that is...)
>> Probably best to refer to Documentation/arm64/booting.txt here, its the
>> authoritative source of what these fields mean.
> 
> While we don't care other bit fields for now, I will add the reference
> to the Documentation file.

Thanks, I don't want to create a second, incomplete set of documentation!


>>> +	u64 reserved[3];
>>> +	u8 magic[4];
>>> +	u32 pe_header;
>>> +};
>>
>> I'm surprised we don't have a definition for this already, I guess its always
>> done in asm. We have kernel/image.h that holds some of this stuff, if we are
>> going to validate the flags, is it worth adding the code there, (and moving it
>> to include/asm)?
> 
> A comment at the beginning of this file says,
>     #ifndef LINKER_SCRIPT
>     #error This file should only be included in vmlinux.lds.S
>     #endif
> Let me think about.

Ah, I missed that.

Having two definitions of something makes me nervous that they can become
different... looks like that header belongs to the linker, and shouldn't be used
here then.


>> I guess you skip the MZ prefix as its not present for !EFI?
> 
> CONFIG_KEXEC_IMAGE_VERIFY_SIG depends on the fact that the file
> format is PE (that is, EFI is enabled).

So if the signature checking is enabled, its already been checked.


>> Could we check branch_code is non-zero, and text-offset points within image-size?
> 
> We could do it, but I don't think this check is very useful.
> 
>>
>> We could check that this platform supports the page-size/endian config that this
>> Image was built with... We get a message from the EFI stub if the page-size
>> can't be supported, it would be nice to do the same here (as we can).
> 
> There is no restriction on page-size or endianness for kexec.

No, but it won't boot if the hardware doesn't support it. The kernel will spin
at a magic address that is, difficult, to debug without JTAG. The bug report
will be "it didn't boot".


> What will be the purpose of this check?

These values are in the header so that the bootloader can check them, then print
a meaningful error. Here, kexec_file_load() is playing the part of the bootloader.

I'm assuming kexec_file_load() can only be used to kexec linux... unlike regular
kexec. Is this where I'm going wrong?


>>> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
>>> new file mode 100644
>>> index 000000000000..4dd524ad6611
>>> --- /dev/null
>>> +++ b/arch/arm64/kernel/kexec_image.c
>>> @@ -0,0 +1,79 @@
>>
>>> +static void *image_load(struct kimage *image,
>>> +				char *kernel, unsigned long kernel_len,
>>> +				char *initrd, unsigned long initrd_len,
>>> +				char *cmdline, unsigned long cmdline_len)
>>> +{
>>> +	struct kexec_buf kbuf;
>>> +	struct arm64_image_header *h = (struct arm64_image_header *)kernel;
>>> +	unsigned long text_offset;
>>> +	int ret;
>>> +
>>> +	/* Load the kernel */
>>> +	kbuf.image = image;
>>> +	kbuf.buf_min = 0;
>>> +	kbuf.buf_max = ULONG_MAX;
>>> +	kbuf.top_down = false;
>>> +
>>> +	kbuf.buffer = kernel;
>>> +	kbuf.bufsz = kernel_len;
>>> +	kbuf.memsz = le64_to_cpu(h->image_size);
>>> +	text_offset = le64_to_cpu(h->text_offset);
>>> +	kbuf.buf_align = SZ_2M;
>>
>>> +	/* Adjust kernel segment with TEXT_OFFSET */
>>> +	kbuf.memsz += text_offset;
>>> +
>>> +	ret = kexec_add_buffer(&kbuf);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	image->arch.kern_segment = image->nr_segments - 1;
>>
>> You only seem to use kern_segment here, and in load_other_segments() called
>> below. Could it not be a local variable passed in? Instead of arch-specific data
>> we keep forever?
> 
> No, kern_segment is also used in load_other_segments() in machine_kexec_file.c.
> To optimize memory hole allocation logic in locate_mem_hole_callback(),
> we need to know the exact range of kernel image (start and end).

That's the second user. My badly-made point is one calls the other, but passes
the data via some until-kexec lifetime struct. (its not important, just an
indicator this worked differently in the past and hasn't been cleaned up).
I meant something like [0].


Thanks,

James


[0] a diff is worth a thousand words:
--------------------%<--------------------
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_
kexec_file.c
index 762f9102899c..c50ce844f09e 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -325,11 +325,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
        return ret;
 }

-int load_other_segments(struct kimage *image,
+int load_other_segments(struct kimage *image, struct kexec_segment *kern_seg,
                        char *initrd, unsigned long initrd_len,
                        char *cmdline, unsigned long cmdline_len)
 {
-       struct kexec_segment *kern_seg;
        struct kexec_buf kbuf;
        void *hdrs_addr;
        unsigned long hdrs_sz;
@@ -368,7 +367,6 @@ int load_other_segments(struct kimage *image,
                                 image->arch.elf_load_addr, hdrs_sz, hdrs_sz);
        }

-       kern_seg = &image->segment[image->arch.kern_segment];
        kbuf.image = image;
        /* not allocate anything below the kernel */
        kbuf.buf_min = kern_seg->mem + kern_seg->memsz;
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 891f2484969d..085cb69293ca 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -173,8 +172,10 @@ static inline int arm64_header_check_pe_sig(const struct ar
m64_image_header *h)
 extern const struct kexec_file_ops kexec_image_ops;

 struct kimage;
+struct kexec_segment;

 extern int load_other_segments(struct kimage *image,
+               struct kexec_segment *kern_seg,
                char *initrd, unsigned long initrd_len,
                char *cmdline, unsigned long cmdline_len);
 #endif
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 7c11beefe65f..0e032d30a79c 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -37,6 +37,7 @@ static void *image_load(struct kimage *image,
                                char *cmdline, unsigned long cmdline_len)
 {
        struct kexec_buf kbuf;
+       struct kexec_segment *kern_seg;
        struct arm64_image_header *h = (struct arm64_image_header *)kernel;
        unsigned long text_offset;
        int ret;
@@ -65,17 +66,17 @@ static void *image_load(struct kimage *image,
        if (ret)
                goto out;

-       image->arch.kern_segment = image->nr_segments - 1;
-       image->segment[image->arch.kern_segment].mem += text_offset;
-       image->segment[image->arch.kern_segment].memsz -= text_offset;
-       image->start = image->segment[image->arch.kern_segment].mem;
+       kern_seg = &image->segment[image->nr_segments - 1];
+       kern_seg->mem += text_offset;
+       kern_seg->memsz -= text_offset;
+       image->start = kern_seg->mem;

        pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-                               image->segment[image->arch.kern_segment].mem,
+                               kern_seg->mem,
                                kbuf.bufsz, kbuf.memsz);

        /* Load additional data */
-       ret = load_other_segments(image, initrd, initrd_len,
+       ret = load_other_segments(image, kern_seg, initrd, initrd_len,
                                cmdline, cmdline_len);

 out:
--------------------%<--------------------
