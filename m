Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FA3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2E72172D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJJNxsw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2E72172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeI0UWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbeI0UWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:22:20 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC356216FA;
        Thu, 27 Sep 2018 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538057034;
        bh=McP1Lt3d2d+vg7kQ3C5nEe/RETJ7ULNUBAufEOZXhNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJJNxsw0AI/7dDFmZxl0kZxd19q4/a/8lp3QdVJ6YYEPGMFjRwqdChi5QGenOCdV7
         pIzcgP1hWI5drfUuAnlAsNhazFofk/p0VQRaDgjWvlf5tCitP0LVGB04fmRcyTJcpS
         KCiGzz6mFjpAQICcV2H6PkQqudZT7QlrCORMXxFk=
Date:   Thu, 27 Sep 2018 09:03:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     lijiang <lijiang@redhat.com>
Cc:     dan.j.williams@intel.com, brijesh.singh@amd.com, bhe@redhat.com,
        thomas.lendacky@amd.com, tiwai@suse.de, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com,
        tglx@linutronix.de, bp@suse.de, dyoung@redhat.com,
        akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 3/3] resource: Fix find_next_iomem_res() iteration issue
Message-ID: <20180927140351.GA257735@bhelgaas-glaptop.roam.corp.google.com>
References: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153782730364.130337.17794279728329113665.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <13084ce6-e29a-c244-3f9c-cf0725646d9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13084ce6-e29a-c244-3f9c-cf0725646d9f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 01:27:41PM +0800, lijiang wrote:
> 在 2018年09月25日 06:15, Bjorn Helgaas 写道:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously find_next_iomem_res() used "*res" as both an input parameter for
> > the range to search and the type of resource to search for, and an output
> > parameter for the resource we found, which makes the interface confusing
> > and hard to use correctly.
> > 
> > All callers allocate a single struct resource and use it for repeated calls
> > to find_next_iomem_res().  When find_next_iomem_res() returns a resource,
> > it overwrites the start, end, flags, and desc members of the struct.  If we
> > call find_next_iomem_res() again, we must update or restore these fields.
> > 
> > The callers (__walk_iomem_res_desc() and walk_system_ram_range()) do not
> > restore res->flags, so if the caller is searching for flags of
> > IORESOURCE_MEM | IORESOURCE_BUSY and finds a resource with flags of
> > IORESOURCE_MEM | IORESOURCE_BUSY | IORESOURCE_SYSRAM, the next search will
> > find only resources marked as IORESOURCE_SYSRAM.
> > 
> > Fix this by restructuring the interface so it takes explicit "start, end,
> > flags" parameters and uses "*res" only as an output parameter.
> 
> Hi, Bjorn
> I personally suggest that some comments might be added in the code, make it clear
> and easy to understand, then which could avoid the old confusion and more code changes.

Since I think the current interface (using *res as both input and
output parameters that have very different meanings) is confusing,
it's hard for *me* to write comments that make it less confusing, but
of course, you're welcome to propose something.

My opinion (probably not universally shared) is that my proposal would
make the code more readable, and it's worth doing even though the diff
is larger.

Anyway, I'll post these patches independently and see if anybody else
has an opinion.

Bjorn

