Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE07BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ECF206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbfAIPhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:37:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfAIPhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:37:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2ACFC369B7;
        Wed,  9 Jan 2019 15:37:15 +0000 (UTC)
Received: from x1.home (ovpn-116-25.phx2.redhat.com [10.3.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C6DF600CD;
        Wed,  9 Jan 2019 15:37:09 +0000 (UTC)
Date:   Wed, 9 Jan 2019 08:37:08 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        walling@linux.ibm.com, cohuck@redhat.com, david@redhat.com,
        pasic@linux.ibm.com, thuth@redhat.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v1 1/2] vfio:iommu: Use capabilities do report IOMMU
 informations
Message-ID: <20190109083708.1d39234d@x1.home>
In-Reply-To: <1547037714-21592-2-git-send-email-pmorel@linux.ibm.com>
References: <1547037714-21592-1-git-send-email-pmorel@linux.ibm.com>
        <1547037714-21592-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 09 Jan 2019 15:37:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jan 2019 13:41:53 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We add a new flag, VFIO_IOMMU_INFO_CAPABILITIES, inside the
> vfio_iommu_type1_info to specify the support for capabilities.
> 
> We add a new capability, with id VFIO_IOMMU_INFO_CAP_DMA
> in the capability list of the VFIO_IOMMU_GET_INFO ioctl.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  include/uapi/linux/vfio.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 8131028..54c4fcb 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -669,6 +669,15 @@ struct vfio_iommu_type1_info {
>  	__u32	flags;
>  #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
>  	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
> +#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
> +	__u64   cap_offset;     /* Offset within info struct of first cap */
> +};
> +
> +#define VFIO_IOMMU_INFO_CAP_DMA 1
> +struct vfio_iommu_cap_dma {
> +	struct vfio_info_cap_header header;
> +	__u64   dma_start;
> +	__u64   dma_end;
>  };
>  
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)

Unfortunately for most systems, a simple start and end is not really
sufficient to describe the available IOVA space, there are often
reserved regions intermixed, so this is not really a complete
solution.  Shameer tried to solve this last year[1] but we ran into a
road block that Intel IGD devices impose a reserved range of IOVA
spaces reported to the user that conflict with existing assignment of
this device and we haven't figured out yet how to be more selective of
the enforcement of those reserved ranges.  Thanks,

Alex

[1] https://lkml.org/lkml/2018/4/18/293
