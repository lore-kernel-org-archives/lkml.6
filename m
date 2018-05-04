Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeEDHcE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:32:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:23513 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751339AbeEDHcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:32:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,361,1520924400";
   d="scan'208";a="55889734"
Subject: Re: [PATCH v3 0/2] iommu/vt-d: Fix mapping PSI missing for
 iommu_map()
To: Peter Xu <peterx@redhat.com>,
        Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20180504023453.25682-1-peterx@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jintack Lim <jintack@cs.columbia.edu>,
        Alexander Witte <alexander.witte@baicanada.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AEC0C70.4080700@linux.intel.com>
Date: Fri, 4 May 2018 15:32:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180504023453.25682-1-peterx@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/04/2018 10:34 AM, Peter Xu wrote:
> v3:
> - drop the pr_debug patch [Joerg]
> - rename all the subjects as suggested [Joerg]
> - rebase
>
> v2:
> - cc correct people and iommu list
>
> (PSI stands for: Page Selective Invalidations)
>
> Intel IOMMU has the caching mode to ease emulation of the device.
> When that bit is set, we need to send PSIs even for newly mapped
> pages.  However current driver is not fully obey the rule.  E.g.,
> iommu_map() API will only do the mapping but it never sent the PSIs
> before.  That can be problematic to emulated IOMMU devices since
> they'll never be able to build up the shadow page tables if without
> such information.  This patchset tries to fix the problem.
>
> Patch 1 introduces a helper to notify the MAP PSIs.
>
> Patch 2 fixes the real problem by making sure every domain mapping
> will trigger the MAP PSI notifications.
>
> Without the patchset, nested device assignment (assign one device
> firstly to L1 guest, then to L2 guest) won't work for QEMU.  After
> applying the patchset, it works.
>
> Please review.  Thanks.

Both patches look good to me.

Best regards,
Lu Baolu

>
> Peter Xu (2):
>   iommu/vt-d: Introduce __mapping_notify_one()
>   iommu/vt-d: Fix iotlb psi missing for mappings
>
>  drivers/iommu/intel-iommu.c | 65 ++++++++++++++++++++++++++-----------
>  1 file changed, 46 insertions(+), 19 deletions(-)
>
