Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197562054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197562054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeLKNoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:44:10 -0500
Received: from 8bytes.org ([81.169.241.247]:53314 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbeLKNnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:43:49 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E75C051B; Tue, 11 Dec 2018 14:43:46 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        jroedel@suse.de, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 3/6] ACPI/IORT: Use device_iommu_mapped()
Date:   Tue, 11 Dec 2018 14:43:40 +0100
Message-Id: <20181211134343.10664-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211134343.10664-1-joro@8bytes.org>
References: <20181211134343.10664-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Replace the iommu-check with a proper and readable function
call.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..0125c8eb9e81 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -805,7 +805,7 @@ static inline int iort_add_device_replay(const struct iommu_ops *ops,
 {
 	int err = 0;
 
-	if (ops->add_device && dev->bus && !dev->iommu_group)
+	if (ops->add_device && dev->bus && !device_iommu_mapped(dev))
 		err = ops->add_device(dev);
 
 	return err;
-- 
2.17.1

