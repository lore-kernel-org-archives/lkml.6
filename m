Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2454E206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404315AbfAPN0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:26:51 -0500
Received: from 8bytes.org ([81.169.241.247]:57966 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732810AbfAPN0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:26:50 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DC342273; Wed, 16 Jan 2019 14:26:49 +0100 (CET)
Date:   Wed, 16 Jan 2019 14:26:48 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Message-ID: <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:16:25AM +0000, Suthikulpanit, Suravee wrote:
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 525659b88ade..ab31ba75da1b 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1248,7 +1248,13 @@ static void __domain_flush_pages(struct protection_domain *domain,
>  	build_inv_iommu_pages(&cmd, address, size, domain->id, pde);
>  
>  	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
> -		if (!domain->dev_iommu[i])
> +		/*
> +		 * The dev_cnt is zero when all devices are detached
> +		 * from the domain. This is the case when VFIO detaches
> +		 * all devices from the group before flushing IOMMU pages.
> +		 * So, always issue the flush command.
> +		 */
> +		if (domain->dev_cnt && !domain->dev_iommu[i])
>  			continue;

This doesn't look like the correct fix. We still miss the flush if we
detach the last device from the domain. How about the attached diff? If
I understand the problem correctly, it should fix the problem more
reliably.

Thanks,

	Joerg

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 87ba23a75b38..dc1e2a8a19d7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1991,25 +1991,36 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 static void do_detach(struct iommu_dev_data *dev_data)
 {
+	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 	u16 alias;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
 	alias = dev_data->alias;
 
-	/* decrease reference counters */
-	dev_data->domain->dev_iommu[iommu->index] -= 1;
-	dev_data->domain->dev_cnt                 -= 1;
-
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
-	clear_dte_entry(dev_data->devid);
-	if (alias != dev_data->devid)
-		clear_dte_entry(alias);
 
+	clear_dte_entry(dev_data->devid);
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
+
+	if (alias != dev_data->devid) {
+		clear_dte_entry(alias);
+		/* Flush the Alias DTE entry */
+		device_flush_dte(alias);
+	}
+
+	/* Flush IOTLB */
+	domain_flush_tlb_pde(domain);
+
+	/* Wait for the flushes to finish */
+	domain_flush_complete(domain);
+
+	/* decrease reference counters - needs to happen after the flushes */
+	domain->dev_iommu[iommu->index] -= 1;
+	domain->dev_cnt                 -= 1;
 }
 
 /*
