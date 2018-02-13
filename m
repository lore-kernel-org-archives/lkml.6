Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935387AbeBMNaE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:30:04 -0500
Received: from 8bytes.org ([81.169.241.247]:36288 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935174AbeBMNaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:30:02 -0500
Date: Tue, 13 Feb 2018 14:29:59 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de
Subject: Re: [PATCH v3] iommu/amd: Add support for fast IOTLB flushing
Message-ID: <20180213132959.kkavgzt37hm7n2tt@8bytes.org>
References: <1517374874-93978-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517374874-93978-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

thanks for working on this.

On Wed, Jan 31, 2018 at 12:01:14AM -0500, Suravee Suthikulpanit wrote:
> +static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
> +				      unsigned long iova, size_t size)
> +{
> +	struct amd_iommu_flush_entries *entry, *p;
> +	unsigned long flags;
> +	bool found = false;
> +
> +	spin_lock_irqsave(&amd_iommu_flush_list_lock, flags);

I am not happy with introducing or using global locks when they are not
necessary. Can this be a per-domain lock?

Besides, did you check it makes sense to actually keep track of the
ranges here? My approach would be to just make iotlb_range_add() an noop
and do a full domain flush in iotlb_sync(). But maybe you did
measurements you can share here to show there is a benefit.



	Joerg
