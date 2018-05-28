Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163539AbeE1Ktb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163410AbeE1KtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Devesh Sharma <devesh.sharma@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 184/496] RDMA/bnxt_re: Fix incorrect DB offset calculation
Date: Mon, 28 May 2018 11:59:29 +0200
Message-Id: <20180528100327.708109499@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Devesh Sharma <devesh.sharma@broadcom.com>

[ Upstream commit c354dff00db8df80f271418d8392065e10ffffb6 ]

To support host systems with non 4K page size, l2_db_size shall be
calculated with 4096 instead of PAGE_SIZE. Also, supply the host page size
to FW during initialization.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |    6 +++++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |    1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |    3 ++-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   |   25 ++++++++++++++++++++++++-
 4 files changed, 32 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -457,7 +457,11 @@ int bnxt_qplib_init_rcfw(struct bnxt_qpl
 	int rc;
 
 	RCFW_CMD_PREP(req, INITIALIZE_FW, cmd_flags);
-
+	/* Supply (log-base-2-of-host-page-size - base-page-shift)
+	 * to bono to adjust the doorbell page sizes.
+	 */
+	req.log2_dbr_pg_size = cpu_to_le16(PAGE_SHIFT -
+					   RCFW_DBR_BASE_PAGE_SHIFT);
 	/*
 	 * VFs need not setup the HW context area, PF
 	 * shall setup this area for VF. Skipping the
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -49,6 +49,7 @@
 #define RCFW_COMM_SIZE			0x104
 
 #define RCFW_DBR_PCI_BAR_REGION		2
+#define RCFW_DBR_BASE_PAGE_SHIFT	12
 
 #define RCFW_CMD_PREP(req, CMD, cmd_flags)				\
 	do {								\
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -130,7 +130,8 @@ int bnxt_qplib_get_dev_attr(struct bnxt_
 	attr->max_pkey = le32_to_cpu(sb->max_pkeys);
 
 	attr->max_inline_data = le32_to_cpu(sb->max_inline_data);
-	attr->l2_db_size = (sb->l2_db_space_size + 1) * PAGE_SIZE;
+	attr->l2_db_size = (sb->l2_db_space_size + 1) *
+			    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
 	attr->max_sgid = le32_to_cpu(sb->max_gid);
 
 	strlcpy(attr->fw_ver, "20.6.28.0", sizeof(attr->fw_ver));
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -1734,7 +1734,30 @@ struct cmdq_initialize_fw {
 	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_PG_2M		   (0x3UL << 4)
 	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_PG_8M		   (0x4UL << 4)
 	#define CMDQ_INITIALIZE_FW_TIM_PG_SIZE_PG_1G		   (0x5UL << 4)
-	__le16 reserved16;
+	/* This value is (log-base-2-of-DBR-page-size - 12).
+	 * 0 for 4KB. HW supported values are enumerated below.
+	 */
+	__le16  log2_dbr_pg_size;
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_MASK	0xfUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_SFT		0
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_4K	0x0UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_8K	0x1UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_16K	0x2UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_32K	0x3UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_64K	0x4UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_128K	0x5UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_256K	0x6UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_512K	0x7UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_1M	0x8UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_2M	0x9UL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_4M	0xaUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_8M	0xbUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_16M	0xcUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_32M	0xdUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_64M	0xeUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_128M	0xfUL
+	#define CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_LAST		\
+			CMDQ_INITIALIZE_FW_LOG2_DBR_PG_SIZE_PG_128M
 	__le64 qpc_page_dir;
 	__le64 mrw_page_dir;
 	__le64 srq_page_dir;
