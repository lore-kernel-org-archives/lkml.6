Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeDKJua (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:50:30 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:49739 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeDKJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:50:29 -0400
X-IronPort-AV: E=Sophos;i="5.48,435,1517875200";
   d="scan'208";a="71367282"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: "'Julien Grall'" <julien.grall@arm.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: RE: [PATCH v4] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
Thread-Topic: [PATCH v4] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
Thread-Index: AQHT0KGz2/bKikUusU6D77v3t5YqI6P7MPiAgAAiKpA=
Date: Wed, 11 Apr 2018 09:50:25 +0000
Message-ID: <68f3d9b993d644e8ab137ccecceb575c@AMSPEX02CL03.citrite.net>
References: <20180410075820.11081-1-paul.durrant@citrix.com>
 <8fff31d5-7eb4-33e8-0fc8-c5bb1ab47eba@arm.com>
In-Reply-To: <8fff31d5-7eb4-33e8-0fc8-c5bb1ab47eba@arm.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3B9oZDI009400

> -----Original Message-----
> From: Julien Grall [mailto:julien.grall@arm.com]
> Sent: 11 April 2018 10:46
> To: Paul Durrant <Paul.Durrant@citrix.com>; xen-devel@lists.xenproject.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: Juergen Gross <jgross@suse.com>; Thomas Gleixner
> <tglx@linutronix.de>; Stefano Stabellini <sstabellini@kernel.org>; Ingo
> Molnar <mingo@redhat.com>
> Subject: Re: [PATCH v4] xen/privcmd: add
> IOCTL_PRIVCMD_MMAP_RESOURCE
> 
> Hi,
> 
> On 10/04/18 08:58, Paul Durrant wrote:
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
> > +		for (i = 0; i < kdata.num; i++)
> > +			pfns[i] = page_to_pfn(pages[i]);
> 
> I don't think this is going to work well if the hypervisor is using a
> different granularity for the page.
> 
> Imagine Xen is using 4K but the kernel 64K. You would end up to have the
> resource not mapped contiguously in the memory.

Good point. I do need to take account of the kernel page size in this case.

  Paul

> 
> Cheers,
> 
> --
> Julien Grall
