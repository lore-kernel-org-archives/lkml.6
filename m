Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030AD2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfBZMtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:49:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46876 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfBZMtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:49:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBEC980D;
        Tue, 26 Feb 2019 04:49:35 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96C0D3F703;
        Tue, 26 Feb 2019 04:49:34 -0800 (PST)
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kevin.tian@intel.com, alex.williamson@redhat.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, christian.koenig@amd.com
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
 <20190220142759.33308-2-jean-philippe.brucker@arm.com>
 <20190226111743.GK20740@8bytes.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <559a7ef6-8591-3936-b208-3bbae555a15a@arm.com>
Date:   Tue, 26 Feb 2019 12:49:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226111743.GK20740@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2019 11:17, Joerg Roedel wrote:
> Hi Jean-Philippe,
> 
> Thanks for the patch! I think this is getting close to be applied after
> the next merge window.
> 
> On Wed, Feb 20, 2019 at 02:27:59PM +0000, Jean-Philippe Brucker wrote:
>> +int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
>> +			  iommu_mm_exit_handler_t mm_exit, void *drvdata)
> 
> I think we are better of with introducing a sva-bind handle which can be
> used to extend and further configure the binding done with this
> function.
> 
> How about a 'struct iommu_sva' with an iommu-private definition that is
> returned by this function:
> 
> 	struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> 						struct mm_struct *mm);
> 
> and the corresponding unbind function:
> 
> 	int iommu_sva_unbind_device(struct iommu_sva* *handle);
> 
> (Btw, does this need to return and int? Can unbinding fail?).

With the pasid-based interface, unbind would have failed if the mm had
exited before the device driver called unbind (and with invalid
parameters). But even then returning an error is only useful for debug,
since callers usually can't handle or propagate release errors.

> With that in place we can implement and extentable API base on the
> handle:
> 
> 	int iommu_sva_get_pasid(struct iommu_sva *handle);
> 	void iommu_sva_set_exit_handler(struct iommu_sva *handle,
> 					iommu_mm_exit_handler_t mm_exit);

Ok sounds good. It doesn't look like this interface requires a lot of
changes on my side (iommu_sva corresponds to the iommu_bond structure
I've been using internally) but I might find problems while implementing it.

> I think at least the AMD IOMMU driver needs more call-backs like a
> handler that is invoked when a fault can not be resolved. And there
> might be others in the future, putting them all in the parameter list of
> the bind function doesn't scale well.

Device drivers will also want to have some private data to easily
identify the faulting or exiting context. How about:

    struct iommu_sva_ops {
        void (*mm_exit)(struct iommu_sva *handle, void *drvdata);
    };
    int iommu_sva_set_ops(struct iommu_sva *handle,
                          const struct iommu_sva_ops *ops,
                          void *drvdata);

I now think that device driver should always call unbind() to release
the iommu_sva handle, even if they got notified by mm_exit.

Thanks,
Jean
