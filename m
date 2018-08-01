Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC81C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E502083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E502083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbeHATvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:51:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405797AbeHATIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E134510EC;
        Wed,  1 Aug 2018 17:04:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 167/336] gpu: host1x: Acquire a reference to the IOVA cache
Date:   Wed,  1 Aug 2018 18:48:22 +0200
Message-Id: <20180801165035.504894446@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit f40e1590c5270e5559fb95a5a0a7c1f5266a522d ]

The IOVA API uses a memory cache to allocate IOVA nodes from. To make
sure that this cache is available, obtain a reference to it and release
the reference when the cache is no longer needed.

On 64-bit ARM this is hidden by the fact that the DMA mapping API gets
that reference and never releases it. On 32-bit ARM, this is papered
over by the Tegra DRM driver (the sole user of the host1x API requiring
the cache) acquiring a reference to the IOVA cache for its own purposes.
However, there may be additional users of this API in the future, so fix
this upfront to avoid surprises.

Fixes: 404bfb78daf3 ("gpu: host1x: Add IOMMU support")
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/host1x/dev.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -223,10 +223,14 @@ static int host1x_probe(struct platform_
 		struct iommu_domain_geometry *geometry;
 		unsigned long order;
 
+		err = iova_cache_get();
+		if (err < 0)
+			goto put_group;
+
 		host->domain = iommu_domain_alloc(&platform_bus_type);
 		if (!host->domain) {
 			err = -ENOMEM;
-			goto put_group;
+			goto put_cache;
 		}
 
 		err = iommu_attach_group(host->domain, host->group);
@@ -234,6 +238,7 @@ static int host1x_probe(struct platform_
 			if (err == -ENODEV) {
 				iommu_domain_free(host->domain);
 				host->domain = NULL;
+				iova_cache_put();
 				iommu_group_put(host->group);
 				host->group = NULL;
 				goto skip_iommu;
@@ -308,6 +313,9 @@ fail_detach_device:
 fail_free_domain:
 	if (host->domain)
 		iommu_domain_free(host->domain);
+put_cache:
+	if (host->group)
+		iova_cache_put();
 put_group:
 	iommu_group_put(host->group);
 
@@ -328,6 +336,7 @@ static int host1x_remove(struct platform
 		put_iova_domain(&host->iova);
 		iommu_detach_group(host->domain, host->group);
 		iommu_domain_free(host->domain);
+		iova_cache_put();
 		iommu_group_put(host->group);
 	}
 


