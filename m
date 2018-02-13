Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934700AbeBMKEu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:04:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:55764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933964AbeBMKEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:04:43 -0500
Date: Tue, 13 Feb 2018 11:04:40 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH] elf: enforce MAP_FIXED on overlaying elf segments (was:
 Re: ppc elf_map breakage with MAP_FIXED_NOREPLACE)
Message-ID: <20180213100440.GM3443@dhcp22.suse.cz>
References: <6db9b33d-fd46-c529-b357-3397926f0733@linux.vnet.ibm.com>
 <20180129132235.GE21609@dhcp22.suse.cz>
 <87k1w081e7.fsf@concordia.ellerman.id.au>
 <20180130094205.GS21609@dhcp22.suse.cz>
 <5eccdc1b-6a10-b48a-c63f-295f69473d97@linux.vnet.ibm.com>
 <20180131131937.GA6740@dhcp22.suse.cz>
 <bfecda5e-ae8b-df91-0add-df6322b42a70@linux.vnet.ibm.com>
 <20180201131007.GJ21609@dhcp22.suse.cz>
 <20180201134026.GK21609@dhcp22.suse.cz>
 <CAGXu5j+fo0Z_ax2O10A-3D3puLhnX+o5M4Lp3TBsnE=NtFCjpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+fo0Z_ax2O10A-3D3puLhnX+o5M4Lp3TBsnE=NtFCjpw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-02-18 07:55:14, Kees Cook wrote:
> On Fri, Feb 2, 2018 at 12:40 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Thu 01-02-18 14:10:07, Michal Hocko wrote:
> > Thanks a lot to Michael Matz for his background. He has pointed me to
> > the following two segments from your binary[1]
> >   LOAD           0x0000000000000000 0x0000000010000000 0x0000000010000000
> >                  0x0000000000013a8c 0x0000000000013a8c  R E    10000
> >   LOAD           0x000000000001fd40 0x000000001002fd40 0x000000001002fd40
> >                  0x00000000000002c0 0x00000000000005e8  RW     10000
> >   LOAD           0x0000000000020328 0x0000000010030328 0x0000000010030328
> >                  0x0000000000000384 0x00000000000094a0  RW     10000
> >
> > That binary has two RW LOAD segments, the first crosses a page border
> > into the second
> > 0x1002fd40 (LOAD2-vaddr) + 0x5e8 (LOAD2-memlen) == 0x10030328 (LOAD3-vaddr)
> >
> > He says
> > : This is actually an artifact of RELRO machinism.  The first RW mapping
> > : will be remapped as RO after relocations are applied (to increase
> > : security).
> > : Well, to be honest, normal relro binaries also don't have more than
> > : two LOAD segments, so whatever RHEL did to their compilation options,
> > : it's something in addition to just relro (which can be detected by
> > : having a GNU_RELRO program header)
> > : But it definitely has something to do with relro, it's just not the
> > : whole story yet.
> >
> > I am still trying to wrap my head around all this, but it smells rather
> > dubious to map different segments over the same page. Is this something
> > that might happen widely and therefore MAP_FIXED_NOREPLACE is a no-go
> > when loading ELF segments? Or is this a special case we can detect?
> 
> Eww. FWIW, I would expect that to be rare and detectable.

OK, so Anshuman has confirmed [1] that the patch below fixes the issue
for him. I am sending this as an RFC because this is not really my area
and load_elf_binary is obscure as hell. The changelog could see much
more clear wording than I am able to provide. Any help would be highly
appreciated.

[1] http://lkml.kernel.org/r/b0a751c4-9552-87b4-c768-3e1b02c18b5c@linux.vnet.ibm.com

>From 97e7355a6dc31a73005fa806566a57eb5c38032b Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Tue, 13 Feb 2018 10:50:53 +0100
Subject: [PATCH] elf: enforce MAP_FIXED on overlaying elf segments

Anshuman has reported that some ELF binaries in his environment fail to
start with
 [   23.423642] 9148 (sed): Uhuuh, elf segment at 0000000010030000 requested but the memory is mapped already
 [   23.423706] requested [10030000, 10040000] mapped [10030000, 10040000] 100073 anon

The reason is that the above binary has overlapping elf segments:
  LOAD           0x0000000000000000 0x0000000010000000 0x0000000010000000
                 0x0000000000013a8c 0x0000000000013a8c  R E    10000
  LOAD           0x000000000001fd40 0x000000001002fd40 0x000000001002fd40
                 0x00000000000002c0 0x00000000000005e8  RW     10000
  LOAD           0x0000000000020328 0x0000000010030328 0x0000000010030328
                 0x0000000000000384 0x00000000000094a0  RW     10000

That binary has two RW LOAD segments, the first crosses a page border
into the second

0x1002fd40 (LOAD2-vaddr) + 0x5e8 (LOAD2-memlen) == 0x10030328 (LOAD3-vaddr)

Handle this situation by enforcing MAP_FIXED when we establish a
temporary brk VMA to handle overlapping segments. All other mappings
will still use MAP_FIXED_NOREPLACE.

Fixes: fs, elf: drop MAP_FIXED usage from elf_map
Reported-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 fs/binfmt_elf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 2f492dfcabde..4679d1d945f9 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -895,7 +895,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	   the correct location in memory. */
 	for(i = 0, elf_ppnt = elf_phdata;
 	    i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
-		int elf_prot = 0, elf_flags;
+		int elf_prot = 0, elf_flags, elf_fixed = MAP_FIXED_NOREPLACE;
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
 
@@ -927,6 +927,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 					 */
 				}
 			}
+
+			/*
+			 * Some binaries have overlapping elf segments and then
+			 * we have to forcefully map over an existing mapping
+			 * e.g. over this newly established brk mapping.
+			 */
+			elf_fixed = MAP_FIXED;
 		}
 
 		if (elf_ppnt->p_flags & PF_R)
@@ -944,7 +951,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		 * the ET_DYN load_addr calculations, proceed normally.
 		 */
 		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
-			elf_flags |= MAP_FIXED_NOREPLACE;
+			elf_flags |= elf_fixed;
 		} else if (loc->elf_ex.e_type == ET_DYN) {
 			/*
 			 * This logic is run once for the first LOAD Program
@@ -980,7 +987,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				load_bias = ELF_ET_DYN_BASE;
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
-				elf_flags |= MAP_FIXED_NOREPLACE;
+				elf_flags |= elf_fixed;
 			} else
 				load_bias = 0;
 
-- 
2.15.1

-- 
Michal Hocko
SUSE Labs
