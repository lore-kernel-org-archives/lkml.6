Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63D9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B2520818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W29Ao9M2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B2520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbeKLJ2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:28:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbeKLITw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:52 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA03E223AE;
        Sun, 11 Nov 2018 22:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975395;
        bh=XOyOj4CyfGld2zh9c8I2iU8qv7YAUYi6fmTuVDbR/so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W29Ao9M2+j2X6d6IZgt4jNrMOoYR86jlTSqyiwiU4kZOpouRy7GDfrxMKdgFFgBPk
         6TS2JuwG9bY8KZO8NhkAd0k7/uJFHbP6x7YArUOXkAo6aw3Kd6aCXJ4Q4XtTTTfPHk
         0x6TqsXxbIjCQ48OcQM1NXgntlLYCHAL1o/9uP+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 084/350] sdhci: acpi: add free_slot callback
Date:   Sun, 11 Nov 2018 14:19:08 -0800
Message-Id: <20181111221710.639198907@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>

[ Upstream commit c7eabbee3de99347105faa7fd925a500ccf43baf ]

The device specific resource can be free in free_slot after
removing host controller.

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-acpi.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -76,6 +76,7 @@ struct sdhci_acpi_slot {
 	size_t		priv_size;
 	int (*probe_slot)(struct platform_device *, const char *, const char *);
 	int (*remove_slot)(struct platform_device *);
+	int (*free_slot)(struct platform_device *pdev);
 	int (*setup_host)(struct platform_device *pdev);
 };
 
@@ -756,6 +757,9 @@ static int sdhci_acpi_probe(struct platf
 err_cleanup:
 	sdhci_cleanup_host(c->host);
 err_free:
+	if (c->slot && c->slot->free_slot)
+		c->slot->free_slot(pdev);
+
 	sdhci_free_host(c->host);
 	return err;
 }
@@ -777,6 +781,10 @@ static int sdhci_acpi_remove(struct plat
 
 	dead = (sdhci_readl(c->host, SDHCI_INT_STATUS) == ~0);
 	sdhci_remove_host(c->host, dead);
+
+	if (c->slot && c->slot->free_slot)
+		c->slot->free_slot(pdev);
+
 	sdhci_free_host(c->host);
 
 	return 0;


