Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B558AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C1525F1F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6EbeAwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C1525F1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964843AbeFYRVv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934275AbeFYRVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:21:49 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E8E25F1B;
        Mon, 25 Jun 2018 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529947308;
        bh=MnouLVhS1Jmpy7U8XV/1xiEkmsei6tlkbKf2tcwd8Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6EbeAwubJ/CdkQaGpxbXiUha2ptk0lV0Rjg/OQmSOh3uSQ73zmQjr0TOsBR5Qk2l
         tj1DjHcQH3YiH4Vbjkf658x+RQ9mkrXf/RofwCd9HRw47gpcG4IPYKcsRccBzOqIJP
         QEcHJeAKuZQcPmabjAPBj6kTEhsB1X418p5b8V2c=
Date:   Mon, 25 Jun 2018 12:21:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Guomin Chen <guomin.chen@suse.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joey Lee <JLee@suse.com>, Borislav Petkov <bp@suse.de>,
        Takashi Iwai <tiwai@suse.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] resource: Fixed iomem resource release failed on
 release_mem_region_adjustable() when memory node or cpu node hot-remove.
Message-ID: <20180625172146.GA191076@bhelgaas-glaptop.roam.corp.google.com>
References: <20180622120138.5411-1-guomin.chen@suse.com>
 <20180622231930.GA2834@bhelgaas-glaptop.roam.corp.google.com>
 <SN1PR18MB2143CB9E209AC070DB0EC8029C740@SN1PR18MB2143.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN1PR18MB2143CB9E209AC070DB0EC8029C740@SN1PR18MB2143.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 05:53:40AM +0000, Guomin Chen wrote:
> Hi 
> 	The report link for this issue is: https://bugzilla.suse.com/show_bug.cgi?id=1092687

If/when you update this patch, please include the URL in the commit log,
e.g.,

  Link: https://bugzilla.suse.com/show_bug.cgi?id=1092687

It would also be nice if you could make that report public so anybody can
read it.

> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: 2018年6月23日 7:20
> > To: Guomin Chen <guomin.chen@suse.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>; Tom Lendacky
> > <thomas.lendacky@amd.com>; Yaowei Bai
> > <baiyaowei@cmss.chinamobile.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > Toshi Kani <toshi.kani@hpe.com>; Dan Williams <dan.j.williams@intel.com>;
> > Thomas Gleixner <tglx@linutronix.de>; Andrew Morton
> > <akpm@linux-foundation.org>; Joey Lee <JLee@suse.com>; Borislav Petkov
> > <bp@suse.de>; Takashi Iwai <tiwai@suse.de>; linux-efi@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/1] resource: Fixed iomem resource release failed on
> > release_mem_region_adjustable() when memory node or cpu node
> > hot-remove.
> > 
> > [+cc Toshi]
> > 
> > On Fri, Jun 22, 2018 at 08:01:38PM +0800, guomin chen wrote:
> > > We've got a bug report indicating the hot-remove node resource release
> > > failed,when the memory on this node is divided into several
> > > sections.because the release_mem_region_adjustable() can only release
> > > one resource that must be [start,end].
> > 
> > Can you please include a URL for the bug report?  That's useful for additional
> > details and gives hints about how future changes in this area might be tested.
> > 
> > release_mem_region_adjustable() and the only call to it were added by Toshi
> > (cc'd):
> > 
> >   825f787bb496 ("resource: add release_mem_region_adjustable()")
> >   fe74ebb106a5 ("mm: change __remove_pages() to call
> > release_mem_region_adjustable()")
> > 
> > > In my case, the BIOS supports faulty memory isolation. if BIOS
> > > detected bad memory block, the BIOS will isolates this badblock.
> > > And set this badblock memory to EfiUnusableMemory in EFI memory map
> > > base on UEFI 2.7 spec.For example in my system, the memory range on
> > > node2 is [mem 0x0000080000000000-0x00000807ffffffff].but the BIOS
> > > detected the [8004e000000-8004e0fffff] is a badblock memory.
> > > So the memory on node2 seem like this:
> > >    		80000000000-8004dffffff : System RAM
> > > 		8004e000000-8004e0fffff : Unusable memory
> > > 		8004e100000-807ffffffff : System RAM
> > >
> > > Now, when offline the cpu node2,the kernel will try to release
> > > ioresource [mem 0x0000080000000000-0x00000807ffffffff]. at this time,
> > > the kernel will release failed,and output error message:
> > > "Unable to release resource <0x0000080000000000-0x00000807ffffffff>
> > > (-22)".
> > > Because the release_mem_region_adjustable() can only release one
> > > resource that must be [0x0000080000000000 , 0x00000807ffffffff].
> > > but now,the iomem resource on node2 [0x0000080000000000,
> > > 0x00000807ffffffff] are divided into three resources [80000000000-
> > > 8004dffffff],[8004e000000-8004e0fffff]and[8004e100000-807ffffffff].
> > >
> > > This patch help to Release multiple iomem resources at once when node
> > > hot-remove. Such as in above case, when hot-remove the cpu node2,the
> > > kernel will try to release resource [0x0000080000000000-
> > > 0x00000807ffffffff].And this patch will release three resources
> > > [80000000000-8004dffffff],[8004e000000-8004e0fffff] and
> > > [8004e100000-807ffffffff].
> > >
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > > Cc: Borislav Petkov <bp@suse.de>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> > > Cc: Takashi Iwai <tiwai@suse.de>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: linux-efi@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: Lee Chun-Yi <JLee@suse.com>
> > > Signed-off-by: guomin chen <guomin.chen@suse.com>
> > > ---
> > >  kernel/resource.c | 73
> > > ++++++++++++++++++++++++++++++++-----------------------
> > >  1 file changed, 43 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/kernel/resource.c b/kernel/resource.c index
> > > 30e1bc68503b..959bcce4c405 100644
> > > --- a/kernel/resource.c
> > > +++ b/kernel/resource.c
> > > @@ -1240,6 +1240,7 @@ int release_mem_region_adjustable(struct
> > resource *parent,
> > >  	struct resource *res;
> > >  	struct resource *new_res;
> > >  	resource_size_t end;
> > > +	resource_size_t new_start = start;
> > >  	int ret = -EINVAL;
> > >
> > >  	end = start + size - 1;
> > > @@ -1257,7 +1258,7 @@ int release_mem_region_adjustable(struct
> > resource *parent,
> > >  			break;
> > >
> > >  		/* look for the next resource if it does not fit into */
> > > -		if (res->start > start || res->end < end) {
> > > +		if (res->end < new_start) {
> > >  			p = &res->sibling;
> > >  			continue;
> > >  		}
> > > @@ -1271,42 +1272,54 @@ int release_mem_region_adjustable(struct
> > resource *parent,
> > >  		}
> > >
> > >  		/* found the target resource; let's adjust accordingly */
> > > -		if (res->start == start && res->end == end) {
> > > +		if (res->start == new_start && res->end == end) {
> > >  			/* free the whole entry */
> > >  			*p = res->sibling;
> > >  			free_resource(res);
> > >  			ret = 0;
> > > -		} else if (res->start == start && res->end != end) {
> > > -			/* adjust the start */
> > > -			ret = __adjust_resource(res, end + 1,
> > > -						res->end - end);
> > > -		} else if (res->start != start && res->end == end) {
> > > -			/* adjust the end */
> > > -			ret = __adjust_resource(res, res->start,
> > > -						start - res->start);
> > > +		} else if (res->end > end) {
> > > +			if (res->start >= new_start) {
> > > +				/* adjust the start */
> > > +				ret = __adjust_resource(res, end + 1,
> > > +							res->end - end);
> > > +			} else {
> > > +				/* split into two entries */
> > > +				if (!new_res) {
> > > +					ret = -ENOMEM;
> > > +					break;
> > > +				}
> > > +				new_res->name = res->name;
> > > +				new_res->start = end + 1;
> > > +				new_res->end = res->end;
> > > +				new_res->flags = res->flags;
> > > +				new_res->desc = res->desc;
> > > +				new_res->parent = res->parent;
> > > +				new_res->sibling = res->sibling;
> > > +				new_res->child = NULL;
> > > +
> > > +				ret = __adjust_resource(res, res->start,
> > > +							new_start - res->start);
> > > +				if (ret)
> > > +					break;
> > > +				res->sibling = new_res;
> > > +				new_res = NULL;
> > > +			}
> > >  		} else {
> > > -			/* split into two entries */
> > > -			if (!new_res) {
> > > -				ret = -ENOMEM;
> > > -				break;
> > > +			if (res->start < new_start) {
> > > +				/* adjust the end */
> > > +				ret = __adjust_resource(res, res->start,
> > > +							new_start - res->start);
> > > +				new_start = res->end+1;
> > > +				p = &res->sibling;
> > > +			} else {
> > > +				new_start = res->end+1;
> > > +				*p = res->sibling;
> > > +				free_resource(res);
> > > +				ret = 0;
> > >  			}
> > > -			new_res->name = res->name;
> > > -			new_res->start = end + 1;
> > > -			new_res->end = res->end;
> > > -			new_res->flags = res->flags;
> > > -			new_res->desc = res->desc;
> > > -			new_res->parent = res->parent;
> > > -			new_res->sibling = res->sibling;
> > > -			new_res->child = NULL;
> > > -
> > > -			ret = __adjust_resource(res, res->start,
> > > -						start - res->start);
> > > -			if (ret)
> > > -				break;
> > > -			res->sibling = new_res;
> > > -			new_res = NULL;
> > > +			if (res->end < end)
> > > +				continue;
> > >  		}
> > > -
> > >  		break;
> > >  	}
> > >
> > > --
> > > 2.12.3
> > >
> 
