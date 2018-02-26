Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeBZJVp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:21:45 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:38397 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeBZJVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:21:40 -0500
X-Google-Smtp-Source: AG47ELsHF86EFBBG+LzLPWnfHQQUo28uVwpgmfeTrXkFbBnZIrIY16P19+2dwYNyfkTVsoZjCE4HQg==
Date: Mon, 26 Feb 2018 18:21:42 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Dave Young <dyoung@redhat.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        akpm@linux-foundation.org, mpe@ellerman.id.au, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/13] x86: kexec_file: factor out elf core header
 related functions
Message-ID: <20180226092141.GB6019@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, bauerman@linux.vnet.ibm.com,
        dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, akpm@linux-foundation.org, mpe@ellerman.id.au,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        julien.thierry@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
 <20180222111732.23051-5-takahiro.akashi@linaro.org>
 <20180224031503.GA11823@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224031503.GA11823@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 11:15:03AM +0800, Dave Young wrote:
> Hi AKASHI,
> On 02/22/18 at 08:17pm, AKASHI Takahiro wrote:
> > exclude_mem_range() and prepare_elf64_headers() can be re-used on other
> > architectures, including arm64, as well. So let them factored out so as to
> > move them to generic side in the next patch.
> > 
> > fill_up_crash_elf_data() can potentially be commonalized for most
> > architectures who want to go through io resources (/proc/iomem) for a list
> > of "System RAM", but leave it private for now.
> 
> Is it possible to spilt this patch to small patches?  For example it can
> be one patch to change the max ranges to a dynamically allocated buffer.
> 
> The remain parts could be splitted as well, so that they can be easier
> to review.

Sure. I'm now going to split patch#4 into four:
   x86: kexec_file: purge system-ram walking from prepare_elf64_headers()
   x86: kexec_file: remove X86_64 dependency from prepare_elf64_headers()
   x86: kexec_file: lift CRASH_MAX_RANGES limit on crash_mem buffer
   x86: kexec_file: clean up prepare_elf64_headers()

In addition, I'm going to post those patches plus old patch#2/3/5
as a separate patch set.

Thanks,
-Takahiro AKASHI

> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/kernel/crash.c | 235 +++++++++++++++++++++---------------------------
> >  1 file changed, 103 insertions(+), 132 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index 10e74d4778a1..5c19cfbf3b85 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -41,32 +41,14 @@
> >  /* Alignment required for elf header segment */
> >  #define ELF_CORE_HEADER_ALIGN   4096
> >  
> > -/* This primarily represents number of split ranges due to exclusion */
> > -#define CRASH_MAX_RANGES	16
> > -
> >  struct crash_mem_range {
> >  	u64 start, end;
> >  };
> >  
> >  struct crash_mem {
> > -	unsigned int nr_ranges;
> > -	struct crash_mem_range ranges[CRASH_MAX_RANGES];
> > -};
> > -
> > -/* Misc data about ram ranges needed to prepare elf headers */
> > -struct crash_elf_data {
> > -	struct kimage *image;
> > -	/*
> > -	 * Total number of ram ranges we have after various adjustments for
> > -	 * crash reserved region, etc.
> > -	 */
> >  	unsigned int max_nr_ranges;
> > -
> > -	/* Pointer to elf header */
> > -	void *ehdr;
> > -	/* Pointer to next phdr */
> > -	void *bufp;
> > -	struct crash_mem mem;
> > +	unsigned int nr_ranges;
> > +	struct crash_mem_range ranges[0];
> >  };
> >  
> >  /* Used while preparing memory map entries for second kernel */
> > @@ -217,29 +199,32 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
> >  	return 0;
> >  }
> >  
> > -
> >  /* Gather all the required information to prepare elf headers for ram regions */
> > -static void fill_up_crash_elf_data(struct crash_elf_data *ced,
> > -				   struct kimage *image)
> > +static struct crash_mem *fill_up_crash_elf_data(void)
> >  {
> >  	unsigned int nr_ranges = 0;
> > -
> > -	ced->image = image;
> > +	struct crash_mem *cmem;
> >  
> >  	walk_system_ram_res(0, -1, &nr_ranges,
> >  				get_nr_ram_ranges_callback);
> >  
> > -	ced->max_nr_ranges = nr_ranges;
> > +	/*
> > +	 * Exclusion of crash region and/or crashk_low_res may cause
> > +	 * another range split. So add extra two slots here.
> > +	 */
> > +	nr_ranges += 2;
> > +	cmem = vmalloc(sizeof(struct crash_mem) +
> > +			sizeof(struct crash_mem_range) * nr_ranges);
> > +	if (!cmem)
> > +		return NULL;
> >  
> > -	/* Exclusion of crash region could split memory ranges */
> > -	ced->max_nr_ranges++;
> > +	cmem->max_nr_ranges = nr_ranges;
> > +	cmem->nr_ranges = 0;
> >  
> > -	/* If crashk_low_res is not 0, another range split possible */
> > -	if (crashk_low_res.end)
> > -		ced->max_nr_ranges++;
> > +	return cmem;
> >  }
> >  
> > -static int exclude_mem_range(struct crash_mem *mem,
> > +static int crash_exclude_mem_range(struct crash_mem *mem,
> >  		unsigned long long mstart, unsigned long long mend)
> >  {
> >  	int i, j;
> > @@ -293,10 +278,8 @@ static int exclude_mem_range(struct crash_mem *mem,
> >  		return 0;
> >  
> >  	/* Split happened */
> > -	if (i == CRASH_MAX_RANGES - 1) {
> > -		pr_err("Too many crash ranges after split\n");
> > +	if (i == mem->max_nr_ranges - 1)
> >  		return -ENOMEM;
> > -	}
> >  
> >  	/* Location where new range should go */
> >  	j = i + 1;
> > @@ -314,27 +297,20 @@ static int exclude_mem_range(struct crash_mem *mem,
> >  
> >  /*
> >   * Look for any unwanted ranges between mstart, mend and remove them. This
> > - * might lead to split and split ranges are put in ced->mem.ranges[] array
> > + * might lead to split and split ranges are put in cmem->ranges[] array
> >   */
> > -static int elf_header_exclude_ranges(struct crash_elf_data *ced,
> > -		unsigned long long mstart, unsigned long long mend)
> > +static int elf_header_exclude_ranges(struct crash_mem *cmem)
> >  {
> > -	struct crash_mem *cmem = &ced->mem;
> >  	int ret = 0;
> >  
> > -	memset(cmem->ranges, 0, sizeof(cmem->ranges));
> > -
> > -	cmem->ranges[0].start = mstart;
> > -	cmem->ranges[0].end = mend;
> > -	cmem->nr_ranges = 1;
> > -
> >  	/* Exclude crashkernel region */
> > -	ret = exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> > +	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> >  	if (ret)
> >  		return ret;
> >  
> >  	if (crashk_low_res.end) {
> > -		ret = exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> > +		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
> > +							crashk_low_res.end);
> >  		if (ret)
> >  			return ret;
> >  	}
> > @@ -344,70 +320,29 @@ static int elf_header_exclude_ranges(struct crash_elf_data *ced,
> >  
> >  static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> >  {
> > -	struct crash_elf_data *ced = arg;
> > -	Elf64_Ehdr *ehdr;
> > -	Elf64_Phdr *phdr;
> > -	unsigned long mstart, mend;
> > -	struct kimage *image = ced->image;
> > -	struct crash_mem *cmem;
> > -	int ret, i;
> > +	struct crash_mem *cmem = arg;
> >  
> > -	ehdr = ced->ehdr;
> > -
> > -	/* Exclude unwanted mem ranges */
> > -	ret = elf_header_exclude_ranges(ced, res->start, res->end);
> > -	if (ret)
> > -		return ret;
> > -
> > -	/* Go through all the ranges in ced->mem.ranges[] and prepare phdr */
> > -	cmem = &ced->mem;
> > -
> > -	for (i = 0; i < cmem->nr_ranges; i++) {
> > -		mstart = cmem->ranges[i].start;
> > -		mend = cmem->ranges[i].end;
> > -
> > -		phdr = ced->bufp;
> > -		ced->bufp += sizeof(Elf64_Phdr);
> > -
> > -		phdr->p_type = PT_LOAD;
> > -		phdr->p_flags = PF_R|PF_W|PF_X;
> > -		phdr->p_offset  = mstart;
> > -
> > -		/*
> > -		 * If a range matches backup region, adjust offset to backup
> > -		 * segment.
> > -		 */
> > -		if (mstart == image->arch.backup_src_start &&
> > -		    (mend - mstart + 1) == image->arch.backup_src_sz)
> > -			phdr->p_offset = image->arch.backup_load_addr;
> > -
> > -		phdr->p_paddr = mstart;
> > -		phdr->p_vaddr = (unsigned long long) __va(mstart);
> > -		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
> > -		phdr->p_align = 0;
> > -		ehdr->e_phnum++;
> > -		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> > -			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
> > -			ehdr->e_phnum, phdr->p_offset);
> > -	}
> > +	cmem->ranges[cmem->nr_ranges].start = res->start;
> > +	cmem->ranges[cmem->nr_ranges].end = res->end;
> > +	cmem->nr_ranges++;
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> > -static int prepare_elf64_headers(struct crash_elf_data *ced,
> > -		void **addr, unsigned long *sz)
> > +static int crash_prepare_elf64_headers(struct crash_mem *cmem, int kernel_map,
> > +					void **addr, unsigned long *sz)
> >  {
> >  	Elf64_Ehdr *ehdr;
> >  	Elf64_Phdr *phdr;
> >  	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
> > -	unsigned char *buf, *bufp;
> > -	unsigned int cpu;
> > +	unsigned char *buf;
> > +	unsigned int cpu, i;
> >  	unsigned long long notes_addr;
> > -	int ret;
> > +	unsigned long mstart, mend;
> >  
> >  	/* extra phdr for vmcoreinfo elf note */
> >  	nr_phdr = nr_cpus + 1;
> > -	nr_phdr += ced->max_nr_ranges;
> > +	nr_phdr += cmem->nr_ranges;
> >  
> >  	/*
> >  	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
> > @@ -425,9 +360,8 @@ static int prepare_elf64_headers(struct crash_elf_data *ced,
> >  	if (!buf)
> >  		return -ENOMEM;
> >  
> > -	bufp = buf;
> > -	ehdr = (Elf64_Ehdr *)bufp;
> > -	bufp += sizeof(Elf64_Ehdr);
> > +	ehdr = (Elf64_Ehdr *)buf;
> > +	phdr = (Elf64_Phdr *)(ehdr + 1);
> >  	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> >  	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
> >  	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
> > @@ -443,42 +377,51 @@ static int prepare_elf64_headers(struct crash_elf_data *ced,
> >  
> >  	/* Prepare one phdr of type PT_NOTE for each present cpu */
> >  	for_each_present_cpu(cpu) {
> > -		phdr = (Elf64_Phdr *)bufp;
> > -		bufp += sizeof(Elf64_Phdr);
> >  		phdr->p_type = PT_NOTE;
> >  		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
> >  		phdr->p_offset = phdr->p_paddr = notes_addr;
> >  		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
> >  		(ehdr->e_phnum)++;
> > +		phdr++;
> >  	}
> >  
> >  	/* Prepare one PT_NOTE header for vmcoreinfo */
> > -	phdr = (Elf64_Phdr *)bufp;
> > -	bufp += sizeof(Elf64_Phdr);
> >  	phdr->p_type = PT_NOTE;
> >  	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
> >  	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
> >  	(ehdr->e_phnum)++;
> > +	phdr++;
> >  
> > -#ifdef CONFIG_X86_64
> >  	/* Prepare PT_LOAD type program header for kernel text region */
> > -	phdr = (Elf64_Phdr *)bufp;
> > -	bufp += sizeof(Elf64_Phdr);
> > -	phdr->p_type = PT_LOAD;
> > -	phdr->p_flags = PF_R|PF_W|PF_X;
> > -	phdr->p_vaddr = (Elf64_Addr)_text;
> > -	phdr->p_filesz = phdr->p_memsz = _end - _text;
> > -	phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
> > -	(ehdr->e_phnum)++;
> > -#endif
> > +	if (kernel_map) {
> > +		phdr->p_type = PT_LOAD;
> > +		phdr->p_flags = PF_R|PF_W|PF_X;
> > +		phdr->p_vaddr = (Elf64_Addr)_text;
> > +		phdr->p_filesz = phdr->p_memsz = _end - _text;
> > +		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
> > +		ehdr->e_phnum++;
> > +		phdr++;
> > +	}
> >  
> > -	/* Prepare PT_LOAD headers for system ram chunks. */
> > -	ced->ehdr = ehdr;
> > -	ced->bufp = bufp;
> > -	ret = walk_system_ram_res(0, -1, ced,
> > -			prepare_elf64_ram_headers_callback);
> > -	if (ret < 0)
> > -		return ret;
> > +	/* Go through all the ranges in cmem->ranges[] and prepare phdr */
> > +	for (i = 0; i < cmem->nr_ranges; i++) {
> > +		mstart = cmem->ranges[i].start;
> > +		mend = cmem->ranges[i].end;
> > +
> > +		phdr->p_type = PT_LOAD;
> > +		phdr->p_flags = PF_R|PF_W|PF_X;
> > +		phdr->p_offset  = mstart;
> > +
> > +		phdr->p_paddr = mstart;
> > +		phdr->p_vaddr = (unsigned long long) __va(mstart);
> > +		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
> > +		phdr->p_align = 0;
> > +		ehdr->e_phnum++;
> > +		phdr++;
> > +		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> > +			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
> > +			ehdr->e_phnum, phdr->p_offset);
> > +	}
> >  
> >  	*addr = buf;
> >  	*sz = elf_sz;
> > @@ -489,18 +432,46 @@ static int prepare_elf64_headers(struct crash_elf_data *ced,
> >  static int prepare_elf_headers(struct kimage *image, void **addr,
> >  					unsigned long *sz)
> >  {
> > -	struct crash_elf_data *ced;
> > -	int ret;
> > +	struct crash_mem *cmem;
> > +	Elf64_Ehdr *ehdr;
> > +	Elf64_Phdr *phdr;
> > +	int ret, i;
> >  
> > -	ced = kzalloc(sizeof(*ced), GFP_KERNEL);
> > -	if (!ced)
> > +	cmem = fill_up_crash_elf_data();
> > +	if (!cmem)
> >  		return -ENOMEM;
> >  
> > -	fill_up_crash_elf_data(ced, image);
> > +	ret = walk_system_ram_res(0, -1, cmem,
> > +				prepare_elf64_ram_headers_callback);
> > +	if (ret)
> > +		goto out;
> > +
> > +	/* Exclude unwanted mem ranges */
> > +	ret = elf_header_exclude_ranges(cmem);
> > +	if (ret)
> > +		goto out;
> >  
> >  	/* By default prepare 64bit headers */
> > -	ret =  prepare_elf64_headers(ced, addr, sz);
> > -	kfree(ced);
> > +	ret =  crash_prepare_elf64_headers(cmem,
> > +				(int)IS_ENABLED(CONFIG_X86_64), addr, sz);
> > +	if (ret)
> > +		goto out;
> > +
> > +	/*
> > +	 * If a range matches backup region, adjust offset to backup
> > +	 * segment.
> > +	 */
> > +	ehdr = (Elf64_Ehdr *)*addr;
> > +	phdr = (Elf64_Phdr *)(ehdr + 1);
> > +	for (i = 0; i < ehdr->e_phnum; phdr++, i++)
> > +		if (phdr->p_type == PT_LOAD &&
> > +				phdr->p_paddr == image->arch.backup_src_start &&
> > +				phdr->p_memsz == image->arch.backup_src_sz) {
> > +			phdr->p_offset = image->arch.backup_load_addr;
> > +			break;
> > +		}
> > +out:
> > +	vfree(cmem);
> >  	return ret;
> >  }
> >  
> > @@ -546,14 +517,14 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
> >  	/* Exclude Backup region */
> >  	start = image->arch.backup_load_addr;
> >  	end = start + image->arch.backup_src_sz - 1;
> > -	ret = exclude_mem_range(cmem, start, end);
> > +	ret = crash_exclude_mem_range(cmem, start, end);
> >  	if (ret)
> >  		return ret;
> >  
> >  	/* Exclude elf header region */
> >  	start = image->arch.elf_load_addr;
> >  	end = start + image->arch.elf_headers_sz - 1;
> > -	return exclude_mem_range(cmem, start, end);
> > +	return crash_exclude_mem_range(cmem, start, end);
> >  }
> >  
> >  /* Prepare memory map for crash dump kernel */
> > -- 
> > 2.16.2
> > 
> 
> Thanks
> Dave
