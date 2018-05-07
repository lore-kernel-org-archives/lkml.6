Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeEGN1j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:27:39 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41864 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeEGN1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:27:36 -0400
X-Google-Smtp-Source: AB8JxZqjU3cuiQXVm6iVf/QSh3LKP9oxA5+s6TmGl1a4hEH9FimvGNtu5/nyNVEbal6c6c58H8/DRQ==
From: Anders Roxell <anders.roxell@linaro.org>
To: andy.gross@linaro.org, david.brown@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] soc: qcom: cmd-db: initialize struct to remove warning
Date: Mon,  7 May 2018 15:27:24 +0200
Message-Id: <20180507132724.25846-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct isn't initialized, so gcc can't guarantee that the struct
member is initialized thats why it says maybe-uninitialized.

drivers/soc/qcom/cmd-db.c: In function ‘cmd_db_read_addr’:
drivers/soc/qcom/cmd-db.c:194:21: warning: ‘ent.addr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  return ret < 0 ? 0 : le32_to_cpu(ent.addr);
drivers/soc/qcom/cmd-db.c: In function ‘cmd_db_read_aux_data’:
drivers/soc/qcom/cmd-db.c:221:10: warning: ‘ent.len’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  ent_len = le16_to_cpu(ent.len);
drivers/soc/qcom/cmd-db.c:226:15: warning: ‘*((void *)&rsc_hdr+4)’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  memcpy(data, rsc_offset(&rsc_hdr, &ent), len);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/qcom/cmd-db.c:226:15: warning: ‘*((void *)&ent+22)’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  CC      drivers/mfd/pcf50633-irq.o
drivers/soc/qcom/cmd-db.c: In function ‘cmd_db_read_aux_data_len’:
drivers/soc/qcom/cmd-db.c:247:38: warning: ‘ent.len’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  return ret < 0 ? 0 : le16_to_cpu(ent.len);
                                      ^
drivers/soc/qcom/cmd-db.c: In function ‘cmd_db_read_slave_id’:
drivers/soc/qcom/cmd-db.c:269:7: warning: ‘ent.addr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  addr = le32_to_cpu(ent.addr);

Initialize structs entry_header and rsc_hdr to remove the compile
warning 'maybe-uninitialized'.

Fixes: f22f5914c8c8 ("drivers: qcom: add command DB driver")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index a6f646295f06..1663dd1e46da 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -186,7 +186,7 @@ static int cmd_db_get_header(const char *id, struct entry_header *eh,
 u32 cmd_db_read_addr(const char *id)
 {
 	int ret;
-	struct entry_header ent;
+	struct entry_header ent = {};
 	struct rsc_hdr rsc_hdr;
 
 	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
@@ -207,8 +207,8 @@ EXPORT_SYMBOL(cmd_db_read_addr);
 int cmd_db_read_aux_data(const char *id, u8 *data, size_t len)
 {
 	int ret;
-	struct entry_header ent;
-	struct rsc_hdr rsc_hdr;
+	struct entry_header ent = {};
+	struct rsc_hdr rsc_hdr = {};
 	u16 ent_len;
 
 	if (!data)
@@ -239,7 +239,7 @@ EXPORT_SYMBOL(cmd_db_read_aux_data);
 size_t cmd_db_read_aux_data_len(const char *id)
 {
 	int ret;
-	struct entry_header ent;
+	struct entry_header ent = {};
 	struct rsc_hdr rsc_hdr;
 
 	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
@@ -258,7 +258,7 @@ EXPORT_SYMBOL(cmd_db_read_aux_data_len);
 enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
 {
 	int ret;
-	struct entry_header ent;
+	struct entry_header ent = {};
 	struct rsc_hdr rsc_hdr;
 	u32 addr;
 
-- 
2.17.0
