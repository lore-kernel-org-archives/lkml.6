Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430182054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmmTyM1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430182054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeKAIxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbeKAIGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15ADC20823;
        Wed, 31 Oct 2018 23:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027165;
        bh=rQkjh6Jbx/gYVbPJxx78KPtQMKnAz+tNa+RYimnIHck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OmmTyM1duX6LbaZo34XL+vfz0/xSidO6h6TcIsGYVD1lnyifzj53HhdNSyhRF3KZx
         qj+9sYqskoQo2IWbPbkFol4AGG1HSX2Nto5fOYJYsxe1sG1nFrMAFfhdbNoTqkRLHH
         cdjcOK/NivR1AGYMjFA6aOAIg9X06TJDWwYPxVKY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 025/146] sdhci: acpi: add free_slot callback
Date:   Wed, 31 Oct 2018 19:03:40 -0400
Message-Id: <20181031230541.28822-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>

[ Upstream commit c7eabbee3de99347105faa7fd925a500ccf43baf ]

The device specific resource can be free in free_slot after
removing host controller.

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 32321bd596d8..c61109f7b793 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -76,6 +76,7 @@ struct sdhci_acpi_slot {
 	size_t		priv_size;
 	int (*probe_slot)(struct platform_device *, const char *, const char *);
 	int (*remove_slot)(struct platform_device *);
+	int (*free_slot)(struct platform_device *pdev);
 	int (*setup_host)(struct platform_device *pdev);
 };
 
@@ -756,6 +757,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 err_cleanup:
 	sdhci_cleanup_host(c->host);
 err_free:
+	if (c->slot && c->slot->free_slot)
+		c->slot->free_slot(pdev);
+
 	sdhci_free_host(c->host);
 	return err;
 }
@@ -777,6 +781,10 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
 
 	dead = (sdhci_readl(c->host, SDHCI_INT_STATUS) == ~0);
 	sdhci_remove_host(c->host, dead);
+
+	if (c->slot && c->slot->free_slot)
+		c->slot->free_slot(pdev);
+
 	sdhci_free_host(c->host);
 
 	return 0;
-- 
2.17.1

