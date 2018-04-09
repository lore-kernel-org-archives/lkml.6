Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeDIIsB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:48:01 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:25552 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeDIIsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:48:00 -0400
X-IronPort-AV: E=Sophos;i="5.48,426,1517875200";
   d="scan'208";a="71232168"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: "'Boris Ostrovsky'" <boris.ostrovsky@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: RE: [PATCH v2] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
Thread-Topic: [PATCH v2] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
Thread-Index: AQHTzPTGdqvISTmwUkqDroW+WI1gIKPyoM0AgAWB+VA=
Date: Mon, 9 Apr 2018 08:47:58 +0000
Message-ID: <1b3fc1c2e24d46539473e6191b3c3bd4@AMSPEX02CL03.citrite.net>
References: <20180405154249.33929-1-paul.durrant@citrix.com>
 <727b9efc-f448-2955-6a47-774de330bcd8@oracle.com>
In-Reply-To: <727b9efc-f448-2955-6a47-774de330bcd8@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w398m7Ba017682

> -----Original Message-----
> From: Boris Ostrovsky [mailto:boris.ostrovsky@oracle.com]
> Sent: 05 April 2018 23:34
> To: Paul Durrant <Paul.Durrant@citrix.com>; x86@kernel.org; xen-
> devel@lists.xenproject.org; linux-kernel@vger.kernel.org
> Cc: Juergen Gross <jgross@suse.com>; Thomas Gleixner
> <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>
> Subject: Re: [PATCH v2] xen/privcmd: add
> IOCTL_PRIVCMD_MMAP_RESOURCE
> 
> On 04/05/2018 11:42 AM, Paul Durrant wrote:
> > My recent Xen patch series introduces a new HYPERVISOR_memory_op to
> > support direct priv-mapping of certain guest resources (such as ioreq
> > pages, used by emulators) by a tools domain, rather than having to access
> > such resources via the guest P2M.
> >
> > This patch adds the necessary infrastructure to the privcmd driver and
> > Xen MMU code to support direct resource mapping.
> >
> > NOTE: The adjustment in the MMU code is partially cosmetic. Xen will now
> >       allow a PV tools domain to map guest pages either by GFN or MFN, thus
> >       the term 'mfn' has been swapped for 'pfn' in the lower layers of the
> >       remap code.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> >
> > v2:
> >  - Fix bug when mapping multiple pages of a resource
> 
> 
> Only a few nits below.
> 
> > ---
> >  arch/x86/xen/mmu.c             |  50 +++++++++++-----
> >  drivers/xen/privcmd.c          | 130
> +++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/xen/privcmd.h     |  11 ++++
> >  include/xen/interface/memory.h |  66 +++++++++++++++++++++
> >  include/xen/interface/xen.h    |   7 ++-
> >  include/xen/xen-ops.h          |  24 +++++++-
> >  6 files changed, 270 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
> > index d33e7dbe3129..8453d7be415c 100644
> > --- a/arch/x86/xen/mmu.c
> > +++ b/arch/x86/xen/mmu.c
> > @@ -65,37 +65,42 @@ static void xen_flush_tlb_all(void)
> >  #define REMAP_BATCH_SIZE 16
> >
> >  struct remap_data {
> > -	xen_pfn_t *mfn;
> > +	xen_pfn_t *pfn;
> >  	bool contiguous;
> > +	bool no_translate;
> >  	pgprot_t prot;
> >  	struct mmu_update *mmu_update;
> >  };
> >
> > -static int remap_area_mfn_pte_fn(pte_t *ptep, pgtable_t token,
> > +static int remap_area_pfn_pte_fn(pte_t *ptep, pgtable_t token,
> >  				 unsigned long addr, void *data)
> >  {
> >  	struct remap_data *rmd = data;
> > -	pte_t pte = pte_mkspecial(mfn_pte(*rmd->mfn, rmd->prot));
> > +	pte_t pte = pte_mkspecial(mfn_pte(*rmd->pfn, rmd->prot));
> >
> >  	/* If we have a contiguous range, just update the mfn itself,
> >  	   else update pointer to be "next mfn". */
> 
> This probably also needs to be updated (and while at it, comment style
> fixed)
> 

Ok.

> >  	if (rmd->contiguous)
> > -		(*rmd->mfn)++;
> > +		(*rmd->pfn)++;
> >  	else
> > -		rmd->mfn++;
> > +		rmd->pfn++;
> >
> > -	rmd->mmu_update->ptr = virt_to_machine(ptep).maddr |
> MMU_NORMAL_PT_UPDATE;
> > +	rmd->mmu_update->ptr = virt_to_machine(ptep).maddr;
> > +	rmd->mmu_update->ptr |= rmd->no_translate ?
> > +		MMU_PT_UPDATE_NO_TRANSLATE :
> > +		MMU_NORMAL_PT_UPDATE;
> >  	rmd->mmu_update->val = pte_val_ma(pte);
> >  	rmd->mmu_update++;
> >
> >  	return 0;
> >  }
> >
> > -static int do_remap_gfn(struct vm_area_struct *vma,
> > +static int do_remap_pfn(struct vm_area_struct *vma,
> >  			unsigned long addr,
> > -			xen_pfn_t *gfn, int nr,
> > +			xen_pfn_t *pfn, int nr,
> >  			int *err_ptr, pgprot_t prot,
> > -			unsigned domid,
> > +			unsigned int domid,
> > +			bool no_translate,
> >  			struct page **pages)
> >  {
> >  	int err = 0;
> > @@ -106,11 +111,12 @@ static int do_remap_gfn(struct vm_area_struct
> *vma,
> >
> >  	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) ==
> (VM_PFNMAP | VM_IO)));
> >
> > -	rmd.mfn = gfn;
> > +	rmd.pfn = pfn;
> >  	rmd.prot = prot;
> >  	/* We use the err_ptr to indicate if there we are doing a contiguous
> >  	 * mapping or a discontigious mapping. */
> 
> Style.
> 

I'm not modifying this comment but I'll fix it.

> >  	rmd.contiguous = !err_ptr;
> > +	rmd.no_translate = no_translate;
> >
> >  	while (nr) {
> >  		int index = 0;
> > @@ -121,7 +127,7 @@ static int do_remap_gfn(struct vm_area_struct
> *vma,
> >
> >  		rmd.mmu_update = mmu_update;
> >  		err = apply_to_page_range(vma->vm_mm, addr, range,
> > -					  remap_area_mfn_pte_fn, &rmd);
> > +					  remap_area_pfn_pte_fn, &rmd);
> >  		if (err)
> >  			goto out;
> >
> > @@ -175,7 +181,8 @@ int xen_remap_domain_gfn_range(struct
> vm_area_struct *vma,
> >  	if (xen_feature(XENFEAT_auto_translated_physmap))
> >  		return -EOPNOTSUPP;
> >
> > -	return do_remap_gfn(vma, addr, &gfn, nr, NULL, prot, domid,
> pages);
> > +	return do_remap_pfn(vma, addr, &gfn, nr, NULL, prot, domid, false,
> > +			    pages);
> >  }
> >  EXPORT_SYMBOL_GPL(xen_remap_domain_gfn_range);
> >
> > @@ -183,7 +190,7 @@ int xen_remap_domain_gfn_array(struct
> vm_area_struct *vma,
> >  			       unsigned long addr,
> >  			       xen_pfn_t *gfn, int nr,
> >  			       int *err_ptr, pgprot_t prot,
> > -			       unsigned domid, struct page **pages)
> > +			       unsigned int domid, struct page **pages)
> 
> Is this really necessary? And if it is, then why are other routines
> (e.g. xen_remap_domain_gfn_range() above) not updated as well?
> 

Ok. It's style fix-up but I can leave it.

> >  {
> >  	if (xen_feature(XENFEAT_auto_translated_physmap))
> >  		return xen_xlate_remap_gfn_array(vma, addr, gfn, nr,
> err_ptr,
> > @@ -194,10 +201,25 @@ int xen_remap_domain_gfn_array(struct
> vm_area_struct *vma,
> >  	 * cause of "wrong memory was mapped in".
> >  	 */
> >  	BUG_ON(err_ptr == NULL);
> > -	return do_remap_gfn(vma, addr, gfn, nr, err_ptr, prot, domid,
> pages);
> > +	return do_remap_pfn(vma, addr, gfn, nr, err_ptr, prot, domid,
> > +			    false, pages);
> >  }
> >  EXPORT_SYMBOL_GPL(xen_remap_domain_gfn_array);
> >
> > +int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
> > +			       unsigned long addr,
> > +			       xen_pfn_t *mfn, int nr,
> > +			       int *err_ptr, pgprot_t prot,
> > +			       unsigned int domid, struct page **pages)
> > +{
> > +	if (xen_feature(XENFEAT_auto_translated_physmap))
> > +		return -EOPNOTSUPP;
> > +
> > +	return do_remap_pfn(vma, addr, mfn, nr, err_ptr, prot, domid,
> > +			    true, pages);
> > +}
> > +EXPORT_SYMBOL_GPL(xen_remap_domain_mfn_array);
> > +
> >  /* Returns: 0 success */
> >  int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
> >  			       int nr, struct page **pages)
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index 1c909183c42a..cca809a204ab 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -33,6 +33,7 @@
> >  #include <xen/xen.h>
> >  #include <xen/privcmd.h>
> >  #include <xen/interface/xen.h>
> > +#include <xen/interface/memory.h>
> >  #include <xen/interface/hvm/dm_op.h>
> >  #include <xen/features.h>
> >  #include <xen/page.h>
> > @@ -722,6 +723,131 @@ static long privcmd_ioctl_restrict(struct file *file,
> void __user *udata)
> >  	return 0;
> >  }
> >
> > +struct remap_pfn {
> > +	struct mm_struct *mm;
> > +	struct page **pages;
> > +	pgprot_t prot;
> > +	unsigned long i;
> > +};
> > +
> > +static int remap_pfn(pte_t *ptep, pgtable_t token, unsigned long addr,
> 
> 
> Maybe remap_pfn_fn (to avoid name shadowing)?
> 

Ok.

> 
> > +		     void *data)
> > +{
> > +	struct remap_pfn *r = data;
> > +	struct page *page = r->pages[r->i];
> > +	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), r->prot));
> > +
> > +	set_pte_at(r->mm, addr, ptep, pte);
> > +	r->i++;
> > +
> > +	return 0;
> > +}
> > +
> > +static long privcmd_ioctl_mmap_resource(struct file *file, void __user
> *udata)
> > +{
> > +	struct privcmd_data *data = file->private_data;
> > +	struct mm_struct *mm = current->mm;
> > +	struct vm_area_struct *vma;
> > +	struct privcmd_mmap_resource kdata;
> > +	xen_pfn_t *pfns = NULL;
> > +	struct xen_mem_acquire_resource xdata;
> > +	int rc;
> > +
> > +	if (copy_from_user(&kdata, udata, sizeof(kdata)))
> > +		return -EFAULT;
> > +
> > +	/* If restriction is in place, check the domid matches */
> > +	if (data->domid != DOMID_INVALID && data->domid != kdata.dom)
> > +		return -EPERM;
> > +
> > +	down_write(&mm->mmap_sem);
> > +
> > +	vma = find_vma(mm, kdata.addr);
> > +	if (!vma || vma->vm_ops != &privcmd_vm_ops) {
> > +		rc = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	pfns = kcalloc(kdata.num, sizeof(*pfns), GFP_KERNEL);
> > +	if (!pfns) {
> > +		rc = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	if (xen_feature(XENFEAT_auto_translated_physmap)) {
> > +		struct page **pages;
> > +		unsigned int i;
> > +
> > +		rc = alloc_empty_pages(vma, kdata.num);
> > +		if (rc < 0)
> > +			goto out;
> > +
> > +		pages = vma->vm_private_data;
> > +		for (i = 0; i < kdata.num; i++) {
> > +			pfns[i] = page_to_pfn(pages[i]);
> > +			pr_info("pfn[%u] = %p\n", i, (void *)pfns[i]);
> > +		}
> > +	} else
> > +		vma->vm_private_data = PRIV_VMA_LOCKED;
> > +
> > +	memset(&xdata, 0, sizeof(xdata));
> > +	xdata.domid = kdata.dom;
> > +	xdata.type = kdata.type;
> > +	xdata.id = kdata.id;
> > +	xdata.frame = kdata.idx;
> > +	xdata.nr_frames = kdata.num;
> > +	set_xen_guest_handle(xdata.frame_list, pfns);
> > +
> > +	xen_preemptible_hcall_begin();
> > +	rc = HYPERVISOR_memory_op(XENMEM_acquire_resource,
> &xdata);
> > +	xen_preemptible_hcall_end();
> > +
> > +	if (rc)
> > +		goto out;
> > +
> > +	if (xen_feature(XENFEAT_auto_translated_physmap)) {
> > +		struct remap_pfn r = {
> > +			.mm = vma->vm_mm,
> > +			.pages = vma->vm_private_data,
> > +			.prot = vma->vm_page_prot,
> > +		};
> > +
> > +		rc = apply_to_page_range(r.mm, kdata.addr,
> > +					 kdata.num << PAGE_SHIFT,
> > +					 remap_pfn, &r);
> > +	} else {
> > +		unsigned int domid =
> > +			(xdata.flags & XENMEM_rsrc_acq_caller_owned) ?
> > +			DOMID_SELF : kdata.dom;
> > +		int num;
> > +
> > +		num = xen_remap_domain_mfn_array(vma,
> > +						 kdata.addr & PAGE_MASK,
> > +						 pfns, kdata.num, (int *)pfns,
> > +						 vma->vm_page_prot,
> > +						 domid,
> > +						 vma->vm_private_data);
> > +		if (num < 0)
> > +			rc = num;
> > +		else if (num != kdata.num) {
> > +			unsigned int i;
> > +
> > +			for (i = 0; i < num; i++) {
> > +				rc = pfns[i];
> > +				if (rc < 0)
> > +					break;
> > +			}
> > +		} else
> > +			rc = 0;
> > +	}
> > +
> > +out:
> > +	kfree(pfns);
> > +
> > +	up_write(&mm->mmap_sem);
> 
> I'd swap these two.
> 

Ok.

I'll need to fix the ARM build breakage too. V2 coming shortly.

  Paul

> 
> -boris
