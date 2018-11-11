Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338F2C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F119D20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak7JrzJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F119D20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbeKLKBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbeKLIRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D59E5214E0;
        Sun, 11 Nov 2018 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975247;
        bh=8yOPprj1BOkY2RlY56pHOWDxuqiMh5pfPNjrmDQEQ8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ak7JrzJNAdZ0/9uyBVtOB5QuLr/pYES1P9nOvXzlwM0zSj9DySN/lwtE3KmVu6Ite
         GaYVO78us4bpxhkMZ+jQt1XZA/nIK7Pbd6rUstlFU0Ut1PyvAeBlnnw8nwWS6z1pqN
         yGmswNeGcPZes7iCyjUzMsEoHcGY6P2o+a4D1zMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/361] sdhci: acpi: add free_slot callback
Date:   Sun, 11 Nov 2018 14:16:58 -0800
Message-Id: <20181111221630.001440912@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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


