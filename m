Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAEDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66FE20854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66FE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeGKHmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:42:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43331 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbeGKHmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:42:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E751B8550F;
        Wed, 11 Jul 2018 07:39:39 +0000 (UTC)
Received: from xz-mi (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1883F2026D6B;
        Wed, 11 Jul 2018 07:39:35 +0000 (UTC)
Date:   Wed, 11 Jul 2018 15:39:32 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v4 6/9] iommu/vt-d: Per PCI device pasid table interfaces
Message-ID: <20180711073932.GA15615@xz-mi>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-7-git-send-email-baolu.lu@linux.intel.com>
 <20180711021826.GA2359@xz-mi>
 <5B45B11D.1080405@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B45B11D.1080405@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 07:39:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 07:39:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'peterx@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:26:21PM +0800, Lu Baolu wrote:

[...]

> >> +int intel_pasid_alloc_table(struct device *dev)
> >> +{
> >> +	struct device_domain_info *info;
> >> +	struct pasid_table *pasid_table;
> >> +	struct pasid_table_opaque data;
> >> +	struct page *pages;
> >> +	size_t size, count;
> >> +	int ret, order;
> >> +
> >> +	info = dev->archdata.iommu;
> >> +	if (WARN_ON(!info || !dev_is_pci(dev) ||
> >> +		    !info->pasid_supported || info->pasid_table))
> >> +		return -EINVAL;
> >> +
> >> +	/* DMA alias device already has a pasid table, use it: */
> >> +	data.pasid_table = &pasid_table;
> >> +	ret = pci_for_each_dma_alias(to_pci_dev(dev),
> >> +				     &get_alias_pasid_table, &data);
> >> +	if (ret)
> >> +		goto attach_out;
> >> +
> >> +	pasid_table = kzalloc(sizeof(*pasid_table), GFP_ATOMIC);
> > Do we need to take some lock here (e.g., the pasid lock)?  Otherwise
> > what if two devices (that are sharing the same DMA alias) call the
> > function intel_pasid_alloc_table() concurrently, then could it
> > possible that we create one table for each of the device while AFAIU
> > we should let them share a single pasid table?
> 
> The only place where this function is called is in a single-thread context
> (protected by a spinlock of device_domain_lock with local interrupt disabled).
> 
> So we don't need an extra lock here. But anyway, I should put a comment
> here.

Yeah, that would be nice too!  Or add a comment for both of the
functions:

  /* Must be with device_domain_lock held */

Regards,

-- 
Peter Xu
