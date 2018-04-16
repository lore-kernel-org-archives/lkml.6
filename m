Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754603AbeDPL4k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:56:40 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:52964 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754156AbeDPL4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:56:39 -0400
Date: Mon, 16 Apr 2018 13:56:25 +0200
From: Johannes Hirte <johannes.hirte@datenkhaos.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, bp@suse.de,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Message-ID: <20180416115624.GA1543@probook>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180201184813.82253-3-Yazen.Ghannam@amd.com>
 <20180414004230.GA2033@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180414004230.GA2033@probook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018 Apr 14, Johannes Hirte wrote:
> On 2018 Feb 01, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > The block address is saved after the block is initialized when
> > threshold_init_device() is called.
> > 
> > Use the saved block address, if available, rather than trying to
> > rediscover it.
> > 
> > We can avoid some *on_cpu() calls in the init path that will cause a
> > call trace when resuming from suspend.
> > 
> > Cc: <stable@vger.kernel.org> # 4.14.x
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > index bf53b4549a17..8c4f8f30c779 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > @@ -436,6 +436,21 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
> >  {
> >  	u32 addr = 0, offset = 0;
> >  
> > +	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
> > +		return addr;
> > +
> > +	/* Get address from already initialized block. */
> > +	if (per_cpu(threshold_banks, cpu)) {
> > +		struct threshold_bank *bankp = per_cpu(threshold_banks, cpu)[bank];
> > +
> > +		if (bankp && bankp->blocks) {
> > +			struct threshold_block *blockp = &bankp->blocks[block];
> > +
> > +			if (blockp)
> > +				return blockp->address;
> > +		}
> > +	}
> > +
> >  	if (mce_flags.smca) {
> >  		if (smca_get_bank_type(bank) == SMCA_RESERVED)
> >  			return addr;
> > -- 
> > 2.14.1
> 
> I have a KASAN: slab-out-of-bounds, and git bisect points me to this
> change:
> 
> Apr 13 00:40:32 probook kernel: ==================================================================
> Apr 13 00:40:32 probook kernel: BUG: KASAN: slab-out-of-bounds in get_block_address.isra.3+0x1e9/0x520
> Apr 13 00:40:32 probook kernel: Read of size 4 at addr ffff8803f165ddf4 by task swapper/0/1
> Apr 13 00:40:32 probook kernel: 
> Apr 13 00:40:32 probook kernel: CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.0-10757-g4ca8ba4ccff9 #532
> Apr 13 00:40:32 probook kernel: Hardware name: HP HP ProBook 645 G2/80FE, BIOS N77 Ver. 01.12 12/19/2017
> Apr 13 00:40:32 probook kernel: Call Trace:
> Apr 13 00:40:32 probook kernel:  dump_stack+0x5b/0x8b
> Apr 13 00:40:32 probook kernel:  ? get_block_address.isra.3+0x1e9/0x520
> Apr 13 00:40:32 probook kernel:  print_address_description+0x65/0x270
> Apr 13 00:40:32 probook kernel:  ? get_block_address.isra.3+0x1e9/0x520
> Apr 13 00:40:32 probook kernel:  kasan_report+0x232/0x350
> Apr 13 00:40:32 probook kernel:  get_block_address.isra.3+0x1e9/0x520
> Apr 13 00:40:32 probook kernel:  ? kobject_init_and_add+0xde/0x130
> Apr 13 00:40:32 probook kernel:  ? get_name+0x390/0x390
> Apr 13 00:40:32 probook kernel:  ? kasan_unpoison_shadow+0x30/0x40
> Apr 13 00:40:32 probook kernel:  ? kasan_kmalloc+0xa0/0xd0
> Apr 13 00:40:32 probook kernel:  allocate_threshold_blocks+0x12c/0xc60
> Apr 13 00:40:32 probook kernel:  ? kobject_add_internal+0x800/0x800
> Apr 13 00:40:32 probook kernel:  ? get_block_address.isra.3+0x520/0x520
> Apr 13 00:40:32 probook kernel:  ? kasan_kmalloc+0xa0/0xd0
> Apr 13 00:40:32 probook kernel:  mce_threshold_create_device+0x35b/0x990
> Apr 13 00:40:32 probook kernel:  ? init_special_inode+0x1d0/0x230
> Apr 13 00:40:32 probook kernel:  threshold_init_device+0x98/0xa7
> Apr 13 00:40:32 probook kernel:  ? mcheck_vendor_init_severity+0x43/0x43
> Apr 13 00:40:32 probook kernel:  do_one_initcall+0x76/0x30c
> Apr 13 00:40:32 probook kernel:  ? trace_event_raw_event_initcall_finish+0x190/0x190
> Apr 13 00:40:32 probook kernel:  ? kasan_unpoison_shadow+0xb/0x40
> Apr 13 00:40:32 probook kernel:  ? kasan_unpoison_shadow+0x30/0x40
> Apr 13 00:40:32 probook kernel:  kernel_init_freeable+0x3d6/0x471
> Apr 13 00:40:32 probook kernel:  ? rest_init+0xf0/0xf0
> Apr 13 00:40:32 probook kernel:  kernel_init+0xa/0x120
> Apr 13 00:40:32 probook kernel:  ? rest_init+0xf0/0xf0
> Apr 13 00:40:32 probook kernel:  ret_from_fork+0x22/0x40
> Apr 13 00:40:32 probook kernel:
> Apr 13 00:40:32 probook kernel: Allocated by task 1:
> Apr 13 00:40:32 probook kernel:  kasan_kmalloc+0xa0/0xd0
> Apr 13 00:40:32 probook kernel:  kmem_cache_alloc_trace+0xf3/0x1f0
> Apr 13 00:40:32 probook kernel:  allocate_threshold_blocks+0x1bc/0xc60
> Apr 13 00:40:32 probook kernel:  mce_threshold_create_device+0x35b/0x990
> Apr 13 00:40:32 probook kernel:  threshold_init_device+0x98/0xa7
> Apr 13 00:40:32 probook kernel:  do_one_initcall+0x76/0x30c
> Apr 13 00:40:32 probook kernel:  kernel_init_freeable+0x3d6/0x471
> Apr 13 00:40:32 probook kernel:  kernel_init+0xa/0x120
> Apr 13 00:40:32 probook kernel:  ret_from_fork+0x22/0x40
> Apr 13 00:40:32 probook kernel: 
> Apr 13 00:40:32 probook kernel: Freed by task 0:
> Apr 13 00:40:32 probook kernel: (stack is not available)
> Apr 13 00:40:32 probook kernel: 
> Apr 13 00:40:32 probook kernel: The buggy address belongs to the object at ffff8803f165dd80
>  which belongs to the cache kmalloc-128 of size 128
> Apr 13 00:40:32 probook kernel: The buggy address is located 116 bytes inside of
>  128-byte region [ffff8803f165dd80, ffff8803f165de00)
>  Apr 13 00:40:32 probook kernel: The buggy address belongs to the page:
> Apr 13 00:40:32 probook kernel: page:ffffea000fc59740 count:1 mapcount:0 mapping:0000000000000000 index:0x0
> Apr 13 00:40:32 probook kernel: flags: 0x2000000000000100(slab)
> Apr 13 00:40:32 probook kernel: raw: 2000000000000100 0000000000000000 0000000000000000 0000000180150015
> Apr 13 00:40:32 probook kernel: raw: dead000000000100 dead000000000200 ffff8803f3403340 0000000000000000
> Apr 13 00:40:32 probook kernel: page dumped because: kasan: bad access detected
> Apr 13 00:40:32 probook kernel: 
> Apr 13 00:40:32 probook kernel: Memory state around the buggy address:
> Apr 13 00:40:32 probook kernel:  ffff8803f165dc80: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
> Apr 13 00:40:32 probook kernel:  ffff8803f165dd00: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> Apr 13 00:40:32 probook kernel: >ffff8803f165dd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
> Apr 13 00:40:32 probook kernel:                                                              ^
> Apr 13 00:40:32 probook kernel:  ffff8803f165de00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> Apr 13 00:40:32 probook kernel:  ffff8803f165de80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> Apr 13 00:40:32 probook kernel: ==================================================================
> 

Putting the whole chaching part under the

if (mce_flags.smca) { 

solved the issue on my Carrizo.


-- 
Regards,
  Johannes
