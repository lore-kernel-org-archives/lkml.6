Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754789AbeDZI5C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:57:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754015AbeDZI44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:56:56 -0400
Date: Thu, 26 Apr 2018 16:56:49 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3 2/3] resource: add walk_system_ram_res_rev()
Message-ID: <20180426085649.GC18395@localhost.localdomain>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-3-bhe@redhat.com>
 <20180419100745.GC3896@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419100745.GC3896@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to all reviewers, I had a redhat urgent issue, this patchset
discussing is delayed.

On 04/19/18 at 12:07pm, Borislav Petkov wrote:
> On Thu, Apr 19, 2018 at 08:18:47AM +0800, Baoquan He wrote:
> > This function, being a variant of walk_system_ram_res() introduced in
> > commit 8c86e70acead ("resource: provide new functions to walk through
> > resources"), walks through a list of all the resources of System RAM
> > in reversed order, i.e., from higher to lower.
> > 
> > It will be used in kexec_file code.
> 
> Of course, what is missing is the big *WHY* you need this to happen this
> way...

Sorry for that, I just ran scripts/get_maintainer.pl to get expert's
name and added them into each patch. The reason this change is made is
in patch 3/3. Test robot reported a code bug on the latest kernel, will
repost and CC everyone in all patches.


Rob Herring asked the same question in v2, I explained to him. The
discussion can be found here:
https://lkml.org/lkml/2018/4/10/484

> 
> >  /*
> > + * This function, being a variant of walk_system_ram_res(), calls the @func
> > + * callback against all memory ranges of type System RAM which are marked as
> > + * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
> > + * higher to lower.
> > + */
> > +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> > +				int (*func)(struct resource *, void *))
> > +{
> > +	unsigned long flags;
> > +	struct resource *res;
> > +	int ret = -1;
> > +
> > +	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > +
> > +	read_lock(&resource_lock);
> > +	list_for_each_entry_reverse(res, &iomem_resource.child, sibling) {
> 
> ... and the other thing that I'm not clear on is why are you
> slapping this function just like that instead of extending
> __walk_iomem_res_desc() to do reverse direction too?

Yes, I planned to do as you said when started to write code. After investigation,
I changed to use the way of this patch. Because __walk_iomem_res_desc()
provides two interfaces by calling find_next_iomem_res(). If
'first_level_children_only' is true, it only iterates system RAM
resource; if 'first_level_children_only' is false, it does depth first
iteration in iomem_resource. The 1st interface is only used by
walk_system_ram_res() and walk_mem_res(). While the 2nd interface need
call find_next_iomem_res() which resorts to next_resource().
next_resource() will check 'sibling_only' to decide if iterate
iomem_resource's children, or walk over all resources of iomem_resource
with depth first. For walk_system_ram_res_rev(), we only need to iterate
iomem_resource's children, and seems no one has requirement to
iterate all iomem_resource's children and grand children
revresedly. For simplifying code implementation, I just did as in this
patch, surely, if any suggestion or scenario given about the reversed
iteration of all resources, I can change to add below functions, and
based on them to implement walk_system_ram_res_rev().

walk_system_ram_res_rev
	->__walk_iomem_res_desc_rev
		->find_next_iomem_res_rev
			->next_resource_rev

Thanks
Baoquan


> 
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> -- 
