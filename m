Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C742C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC29208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC29208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeFLK3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:29:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:34353 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932608AbeFLKW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:22:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 03:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,214,1526367600"; 
   d="scan'208";a="66321900"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2018 03:22:25 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v6 04/29] fpga: mgr: add compat_id support
Date:   Tue, 12 Jun 2018 18:10:18 +0800
Message-Id: <1528798243-2029-5-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces compat_id support to fpga manager, it adds
a fpga_compat_id pointer to fpga manager data structure to allow
fpga manager drivers to save the compatibility id. This compat_id
could be used for compatibility checking before doing partial
reconfiguration to associated fpga regions.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v6: add Acked-by from Alan.
---
 include/linux/fpga/fpga-mgr.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index e249b72..8942e61 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -136,11 +136,23 @@ struct fpga_manager_ops {
 #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
 
 /**
+ * struct fpga_compat_id - id for compatibility check
+ *
+ * @id_h: high 64bit of the compat_id
+ * @id_l: low 64bit of the compat_id
+ */
+struct fpga_compat_id {
+	u64 id_h;
+	u64 id_l;
+};
+
+/**
  * struct fpga_manager - fpga manager structure
  * @name: name of low level fpga manager
  * @dev: fpga manager device
  * @ref_mutex: only allows one reference to fpga manager
  * @state: state of fpga manager
+ * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
  * @priv: low level driver private date
  */
@@ -149,6 +161,7 @@ struct fpga_manager {
 	struct device dev;
 	struct mutex ref_mutex;
 	enum fpga_mgr_states state;
+	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
 	void *priv;
 };
-- 
1.8.3.1

