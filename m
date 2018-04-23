Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755216AbeDWKyT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:54:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754751AbeDWKyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:54:12 -0400
Date: Mon, 23 Apr 2018 03:54:09 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>, airlied@linux.ie,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: drm: tegra: Adding new typedef vm_fault_t
Message-ID: <20180423105409.GC2308@bombadil.infradead.org>
References: <20180417134755.GA30291@jordon-HP-15-Notebook-PC>
 <20180418082439.GA4646@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418082439.GA4646@ulmo>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 10:24:39AM +0200, Thierry Reding wrote:
> > @@ -437,20 +436,7 @@ static int tegra_bo_fault(struct vm_fault *vmf)
> >  	offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> >  	page = bo->pages[offset];
> > 
> > -	err = vm_insert_page(vma, vmf->address, page);
> > -	switch (err) {
> > -	case -EAGAIN:
> > -	case 0:
> > -	case -ERESTARTSYS:
> > -	case -EINTR:
> > -	case -EBUSY:
> > -		return VM_FAULT_NOPAGE;
> > -
> > -	case -ENOMEM:
> > -		return VM_FAULT_OOM;
> > -	}
> > -
> > -	return VM_FAULT_SIGBUS;
> > +	return vmf_insert_page(vma, vmf->address, page);
> >  }
> 
> This new function returns VM_FAULT_NOPAGE only for 0 and -EBUSY, whereas
> we used to return VM_FAULT_NOPAGE for -EAGAIN, -ERESTARTSYS and -EINTR
> as well. Was this previously wrong?

Not so much wrong as unnecessary.  vm_insert_page() can't return -EAGAIN,
-ERESTARTSYS or -EINTR.
