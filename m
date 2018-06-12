Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2AC5AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5091208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5091208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933810AbeFLIKB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:10:01 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:6023 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933574AbeFLIJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:09:52 -0400
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
Subject: [PATCH 05/13] selinux: Cleanup printk logging in avtab
Date:   Tue, 12 Jun 2018 10:09:04 +0200
Message-ID: <20180612080912.7827-6-peter.enderborg@sony.com>
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
 security/selinux/ss/avtab.c | 51 +++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index a2c9148b0662..c0417cf17fee 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -338,7 +338,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 	h->nel = 0;
 	h->nslot = nslot;
 	h->mask = mask;
-	printk(KERN_DEBUG "SELinux: %d avtab hash slots, %d rules.\n",
+	pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
 	       h->nslot, nrules);
 	return 0;
 }
@@ -368,7 +368,7 @@ void avtab_hash_eval(struct avtab *h, char *tag)
 		}
 	}
 
-	printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
+	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
 	       "longest chain length %d sum of chain length^2 %llu\n",
 	       tag, h->nel, slots_used, h->nslot, max_chain_len,
 	       chain2_len_sum);
@@ -407,18 +407,18 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	if (vers < POLICYDB_VERSION_AVTAB) {
 		rc = next_entry(buf32, fp, sizeof(u32));
 		if (rc) {
-			printk(KERN_ERR "SELinux: avtab: truncated entry\n");
+			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
 		items2 = le32_to_cpu(buf32[0]);
 		if (items2 > ARRAY_SIZE(buf32)) {
-			printk(KERN_ERR "SELinux: avtab: entry overflow\n");
+			pr_err("SELinux: avtab: entry overflow\n");
 			return -EINVAL;
 
 		}
 		rc = next_entry(buf32, fp, sizeof(u32)*items2);
 		if (rc) {
-			printk(KERN_ERR "SELinux: avtab: truncated entry\n");
+			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
 		items = 0;
@@ -426,19 +426,19 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		val = le32_to_cpu(buf32[items++]);
 		key.source_type = (u16)val;
 		if (key.source_type != val) {
-			printk(KERN_ERR "SELinux: avtab: truncated source type\n");
+			pr_err("SELinux: avtab: truncated source type\n");
 			return -EINVAL;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_type = (u16)val;
 		if (key.target_type != val) {
-			printk(KERN_ERR "SELinux: avtab: truncated target type\n");
+			pr_err("SELinux: avtab: truncated target type\n");
 			return -EINVAL;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_class = (u16)val;
 		if (key.target_class != val) {
-			printk(KERN_ERR "SELinux: avtab: truncated target class\n");
+			pr_err("SELinux: avtab: truncated target class\n");
 			return -EINVAL;
 		}
 
@@ -446,16 +446,16 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
 
 		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
-			printk(KERN_ERR "SELinux: avtab: null entry\n");
+			pr_err("SELinux: avtab: null entry\n");
 			return -EINVAL;
 		}
 		if ((val & AVTAB_AV) &&
 		    (val & AVTAB_TYPE)) {
-			printk(KERN_ERR "SELinux: avtab: entry has both access vectors and types\n");
+			pr_err("SELinux: avtab: entry has both access vectors and types\n");
 			return -EINVAL;
 		}
 		if (val & AVTAB_XPERMS) {
-			printk(KERN_ERR "SELinux: avtab: entry has extended permissions\n");
+			pr_err("SELinux: avtab: entry has extended permissions\n");
 			return -EINVAL;
 		}
 
@@ -470,7 +470,8 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		}
 
 		if (items != items2) {
-			printk(KERN_ERR "SELinux: avtab: entry only had %d items, expected %d\n", items2, items);
+			pr_err("SELinux: avtab: entry only had %d items, expected %d\n",
+			       items2, items);
 			return -EINVAL;
 		}
 		return 0;
@@ -478,7 +479,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 
 	rc = next_entry(buf16, fp, sizeof(u16)*4);
 	if (rc) {
-		printk(KERN_ERR "SELinux: avtab: truncated entry\n");
+		pr_err("SELinux: avtab: truncated entry\n");
 		return rc;
 	}
 
@@ -491,7 +492,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	if (!policydb_type_isvalid(pol, key.source_type) ||
 	    !policydb_type_isvalid(pol, key.target_type) ||
 	    !policydb_class_isvalid(pol, key.target_class)) {
-		printk(KERN_ERR "SELinux: avtab: invalid type or class\n");
+		pr_err("SELinux: avtab: invalid type or class\n");
 		return -EINVAL;
 	}
 
@@ -501,13 +502,13 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 			set++;
 	}
 	if (!set || set > 1) {
-		printk(KERN_ERR "SELinux:  avtab:  more than one specifier\n");
+		pr_err("SELinux:  avtab:  more than one specifier\n");
 		return -EINVAL;
 	}
 
 	if ((vers < POLICYDB_VERSION_XPERMS_IOCTL) &&
 			(key.specified & AVTAB_XPERMS)) {
-		printk(KERN_ERR "SELinux:  avtab:  policy version %u does not "
+		pr_err("SELinux:  avtab:  policy version %u does not "
 				"support extended permissions rules and one "
 				"was specified\n", vers);
 		return -EINVAL;
@@ -515,17 +516,17 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		memset(&xperms, 0, sizeof(struct avtab_extended_perms));
 		rc = next_entry(&xperms.specified, fp, sizeof(u8));
 		if (rc) {
-			printk(KERN_ERR "SELinux: avtab: truncated entry\n");
+			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
 		rc = next_entry(&xperms.driver, fp, sizeof(u8));
 		if (rc) {
-			printk(KERN_ERR "SELinux: avtab: truncated entry\n");
+			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
 		rc = next_entry(buf32, fp, sizeof(u32)*ARRAY_SIZE(xperms.perms.p));
 		if (rc) {
-			printk(KERN_ERR "SELinux: avtab: truncated entry\n");
+			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
 		for (i = 0; i < ARRAY_SIZE(xperms.perms.p); i++)
@@ -534,14 +535,14 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	} else {
 		rc = next_entry(buf32, fp, sizeof(u32));
 		if (rc) {
-			printk(KERN_ERR "SELinux: avtab: truncated entry\n");
+			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
 		datum.u.data = le32_to_cpu(*buf32);
 	}
 	if ((key.specified & AVTAB_TYPE) &&
 	    !policydb_type_isvalid(pol, datum.u.data)) {
-		printk(KERN_ERR "SELinux: avtab: invalid type\n");
+		pr_err("SELinux: avtab: invalid type\n");
 		return -EINVAL;
 	}
 	return insertf(a, &key, &datum, p);
@@ -562,12 +563,12 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc < 0) {
-		printk(KERN_ERR "SELinux: avtab: truncated table\n");
+		pr_err("SELinux: avtab: truncated table\n");
 		goto bad;
 	}
 	nel = le32_to_cpu(buf[0]);
 	if (!nel) {
-		printk(KERN_ERR "SELinux: avtab: table is empty\n");
+		pr_err("SELinux: avtab: table is empty\n");
 		rc = -EINVAL;
 		goto bad;
 	}
@@ -580,9 +581,9 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
 		if (rc) {
 			if (rc == -ENOMEM)
-				printk(KERN_ERR "SELinux: avtab: out of memory\n");
+				pr_err("SELinux: avtab: out of memory\n");
 			else if (rc == -EEXIST)
-				printk(KERN_ERR "SELinux: avtab: duplicate entry\n");
+				pr_err("SELinux: avtab: duplicate entry\n");
 
 			goto bad;
 		}
-- 
2.15.1

