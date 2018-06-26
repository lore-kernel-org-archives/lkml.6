Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B185C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3A4268E8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3A4268E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934322AbeFZXyy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:54:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:38513 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934216AbeFZXy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:54:29 -0400
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5QNQ6qZ022979;
        Tue, 26 Jun 2018 18:26:22 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 02/14] fsi: Move code around to avoid forward declaration
Date:   Wed, 27 Jun 2018 09:25:53 +1000
Message-Id: <20180626232605.13420-3-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move fsi_slave_set_smode() and its helpers to before it's
first user and remove the corresponding forward declaration.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-core.c | 94 +++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 565218872635..2f6f9b8c75e4 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -215,7 +215,52 @@ static int fsi_slave_report_and_clear_errors(struct fsi_slave *slave)
 			&irq, sizeof(irq));
 }
 
-static int fsi_slave_set_smode(struct fsi_master *master, int link, int id);
+/* Encode slave local bus echo delay */
+static inline uint32_t fsi_smode_echodly(int x)
+{
+	return (x & FSI_SMODE_ED_MASK) << FSI_SMODE_ED_SHIFT;
+}
+
+/* Encode slave local bus send delay */
+static inline uint32_t fsi_smode_senddly(int x)
+{
+	return (x & FSI_SMODE_SD_MASK) << FSI_SMODE_SD_SHIFT;
+}
+
+/* Encode slave local bus clock rate ratio */
+static inline uint32_t fsi_smode_lbcrr(int x)
+{
+	return (x & FSI_SMODE_LBCRR_MASK) << FSI_SMODE_LBCRR_SHIFT;
+}
+
+/* Encode slave ID */
+static inline uint32_t fsi_smode_sid(int x)
+{
+	return (x & FSI_SMODE_SID_MASK) << FSI_SMODE_SID_SHIFT;
+}
+
+static uint32_t fsi_slave_smode(int id)
+{
+	return FSI_SMODE_WSC | FSI_SMODE_ECRC
+		| fsi_smode_sid(id)
+		| fsi_smode_echodly(0xf) | fsi_smode_senddly(0xf)
+		| fsi_smode_lbcrr(0x8);
+}
+
+static int fsi_slave_set_smode(struct fsi_master *master, int link, int id)
+{
+	uint32_t smode;
+	__be32 data;
+
+	/* set our smode register with the slave ID field to 0; this enables
+	 * extended slave addressing
+	 */
+	smode = fsi_slave_smode(id);
+	data = cpu_to_be32(smode);
+
+	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SMODE,
+			&data, sizeof(data));
+}
 
 static int fsi_slave_handle_error(struct fsi_slave *slave, bool write,
 				  uint32_t addr, size_t size)
@@ -569,53 +614,6 @@ static const struct bin_attribute fsi_slave_term_attr = {
 	.write = fsi_slave_sysfs_term_write,
 };
 
-/* Encode slave local bus echo delay */
-static inline uint32_t fsi_smode_echodly(int x)
-{
-	return (x & FSI_SMODE_ED_MASK) << FSI_SMODE_ED_SHIFT;
-}
-
-/* Encode slave local bus send delay */
-static inline uint32_t fsi_smode_senddly(int x)
-{
-	return (x & FSI_SMODE_SD_MASK) << FSI_SMODE_SD_SHIFT;
-}
-
-/* Encode slave local bus clock rate ratio */
-static inline uint32_t fsi_smode_lbcrr(int x)
-{
-	return (x & FSI_SMODE_LBCRR_MASK) << FSI_SMODE_LBCRR_SHIFT;
-}
-
-/* Encode slave ID */
-static inline uint32_t fsi_smode_sid(int x)
-{
-	return (x & FSI_SMODE_SID_MASK) << FSI_SMODE_SID_SHIFT;
-}
-
-static uint32_t fsi_slave_smode(int id)
-{
-	return FSI_SMODE_WSC | FSI_SMODE_ECRC
-		| fsi_smode_sid(id)
-		| fsi_smode_echodly(0xf) | fsi_smode_senddly(0xf)
-		| fsi_smode_lbcrr(0x8);
-}
-
-static int fsi_slave_set_smode(struct fsi_master *master, int link, int id)
-{
-	uint32_t smode;
-	__be32 data;
-
-	/* set our smode register with the slave ID field to 0; this enables
-	 * extended slave addressing
-	 */
-	smode = fsi_slave_smode(id);
-	data = cpu_to_be32(smode);
-
-	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SMODE,
-			&data, sizeof(data));
-}
-
 static void fsi_slave_release(struct device *dev)
 {
 	struct fsi_slave *slave = to_fsi_slave(dev);
-- 
2.17.1

