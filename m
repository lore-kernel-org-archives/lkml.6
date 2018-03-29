Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeC2WHX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:07:23 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35945 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbeC2WHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:17 -0400
X-Google-Smtp-Source: AIpwx4/HZFvRYuH7s1r5qxP8oCedYPmf7EIRLgvrOWh5MTH+h3N1+ihPlZUg/8dAIIUe7G+oJWt/wg==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 13/37] lightnvm: make 1.2 data structures explicit
Date: Fri, 30 Mar 2018 00:05:00 +0200
Message-Id: <20180329220524.30363-14-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the 1.2 data structures explicit, so it will be easy to identify
the 2.0 data structures. Also fix the order of which the nvme_nvm_*
are declared, such that they follow the nvme_nvm_command order.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 82 ++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index dc0b1335c7c6..60db3f1b59da 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -51,6 +51,21 @@ struct nvme_nvm_ph_rw {
 	__le64			resv;
 };
 
+struct nvme_nvm_erase_blk {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd[2];
+	__le64			prp1;
+	__le64			prp2;
+	__le64			spba;
+	__le16			length;
+	__le16			control;
+	__le32			dsmgmt;
+	__le64			resv;
+};
+
 struct nvme_nvm_identity {
 	__u8			opcode;
 	__u8			flags;
@@ -89,33 +104,18 @@ struct nvme_nvm_setbbtbl {
 	__u32			rsvd4[3];
 };
 
-struct nvme_nvm_erase_blk {
-	__u8			opcode;
-	__u8			flags;
-	__u16			command_id;
-	__le32			nsid;
-	__u64			rsvd[2];
-	__le64			prp1;
-	__le64			prp2;
-	__le64			spba;
-	__le16			length;
-	__le16			control;
-	__le32			dsmgmt;
-	__le64			resv;
-};
-
 struct nvme_nvm_command {
 	union {
 		struct nvme_common_command common;
-		struct nvme_nvm_identity identity;
 		struct nvme_nvm_ph_rw ph_rw;
+		struct nvme_nvm_erase_blk erase;
+		struct nvme_nvm_identity identity;
 		struct nvme_nvm_getbbtbl get_bb;
 		struct nvme_nvm_setbbtbl set_bb;
-		struct nvme_nvm_erase_blk erase;
 	};
 };
 
-struct nvme_nvm_id_group {
+struct nvme_nvm_id12_grp {
 	__u8			mtype;
 	__u8			fmtype;
 	__le16			res16;
@@ -141,7 +141,7 @@ struct nvme_nvm_id_group {
 	__u8			reserved[906];
 } __packed;
 
-struct nvme_nvm_addr_format {
+struct nvme_nvm_id12_addrf {
 	__u8			ch_offset;
 	__u8			ch_len;
 	__u8			lun_offset;
@@ -157,16 +157,16 @@ struct nvme_nvm_addr_format {
 	__u8			res[4];
 } __packed;
 
-struct nvme_nvm_id {
+struct nvme_nvm_id12 {
 	__u8			ver_id;
 	__u8			vmnt;
 	__u8			cgrps;
 	__u8			res;
 	__le32			cap;
 	__le32			dom;
-	struct nvme_nvm_addr_format ppaf;
+	struct nvme_nvm_id12_addrf ppaf;
 	__u8			resv[228];
-	struct nvme_nvm_id_group group;
+	struct nvme_nvm_id12_grp grp;
 	__u8			resv2[2880];
 } __packed;
 
@@ -191,25 +191,25 @@ static inline void _nvme_nvm_check_size(void)
 {
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_identity) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_ph_rw) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_erase_blk) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_getbbtbl) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_setbbtbl) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_nvm_erase_blk) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_nvm_id_group) != 960);
-	BUILD_BUG_ON(sizeof(struct nvme_nvm_addr_format) != 16);
-	BUILD_BUG_ON(sizeof(struct nvme_nvm_id) != NVME_IDENTIFY_DATA_SIZE);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_id12_grp) != 960);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_id12_addrf) != 16);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_id12) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_bb_tbl) != 64);
 }
 
-static int init_grps(struct nvm_id *nvm_id, struct nvme_nvm_id *nvme_nvm_id)
+static int init_grp(struct nvm_id *nvm_id, struct nvme_nvm_id12 *id12)
 {
-	struct nvme_nvm_id_group *src;
+	struct nvme_nvm_id12_grp *src;
 	struct nvm_id_group *grp;
 	int sec_per_pg, sec_per_pl, pg_per_blk;
 
-	if (nvme_nvm_id->cgrps != 1)
+	if (id12->cgrps != 1)
 		return -EINVAL;
 
-	src = &nvme_nvm_id->group;
+	src = &id12->grp;
 	grp = &nvm_id->grp;
 
 	grp->mtype = src->mtype;
@@ -261,34 +261,34 @@ static int init_grps(struct nvm_id *nvm_id, struct nvme_nvm_id *nvme_nvm_id)
 static int nvme_nvm_identity(struct nvm_dev *nvmdev, struct nvm_id *nvm_id)
 {
 	struct nvme_ns *ns = nvmdev->q->queuedata;
-	struct nvme_nvm_id *nvme_nvm_id;
+	struct nvme_nvm_id12 *id;
 	struct nvme_nvm_command c = {};
 	int ret;
 
 	c.identity.opcode = nvme_nvm_admin_identity;
 	c.identity.nsid = cpu_to_le32(ns->head->ns_id);
 
-	nvme_nvm_id = kmalloc(sizeof(struct nvme_nvm_id), GFP_KERNEL);
-	if (!nvme_nvm_id)
+	id = kmalloc(sizeof(struct nvme_nvm_id12), GFP_KERNEL);
+	if (!id)
 		return -ENOMEM;
 
 	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, (struct nvme_command *)&c,
-				nvme_nvm_id, sizeof(struct nvme_nvm_id));
+				id, sizeof(struct nvme_nvm_id12));
 	if (ret) {
 		ret = -EIO;
 		goto out;
 	}
 
-	nvm_id->ver_id = nvme_nvm_id->ver_id;
-	nvm_id->vmnt = nvme_nvm_id->vmnt;
-	nvm_id->cap = le32_to_cpu(nvme_nvm_id->cap);
-	nvm_id->dom = le32_to_cpu(nvme_nvm_id->dom);
-	memcpy(&nvm_id->ppaf, &nvme_nvm_id->ppaf,
+	nvm_id->ver_id = id->ver_id;
+	nvm_id->vmnt = id->vmnt;
+	nvm_id->cap = le32_to_cpu(id->cap);
+	nvm_id->dom = le32_to_cpu(id->dom);
+	memcpy(&nvm_id->ppaf, &id->ppaf,
 					sizeof(struct nvm_addr_format));
 
-	ret = init_grps(nvm_id, nvme_nvm_id);
+	ret = init_grp(nvm_id, id);
 out:
-	kfree(nvme_nvm_id);
+	kfree(id);
 	return ret;
 }
 
-- 
2.11.0
