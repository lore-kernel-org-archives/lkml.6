Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbeDBS1b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 14:27:31 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:33540 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753231AbeDBS1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 14:27:30 -0400
From: Alexander Kappner <agk@godking.net>
To: ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org
Cc: ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Kappner <agk@godking.net>
Subject: [PATCH] Add Second Fan Support for Thinkpad P50
Date: Mon,  2 Apr 2018 11:27:01 -0700
Message-Id: <1522693621-3124-1-git-send-email-agk@godking.net>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Thinkpad P50 has 2 fans. Add the 2FAN quirk so the tpacpi driver
properly reports both fan speeds.
Because the P50 doesn't report the version of its EC controller, we need to
identify it by BIOS version (N1).

Signed-off-by: Alexander Kappner <agk@godking.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d5eaf3b1..ebdc300 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8699,16 +8699,24 @@ static const struct attribute_group fan_attr_group = {
 	  .ec = TPID(__id1, __id2),		\
 	  .quirks = __quirks }
 
+#define TPACPI_FAN_QL_BIOS(__id1, __id2, __quirks)	\
+	{ .vendor = PCI_VENDOR_ID_LENOVO,	\
+	  .bios = TPID(__id1, __id2),		\
+	  .ec = TPACPI_MATCH_ANY,		\
+	  .quirks = __quirks }
+
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_FAN_QI('1', 'Y', TPACPI_FAN_Q1),
 	TPACPI_FAN_QI('7', '8', TPACPI_FAN_Q1),
 	TPACPI_FAN_QI('7', '6', TPACPI_FAN_Q1),
 	TPACPI_FAN_QI('7', '0', TPACPI_FAN_Q1),
 	TPACPI_FAN_QL('7', 'M', TPACPI_FAN_2FAN),
+	TPACPI_FAN_QL_BIOS('N', '1', TPACPI_FAN_2FAN) // Thinkpad P50 has 2 fans
 };
 
 #undef TPACPI_FAN_QL
 #undef TPACPI_FAN_QI
+#undef TPACPI_FAN_QL_BIOS
 
 static int __init fan_init(struct ibm_init_struct *iibm)
 {
-- 
2.1.4
