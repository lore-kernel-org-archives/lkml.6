Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92805C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DBC2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DBC2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeILODa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:03:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47162 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbeILOD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:03:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C50F200126;
        Wed, 12 Sep 2018 10:59:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E6C6200123;
        Wed, 12 Sep 2018 10:59:54 +0200 (CEST)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net [10.171.81.110])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A3CEF205F0;
        Wed, 12 Sep 2018 10:59:53 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/12] bus: fsl-mc: add support for dpseci device type
Date:   Wed, 12 Sep 2018 11:59:26 +0300
Message-Id: <20180912085937.22489-2-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180912085937.22489-1-horia.geanta@nxp.com>
References: <20180912085937.22489-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 5 +++++
 include/linux/fsl/mc.h          | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 5d8266c6571f..4552b06fe601 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -188,6 +188,10 @@ struct device_type fsl_mc_bus_dprtc_type = {
 	.name = "fsl_mc_bus_dprtc"
 };
 
+struct device_type fsl_mc_bus_dpseci_type = {
+	.name = "fsl_mc_bus_dpseci"
+};
+
 static struct device_type *fsl_mc_get_device_type(const char *type)
 {
 	static const struct {
@@ -203,6 +207,7 @@ static struct device_type *fsl_mc_get_device_type(const char *type)
 		{ &fsl_mc_bus_dpmcp_type, "dpmcp" },
 		{ &fsl_mc_bus_dpmac_type, "dpmac" },
 		{ &fsl_mc_bus_dprtc_type, "dprtc" },
+		{ &fsl_mc_bus_dpseci_type, "dpseci" },
 		{ NULL, NULL }
 	};
 	int i;
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index f27cb14088a4..5160f06ffbac 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -405,6 +405,7 @@ extern struct device_type fsl_mc_bus_dpcon_type;
 extern struct device_type fsl_mc_bus_dpmcp_type;
 extern struct device_type fsl_mc_bus_dpmac_type;
 extern struct device_type fsl_mc_bus_dprtc_type;
+extern struct device_type fsl_mc_bus_dpseci_type;
 
 static inline bool is_fsl_mc_bus_dprc(const struct fsl_mc_device *mc_dev)
 {
@@ -451,6 +452,11 @@ static inline bool is_fsl_mc_bus_dprtc(const struct fsl_mc_device *mc_dev)
 	return mc_dev->dev.type == &fsl_mc_bus_dprtc_type;
 }
 
+static inline bool is_fsl_mc_bus_dpseci(const struct fsl_mc_device *mc_dev)
+{
+	return mc_dev->dev.type == &fsl_mc_bus_dpseci_type;
+}
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.16.2

