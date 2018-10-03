Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC5EC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214662089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EPNbhfWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214662089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJCXqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:46:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58740 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCXqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:46:30 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w93GumJ8023843;
        Wed, 3 Oct 2018 11:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538585808;
        bh=6U9ZBFyp0zX5wRfXVDKmEvp8hOJt7BLMWkGpfvcFO0U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EPNbhfWpjGo0dihVi33JmIJIGsYBaGbvpOGaIHBpsjsyoUvOGeSxKd3e5n8R2+6W2
         tqLsHcvtDNaqth343/Dat+68oILQoLLnqmYmyJW1g554MkDJE1yCU/r4DLD2qhvrMP
         MHki2wyK8DKn9EAh+zC6GAZAh3Wvn6GoPQnHv/5Y=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93GumcT007091;
        Wed, 3 Oct 2018 11:56:48 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 11:56:48 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 11:56:48 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93GuZMK030968;
        Wed, 3 Oct 2018 11:56:45 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Brian Norris <computersforpeace@gmail.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 3/3] mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller
Date:   Wed, 3 Oct 2018 22:26:03 +0530
Message-ID: <20181003165603.2579-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003165603.2579-1-vigneshr@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence OSPI controller IP supports Octal IO (x8 IO lines),
It also has an integrated PHY. IP register layout is very
similar to existing QSPI IP except for additional bits to support Octal
and Octal DDR mode. Therefore, extend current driver to support Octal
mode.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index e24db817154e..48b00e75a879 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -101,6 +101,7 @@ struct cqspi_st {
 #define CQSPI_INST_TYPE_SINGLE			0
 #define CQSPI_INST_TYPE_DUAL			1
 #define CQSPI_INST_TYPE_QUAD			2
+#define CQSPI_INST_TYPE_OCTAL			3
 
 #define CQSPI_DUMMY_CLKS_PER_BYTE		8
 #define CQSPI_DUMMY_BYTES_MAX			4
@@ -898,6 +899,9 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
 		case SNOR_PROTO_1_1_4:
 			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
 			break;
+		case SNOR_PROTO_1_1_8:
+			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1205,6 +1209,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
 			SNOR_HWCAPS_READ_FAST |
 			SNOR_HWCAPS_READ_1_1_2 |
 			SNOR_HWCAPS_READ_1_1_4 |
+			SNOR_HWCAPS_READ_1_1_8 |
 			SNOR_HWCAPS_PP,
 	};
 	struct platform_device *pdev = cqspi->pdev;
@@ -1456,6 +1461,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "ti,k2g-qspi",
 		.data = (void *)CQSPI_NEEDS_WR_DELAY,
 	},
+	{
+		.compatible = "ti,am654-ospi",
+		.data = (void *)CQSPI_NEEDS_WR_DELAY,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.19.0

