Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F3AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923822146F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfBZLRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:17:47 -0500
Received: from 8bytes.org ([81.169.241.247]:41478 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBZLRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:17:46 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 468CC41A; Tue, 26 Feb 2019 12:17:45 +0100 (CET)
Date:   Tue, 26 Feb 2019 12:17:43 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, alex.williamson@redhat.com
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190226111743.GK20740@8bytes.org>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
 <20190220142759.33308-2-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220142759.33308-2-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

Thanks for the patch! I think this is getting close to be applied after
the next merge window.

On Wed, Feb 20, 2019 at 02:27:59PM +0000, Jean-Philippe Brucker wrote:
> +int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
> +			  iommu_mm_exit_handler_t mm_exit, void *drvdata)

I think we are better of with introducing a sva-bind handle which can be
used to extend and further configure the binding done with this
function.

How about a 'struct iommu_sva' with an iommu-private definition that is
returned by this function:

	struct iommu_sva *iommu_sva_bind_device(struct device *dev,
						struct mm_struct *mm);

and the corresponding unbind function:

	int iommu_sva_unbind_device(struct iommu_sva* *handle);

(Btw, does this need to return and int? Can unbinding fail?).

With that in place we can implement and extentable API base on the
handle:

	int iommu_sva_get_pasid(struct iommu_sva *handle);
	void iommu_sva_set_exit_handler(struct iommu_sva *handle,
					iommu_mm_exit_handler_t mm_exit);

I think at least the AMD IOMMU driver needs more call-backs like a
handler that is invoked when a fault can not be resolved. And there
might be others in the future, putting them all in the parameter list of
the bind function doesn't scale well.

Regards,

	Joerg
