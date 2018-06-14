Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BD3A5C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D777208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D777208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964802AbeFNKsl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:48:41 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54079 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755114AbeFNKsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:48:38 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0C73E20004;
        Thu, 14 Jun 2018 10:48:41 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, joro@8bytes.org
Cc:     linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND 1/6] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
Date:   Thu, 14 Jun 2018 12:48:21 +0200
Message-Id: <1528973306-7962-2-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Bump up the maximum numbers of micro-TLBS to 48.

Each IPMMU device instance get micro-TLB assignment via
the "iommus" property in DT. Older SoCs tend to use a
maximum number of 32 micro-TLBs per IPMMU instance however
newer SoCs such as r8a7796 make use of up to 48 micro-TLBs.

At this point no SoC specific handling is done to validate
the maximum number of micro-TLBs, and because of that the
DT information is assumed to be within correct range for
each particular SoC.

If needed in the future SoC specific feature flags can be
added to handle the maximum number of micro-TLBs without
requiring DT changes, however at this point this does not
seem necessary.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 40ae6e8..5c1ade7 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -194,7 +194,9 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 #define IMPMBA(n)			(0x0280 + ((n) * 4))
 #define IMPMBD(n)			(0x02c0 + ((n) * 4))
 
-#define IMUCTR(n)			(0x0300 + ((n) * 16))
+#define IMUCTR(n)			((n) < 32 ? IMUCTR0(n) : IMUCTR32(n))
+#define IMUCTR0(n)			(0x0300 + ((n) * 16))
+#define IMUCTR32(n)			(0x0600 + (((n) - 32) * 16))
 #define IMUCTR_FIXADDEN			(1 << 31)
 #define IMUCTR_FIXADD_MASK		(0xff << 16)
 #define IMUCTR_FIXADD_SHIFT		16
@@ -204,7 +206,9 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 #define IMUCTR_FLUSH			(1 << 1)
 #define IMUCTR_MMUEN			(1 << 0)
 
-#define IMUASID(n)			(0x0308 + ((n) * 16))
+#define IMUASID(n)			((n) < 32 ? IMUASID0(n) : IMUASID32(n))
+#define IMUASID0(n)			(0x0308 + ((n) * 16))
+#define IMUASID32(n)			(0x0608 + (((n) - 32) * 16))
 #define IMUASID_ASID8_MASK		(0xff << 8)
 #define IMUASID_ASID8_SHIFT		8
 #define IMUASID_ASID0_MASK		(0xff << 0)
@@ -955,7 +959,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	}
 
 	mmu->dev = &pdev->dev;
-	mmu->num_utlbs = 32;
+	mmu->num_utlbs = 48;
 	spin_lock_init(&mmu->lock);
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
 	mmu->features = of_device_get_match_data(&pdev->dev);
-- 
2.7.4

