Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A4DECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8B421471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8B421471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeIRKuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 06:50:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726853AbeIRKuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 06:50:04 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 22522F3255FF4;
        Tue, 18 Sep 2018 13:19:08 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Tue, 18 Sep 2018 13:19:07 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <andy.gross@linaro.org>, <david.brown@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: qcom: Fix a uninitialized warning.
Date:   Tue, 18 Sep 2018 13:06:48 +0800
Message-ID: <1537247208-33632-1-git-send-email-zhongjiang@huawei.com>
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

