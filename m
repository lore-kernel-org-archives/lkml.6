Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934693AbeBMKAZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:00:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:55363 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933416AbeBMKAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:00:19 -0500
Date: Tue, 13 Feb 2018 11:00:16 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au, broonie@kernel.org
Subject: Re: ppc elf_map breakage with MAP_FIXED_NOREPLACE
Message-ID: <20180213100016.GL3443@dhcp22.suse.cz>
References: <15da8c87-e6db-13aa-01c8-a913656bfdb6@linux.vnet.ibm.com>
 <6db9b33d-fd46-c529-b357-3397926f0733@linux.vnet.ibm.com>
 <20180129132235.GE21609@dhcp22.suse.cz>
 <87k1w081e7.fsf@concordia.ellerman.id.au>
 <20180130094205.GS21609@dhcp22.suse.cz>
 <5eccdc1b-6a10-b48a-c63f-295f69473d97@linux.vnet.ibm.com>
 <20180131131937.GA6740@dhcp22.suse.cz>
 <bfecda5e-ae8b-df91-0add-df6322b42a70@linux.vnet.ibm.com>
 <20180201134829.GL21609@dhcp22.suse.cz>
 <b0a751c4-9552-87b4-c768-3e1b02c18b5c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a751c4-9552-87b4-c768-3e1b02c18b5c@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-02-18 12:19:18, Anshuman Khandual wrote:
> On 02/01/2018 07:18 PM, Michal Hocko wrote:
> > On Thu 01-02-18 08:43:34, Anshuman Khandual wrote:
> > [...]
> >> $dmesg | grep elf_brk
> >> [    9.571192] elf_brk 10030328 elf_bss 10030000
> >>
> >> static int load_elf_binary(struct linux_binprm *bprm)
> >> ---------------------
> >>
> >> 	if (unlikely (elf_brk > elf_bss)) {
> >> 			unsigned long nbyte;
> >> 	            
> >> 			/* There was a PT_LOAD segment with p_memsz > p_filesz
> >> 			   before this one. Map anonymous pages, if needed,
> >> 			   and clear the area.  */
> >> 			retval = set_brk(elf_bss + load_bias,
> >> 					 elf_brk + load_bias,
> >> 					 bss_prot);
> >>
> >>
> >> ---------------------
> > 
> > Just a blind shot... Does the following make any difference?
> > ---
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 021fe78998ea..04b24d00c911 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -895,7 +895,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  	   the correct location in memory. */
> >  	for(i = 0, elf_ppnt = elf_phdata;
> >  	    i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
> > -		int elf_prot = 0, elf_flags;
> > +		int elf_prot = 0, elf_flags, elf_fixed = MAP_FIXED_NOREPLACE;
> >  		unsigned long k, vaddr;
> >  		unsigned long total_size = 0;
> >  
> > @@ -927,6 +927,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  					 */
> >  				}
> >  			}
> > +			elf_fixed = MAP_FIXED;
> >  		}
> >  
> >  		if (elf_ppnt->p_flags & PF_R)
> > @@ -944,7 +945,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  		 * the ET_DYN load_addr calculations, proceed normally.
> >  		 */
> >  		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
> > -			elf_flags |= MAP_FIXED_NOREPLACE;
> > +			elf_flags |= elf_fixed;
> >  		} else if (loc->elf_ex.e_type == ET_DYN) {
> >  			/*
> >  			 * This logic is run once for the first LOAD Program
> > @@ -980,7 +981,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  				load_bias = ELF_ET_DYN_BASE;
> >  				if (current->flags & PF_RANDOMIZE)
> >  					load_bias += arch_mmap_rnd();
> > -				elf_flags |= MAP_FIXED_NOREPLACE;
> > +				elf_flags |= elf_fixed;
> >  			} else
> >  				load_bias = 0;
> >  
> > 
> 
> Yeah, it does solve the problem on mmotm-2018-01-25-16-20.

Thanks a lot for testing! I will post an RFC patch shortly.

-- 
Michal Hocko
SUSE Labs
