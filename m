Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EC1B2C16ABE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966872087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beiJEOYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966872087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934584AbeFKTJR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:09:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52651 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934612AbeFKTJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:09:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so16543902wmb.2;
        Mon, 11 Jun 2018 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wcPcm00iDHvkG+unEA7BAB34asSEtarPGoA7YY2LQ3g=;
        b=beiJEOYXhVwhYuoptx1C9IqIaoZ5Z/pKKdkCLp+KXVPfU2gZ1Wn+Orl26kV3CEzSAf
         RrjLTXLc5/Sn5wCfGnXiqcIaffjPNCVK0n2OAQDdUCnuaF/NZEqT+Kl8DqYeL6Km2CkI
         bepVrfO5JRAxE8s7Rd2V1V51+rns8PZOBMW6l9d6DSAS9ViS9OHR39FDu8a6/WzTiQ9T
         cC0+3rqj/4Tc5Abeg25tAMJp0fBYnvEnCW6B+8xqeMDayj6p1gr14KJLaUKljyzpLdf3
         1x0k+Mc1o8qk7tb8zdJyDeeoreIxPqy05BXDMl8aeGuuWpAER1KXEh9dy6gVHcyUKTN5
         F5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wcPcm00iDHvkG+unEA7BAB34asSEtarPGoA7YY2LQ3g=;
        b=HtCjk5WLFjTJTaCuvY6rRrn/YOY0UR81qE7RXgpVtlhWAHqn75GIWJ11fBe6HVyZUt
         5N3oIt5sbtdOC69F/jdSzhubNVuvrBqW+fWj+dBCmMIX0JiR/HnR0fJekkqWGfLmQAaz
         z+99A6YruI4k4Ew+wCmz6+EPBQCNuNYPUSZY/bcjKnV1UxFCzPBrwhu275Lx9bf+RD95
         o8zc+R6KQBqqvCtAt5lEqpEFIWBOiGDlFCyJa9USnUckpjzXRP40wFOswxV3cM9tFb8g
         mQQmdZu/XRD4OxqyxB5pfbk2g7a9PA2DhgdUHJ7w1VOaydG0V98McpMQkk0nBV7t17k+
         robg==
X-Gm-Message-State: APt69E00AskKm4nxA39eRT3I4YJFtAkIh81UpATQUjMsSSsapQ6twa2Y
        qNSVB9rq1V0JKNWvOXeQaEE=
X-Google-Smtp-Source: ADUXVKKeLXfp5J6Wbkt2/4Br+CLdW3CSJdopNmpNjw13L6JkEvDxJ62B/G9qNjfd/q/IgUiHmZXyDA==
X-Received: by 2002:a1c:5b0d:: with SMTP id p13-v6mr130013wmb.53.1528744151075;
        Mon, 11 Jun 2018 12:09:11 -0700 (PDT)
Received: from localhost.localdomain ([141.226.166.38])
        by smtp.gmail.com with ESMTPSA id c11-v6sm47128191wri.49.2018.06.11.12.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 12:09:10 -0700 (PDT)
From:   Ramon Fried <ramon.fried@gmail.com>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ramon Fried <ramon.fried@gmail.com>
Subject: [PATCH] soc: qcom: smem: fix checkpatch warnings
Date:   Tue, 12 Jun 2018 01:08:35 +0300
Message-Id: <20180611220835.11129-1-ramon.fried@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Fixed checkpatch.sh warnings in smem.c & smem.h:
- WARNING: Prefer 'unsigned int' to bare use of 'unsigned'.
- WARNING: Block comments should align the * on each line.
- WARNING: line over 80 characters.
- ERROR: do not use assignment in if condition.

* Fixed grammar in comment.

