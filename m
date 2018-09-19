Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC0FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F10A2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F10A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbeISLL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:11:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55841 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbeISLL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:11:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 18B2A7BB3B802;
        Wed, 19 Sep 2018 13:35:08 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 13:35:04 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <andy.gross@linaro.org>, <david.brown@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc: qcom: cmd-db: Fix some uninitialized warning.
Date:   Wed, 19 Sep 2018 13:22:44 +0800
Message-ID: <1537334564-32266-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

drivers/soc/qcom/cmd-db.c:194:38: warning: ent.addr may be used uninitialized in this function [-Wmaybe-uninitialized]
  return ret < 0 ? 0 : le32_to_cpu(ent.addr);

drivers/soc/qcom/cmd-db.c:247:38: warning: ent.len may be used uninitialized in this function [-Wmaybe-uninitialized]
  return ret < 0 ? 0 : le16_to_cpu(ent.len);

drivers/soc/qcom/cmd-db.c:269:24: warning: ent.addr may be used uninitialized in this function [-Wmaybe-uninitialized]
  addr = le32_to_cpu(ent.addr);

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/soc/qcom/cmd-db.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index a6f6462..280877f 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -186,7 +186,7 @@ static int cmd_db_get_header(const char *id, struct entry_header *eh,
 u32 cmd_db_read_addr(const char *id)
 {
 	int ret;
-	struct entry_header ent;
+	struct entry_header ent = {0};
 	struct rsc_hdr rsc_hdr;
 
 	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
@@ -239,7 +239,7 @@ int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
 size_t cmd_db_read_aux_data_len(const char *id)
 {
 	int ret;
-	struct entry_header ent;
+	struct entry_header ent = {0};
 	struct rsc_hdr rsc_hdr;
 
 	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
@@ -258,7 +258,7 @@ size_t cmd_db_read_aux_data_len(const char *id)
 enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
 {
 	int ret;
-	struct entry_header ent;
+	struct entry_header ent = {0};
 	struct rsc_hdr rsc_hdr;
 	u32 addr;
 
-- 
1.7.12.4

