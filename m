Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33404C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0097F21848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbfA2PBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:01:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:8099 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfA2PBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="314531707"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2019 07:01:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 525DF377; Tue, 29 Jan 2019 17:01:44 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH 04/28] thunderbolt: Add dummy read after port capability list walk on Light Ridge
Date:   Tue, 29 Jan 2019 18:01:19 +0300
Message-Id: <20190129150143.12681-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Light Ridge has an issue where reading the next capability pointer
location in port config space the read data is not cleared. It is fine
to read capabilities each after another so only thing we need to do is
to make sure we issue dummy read after tb_port_find_cap() is finished to
avoid the issue in next read.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/cap.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/thunderbolt/cap.c b/drivers/thunderbolt/cap.c
index 94a507f12b71..b7a3b62805a6 100644
--- a/drivers/thunderbolt/cap.c
+++ b/drivers/thunderbolt/cap.c
@@ -56,6 +56,21 @@ static int tb_port_enable_tmu(struct tb_port *port, bool enable)
 	return tb_sw_write(sw, &value, TB_CFG_SWITCH, offset, 1);
 }
 
+static void tb_port_dummy_read(struct tb_port *port)
+{
+	/*
+	 * When reading from next capability pointer location in port
+	 * config space the read data is not cleared on LR. To avoid
+	 * reading stale data on next read perform one dummy read after
+	 * port capabilities are walked.
+	 */
+	if (port->sw->config.device_id == PCI_DEVICE_ID_INTEL_LIGHT_RIDGE) {
+		u32 dummy;
+
+		tb_port_read(port, &dummy, TB_CFG_PORT, 0, 1);
+	}
+}
+
 static int __tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
 {
 	u32 offset = 1;
@@ -96,6 +111,7 @@ int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
 
 	ret = __tb_port_find_cap(port, cap);
 
+	tb_port_dummy_read(port);
 	tb_port_enable_tmu(port, false);
 
 	return ret;
-- 
2.20.1

