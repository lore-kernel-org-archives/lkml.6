Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D3674C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8848E208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8848E208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934149AbeFLOiH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:38:07 -0400
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]:49021 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932905AbeFLOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:38:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6DA501358B;
        Tue, 12 Jun 2018 14:38:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: magic94_2907044760740
X-Filterd-Recvd-Size: 5348
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Jun 2018 14:38:01 +0000 (UTC)
Message-ID: <a85d28e8cbd32acda21424ab6a46089f26969671.camel@perches.com>
Subject: Re: [PATCH 01/13] selinux: Cleanup printk logging in conditional
From:   Joe Perches <joe@perches.com>
To:     Peter Enderborg <peter.enderborg@sony.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Date:   Tue, 12 Jun 2018 07:38:00 -0700
In-Reply-To: <20180612080912.7827-2-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
         <20180612080912.7827-2-peter.enderborg@sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 10:09 +0200, Peter Enderborg wrote:
> Replace printk with pr_* to avoid checkpatch warnings.

I believe it would be nicer to remove the
"SELinux: " prefix embbeded in each format
and use a specific

#define pr_fmt(fmt) "SELinux: " fmt

to automatically prefix these formats.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
[]
> @@ -96,7 +96,7 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
>  	if (new_state != node->cur_state) {
>  		node->cur_state = new_state;
>  		if (new_state == -1)
> -			printk(KERN_ERR "SELinux: expression result was undefined - disabling all rules.\n");
> +			pr_err("SELinux: expression result was undefined - disabling all rules.\n");
>  		/* turn the rules on or off */
>  		for (cur = node->true_list; cur; cur = cur->next) {
>  			if (new_state <= 0)

So, for instance, this patch could become:
(etc and so forth for each patch in this series)

---
 security/selinux/ss/conditional.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index c91543a617ac..e96820d92b61 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -7,6 +7,8 @@
  *	the Free Software Foundation, version 2.
  */
 
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -96,7 +98,7 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
 	if (new_state != node->cur_state) {
 		node->cur_state = new_state;
 		if (new_state == -1)
-			printk(KERN_ERR "SELinux: expression result was undefined - disabling all rules.\n");
+			pr_err("expression result was undefined - disabling all rules\n");
 		/* turn the rules on or off */
 		for (cur = node->true_list; cur; cur = cur->next) {
 			if (new_state <= 0)
@@ -287,7 +289,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 	 */
 	if (k->specified & AVTAB_TYPE) {
 		if (avtab_search(&p->te_avtab, k)) {
-			printk(KERN_ERR "SELinux: type rule already exists outside of a conditional.\n");
+			pr_err("type rule already exists outside of a conditional\n");
 			goto err;
 		}
 		/*
@@ -302,7 +304,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
 			if (node_ptr) {
 				if (avtab_search_node_next(node_ptr, k->specified)) {
-					printk(KERN_ERR "SELinux: too many conflicting type rules.\n");
+					pr_err("too many conflicting type rules\n");
 					goto err;
 				}
 				found = 0;
@@ -313,13 +315,13 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 					}
 				}
 				if (!found) {
-					printk(KERN_ERR "SELinux: conflicting type rules.\n");
+					pr_err("conflicting type rules\n");
 					goto err;
 				}
 			}
 		} else {
 			if (avtab_search(&p->te_cond_avtab, k)) {
-				printk(KERN_ERR "SELinux: conflicting type rules when adding type rule for true.\n");
+				pr_err("conflicting type rules when adding type rule for true\n");
 				goto err;
 			}
 		}
@@ -327,7 +329,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 
 	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
 	if (!node_ptr) {
-		printk(KERN_ERR "SELinux: could not insert rule.\n");
+		pr_err("could not insert rule\n");
 		rc = -ENOMEM;
 		goto err;
 	}
@@ -387,12 +389,12 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
-		printk(KERN_ERR "SELinux: conditional expressions uses unknown operator.\n");
+		pr_err("conditional expressions uses unknown operator\n");
 		return 0;
 	}
 
 	if (expr->bool > p->p_bools.nprim) {
-		printk(KERN_ERR "SELinux: conditional expressions uses unknown bool.\n");
+		pr_err("conditional expressions uses unknown bool\n");
 		return 0;
 	}
 	return 1;

