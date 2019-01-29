Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB94C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F59D2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfA2Hc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:32:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58459 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726905AbfA2Hc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:32:26 -0500
X-UUID: 1bffa034c2504860b1cf618c7ec583c0-20190129
X-UUID: 1bffa034c2504860b1cf618c7ec583c0-20190129
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 913621972; Tue, 29 Jan 2019 15:32:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 15:32:12 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 15:32:12 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: [PATCH 08/10] soc: mediatek: add packet encoder function
Date:   Tue, 29 Jan 2019 15:32:05 +0800
Message-ID: <1548747128-60136-9-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a function can encode the GCE instructions

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c   | 102 ++++++++++++++++++++-----------
 include/linux/mailbox/mtk-cmdq-mailbox.h |   2 +
 include/linux/soc/mediatek/mtk-cmdq.h    |  14 ++---
 3 files changed, 76 insertions(+), 42 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 16c0393..923a815 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -9,11 +9,43 @@
 #include <linux/mailbox_controller.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
-#define CMDQ_ARG_A_WRITE_MASK	0xffff
+#define CMDQ_GET_ARG_B(arg)	(((arg) & GENMASK(31, 16)) >> 16)
+#define CMDQ_GET_ARG_C(arg)	((arg) & GENMASK(15, 0))
 #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
 #define CMDQ_EOC_CMD		((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
 				<< 32 | CMDQ_EOC_IRQ_EN)
+#define CMDQ_IMMEDIATE_VALUE	0
+#define CMDQ_REG_TYPE		1
+
+struct cmdq_instruction {
+	s16 arg_c:16;
+	s16 arg_b:16;
+	s16 arg_a:16;
+	u8 s_op:5;
+	u8 arg_c_type:1;
+	u8 arg_b_type:1;
+	u8 arg_a_type:1;
+	u8 op:8;
+};
+
+static void cmdq_pkt_instr_encoder(struct cmdq_pkt *pkt, s16 arg_c, s16 arg_b,
+				   s16 arg_a, u8 s_op, u8 arg_c_type,
+				   u8 arg_b_type, u8 arg_a_type, u8 op)
+{
+	struct cmdq_instruction *cmdq_inst;
+
+	cmdq_inst = pkt->va_base + pkt->cmd_buf_size;
+	cmdq_inst->op = op;
+	cmdq_inst->arg_a_type = arg_a_type;
+	cmdq_inst->arg_b_type = arg_b_type;
+	cmdq_inst->arg_c_type = arg_c_type;
+	cmdq_inst->s_op = s_op;
+	cmdq_inst->arg_a = arg_a;
+	cmdq_inst->arg_b = arg_b;
+	cmdq_inst->arg_c = arg_c;
+	pkt->cmd_buf_size += CMDQ_INST_SIZE;
+}
 
 u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base)
 {
@@ -180,10 +212,11 @@ void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
 }
 EXPORT_SYMBOL(cmdq_pkt_destroy);
 
