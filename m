Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDFFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D27207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfBVFff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:35:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:64127 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbfBVFfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 00:35:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 21:35:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,398,1544515200"; 
   d="scan'208";a="116887848"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2019 21:35:32 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jis Ben <jisben@google.com>
Subject: Re: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
To:     James Dong <xmdong@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20190222024455.20802-1-xmdong@google.com>
 <cf965dec-1bae-1d98-e97c-6a84c0c9862f@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fe6dcb4e-03c4-0bbf-c51f-5964b20593dd@linux.intel.com>
Date:   Fri, 22 Feb 2019 13:30:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <cf965dec-1bae-1d98-e97c-6a84c0c9862f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2/22/19 1:06 PM, Lu Baolu wrote:

> Do you mind checking this?
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6ecdcf8fc8c0..f62f30bc1339 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2632,6 +2632,9 @@ static struct dmar_domain 
> *find_or_alloc_domain(struct device *dev, int gaw)
>                          goto out;
>          }
> 
> +       if (!iommu_should_identity_map(dev, 0))
> +               return si_domain;
> +
>          /* Allocate and initialize new domain for the device */
>          domain = alloc_domain(0);
>          if (!domain)

Oops! This can't be compiled. Please try below instead if you'd like to.
Sorry about it.

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6ecdcf8fc8c0..b89f5ba6a3c8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -174,6 +174,8 @@ static inline unsigned long virt_to_dma_pfn(void *p)
         return page_to_dma_pfn(virt_to_page(p));
  }

+static int iommu_should_identity_map(struct device *dev, int startup);
+
  /* global iommu list, set NULL for ignored DMAR units */
  static struct intel_iommu **g_iommus;

@@ -2632,6 +2634,9 @@ static struct dmar_domain 
*find_or_alloc_domain(struct device *dev, int gaw)
                         goto out;
         }

+       if (iommu_should_identity_map(dev, 0))
+               return si_domain;
+
         /* Allocate and initialize new domain for the device */
         domain = alloc_domain(0);
         if (!domain)

Best regards,
Lu Baolu