Signed-off-by: Ramon Fried <ramon.fried@gmail.com>
---
 drivers/soc/qcom/smem.c       | 41 +++++++++++++++++++----------------
 include/linux/soc/qcom/smem.h |  6 ++---
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 0b94d62fad2b..e5ef6611ed73 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -22,7 +22,7 @@
 #include <linux/soc/qcom/smem.h>
 
 /*
- * The Qualcomm shared memory system is a allocate only heap structure that
+ * The Qualcomm shared memory system is an allocate only heap structure that
  * consists of one of more memory areas that can be accessed by the processors
  * in the SoC.
  *
@@ -94,11 +94,11 @@
 #define SMEM_HOST_COUNT		10
 
 /**
-  * struct smem_proc_comm - proc_comm communication struct (legacy)
-  * @command:	current command to be executed
-  * @status:	status of the currently requested command
-  * @params:	parameters to the command
-  */
+ * struct smem_proc_comm - proc_comm communication struct (legacy)
+ * @command:	current command to be executed
+ * @status:	status of the currently requested command
+ * @params:	parameters to the command
+ */
 struct smem_proc_comm {
 	__le32 command;
 	__le32 status;
@@ -276,7 +276,7 @@ struct qcom_smem {
 	size_t cacheline[SMEM_HOST_COUNT];
 	u32 item_count;
 
-	unsigned num_regions;
+	unsigned int num_regions;
 	struct smem_region regions[0];
 };
 
@@ -350,7 +350,7 @@ static struct qcom_smem *__smem;
 
 static int qcom_smem_alloc_private(struct qcom_smem *smem,
 				   struct smem_partition_header *phdr,
-				   unsigned item,
+				   unsigned int item,
 				   size_t size)
 {
 	struct smem_private_entry *hdr, *end;
@@ -400,7 +400,7 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 }
 
 static int qcom_smem_alloc_global(struct qcom_smem *smem,
-				  unsigned item,
+				  unsigned int item,
 				  size_t size)
 {
 	struct smem_global_entry *entry;
@@ -441,7 +441,7 @@ static int qcom_smem_alloc_global(struct qcom_smem *smem,
  * Allocate space for a given smem item of size @size, given that the item is
  * not yet allocated.
  */
-int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
+int qcom_smem_alloc(unsigned int host, unsigned int item, size_t size)
 {
 	struct smem_partition_header *phdr;
 	unsigned long flags;
@@ -482,14 +482,14 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 EXPORT_SYMBOL(qcom_smem_alloc);
 
 static void *qcom_smem_get_global(struct qcom_smem *smem,
-				  unsigned item,
+				  unsigned int item,
 				  size_t *size)
 {
 	struct smem_header *header;
 	struct smem_region *area;
 	struct smem_global_entry *entry;
 	u32 aux_base;
-	unsigned i;
+	unsigned int i;
 
 	header = smem->regions[0].virt_base;
 	entry = &header->toc[item];
@@ -514,7 +514,7 @@ static void *qcom_smem_get_global(struct qcom_smem *smem,
 static void *qcom_smem_get_private(struct qcom_smem *smem,
 				   struct smem_partition_header *phdr,
 				   size_t cacheline,
-				   unsigned item,
+				   unsigned int item,
 				   size_t *size)
 {
 	struct smem_private_entry *e, *end;
@@ -575,7 +575,7 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
  * Looks up smem item and returns pointer to it. Size of smem
  * item is returned in @size.
  */
-void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
+void *qcom_smem_get(unsigned int host, unsigned int item, size_t *size)
 {
 	struct smem_partition_header *phdr;
 	unsigned long flags;
@@ -621,11 +621,11 @@ EXPORT_SYMBOL(qcom_smem_get);
  * To be used by smem clients as a quick way to determine if any new
  * allocations has been made.
  */
-int qcom_smem_get_free_space(unsigned host)
+int qcom_smem_get_free_space(unsigned int host)
 {
 	struct smem_partition_header *phdr;
 	struct smem_header *header;
-	unsigned ret;
+	unsigned int ret;
 
 	if (!__smem)
 		return -EPROBE_DEFER;
@@ -902,9 +902,12 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (num_regions > 1 && (ret = qcom_smem_map_memory(smem, &pdev->dev,
-					"qcom,rpm-msg-ram", 1)))
-		return ret;
+	if (num_regions > 1) {
+		ret = qcom_smem_map_memory(smem, &pdev->dev,
+					"qcom,rpm-msg-ram", 1);
+		if (ret)
+			return ret;
+	}
 
 	header = smem->regions[0].virt_base;
 	if (le32_to_cpu(header->initialized) != 1 ||
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index c1657ed27b30..d0e8783bccff 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -4,9 +4,9 @@
 
 #define QCOM_SMEM_HOST_ANY -1
 
-int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
-void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
+int qcom_smem_alloc(unsigned int host, unsigned int item, size_t size);
+void *qcom_smem_get(unsigned int host, unsigned int item, size_t *size);
 
-int qcom_smem_get_free_space(unsigned host);
+int qcom_smem_get_free_space(unsigned int host);
 
 #endif
-- 
2.17.1

