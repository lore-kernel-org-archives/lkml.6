Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeEGIEZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:04:25 -0400
Received: from 8bytes.org ([81.169.241.247]:59086 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeEGIEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:04:22 -0400
Date: Mon, 7 May 2018 10:04:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
Message-ID: <20180507080420.GB18595@8bytes.org>
References: <cover.1523304324.git.digetx@gmail.com>
 <f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
 <20180427100202.GO30388@ulmo>
 <716edf58-38a7-21e5-1668-b866bf392e34@arm.com>
 <6827bda3-1aa2-da60-a749-8e2dd2e595f3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6827bda3-1aa2-da60-a749-8e2dd2e595f3@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 12:19:01AM +0300, Dmitry Osipenko wrote:
> Probably the best variant would be to give an explicit control over syncing to a
> user of the IOMMU API, like for example device driver may perform multiple
> mappings / unmappings and then sync/flush in the end. I'm not sure that it's
> really worth the hassle to shuffle the API right now, maybe we can implement it
> later if needed. Joerg, do you have objections to a 'compound page' approach?

Have you measured the performance difference on both variants? The
compound-page approach only works for cases when the physical memory you
map contiguous and correctly aligned.

If it is really needed I would prefer a separate iotlb_sync_map()
call-back that is just NULL when not needed. This way all users that
don't need it only get a minimal penalty in the mapping path and you
don't have any requirements on the physical memory you map to get good
performance.


	Joerg