> > Original-patch: http://lore.kernel.org/lkml/20180921073211.20097-2-lijiang@redhat.com
> > Based-on-patch-by: Lianbo Jiang <lijiang@redhat.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  kernel/resource.c |   94 +++++++++++++++++++++++------------------------------
> >  1 file changed, 41 insertions(+), 53 deletions(-)
> > 
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index 155ec873ea4d..9891ea90cc8f 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -319,23 +319,26 @@ int release_resource(struct resource *old)
> >  EXPORT_SYMBOL(release_resource);
> >  
> >  /*
> > - * Finds the lowest iomem resource existing within [res->start..res->end].
> > - * The caller must specify res->start, res->end, res->flags, and optionally
> > - * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
> > - * This function walks the whole tree and not just first level children until
> > - * and unless first_level_children_only is true.
> > + * Finds the lowest iomem resource that covers part of [start..end].  The
> > + * caller must specify start, end, flags, and desc (which may be
> > + * IORES_DESC_NONE).
> > + *
> > + * If a resource is found, returns 0 and *res is overwritten with the part
> > + * of the resource that's within [start..end]; if none is found, returns
> > + * -1.
> > + *
> > + * This function walks the whole tree and not just first level children
> > + * unless first_level_children_only is true.
> >   */
> > -static int find_next_iomem_res(struct resource *res, unsigned long desc,
> > -			       bool first_level_children_only)
> > +static int find_next_iomem_res(resource_size_t start, resource_size_t end,
> > +			       unsigned long flags, unsigned long desc,
> > +			       bool first_level_children_only,
> > +			       struct resource *res)
> >  {
> > -	resource_size_t start, end;
> >  	struct resource *p;
> >  	bool sibling_only = false;
> >  
> >  	BUG_ON(!res);
> > -
> > -	start = res->start;
> > -	end = res->end;
> >  	BUG_ON(start >= end);
> >  
> >  	if (first_level_children_only)
> > @@ -344,7 +347,7 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
> >  	read_lock(&resource_lock);
> >  
> >  	for (p = iomem_resource.child; p; p = next_resource(p, sibling_only)) {
> > -		if ((p->flags & res->flags) != res->flags)
> > +		if ((p->flags & flags) != flags)
> >  			continue;
> >  		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
> >  			continue;
> > @@ -359,32 +362,31 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
> >  	read_unlock(&resource_lock);
> >  	if (!p)
> >  		return -1;
> > +
> >  	/* copy data */
> > -	if (res->start < p->start)
> > -		res->start = p->start;
> > -	if (res->end > p->end)
> > -		res->end = p->end;
> > +	res->start = max(start, p->start);
> > +	res->end = min(end, p->end);
> >  	res->flags = p->flags;
> >  	res->desc = p->desc;
> >  	return 0;
> >  }
> >  
> > -static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
> > -				 bool first_level_children_only,
> > -				 void *arg,
> > +static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
> > +				 unsigned long flags, unsigned long desc,
> > +				 bool first_level_children_only, void *arg,
> >  				 int (*func)(struct resource *, void *))
> >  {
> > -	u64 orig_end = res->end;
> > +	struct resource res;
> >  	int ret = -1;
> >  
> > -	while ((res->start < res->end) &&
> > -	       !find_next_iomem_res(res, desc, first_level_children_only)) {
> > -		ret = (*func)(res, arg);
> > +	while (start < end &&
> > +	       !find_next_iomem_res(start, end, flags, desc,
> > +				    first_level_children_only, &res)) {
> > +		ret = (*func)(&res, arg);
> >  		if (ret)
> >  			break;
> >  
> > -		res->start = res->end + 1;
> > -		res->end = orig_end;
> > +		start = res.end + 1;
> >  	}
> >  
> >  	return ret;
> > @@ -407,13 +409,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
> >  int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
> >  		u64 end, void *arg, int (*func)(struct resource *, void *))
> >  {
> > -	struct resource res;
> > -
> > -	res.start = start;
> > -	res.end = end;
> > -	res.flags = flags;
> > -
> > -	return __walk_iomem_res_desc(&res, desc, false, arg, func);
> > +	return __walk_iomem_res_desc(start, end, flags, desc, false, arg, func);
> >  }
> >  EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
> >  
> > @@ -427,13 +423,9 @@ EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
> >  int walk_system_ram_res(u64 start, u64 end, void *arg,
> >  				int (*func)(struct resource *, void *))
> >  {
> > -	struct resource res;
> > -
> > -	res.start = start;
> > -	res.end = end;
> > -	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > +	unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> >  
> > -	return __walk_iomem_res_desc(&res, IORES_DESC_NONE, true,
> > +	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, true,
> >  				     arg, func);
> >  }
> >  
> > @@ -444,13 +436,9 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
> >  int walk_mem_res(u64 start, u64 end, void *arg,
> >  		 int (*func)(struct resource *, void *))
> >  {
> > -	struct resource res;
> > -
> > -	res.start = start;
> > -	res.end = end;
> > -	res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> > +	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> >  
> > -	return __walk_iomem_res_desc(&res, IORES_DESC_NONE, true,
> > +	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, true,
> >  				     arg, func);
> >  }
> >  
> > @@ -464,25 +452,25 @@ int walk_mem_res(u64 start, u64 end, void *arg,
> >  int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
> >  		void *arg, int (*func)(unsigned long, unsigned long, void *))
> >  {
> > +	resource_size_t start, end;
> > +	unsigned long flags;
> >  	struct resource res;
> >  	unsigned long pfn, end_pfn;
> > -	u64 orig_end;
> >  	int ret = -1;
> >  
> > -	res.start = (u64) start_pfn << PAGE_SHIFT;
> > -	res.end = ((u64)(start_pfn + nr_pages) << PAGE_SHIFT) - 1;
> > -	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > -	orig_end = res.end;
> > -	while ((res.start < res.end) &&
> > -		(find_next_iomem_res(&res, IORES_DESC_NONE, true) >= 0)) {
> > +	start = (u64) start_pfn << PAGE_SHIFT;
> > +	end = ((u64)(start_pfn + nr_pages) << PAGE_SHIFT) - 1;
> > +	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > +	while (start < end &&
> > +	       !find_next_iomem_res(start, end, flags, IORES_DESC_NONE,
> > +				    true, &res)) {
> >  		pfn = (res.start + PAGE_SIZE - 1) >> PAGE_SHIFT;
> >  		end_pfn = (res.end + 1) >> PAGE_SHIFT;
> >  		if (end_pfn > pfn)
> >  			ret = (*func)(pfn, end_pfn - pfn, arg);
> >  		if (ret)
> >  			break;
> > -		res.start = res.end + 1;
> > -		res.end = orig_end;
> > +		start = res.end + 1;
> >  	}
> >  	return ret;
> >  }
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
