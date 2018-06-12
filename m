Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C8FF3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DFE208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DFE208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934099AbeFLIPH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:15:07 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:5942 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932803AbeFLIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:09:49 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH 01/13] selinux: Cleanup printk logging in conditional
Date:   Tue, 12 Jun 2018 10:09:00 +0200
Message-ID: <20180612080912.7827-2-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/conditional.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index c91543a617ac..f49e522e932d 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -96,7 +96,7 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
 	if (new_state != node->cur_state) {
 		node->cur_state = new_state;
 		if (new_state == -1)
-			printk(KERN_ERR "SELinux: expression result was undefined - disabling all rules.\n");
+			pr_err("SELinux: expression result was undefined - disabling all rules.\n");
 		/* turn the rules on or off */
 		for (cur = node->true_list; cur; cur = cur->next) {
 			if (new_state <= 0)
@@ -287,7 +287,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 	 */
 	if (k->specified & AVTAB_TYPE) {
 		if (avtab_search(&p->te_avtab, k)) {
-			printk(KERN_ERR "SELinux: type rule already exists outside of a conditional.\n");
+			pr_err("SELinux: type rule already exists outside of a conditional.\n");
 			goto err;
 		}
 		/*
@@ -302,7 +302,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
 			if (node_ptr) {
 				if (avtab_search_node_next(node_ptr, k->specified)) {
-					printk(KERN_ERR "SELinux: too many conflicting type rules.\n");
+					pr_err("SELinux: too many conflicting type rules.\n");
 					goto err;
 				}
 				found = 0;
@@ -313,13 +313,13 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 					}
 				}
 				if (!found) {
-					printk(KERN_ERR "SELinux: conflicting type rules.\n");
+					pr_err("SELinux: conflicting type rules.\n");
 					goto err;
 				}
 			}
 		} else {
 			if (avtab_search(&p->te_cond_avtab, k)) {
-				printk(KERN_ERR "SELinux: conflicting type rules when adding type rule for true.\n");
+				pr_err("SELinux: conflicting type rules when adding type rule for true.\n");
 				goto err;
 			}
 		}
@@ -327,7 +327,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 
 	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
 	if (!node_ptr) {
-		printk(KERN_ERR "SELinux: could not insert rule.\n");
+		pr_err("SELinux: could not insert rule.\n");
 		rc = -ENOMEM;
 		goto err;
 	}
@@ -387,12 +387,12 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
-		printk(KERN_ERR "SELinux: conditional expressions uses unknown operator.\n");
+		pr_err("SELinux: conditional expressions uses unknown operator.\n");
 		return 0;
 	}
 
 	if (expr->bool > p->p_bools.nprim) {
-		printk(KERN_ERR "SELinux: conditional expressions uses unknown bool.\n");
+		pr_err("SELinux: conditional expressions uses unknown bool.\n");
 		return 0;
 	}
 	return 1;
-- 
2.15.1

