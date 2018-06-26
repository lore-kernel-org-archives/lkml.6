Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882C5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7A326856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7A326856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933482AbeFZKAQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:00:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:2950 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbeFZKAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:00:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 03:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="66399919"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2018 03:00:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E4F44F8; Tue, 26 Jun 2018 13:00:09 +0300 (EEST)
Date:   Tue, 26 Jun 2018 13:00:09 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] x86/mm: don't free p4d table when it is folded at
 runtime.
Message-ID: <20180626100009.2uppa3qjbvtyztsz@black.fi.intel.com>
References: <20180625102427.15015-1-aryabinin@virtuozzo.com>
 <20180625115038.6jezjq3wjqesrl6j@kshutemo-mobl1>
 <20180626074049.GA8970@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626074049.GA8970@localhost.localdomain>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:40:49AM +0000, Baoquan He wrote:
> Hi Kirill,
> 
> On 06/25/18 at 02:50pm, Kirill A. Shutemov wrote:
> > On Mon, Jun 25, 2018 at 01:24:27PM +0300, Andrey Ryabinin wrote:
> > > When the p4d page table layer is folded at runtime, the p4d_free()
> > > should do nothing, the same as in <asm-generic/pgtable-nop4d.h>.
> > > 
> > > It seems this bug should cause double-free in efi_call_phys_epilog(),
> > > but I don't know how to trigger that code path, so I can't confirm that
> > > by testing.
> > 
> > + Baoquan, Matt.
> > 
> > There's other bug in the efi_call_phys_epilog() that prevents the bug from
> > being triggered.
> > 
> > With the patch below. You can trigger the bug with efi=old_map in kernel
> > command line + KALSR and CONFIG_X86_5LEVEL=y:
> > 
> > 	page:fffff6bec0000000 count:0 mapcount:1 mapping:0000000000000000 index:0x0
> > 	flags: 0x800(reserved)
> > 	raw: 0000000000000800 fffff6bec0000008 fffff6bec0000008 0000000000000000
> > 	raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > 	page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> > 	------------[ cut here ]------------
> > 	kernel BUG at /home/kas/linux/la57/include/linux/mm.h:499!
> > 	invalid opcode: 0000 [#1] PREEMPT SMP
> > 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc2-00037-g6f0d349d922b-dirty #58
> > 	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> > 	RIP: 0010:__free_pages+0x28/0x30
> > 	Code: 00 00 8b 47 34 85 c0 74 15 f0 ff 4f 34 75 09 85 f6 74 06 e9 ca d8 ff ff c3 e9 64 ff ff ff 48
> > 	RSP: 0000:ffffffff9a403e90 EFLAGS: 00000246
> > 	RAX: 000000000000003e RBX: ffffffff9a41d000 RCX: 0000000000000002
> > 	RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000ffffffff
> > 	RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > 	R10: 0000000000000000 R11: 0000000000000000 R12: ffff9092af089000
> > 	R13: ffffffff9a598a80 R14: 0000000000000001 R15: 0000000000000001
> > 	FS:  0000000000000000(0000) GS:ffff9092bfc00000(0000) knlGS:0000000000000000
> > 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	CR2: ffff9092bffff000 CR3: 0000000198e1d000 CR4: 00000000000006b0
> > 	Call Trace:
> > 	 efi_call_phys_epilog+0x17d/0x1bb
> > 	 efi_enter_virtual_mode+0x457/0x4ca
> > 	 start_kernel+0x443/0x4dc
> > 	 secondary_startup_64+0xb7/0xc0
> > 	Modules linked in:
> > 	---[ end trace 61e271260b11acdd ]---
> > 
> > I'll send patch for efi_call_phys_epilog().
> > 
> > > 
> > > Fixes: 98219dda2ab5 ("x86/mm: Fold p4d page table layer at runtime")
> > > Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > 
> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: stable@vger.kernel.org # 4.17
> > 
> > > ---
> > >  arch/x86/include/asm/pgalloc.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
> > > index ada6410fd2ec..fbd578daa66e 100644
> > > --- a/arch/x86/include/asm/pgalloc.h
> > > +++ b/arch/x86/include/asm/pgalloc.h
> > > @@ -184,6 +184,9 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
> > >  
> > >  static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
> > >  {
> > > +	if (!pgtable_l5_enabled())
> > > +		return;
> > > +
> > >  	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
> > >  	free_page((unsigned long)p4d);
> > >  }
> > 
> > diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> > index e01f7ceb9e7a..77873ce700ae 100644
> > --- a/arch/x86/platform/efi/efi_64.c
> > +++ b/arch/x86/platform/efi/efi_64.c
> > @@ -166,14 +166,14 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
> >                 pgd = pgd_offset_k(pgd_idx * PGDIR_SIZE);
> >                 set_pgd(pgd_offset_k(pgd_idx * PGDIR_SIZE), save_pgd[pgd_idx]);
> > 
> > -               if (!(pgd_val(*pgd) & _PAGE_PRESENT))
> > +               if (!pgd_present(*pgd))
> >                         continue;
> 
> I may not understand boot-time p4d folding. Here p4d is folded, why
> pgd_present() need always return 1 if p4d folded?

Yeah. This is confusing. Basically, we pretend that p4d level consist of 1
entry, with the same value as pgd above. We say that pgd is always present
and all checks happens on p4d level.

It's not specific to boot-time folding. Compilet-time folding doing the
same. See include/asm-generic/pgtable-nop4d.h (and the rest -nop?d.h)

-- 
 Kirill A. Shutemov
