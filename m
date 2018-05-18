Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeERHmM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:42:12 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36418 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeERHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:42:07 -0400
X-Google-Smtp-Source: AB8JxZpWIhIYtPYx5BAADA848foNEjvSnPLFzWSu+KhjudkUdK7vfICOKIgFmChU0R1zrYBTxA5RJQ==
Date: Fri, 18 May 2018 16:42:04 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 05/11] arm64: kexec_file: load initrd and device-tree
Message-ID: <20180518074203.GM2737@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-6-takahiro.akashi@linaro.org>
 <c10624c0-9962-af38-1dd5-656902180ace@arm.com>
 <20180518071133.GL2737@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518071133.GL2737@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 04:11:35PM +0900, AKASHI Takahiro wrote:
> James,
> 
> On Tue, May 15, 2018 at 05:20:00PM +0100, James Morse wrote:
> > Hi Akashi,
> > 
> > On 25/04/18 07:26, AKASHI Takahiro wrote:
> > > load_other_segments() is expected to allocate and place all the necessary
> > > memory segments other than kernel, including initrd and device-tree
> > > blob (and elf core header for crash).
> > > While most of the code was borrowed from kexec-tools' counterpart,
> > > users may not be allowed to specify dtb explicitly, instead, the dtb
> > > presented by a boot loader is reused.
> > 
> > (Nit: "a boot loader" -> "the original boot loader")
> 
> OK
> 
> > > arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
> > > specific data allocated in load_other_segments().
> > 
> > 
> > > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > > index f9ebf54ca247..b3b9b1725d8a 100644
> > > --- a/arch/arm64/kernel/machine_kexec_file.c
> > > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > > @@ -13,7 +13,26 @@
> > >  #include <linux/ioport.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/kexec.h>
> > > +#include <linux/libfdt.h>
> > >  #include <linux/memblock.h>
> > > +#include <linux/of_fdt.h>
> > > +#include <linux/types.h>
> > > +#include <asm/byteorder.h>
> > > +
> > > +static int __dt_root_addr_cells;
> > > +static int __dt_root_size_cells;
> > 
> > > @@ -55,3 +74,144 @@ int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > >  
> > >  	return ret;
> > >  }
> > > +
> > > +static int setup_dtb(struct kimage *image,
> > > +		unsigned long initrd_load_addr, unsigned long initrd_len,
> > > +		char *cmdline, unsigned long cmdline_len,
> > > +		char **dtb_buf, size_t *dtb_buf_len)
> > > +{
> > > +	char *buf = NULL;
> > > +	size_t buf_size;
> > > +	int nodeoffset;
> > > +	u64 value;
> > > +	int range_len;
> > > +	int ret;
> > > +
> > > +	/* duplicate dt blob */
> > > +	buf_size = fdt_totalsize(initial_boot_params);
> > > +	range_len = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
> > 
> > These two cells values are 0 here. Did you want
> > arch_kexec_file_init() in patch 7 in this patch?
> > 
> > Ah, range_len isn't used, so, did you want the cells values and this range_len
> > thing in in patch 7!?
> 
> Umm, this problem has long existed since my v1 :)
> I might better re-think about patch order.
> 
> > 
> > > +
> > > +	if (initrd_load_addr)
> > > +		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64))
> > > +				+ fdt_prop_len("linux,initrd-end", sizeof(u64));
> > > +
> > > +	if (cmdline)
> > > +		buf_size += fdt_prop_len("bootargs", cmdline_len + 1);
> > 
> > I can't find where fdt_prop_len() .... oh, patch 7. fdt_prop_len() doesn't look
> > like the sort of thing that should be created here, but I agree there isn't an
> > existing API to do this.
> 
> Will take care of it.
> 
> 
> > (This must be why powerpc guesses that the fdt won't be more than double in size).
> > 
> > 
> > > +	buf = vmalloc(buf_size);
> > > +	if (!buf) {
> > > +		ret = -ENOMEM;
> > > +		goto out_err;
> > > +	}
> > > +
> > > +	ret = fdt_open_into(initial_boot_params, buf, buf_size);
> > > +	if (ret)
> > > +		goto out_err;
> > > +
> > > +	nodeoffset = fdt_path_offset(buf, "/chosen");
> > > +	if (nodeoffset < 0)
> > > +		goto out_err;
> > > +
> > > +	/* add bootargs */
> > > +	if (cmdline) {
> > > +		ret = fdt_setprop(buf, nodeoffset, "bootargs",
> > > +						cmdline, cmdline_len + 1);
> > 
> > fdt_setprop_string()?
> 
> OK

cmdline_len is passed by system call, kexec_file_load(), and this means
that we can't believe that cmdline is always terminated with '\0'.
> 
> > 
> > > +		if (ret)
> > > +			goto out_err;
> > > +	}
> > > +
> > > +	/* add initrd-* */
> > > +	if (initrd_load_addr) {
> > > +		value = cpu_to_fdt64(initrd_load_addr);
> > > +		ret = fdt_setprop(buf, nodeoffset, "linux,initrd-start",
> > > +				&value, sizeof(value));
> > 
> > sizeof(value) was assumed to be the same as sizeof(u64) earlier.
> > fdt_setprop_u64()?
> 
> OK
> 
> > 
> > > +		if (ret)
> > > +			goto out_err;
> > > +
> > > +		value = cpu_to_fdt64(initrd_load_addr + initrd_len);
> > > +		ret = fdt_setprop(buf, nodeoffset, "linux,initrd-end",
> > > +				&value, sizeof(value));
> > > +		if (ret)
> > > +			goto out_err;
> > > +	}
> > > +
> > > +	/* trim a buffer */
> > > +	fdt_pack(buf);
> > > +	*dtb_buf = buf;
> > > +	*dtb_buf_len = fdt_totalsize(buf);
> > > +
> > > +	return 0;
> > > +
> > > +out_err:
> > > +	vfree(buf);
> > > +	return ret;
> > > +}
> > 
> > While powerpc has some similar code for updating the initrd and cmdline, it
> > makes different assumptions about the size of the dt, and has different behavior
> > for memreserve. (looks like we don't expect the initramfs to be memreserved).
> > Lets leave unifying that stuff where possible for the future.
> 
> Sure
> 
> > > +int load_other_segments(struct kimage *image,
> > > +			char *initrd, unsigned long initrd_len,
> > > +			char *cmdline, unsigned long cmdline_len)
> > > +{
> > > +	struct kexec_segment *kern_seg;
> > > +	struct kexec_buf kbuf;
> > > +	unsigned long initrd_load_addr = 0;
> > > +	char *dtb = NULL;
> > > +	unsigned long dtb_len = 0;
> > > +	int ret = 0;
> > > +
> > > +	kern_seg = &image->segment[image->arch.kern_segment];
> > > +	kbuf.image = image;
> > > +	/* not allocate anything below the kernel */
> > > +	kbuf.buf_min = kern_seg->mem + kern_seg->memsz;
> > 
> > > +	/* load initrd */
> > > +	if (initrd) {
> > > +		kbuf.buffer = initrd;
> > > +		kbuf.bufsz = initrd_len;
> > > +		kbuf.memsz = initrd_len;
> > 
> > > +		kbuf.buf_align = 0;
> > 
> > I'm surprised there initrd has no alignment requirement,
> 
> MeToo.
> 
> > but kexec_add_buffer()
> > rounds this up to PAGE_SIZE.
> 
> It seems that kimage_load_segment() requires this, but I'm not sure.
> 
> > 
> > > +		/* within 1GB-aligned window of up to 32GB in size */
> > > +		kbuf.buf_max = round_down(kern_seg->mem, SZ_1G)
> > > +						+ (unsigned long)SZ_1G * 32;
> > > +		kbuf.top_down = false;
> > > +
> > > +		ret = kexec_add_buffer(&kbuf);
> > > +		if (ret)
> > > +			goto out_err;
> > > +		initrd_load_addr = kbuf.mem;
> > > +
> > > +		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > > +				initrd_load_addr, initrd_len, initrd_len);
> > > +	}
> > > +
> > > +	/* load dtb blob */
> > > +	ret = setup_dtb(image, initrd_load_addr, initrd_len,
> > > +				cmdline, cmdline_len, &dtb, &dtb_len);
> > > +	if (ret) {
> > > +		pr_err("Preparing for new dtb failed\n");
> > > +		goto out_err;
> > > +	}
> > > +
> > > +	kbuf.buffer = dtb;
> > > +	kbuf.bufsz = dtb_len;
> > > +	kbuf.memsz = dtb_len;
> > > +	/* not across 2MB boundary */
> > > +	kbuf.buf_align = SZ_2M;
> > > +	kbuf.buf_max = ULONG_MAX;
> > > +	kbuf.top_down = true;
> > > +
> > > +	ret = kexec_add_buffer(&kbuf);
> > > +	if (ret)
> > > +		goto out_err;
> > > +	image->arch.dtb_mem = kbuf.mem;
> > > +	image->arch.dtb_buf = dtb;
> > > +
> > > +	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > > +			kbuf.mem, dtb_len, dtb_len);
> > > +
> > > +	return 0;
> > > +
> > > +out_err:
> > > +	vfree(dtb);
> > > +	image->arch.dtb_buf = NULL;
> > 
> > Won't kimage_file_post_load_cleanup() always be called if we return an error
> > here? Why not leave the free()ing until then?
> 
> Right.
> The reason why I left the code here was that we'd better locally clean up
> all the stuff that were locally allocated if we trivially need to (and can)
> do so.
> 
> As it's redundant, I will remove it.

will remove only "image->arch.dtb_buf = NULL."

> Thanks,
> -Takahiro AKASHI
> 
> > 
> > > +	return ret;
> > > +}
> > 
> > 
> > 
> > Thanks,
> > 
> > James
