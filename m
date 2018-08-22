Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF1CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE28620673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE28620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeHVPiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:38:17 -0400
Received: from mx.socionext.com ([202.248.49.38]:50748 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbeHVPiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:38:10 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Aug 2018 21:13:29 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 2822B600AA;
        Wed, 22 Aug 2018 21:13:29 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 22 Aug 2018 21:13:29 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 78DA01A0E11;
        Wed, 22 Aug 2018 21:13:28 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 3/3] ata: ahci_platform: enable to get and control reset
Date:   Wed, 22 Aug 2018 21:13:03 +0900
Message-Id: <1534939983-16264-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike SoC-specific driver, generic ahci_platform driver doesn't
have any chances to control resets.

This adds AHCI_PLATFORM_GET_RESETS to ahci_platform_get_resources()
on the generic driver to enable reset control support.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/ata/ahci_platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 5709273..ddd9308 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -43,7 +43,8 @@ static int ahci_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev, 0);
+	hpriv = ahci_platform_get_resources(pdev,
+					    AHCI_PLATFORM_GET_RESETS);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-- 
2.7.4

