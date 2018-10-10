Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AD4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAE2214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ixgJc0lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAE2214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJJO3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:29:25 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:13726 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJJO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1539155318; x=1570691318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2et5qi7ViQG/aDz+NqvyPg/04qsnznoaXv/xHHeGZqc=;
  b=ixgJc0lDU/MVUjGsyRlKlNQ5XWBwVMnOlUTKrmORSVpza8NF+gyiZ3cI
   RYJABGd+j/KBXgana+tyX4DyzKB9KvyE2HsvnU5KZXRQQqLybOgFXduX0
   5lQMVliORkoosmZnZpOc1t0picAeorRfgo0WV5adFp8AFjJeYZCkpCRnj
   A=;
X-IronPort-AV: E=Sophos;i="5.54,363,1534809600"; 
   d="scan'208";a="635317170"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Oct 2018 07:08:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9A78UOt006655
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 10 Oct 2018 07:08:35 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 10 Oct 2018 07:08:34 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.160.4) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 10 Oct 2018 07:08:29 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <talel@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Subject: [PATCH 2/2] dw: spi: add 'cs-override' DT property support
Date:   Wed, 10 Oct 2018 10:08:13 +0300
Message-ID: <1539155293-21750-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539155293-21750-1-git-send-email-talel@amazon.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.4]
X-ClientProxiedBy: EX13d09UWC004.ant.amazon.com (10.43.162.114) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for an optional devicetree property called 'cs-override', which
is necessary for the Amazon Alpine spi controller. 'cs-override' is used in
the dw spi driver if specified in the devicetree.  Otherwise, fall back to
driver default behavior, i.e., original dw IP hw driver behavior.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/spi/spi-dw-mmio.c | 2 ++
 drivers/spi/spi-dw.c      | 6 ++++++
 drivers/spi/spi-dw.h      | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index a768461..a2f7359 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -195,6 +195,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 					goto out;
 			}
 		}
+		dws->cs_override = of_property_read_bool(pdev->dev.of_node,
+							 "cs-override");
 	}
 
 	init_func = device_get_match_data(&pdev->dev);
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 3e205ab..eb4c3d1 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -144,6 +144,8 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 
 	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
+	else
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

