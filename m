Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935904AbeCBGEg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 01:04:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932310AbeCBGEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 01:04:34 -0500
Date: Fri, 2 Mar 2018 14:04:24 +0800
From: Dave Young <dyoung@redhat.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, vgoyal@redhat.com,
        bhe@redhat.com, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 6/7] x86: kexec_file: clean up prepare_elf64_headers()
Message-ID: <20180302060424.GC15422@dhcp-128-65.nay.redhat.com>
References: <20180227044814.24808-1-takahiro.akashi@linaro.org>
 <20180227044814.24808-7-takahiro.akashi@linaro.org>
 <20180302053945.GD2952@dhcp-128-65.nay.redhat.com>
 <20180302055845.GR6019@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302055845.GR6019@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/18 at 02:58pm, AKASHI Takahiro wrote:
> On Fri, Mar 02, 2018 at 01:39:45PM +0800, Dave Young wrote:
> > On 02/27/18 at 01:48pm, AKASHI Takahiro wrote:
> > > removing bufp variable in prepare_elf64_headers() makes the code simpler
> > > and more understandable.
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > ---
> > >  arch/x86/kernel/crash.c | 18 +++++++-----------
> > >  1 file changed, 7 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > > index bfc37ad20d4a..a842fd847684 100644
> > > --- a/arch/x86/kernel/crash.c
> > > +++ b/arch/x86/kernel/crash.c
> > > @@ -334,7 +334,7 @@ static int prepare_elf64_headers(struct crash_mem *cmem, int kernel_map,
> > >  	Elf64_Ehdr *ehdr;
> > >  	Elf64_Phdr *phdr;
> > >  	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
> > > -	unsigned char *buf, *bufp;
> > > +	unsigned char *buf;
> > >  	unsigned int cpu, i;
> > >  	unsigned long long notes_addr;
> > >  	unsigned long mstart, mend;
> > > @@ -359,9 +359,8 @@ static int prepare_elf64_headers(struct crash_mem *cmem, int kernel_map,
> > >  	if (!buf)
> > >  		return -ENOMEM;
> > >  
> > > -	bufp = buf;
> > > -	ehdr = (Elf64_Ehdr *)bufp;
> > > -	bufp += sizeof(Elf64_Ehdr);
> > > +	ehdr = (Elf64_Ehdr *)buf;
> > > +	phdr = (Elf64_Phdr *)(ehdr + 1);
> > 
> > phdr should start with ehdr + sizeof(Elf64_Ehdr);
> 
> Well, it's a matter of rhetoric :)
> The values from both expressions are the same.
> Or do you mean my expression is confusing?

Oops, I interpret it as (Elf64_Phdr *)ehdr + 1;

Please ignore this comment then.

> 
> -Takahiro AKASHI
> 
> 
> > >  	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> > >  	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
> > >  	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
> > > @@ -377,33 +376,30 @@ static int prepare_elf64_headers(struct crash_mem *cmem, int kernel_map,
> > >  
> > >  	/* Prepare one phdr of type PT_NOTE for each present cpu */
> > >  	for_each_present_cpu(cpu) {
> > > -		phdr = (Elf64_Phdr *)bufp;
> > > -		bufp += sizeof(Elf64_Phdr);
> > >  		phdr->p_type = PT_NOTE;
> > >  		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
> > >  		phdr->p_offset = phdr->p_paddr = notes_addr;
> > >  		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
> > >  		(ehdr->e_phnum)++;
> > > +		phdr++;
> > >  	}
> > >  
> > >  	/* Prepare one PT_NOTE header for vmcoreinfo */
> > > -	phdr = (Elf64_Phdr *)bufp;
> > > -	bufp += sizeof(Elf64_Phdr);
> > >  	phdr->p_type = PT_NOTE;
> > >  	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
> > >  	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
> > >  	(ehdr->e_phnum)++;
> > > +	phdr++;
> > >  
> > >  	/* Prepare PT_LOAD type program header for kernel text region */
> > >  	if (kernel_map) {
> > > -		phdr = (Elf64_Phdr *)bufp;
> > > -		bufp += sizeof(Elf64_Phdr);
> > >  		phdr->p_type = PT_LOAD;
> > >  		phdr->p_flags = PF_R|PF_W|PF_X;
> > >  		phdr->p_vaddr = (Elf64_Addr)_text;
> > >  		phdr->p_filesz = phdr->p_memsz = _end - _text;
> > >  		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
> > > -		(ehdr->e_phnum)++;
> > > +		ehdr->e_phnum++;
> > > +		phdr++;
> > >  	}
> > >  
> > >  	/* Go through all the ranges in cmem->ranges[] and prepare phdr */
> > > -- 
> > > 2.16.2
> > > 
> > 
> > Thanks
> > Dave
