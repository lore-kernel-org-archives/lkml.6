Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C43C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9739720020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9739720020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933340AbeFTUWd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:22:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:17653 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933085AbeFTUWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:22:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 13:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="209775747"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2018 13:22:23 -0700
Date:   Wed, 20 Jun 2018 13:25:31 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     stable@vger.kernel.org, "Ashok Raj" <ashok.raj@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/2] iommu/vt-d: add definitions for PFSID
Message-ID: <20180620132531.460fdba4@jacob-builder>
In-Reply-To: <1528390620-31565-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1528390620-31565-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1528390620-31565-2-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg/David,

Any comments on this? I will rebase to 18-rc1.
Thanks,

Jacob

On Thu,  7 Jun 2018 09:56:59 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> When SRIOV VF device IOTLB is invalidated, we need to provide
> the PF source ID such that IOMMU hardware can gauge the depth
> of invalidation queue which is shared among VFs. This is needed
> when device invalidation throttle (DIT) capability is supported.
> 
> This patch adds bit definitions for checking and tracking PFSID.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: stable@vger.kernel.org
> Cc: "Ashok Raj" <ashok.raj@intel.com>
> Cc: "Lu Baolu" <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 1 +
>  include/linux/intel-iommu.h | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 749d8f2..3d77d61 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -422,6 +422,7 @@ struct device_domain_info {
>  	struct list_head global; /* link to global list */
>  	u8 bus;			/* PCI bus number */
>  	u8 devfn;		/* PCI devfn number */
> +	u16 pfsid;		/* SRIOV physical function source
> ID */ u8 pasid_supported:3;
>  	u8 pasid_enabled:1;
>  	u8 pri_supported:1;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ef169d6..af1c05f 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -114,6 +114,7 @@
>   * Extended Capability Register
>   */
>  
> +#define ecap_dit(e)		((e >> 41) & 0x1)
>  #define ecap_pasid(e)		((e >> 40) & 0x1)
>  #define ecap_pss(e)		((e >> 35) & 0x1f)
>  #define ecap_eafs(e)		((e >> 34) & 0x1)
> @@ -284,6 +285,7 @@ enum {
>  #define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
>  #define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
>  #define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
> +#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) |
> ((u64)(pfsid & 0xfff) << 52)) #define QI_DEV_IOTLB_SIZE	1
>  #define QI_DEV_IOTLB_MAX_INVS	32
>  
> @@ -308,6 +310,7 @@ enum {
>  #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
>  #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
>  #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
> +#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) |
> ((u64)(pfsid & 0xfff) << 52)) #define QI_DEV_EIOTLB_MAX_INVS	32
>  
>  #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)

[Jacob Pan]
