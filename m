Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935873AbeCBFgX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:36:23 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35031 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935856AbeCBFgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:36:21 -0500
X-Google-Smtp-Source: AG47ELvGj4EMsNQ3o0hTtobCc5ex2esZHmBLs8fDSWT5ZrGUF9XT6QXIpAoqFjLMyGlERXw9UNtrOw==
Date: Fri, 2 Mar 2018 14:36:33 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Dave Young <dyoung@redhat.com>
Cc: vgoyal@redhat.com, bhe@redhat.com, mpe@ellerman.id.au,
        bauerman@linux.vnet.ibm.com, prudo@linux.vnet.ibm.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 5/7] x86: kexec_file: lift CRASH_MAX_RANGES limit on
 crash_mem buffer
Message-ID: <20180302053632.GP6019@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, vgoyal@redhat.com, bhe@redhat.com,
        mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20180227044814.24808-1-takahiro.akashi@linaro.org>
 <20180227044814.24808-6-takahiro.akashi@linaro.org>
 <20180302053153.GC2952@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302053153.GC2952@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 01:31:53PM +0800, Dave Young wrote:
> On 02/27/18 at 01:48pm, AKASHI Takahiro wrote:
> > While CRASH_MAX_RANGES (== 16) seems to be good enough, fixed-number
> > array is not a good idea in general.
> > 
> > In this patch, size of crash_mem buffer is calculated as before and
> > the buffer is now dynamically allocated. This change also allows removing
> > crash_elf_data structure.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/kernel/crash.c | 80 ++++++++++++++++++-------------------------------
> >  1 file changed, 29 insertions(+), 51 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index 913fd8021f8a..bfc37ad20d4a 100644
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
> > @@ -217,26 +199,29 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
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
> 
> I know it is probably not possible fail here, but for safe we can check
> if nr_ranges == 0

OK.

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
> 
> vzalloc will be better. 

Sure.

-Takahiro AKASHI

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
> >  static int exclude_mem_range(struct crash_mem *mem,
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
> > @@ -314,11 +297,10 @@ static int exclude_mem_range(struct crash_mem *mem,
> >  
> >  /*
> >   * Look for any unwanted ranges between mstart, mend and remove them. This
> > - * might lead to split and split ranges are put in ced->mem.ranges[] array
> > + * might lead to split and split ranges are put in cmem->ranges[] array
> >   */
> > -static int elf_header_exclude_ranges(struct crash_elf_data *ced)
> > +static int elf_header_exclude_ranges(struct crash_mem *cmem)
> >  {
> > -	struct crash_mem *cmem = &ced->mem;
> >  	int ret = 0;
> >  
> >  	/* Exclude crashkernel region */
> > @@ -337,8 +319,7 @@ static int elf_header_exclude_ranges(struct crash_elf_data *ced)
> >  
> >  static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> >  {
> > -	struct crash_elf_data *ced = arg;
> > -	struct crash_mem *cmem = &ced->mem;
> > +	struct crash_mem *cmem = arg;
> >  
> >  	cmem->ranges[cmem->nr_ranges].start = res->start;
> >  	cmem->ranges[cmem->nr_ranges].end = res->end;
> > @@ -347,7 +328,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> >  	return 0;
> >  }
> >  
> > -static int prepare_elf64_headers(struct crash_elf_data *ced, int kernel_map,
> > +static int prepare_elf64_headers(struct crash_mem *cmem, int kernel_map,
> >  		void **addr, unsigned long *sz)
> >  {
> >  	Elf64_Ehdr *ehdr;
> > @@ -356,12 +337,11 @@ static int prepare_elf64_headers(struct crash_elf_data *ced, int kernel_map,
> >  	unsigned char *buf, *bufp;
> >  	unsigned int cpu, i;
> >  	unsigned long long notes_addr;
> > -	struct crash_mem *cmem = &ced->mem;
> >  	unsigned long mstart, mend;
> >  
> >  	/* extra phdr for vmcoreinfo elf note */
> >  	nr_phdr = nr_cpus + 1;
> > -	nr_phdr += ced->max_nr_ranges;
> > +	nr_phdr += cmem->nr_ranges;
> >  
> >  	/*
> >  	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
> > @@ -455,29 +435,27 @@ static int prepare_elf64_headers(struct crash_elf_data *ced, int kernel_map,
> >  static int prepare_elf_headers(struct kimage *image, void **addr,
> >  					unsigned long *sz)
> >  {
> > -	struct crash_elf_data *ced;
> > +	struct crash_mem *cmem;
> >  	Elf64_Ehdr *ehdr;
> >  	Elf64_Phdr *phdr;
> >  	int ret, i;
> >  
> > -	ced = kzalloc(sizeof(*ced), GFP_KERNEL);
> > -	if (!ced)
> > +	cmem = fill_up_crash_elf_data();
> > +	if (!cmem)
> >  		return -ENOMEM;
> >  
> > -	fill_up_crash_elf_data(ced, image);
> > -
> > -	ret = walk_system_ram_res(0, -1, ced,
> > +	ret = walk_system_ram_res(0, -1, cmem,
> >  				prepare_elf64_ram_headers_callback);
> >  	if (ret)
> >  		goto out;
> >  
> >  	/* Exclude unwanted mem ranges */
> > -	ret = elf_header_exclude_ranges(ced);
> > +	ret = elf_header_exclude_ranges(cmem);
> >  	if (ret)
> >  		goto out;
> >  
> >  	/* By default prepare 64bit headers */
> > -	ret =  prepare_elf64_headers(ced,
> > +	ret =  prepare_elf64_headers(cmem,
> >  				(int)IS_ENABLED(CONFIG_X86_64), addr, sz);
> >  	if (ret)
> >  		goto out;
> > @@ -496,7 +474,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
> >  			break;
> >  		}
> >  out:
> > -	kfree(ced);
> > +	vfree(cmem);
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.16.2
> > 
> 
> Thanks
> Dave
