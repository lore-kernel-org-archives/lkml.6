Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D63CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE136208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE136208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933977AbeFLILo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:11:44 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:6038 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932497AbeFLIJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:09:53 -0400
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
Subject: [PATCH 06/13] selinux: Cleanup printk logging in services
Date:   Tue, 12 Jun 2018 10:09:05 +0200
Message-ID: <20180612080912.7827-7-peter.enderborg@sony.com>
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
 security/selinux/ss/services.c | 71 +++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8057e19dc15f..9ad9b6c2f0a7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -136,8 +136,7 @@ static int selinux_set_mapping(struct policydb *pol,
 
 		p_out->value = string_to_security_class(pol, p_in->name);
 		if (!p_out->value) {
-			printk(KERN_INFO
-			       "SELinux:  Class %s not defined in policy.\n",
+			pr_info("SELinux:  Class %s not defined in policy.\n",
 			       p_in->name);
 			if (pol->reject_unknown)
 				goto err;
@@ -156,8 +155,7 @@ static int selinux_set_mapping(struct policydb *pol,
 			p_out->perms[k] = string_to_av_perm(pol, p_out->value,
 							    p_in->perms[k]);
 			if (!p_out->perms[k]) {
-				printk(KERN_INFO
-				       "SELinux:  Permission %s in class %s not defined in policy.\n",
+				pr_info("SELinux:  Permission %s in class %s not defined in policy.\n",
 				       p_in->perms[k], p_in->name);
 				if (pol->reject_unknown)
 					goto err;
@@ -170,7 +168,7 @@ static int selinux_set_mapping(struct policydb *pol,
 	}
 
 	if (print_unknown_handle)
-		printk(KERN_INFO "SELinux: the above unknown classes and permissions will be %s\n",
+		pr_info("SELinux: the above unknown classes and permissions will be %s\n",
 		       pol->allow_unknown ? "allowed" : "denied");
 
 	out_map->size = i;
@@ -644,7 +642,7 @@ static void context_struct_compute_av(struct policydb *policydb,
 
 	if (unlikely(!tclass || tclass > policydb->p_classes.nprim)) {
 		if (printk_ratelimit())
-			printk(KERN_WARNING "SELinux:  Invalid class %hu\n", tclass);
+			pr_warn("SELinux:  Invalid class %hu\n", tclass);
 		return;
 	}
 
@@ -793,7 +791,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 
 	ocontext = sidtab_search(sidtab, oldsid);
 	if (!ocontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 			__func__, oldsid);
 		rc = -EINVAL;
 		goto out;
@@ -801,7 +799,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 
 	ncontext = sidtab_search(sidtab, newsid);
 	if (!ncontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 			__func__, newsid);
 		rc = -EINVAL;
 		goto out;
@@ -809,7 +807,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 
 	tcontext = sidtab_search(sidtab, tasksid);
 	if (!tcontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 			__func__, tasksid);
 		rc = -EINVAL;
 		goto out;
@@ -883,7 +881,7 @@ int security_bounded_transition(struct selinux_state *state,
 	rc = -EINVAL;
 	old_context = sidtab_search(sidtab, old_sid);
 	if (!old_context) {
-		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
+		pr_err("SELinux: %s: unrecognized SID %u\n",
 		       __func__, old_sid);
 		goto out;
 	}
@@ -891,7 +889,7 @@ int security_bounded_transition(struct selinux_state *state,
 	rc = -EINVAL;
 	new_context = sidtab_search(sidtab, new_sid);
 	if (!new_context) {
-		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
+		pr_err("SELinux: %s: unrecognized SID %u\n",
 		       __func__, new_sid);
 		goto out;
 	}
@@ -1040,14 +1038,14 @@ void security_compute_xperms_decision(struct selinux_state *state,
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
 		goto out;
 	}
 
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, tsid);
 		goto out;
 	}
@@ -1129,7 +1127,7 @@ void security_compute_av(struct selinux_state *state,
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
 		goto out;
 	}
@@ -1140,7 +1138,7 @@ void security_compute_av(struct selinux_state *state,
 
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, tsid);
 		goto out;
 	}
@@ -1183,7 +1181,7 @@ void security_compute_av_user(struct selinux_state *state,
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
 		goto out;
 	}
@@ -1194,7 +1192,7 @@ void security_compute_av_user(struct selinux_state *state,
 
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, tsid);
 		goto out;
 	}
@@ -1310,7 +1308,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 			*scontext = scontextp;
 			goto out;
 		}
-		printk(KERN_ERR "SELinux: %s:  called before initial "
+		pr_err("SELinux: %s:  called before initial "
 		       "load_policy on unknown SID %d\n", __func__, sid);
 		rc = -EINVAL;
 		goto out;
@@ -1323,7 +1321,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 	else
 		context = sidtab_search(sidtab, sid);
 	if (!context) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 			__func__, sid);
 		rc = -EINVAL;
 		goto out_unlock;
@@ -1678,14 +1676,14 @@ static int security_compute_sid(struct selinux_state *state,
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, ssid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, tsid);
 		rc = -EINVAL;
 		goto out_unlock;
@@ -1911,7 +1909,8 @@ static inline int convert_context_handle_invalid_context(
 		return -EINVAL;
 
 	if (!context_struct_to_string(policydb, context, &s, &len)) {
-		printk(KERN_WARNING "SELinux:  Context %s would be invalid if enforcing\n", s);
+		pr_warn("SELinux:  Context %s would be invalid if enforcing\n",
+			s);
 		kfree(s);
 	}
 	return 0;
@@ -1962,7 +1961,7 @@ static int convert_context(u32 key,
 					      c->len, &ctx, SECSID_NULL);
 		kfree(s);
 		if (!rc) {
-			printk(KERN_INFO "SELinux:  Context %s became valid (mapped).\n",
+			pr_info("SELinux:  Context %s became valid (mapped).\n",
 			       c->str);
 			/* Replace string with mapped representation. */
 			kfree(c->str);
@@ -1974,7 +1973,7 @@ static int convert_context(u32 key,
 			goto out;
 		} else {
 			/* Other error condition, e.g. ENOMEM. */
-			printk(KERN_ERR "SELinux:   Unable to map context %s, rc = %d.\n",
+			pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
 			       c->str, -rc);
 			goto out;
 		}
@@ -2033,7 +2032,7 @@ static int convert_context(u32 key,
 			oc = oc->next;
 		rc = -EINVAL;
 		if (!oc) {
-			printk(KERN_ERR "SELinux:  unable to look up"
+			pr_err("SELinux:  unable to look up"
 				" the initial SIDs list\n");
 			goto bad;
 		}
@@ -2065,7 +2064,7 @@ static int convert_context(u32 key,
 	context_destroy(c);
 	c->str = s;
 	c->len = len;
-	printk(KERN_INFO "SELinux:  Context %s became invalid (unmapped).\n",
+	pr_info("SELinux:  Context %s became invalid (unmapped).\n",
 	       c->str);
 	rc = 0;
 	goto out;
@@ -2170,13 +2169,13 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	newpolicydb->len = len;
 	/* If switching between different policy types, log MLS status */
 	if (policydb->mls_enabled && !newpolicydb->mls_enabled)
-		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
+		pr_info("SELinux: Disabling MLS support...\n");
 	else if (!policydb->mls_enabled && newpolicydb->mls_enabled)
-		printk(KERN_INFO "SELinux: Enabling MLS support...\n");
+		pr_info("SELinux: Enabling MLS support...\n");
 
 	rc = policydb_load_isids(newpolicydb, &newsidtab);
 	if (rc) {
-		printk(KERN_ERR "SELinux:  unable to load the initial SIDs\n");
+		pr_err("SELinux:  unable to load the initial SIDs\n");
 		policydb_destroy(newpolicydb);
 		goto out;
 	}
@@ -2187,7 +2186,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 
 	rc = security_preserve_bools(state, newpolicydb);
 	if (rc) {
-		printk(KERN_ERR "SELinux:  unable to preserve booleans\n");
+		pr_err("SELinux:  unable to preserve booleans\n");
 		goto err;
 	}
 
@@ -2207,7 +2206,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	args.newp = newpolicydb;
 	rc = sidtab_map(&newsidtab, convert_context, &args);
 	if (rc) {
-		printk(KERN_ERR "SELinux:  unable to convert the internal"
+		pr_err("SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
 			" table\n");
 		goto err;
@@ -2999,7 +2998,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 	rc = -EINVAL;
 	context1 = sidtab_search(sidtab, sid);
 	if (!context1) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 			__func__, sid);
 		goto out_unlock;
 	}
@@ -3007,7 +3006,7 @@ int security_sid_mls_copy(struct selinux_state *state,
 	rc = -EINVAL;
 	context2 = sidtab_search(sidtab, mls_sid);
 	if (!context2) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 			__func__, mls_sid);
 		goto out_unlock;
 	}
@@ -3104,14 +3103,14 @@ int security_net_peersid_resolve(struct selinux_state *state,
 	rc = -EINVAL;
 	nlbl_ctx = sidtab_search(sidtab, nlbl_sid);
 	if (!nlbl_ctx) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, nlbl_sid);
 		goto out;
 	}
 	rc = -EINVAL;
 	xfrm_ctx = sidtab_search(sidtab, xfrm_sid);
 	if (!xfrm_ctx) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		pr_err("SELinux: %s:  unrecognized SID %d\n",
 		       __func__, xfrm_sid);
 		goto out;
 	}
@@ -3202,7 +3201,7 @@ int security_get_permissions(struct selinux_state *state,
 	rc = -EINVAL;
 	match = hashtab_search(policydb->p_classes.table, class);
 	if (!match) {
-		printk(KERN_ERR "SELinux: %s:  unrecognized class %s\n",
+		pr_err("SELinux: %s:  unrecognized class %s\n",
 			__func__, class);
 		goto out;
 	}
-- 
2.15.1

