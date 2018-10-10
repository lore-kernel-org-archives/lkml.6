Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C17C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10E0214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QCUG4uT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10E0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJJWib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:38:31 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:45416 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJJWia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1539184552; x=1570720552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Fn3QrxPgQJDHEYNKmSe6DpSUJ0XH+yTqsoAizieQwQ4=;
  b=QCUG4uT5zvnnA3rgGWhHVa88ZyeECUZyBZSQ4kjrIpiZgfz82fLGsH8C
   nlDdeRR/GxCp7JdJrbdY1qYl3s56Y3cu82zGmi89TCzGF53MDhhGGtUJn
   gt/4zOET/h4l3Lqr3Az1A756nGGIbxTh4RZeRhA5lmFaxlRBV9rFXKl4+
   g=;
X-IronPort-AV: E=Sophos;i="5.54,364,1534809600"; 
   d="scan'208";a="635417528"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Oct 2018 15:15:44 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9AFFew5042244
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 10 Oct 2018 15:15:42 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 10 Oct 2018 15:15:41 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.160.173) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 10 Oct 2018 15:15:35 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <talel@amazon.com>, <jonnyc@amazon.com>, <ronenk@amazon.com>,
        <barakw@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 2/2] dw: spi: add support for Alpine spi controller
Date:   Wed, 10 Oct 2018 18:15:16 +0300
Message-ID: <1539184516-8200-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539184516-8200-1-git-send-email-talel@amazon.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <1539184516-8200-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.173]
X-ClientProxiedBy: EX13D18UWA001.ant.amazon.com (10.43.160.11) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a new devicetree compatible string called
'al,alpine-apb-ssi', which is necessary for the Amazon Alpine spi
controller. 'al,alpine-dw-apb-ssi' is used in the dw spi driver if
specified in the devicetree.  Otherwise, fall back to driver default
behavior, i.e. original dw IP hw driver behavior.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/spi/spi-dw-mmio.c | 9 +++++++++
 drivers/spi/spi-dw.c      | 6 ++++++
 drivers/spi/spi-dw.h      | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index a768461..88b04d2 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -126,6 +126,14 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
 				JAGUAR2_IF_SI_OWNER_OFFSET);
 }
 
+static int dw_spi_alpine_init(struct platform_device *pdev,
+			      struct dw_spi_mmio *dwsmmio)
+{
+	dwsmmio->dws.cs_override = 1;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -230,6 +238,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dw-apb-ssi", },
 	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_ocelot_init},
 	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
+	{ .compatible = "al,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 3e205ab..b705f2b 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -144,6 +144,8 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 
 	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
+	else if (dws->cs_override)
+		dw_writel(dws, DW_SPI_SER, 0);
 }
 EXPORT_SYMBOL_GPL(dw_spi_set_cs);
 
@@ -463,6 +465,10 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 		dws->fifo_len = (fifo == 1) ? 0 : fifo;
 		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
 	}
+
+	/* enable HW fixup for explicit CS deselect for Amazon's alpine chip */
+	if (dws->cs_override)
+		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
 }
 
 int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 0168b08..c9c1588 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -32,6 +32,7 @@
 #define DW_SPI_IDR			0x58
 #define DW_SPI_VERSION			0x5c
 #define DW_SPI_DR			0x60
+#define DW_SPI_CS_OVERRIDE		0xf4
 
 /* Bit fields in CTRLR0 */
 #define SPI_DFS_OFFSET			0
@@ -109,6 +110,7 @@ struct dw_spi {
 	u32			fifo_len;	/* depth of the FIFO buffer */
 	u32			max_freq;	/* max bus freq supported */
 
+	int			cs_override;
 	u32			reg_io_width;	/* DR I/O width in bytes */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
-- 
2.7.4

