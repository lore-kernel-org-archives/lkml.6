Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C01C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6221621797
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6221621797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeHHTyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:54:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727062AbeHHTyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:54:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F8A1402315B;
        Wed,  8 Aug 2018 17:33:30 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F6682027047;
        Wed,  8 Aug 2018 17:33:29 +0000 (UTC)
Date:   Wed, 8 Aug 2018 13:33:28 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, david@redhat.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180808173328.GC3429@redhat.com>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <20180807145900.GH10003@dhcp22.suse.cz>
 <20180807151810.GB3301@redhat.com>
 <20180808094502.GA10068@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180808094502.GA10068@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 08 Aug 2018 17:33:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 08 Aug 2018 17:33:30 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:45:02AM +0200, Oscar Salvador wrote:
> On Tue, Aug 07, 2018 at 11:18:10AM -0400, Jerome Glisse wrote:
> > Correct, you should not call release_mem_region_adjustable() the device
> > region is not part of regular iomem resource as it might not necessarily
> > be enumerated through known ways to the kernel (ie only the device driver
> > can discover the region and core kernel do not know about it).
> > 
> > One of the issue to adding this region to iomem resource is that they
> > really need to be ignored by core kernel because you can not assume that
> > CPU can actually access them. Moreover, if CPU can access them it is
> > likely that CPU can not do atomic operation on them (ie what happens on
> > a CPU atomic instruction is undefined). So they are _special_ and only
> > make sense to be use in conjunction with a device driver.
> > 
> > 
> > Also in the case they do exist in iomem resource it is as PCIE BAR so
> > as IORESOURCE_IO (iirc) and thus release_mem_region_adjustable() would
> > return -EINVAL. Thought nothing bad happens because of that, only a
> > warning message that might confuse the user.
> 
> Just to see if I understand this correctly.
> I guess that these regions are being registered via devm_request_mem_region() calls.
> Among other callers, devm_request_mem_region() is being called from:
> 
> dax_pmem_probe
> hmm_devmem_add
> 
> AFAICS from the code, those regions will inherit the flags from the parent, which is iomem_resource:
> 
> #define devm_request_mem_region(dev,start,n,name) \
> 	__devm_request_region(dev, &iomem_resource, (start), (n), (name))
> 
> struct resource iomem_resource = {
> 	.name	= "PCI mem",
> 	.start	= 0,
> 	.end	= -1,
> 	.flags	= IORESOURCE_MEM,
> };
> 
> 
> struct resource * __request_region()
> {
> 	...
> 	...
> 	res->flags = resource_type(parent) | resource_ext_type(parent);
> 	res->flags |= IORESOURCE_BUSY | flags;
> 	res->desc = parent->desc;
> 	...
> 	...
> }

Yeah you right my recollection of this was wrong.

> 
> So the regions will not be tagged as IORESOURCE_IO but IORESOURCE_MEM.
> From the first glance release_mem_region_adjustable() looks like it does
> more things than __release_region(), and I did not check it deeply
> but maybe we can make it work.

The root issue here is not releasing the resource when hotremoving
the memory. The device driver still wants to keep owning the resource
after hotremove of memory. The device driver do not necessarily always
need struct page to make use of that resource.


Cheers,
Jérôme
