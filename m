Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8618C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3B620861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3B620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIGM6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:58:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727670AbeIGM6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:58:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0E5E401EF27;
        Fri,  7 Sep 2018 08:18:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0E1710F1C09;
        Fri,  7 Sep 2018 08:18:43 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com
Subject: [PATCH 3/4 v7] amd_iommu: remap the device table of IOMMU with the memory encryption mask for kdump
Date:   Fri,  7 Sep 2018 16:18:04 +0800
Message-Id: <20180907081805.368-4-lijiang@redhat.com>
In-Reply-To: <20180907081805.368-1-lijiang@redhat.com>
References: <20180907081805.368-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 07 Sep 2018 08:18:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 07 Sep 2018 08:18:52 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump kernel, it will copy the device table of IOMMU from the old device
table, which is encrypted when SME is enabled in the first kernel. So we
have to remap the old device table with the memory encryption mask.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 84b3e4445d46..3931c7de7c69 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -902,12 +902,22 @@ static bool copy_device_table(void)
 		}
 	}
 
-	old_devtb_phys = entry & PAGE_MASK;
+	/*
+	 * When SME is enabled in the first kernel, the entry includes the
+	 * memory encryption mask(sme_me_mask), we must remove the memory
+	 * encryption mask to obtain the true physical address in kdump kernel.
+	 */
+	old_devtb_phys = __sme_clr(entry) & PAGE_MASK;
+
 	if (old_devtb_phys >= 0x100000000ULL) {
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+	old_devtb = (sme_active() && is_kdump_kernel())
+		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
+							dev_table_size)
+		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+
 	if (!old_devtb)
 		return false;
 
-- 
2.17.1

