Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1B0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E422186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfBFNRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:17:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:26739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfBFNRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="136336010"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2019 05:17:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AAB7215B; Wed,  6 Feb 2019 15:17:38 +0200 (EET)
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
Subject: [PATCH v2 04/28] thunderbolt: Add dummy read after port capability list walk on Light Ridge
Date:   Wed,  6 Feb 2019 16:17:14 +0300
Message-Id: <20190206131738.43696-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
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
index 0de548bda663..8aceb0d97a63 100644
--- a/drivers/thunderbolt/cap.c
+++ b/drivers/thunderbolt/cap.c
@@ -57,6 +57,21 @@ static int tb_port_enable_tmu(struct tb_port *port, bool enable)
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
@@ -97,6 +112,7 @@ int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
 
 	ret = __tb_port_find_cap(port, cap);
 
+	tb_port_dummy_read(port);
 	tb_port_enable_tmu(port, false);
 
 	return ret;
-- 
2.20.1

