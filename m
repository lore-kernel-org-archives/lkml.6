Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90425C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C0120661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C0120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeLIWZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:25:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34888 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbeLIVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:15 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002if-E5; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003Ks-MI; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Tejun Heo" <tj@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Bart Van Assche" <bart.vanassche@wdc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.896158666@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 096/328] scsi: sysfs: Introduce sysfs_{un,}break_active_protection()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 2afc9166f79b8f6da5f347f48515215ceee4ae37 upstream.

Introduce these two functions and export them such that the next patch
can add calls to these functions from the SCSI core.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/sysfs/file.c       | 44 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/sysfs.h | 14 ++++++++++++++
 2 files changed, 58 insertions(+)

--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -357,6 +357,50 @@ int sysfs_chmod_file(struct kobject *kob
 EXPORT_SYMBOL_GPL(sysfs_chmod_file);
 
 /**
+ * sysfs_break_active_protection - break "active" protection
+ * @kobj: The kernel object @attr is associated with.
+ * @attr: The attribute to break the "active" protection for.
+ *
+ * With sysfs, just like kernfs, deletion of an attribute is postponed until
+ * all active .show() and .store() callbacks have finished unless this function
+ * is called. Hence this function is useful in methods that implement self
+ * deletion.
+ */
+struct kernfs_node *sysfs_break_active_protection(struct kobject *kobj,
+						  const struct attribute *attr)
+{
+	struct kernfs_node *kn;
+
+	kobject_get(kobj);
+	kn = kernfs_find_and_get(kobj->sd, attr->name);
+	if (kn)
+		kernfs_break_active_protection(kn);
+	return kn;
+}
+EXPORT_SYMBOL_GPL(sysfs_break_active_protection);
+
+/**
+ * sysfs_unbreak_active_protection - restore "active" protection
+ * @kn: Pointer returned by sysfs_break_active_protection().
+ *
+ * Undo the effects of sysfs_break_active_protection(). Since this function
+ * calls kernfs_put() on the kernfs node that corresponds to the 'attr'
+ * argument passed to sysfs_break_active_protection() that attribute may have
+ * been removed between the sysfs_break_active_protection() and
+ * sysfs_unbreak_active_protection() calls, it is not safe to access @kn after
+ * this function has returned.
+ */
+void sysfs_unbreak_active_protection(struct kernfs_node *kn)
+{
+	struct kobject *kobj = kn->parent->priv;
+
+	kernfs_unbreak_active_protection(kn);
+	kernfs_put(kn);
+	kobject_put(kobj);
+}
+EXPORT_SYMBOL_GPL(sysfs_unbreak_active_protection);
+
+/**
  * sysfs_remove_file_ns - remove an object attribute with a custom ns tag
  * @kobj: object we're acting for
  * @attr: attribute descriptor
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -204,6 +204,9 @@ int __must_check sysfs_create_files(stru
 				   const struct attribute **attr);
 int __must_check sysfs_chmod_file(struct kobject *kobj,
 				  const struct attribute *attr, umode_t mode);
+struct kernfs_node *sysfs_break_active_protection(struct kobject *kobj,
+						  const struct attribute *attr);
+void sysfs_unbreak_active_protection(struct kernfs_node *kn);
 void sysfs_remove_file_ns(struct kobject *kobj, const struct attribute *attr,
 			  const void *ns);
 bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr);
@@ -314,6 +317,17 @@ static inline int sysfs_chmod_file(struc
 	return 0;
 }
 
+static inline struct kernfs_node *
+sysfs_break_active_protection(struct kobject *kobj,
+			      const struct attribute *attr)
+{
+	return NULL;
+}
+
+static inline void sysfs_unbreak_active_protection(struct kernfs_node *kn)
+{
+}
+
 static inline void sysfs_remove_file_ns(struct kobject *kobj,
 					const struct attribute *attr,
 					const void *ns)

