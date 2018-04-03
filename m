Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeDCRJP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:09:15 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40317 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeDCRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:08:53 -0400
X-Google-Smtp-Source: AIpwx4/AW6blcZSpBOBYVdfCDQsM5ctpSH51Dbs3/NRW+FGUWS8aj4X8z8B+YuRRX0rrjpN1CTZ+vg==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH 3/4] acpi: apei: Do not panic() in NMI because of GHES messages
Date: Tue,  3 Apr 2018 12:08:29 -0500
Message-Id: <20180403170830.29282-4-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180403170830.29282-1-mr.nuke.me@gmail.com>
References: <20180403170830.29282-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIOSes like to send NMIs for a number of silly reasons often deemed
to be "fatal". For example pin bounce during a PCIE hotplug/unplug
might cause the link to go down and retrain, with fatal PCI errors
being generated while the link is retraining.

Instead of panic()ing in NMI context, pass fatal errors down to IRQ
context to see if they can be resolved.

With these change, PCIe error are handled by AER. Other far less
common errors, such as machine check exceptions, still cause a panic()
in their respective handlers.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2c998125b1d5..7243a99ea57e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -428,8 +428,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
  * GHES_SEV_RECOVERABLE -> AER_NONFATAL
  * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
  *     These both need to be reported and recovered from by the AER driver.
- * GHES_SEV_PANIC does not make it to this handling since the kernel must
- *     panic.
+ * GHES_SEV_PANIC -> AER_FATAL
  */
 static bool ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 {
@@ -899,6 +898,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
+	int corrected_sev;
 	u32 len, node_len;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
@@ -914,7 +914,14 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 		len = cper_estatus_len(estatus);
 		node_len = GHES_ESTATUS_NODE_LEN(len);
-		ghes_do_proc(estatus_node->ghes, estatus);
+		corrected_sev = ghes_do_proc(estatus_node->ghes, estatus);
+
+		if (corrected_sev >= GHES_SEV_PANIC) {
+			oops_begin();
+			ghes_print_queued_estatus();
+			__ghes_panic(estatus_node->ghes);
+		}
+
 		if (!ghes_estatus_cached(estatus)) {
 			generic = estatus_node->generic;
 			if (ghes_print_estatus(NULL, generic, estatus))
@@ -955,7 +962,7 @@ static void __process_error(struct ghes *ghes)
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
 	struct ghes *ghes;
-	int sev, ret = NMI_DONE;
+	int ret = NMI_DONE;
 
 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
 		return ret;
@@ -968,13 +975,6 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 			ret = NMI_HANDLED;
 		}
 
-		sev = ghes_severity(ghes->estatus->error_severity);
-		if (sev >= GHES_SEV_PANIC) {
-			oops_begin();
-			ghes_print_queued_estatus();
-			__ghes_panic(ghes);
-		}
-
 		if (!(ghes->flags & GHES_TO_CLEAR))
 			continue;
 
-- 
2.14.3
