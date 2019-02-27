Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F89C20863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfB0VjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:39:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:50177 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfB0VjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:39:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 13:39:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="129891160"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2019 13:39:16 -0800
Date:   Wed, 27 Feb 2019 13:41:29 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        ashok.raj@intel.com, baolu.lu@linux.intel.com,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190227134129.51ad42ac@jacob-builder>
In-Reply-To: <20190226111743.GK20740@8bytes.org>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
        <20190220142759.33308-2-jean-philippe.brucker@arm.com>
        <20190226111743.GK20740@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 12:17:43 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> Hi Jean-Philippe,
> 
> Thanks for the patch! I think this is getting close to be applied
> after the next merge window.
> 
> On Wed, Feb 20, 2019 at 02:27:59PM +0000, Jean-Philippe Brucker wrote:
> > +int iommu_sva_bind_device(struct device *dev, struct mm_struct
> > *mm, int *pasid,
> > +			  iommu_mm_exit_handler_t mm_exit, void
> > *drvdata)  
> 
> I think we are better of with introducing a sva-bind handle which can
> be used to extend and further configure the binding done with this
> function.
> 
> How about a 'struct iommu_sva' with an iommu-private definition that
> is returned by this function:
> 
> 	struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> 						struct mm_struct *mm);
> 
Just trying to understand how to use this API.
So if we bind the same mm to two different devices, we should get two
different iommu_sva handle, right?
I think intel-svm still needs a flag argument for supervisor pasid etc.
Other than that, I think both interface should work for vt-d.

Another question is that for nested SVA, we will need to bind guest mm.
Do you think we should try to reuse this or have it separate? I am
working on a separate API for now.

> and the corresponding unbind function:
> 
> 	int iommu_sva_unbind_device(struct iommu_sva* *handle);
> 
> (Btw, does this need to return and int? Can unbinding fail?).
> 
> With that in place we can implement and extentable API base on the
> handle:
> 
> 	int iommu_sva_get_pasid(struct iommu_sva *handle);
If multiple bind to the same mm gets multiple handles, this API should
retrieve the same pasid for different handle?

Just curious why making
the handle private instead of returning the pasid value in the handle?

> 	void iommu_sva_set_exit_handler(struct iommu_sva *handle,
> 					iommu_mm_exit_handler_t
> mm_exit);
> 
> I think at least the AMD IOMMU driver needs more call-backs like a
> handler that is invoked when a fault can not be resolved. And there
> might be others in the future, putting them all in the parameter list
> of the bind function doesn't scale well.
> 

> Regards,
> 
> 	Joerg

