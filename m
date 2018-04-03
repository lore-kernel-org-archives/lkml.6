Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeDCRIy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:08:54 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32955 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbeDCRIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:08:52 -0400
X-Google-Smtp-Source: AIpwx49LY6ZzV508jnHY5489gn+HkdoLlfgYcaQEHqae8fHCN9nrVCBsgQ0skhkZq8WVVH/mre6WWA==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH 2/4] acpi: apei: Swap ghes_print_queued_estatus and ghes_proc_in_irq
Date: Tue,  3 Apr 2018 12:08:28 -0500
Message-Id: <20180403170830.29282-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180403170830.29282-1-mr.nuke.me@gmail.com>
References: <20180403170830.29282-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ghes_print_queued_estatus() above ghes_proc_in_irq(). In a
subsequent patch, the NMI handler will be updated, and the print
functionality will be used in ghes_proc_in_irq.
This simply makes the subsequent diff look sane.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 25cf77a18e0a..2c998125b1d5 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -870,13 +870,12 @@ static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
 
 static LIST_HEAD(ghes_nmi);
 
-static void ghes_proc_in_irq(struct irq_work *irq_work)
+static void ghes_print_queued_estatus(void)
 {
-	struct llist_node *llnode, *next;
+	struct llist_node *llnode;
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
-	u32 len, node_len;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
 	/*
@@ -885,30 +884,22 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 	 */
 	llnode = llist_reverse_order(llnode);
 	while (llnode) {
-		next = llnode->next;
 		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
 					   llnode);
 		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-		len = cper_estatus_len(estatus);
-		node_len = GHES_ESTATUS_NODE_LEN(len);
-		ghes_do_proc(estatus_node->ghes, estatus);
-		if (!ghes_estatus_cached(estatus)) {
-			generic = estatus_node->generic;
-			if (ghes_print_estatus(NULL, generic, estatus))
-				ghes_estatus_cache_add(generic, estatus);
-		}
-		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
-			      node_len);
-		llnode = next;
+		generic = estatus_node->generic;
+		ghes_print_estatus(NULL, generic, estatus);
+		llnode = llnode->next;
 	}
 }
 
-static void ghes_print_queued_estatus(void)
+static void ghes_proc_in_irq(struct irq_work *irq_work)
 {
-	struct llist_node *llnode;
+	struct llist_node *llnode, *next;
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
+	u32 len, node_len;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
 	/*
@@ -917,12 +908,21 @@ static void ghes_print_queued_estatus(void)
 	 */
 	llnode = llist_reverse_order(llnode);
 	while (llnode) {
+		next = llnode->next;
 		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
 					   llnode);
 		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-		generic = estatus_node->generic;
-		ghes_print_estatus(NULL, generic, estatus);
-		llnode = llnode->next;
+		len = cper_estatus_len(estatus);
+		node_len = GHES_ESTATUS_NODE_LEN(len);
+		ghes_do_proc(estatus_node->ghes, estatus);
+		if (!ghes_estatus_cached(estatus)) {
+			generic = estatus_node->generic;
+			if (ghes_print_estatus(NULL, generic, estatus))
+				ghes_estatus_cache_add(generic, estatus);
+		}
+		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
+			      node_len);
+		llnode = next;
 	}
 }
 
-- 
2.14.3