-static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
-				   u32 arg_a, u32 arg_b)
+static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, s16 arg_c, s16 arg_b,
+				   s16 arg_a, u8 s_op, u8 arg_c_type,
+				   u8 arg_b_type, u8 arg_a_type,
+				   enum cmdq_code code)
 {
-	u64 *cmd_ptr;
 
 	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
 		/*
@@ -199,65 +232,59 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
 			__func__, (u32)pkt->buf_size);
 		return -ENOMEM;
 	}
-	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
-	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
-	pkt->cmd_buf_size += CMDQ_INST_SIZE;
+	cmdq_pkt_instr_encoder(pkt, arg_c, arg_b, arg_a, s_op, arg_c_type,
+			       arg_b_type, arg_a_type, code);
 
 	return 0;
 }
 
-int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset)
+int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
 {
-	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
-		    (subsys << CMDQ_SUBSYS_SHIFT);
-
-	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
+	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(value),
+				       CMDQ_GET_ARG_B(value), offset, subsys,
+				       CMDQ_IMMEDIATE_VALUE,
+				       CMDQ_IMMEDIATE_VALUE,
+				       CMDQ_IMMEDIATE_VALUE, CMDQ_CODE_WRITE);
 }
 EXPORT_SYMBOL(cmdq_pkt_write);
 
-int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
-			u32 subsys, u32 offset, u32 mask)
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
+			u32 value, u32 mask)
 {
 	u32 offset_mask = offset;
 	int err = 0;
 
 	if (mask != 0xffffffff) {
-		err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
+		err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(~mask),
+					      CMDQ_GET_ARG_B(~mask), 0, 0, 0, 0,
+					      0, CMDQ_CODE_MASK);
 		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
 	}
-	err |= cmdq_pkt_write(pkt, value, subsys, offset_mask);
+	err |= cmdq_pkt_write(pkt, subsys, offset_mask, value);
 
 	return err;
 }
 EXPORT_SYMBOL(cmdq_pkt_write_mask);
 
-int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
+int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event)
 {
-	u32 arg_b;
-
 	if (event >= CMDQ_MAX_EVENT)
 		return -EINVAL;
 
-	/*
-	 * WFE arg_b
-	 * bit 0-11: wait value
-	 * bit 15: 1 - wait, 0 - no wait
-	 * bit 16-27: update value
-	 * bit 31: 1 - update, 0 - no update
-	 */
-	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
-
-	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event, arg_b);
+	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_WFE_OPTION),
+				       CMDQ_GET_ARG_B(CMDQ_WFE_OPTION), event,
+				       0, 0, 0, 0, CMDQ_CODE_WFE);
 }
 EXPORT_SYMBOL(cmdq_pkt_wfe);
 
-int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
+int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
 {
 	if (event >= CMDQ_MAX_EVENT)
 		return -EINVAL;
 
-	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event,
-				       CMDQ_WFE_UPDATE);
+	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_WFE_UPDATE),
+				       CMDQ_GET_ARG_B(CMDQ_WFE_UPDATE), event,
+				       0, 0, 0, 0, CMDQ_CODE_WFE);
 }
 EXPORT_SYMBOL(cmdq_pkt_clear_event);
 
@@ -266,10 +293,15 @@ static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 	int err;
 
 	/* insert EOC and generate IRQ for each command iteration */
-	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
-
+	err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_EOC_IRQ_EN),
+				      CMDQ_GET_ARG_B(CMDQ_EOC_IRQ_EN),
+				      0, 0, 0, 0, 0, CMDQ_CODE_EOC);
+	if (err < 0)
+		return err;
 	/* JUMP to end */
-	err |= cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
+	err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(CMDQ_JUMP_PASS),
+				      CMDQ_GET_ARG_B(CMDQ_JUMP_PASS),
+				      0, 0, 0, 0, 0, CMDQ_CODE_JUMP);
 
 	return err;
 }
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index 911475da..f21801d 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -19,6 +19,8 @@
 #define CMDQ_WFE_UPDATE			BIT(31)
 #define CMDQ_WFE_WAIT			BIT(15)
 #define CMDQ_WFE_WAIT_VALUE		0x1
+#define CMDQ_WFE_OPTION                 (CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | \
+					CMDQ_WFE_WAIT_VALUE)
 /** cmdq event maximum */
 #define CMDQ_MAX_EVENT			0x3ff
 
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index e5b0a98..e4d1876 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -70,26 +70,26 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
 /**
  * cmdq_pkt_write() - append write command to the CMDQ packet
  * @pkt:	the CMDQ packet
- * @value:	the specified target register value
  * @subsys:	the CMDQ sub system code
  * @offset:	register offset from CMDQ sub system
+ * @value:	the specified target register value
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset);
+int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value);
 
 /**
  * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
  * @pkt:	the CMDQ packet
- * @value:	the specified target register value
  * @subsys:	the CMDQ sub system code
  * @offset:	register offset from CMDQ sub system
+ * @value:	the specified target register value
  * @mask:	the specified target register mask
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
-			u32 subsys, u32 offset, u32 mask);
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys, u16 offset,
+			u32 value, u32 mask);
 
 /**
  * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
@@ -98,7 +98,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
+int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
 
 /**
  * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
@@ -107,7 +107,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event);
+int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event);
 
 /**
  * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
-- 
1.9.1

