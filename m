Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D25C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C829720866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zc1RIy4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C829720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeILTs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeILTsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:48:25 -0400
Received: from localhost.localdomain (unknown [192.55.54.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 951FD20890;
        Wed, 12 Sep 2018 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536763416;
        bh=EriHvUk/yR9Afq8GoKBtaJSd+oeAPD3Ke+fYJniyAgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zc1RIy4Zv481scJUOre8ooXRNw0LYfMuBhr6Ft32XUjPqAKuupPwcuuiJ5uXbqx4W
         gp+jFfLz/EI7fDO+DQc0Z2q9IndoUwImVH9pVhjIOgeCHBcnfpuNIUlc5doDxibK7s
         XrTDU00dQmDbsfmcN2OfEfORr76FlD4X62MO4n38=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 5/5] fpga: dfl-fme-region: Use platform_get_drvdata()
Date:   Wed, 12 Sep 2018 09:43:27 -0500
Message-Id: <20180912144327.3130-6-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180912144327.3130-1-atull@kernel.org>
References: <20180912144327.3130-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Use platform_get_drvdata() in remove() function of
the platform driver rather than dev_get_drvdata()
to match the platform_set_drvdata in the probe().

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl-fme-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 51a5ac2..3fa0de2 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -66,7 +66,7 @@ static int fme_region_probe(struct platform_device *pdev)
 
 static int fme_region_remove(struct platform_device *pdev)
 {
-	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+	struct fpga_region *region = platform_get_drvdata(pdev);
 	struct fpga_manager *mgr = region->mgr;
 
 	fpga_region_unregister(region);
-- 
2.7.4

