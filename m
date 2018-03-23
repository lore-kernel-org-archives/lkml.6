Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeCWA6w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:58:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751551AbeCWA6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:58:50 -0400
Date: Fri, 23 Mar 2018 08:58:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        takahiro.akashi@linaro.org, ebiederm@xmission.com, vgoyal@redhat.com,
        dyoung@redhat.com, prudo@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-ID: <20180323005845.GA25740@localhost.localdomain>
References: <20180322033722.9279-1-bhe@redhat.com>
 <20180322033722.9279-2-bhe@redhat.com>
 <20180322152929.9b421af2f66cc819ad691207@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322152929.9b421af2f66cc819ad691207@linux-foundation.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks a lot for your reviewing!

On 03/22/18 at 03:29pm, Andrew Morton wrote:
> >  /*
> > + * This function, being a variant of walk_system_ram_res(), calls the @func
> > + * callback against all memory ranges of type System RAM which are marked as
> > + * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
> > + * higher to lower.
> > + */
> 
> This should document the return value, as should walk_system_ram_res().
> Why does it return -1 on error rather than an errno (ENOMEM)?

OK, will add sentences to tell this. So for walk_system_ram_res() only
'-1' indicates the failure of finding, '0' the success. While in
walk_system_ram_res_rev(), add '-ENOMEM' to indicate failure of vmalloc
allocation.

> 
> > +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> > +				int (*func)(struct resource *, void *))
> > +{
> > +	struct resource res, *rams;
> > +	int rams_size = 16, i;
> > +	int ret = -1;
> > +
> > +	/* create a list */
> > +	rams = vmalloc(sizeof(struct resource) * rams_size);
> > +	if (!rams)
> > +		return ret;
> > +
> > +	res.start = start;
> > +	res.end = end;
> > +	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > +	i = 0;
> > +	while ((res.start < res.end) &&
> > +		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
> > +		if (i >= rams_size) {
> > +			/* re-alloc */
> > +			struct resource *rams_new;
> > +			int rams_new_size;
> > +
> > +			rams_new_size = rams_size + 16;
> > +			rams_new = vmalloc(sizeof(struct resource)
> > +							* rams_new_size);
> > +			if (!rams_new)
> > +				goto out;
> > +
> > +			memcpy(rams_new, rams,
> > +					sizeof(struct resource) * rams_size);
> > +			vfree(rams);
> > +			rams = rams_new;
> > +			rams_size = rams_new_size;
> > +		}
> > +
> > +		rams[i].start = res.start;
> > +		rams[i++].end = res.end;
> > +
> > +		res.start = res.end + 1;
> > +		res.end = end;
> > +	}
> > +
> > +	/* go reverse */
> > +	for (i--; i >= 0; i--) {
> > +		ret = (*func)(&rams[i], arg);
> > +		if (ret)
> > +			break;
> > +	}
> 
> erk, this is pretty nasty.  Isn't there a better way :(

Yes, this is not efficient.

In struct resource{}, ->sibling list is a singly linked list. I ever
thought about changing it to doubly linked list, yet not very sure if
it will have effect since struct resource is a core data structure.
AKASHI's method is more acceptable, and currently only kexec has this
requirement.

> 
> > +out:
> > +	vfree(rams);
> > +	return ret;
> > +}
> 
