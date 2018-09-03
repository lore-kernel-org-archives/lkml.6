Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BCFC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0D920869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0D920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeICVNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:13:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeICVNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:13:35 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DBFB8CEE;
        Mon,  3 Sep 2018 16:52:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3.18 54/56] scsi: sysfs: Introduce sysfs_{un,}break_active_protection()
Date:   Mon,  3 Sep 2018 18:49:44 +0200
Message-Id: <20180903164926.794622165@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 2afc9166f79b8f6da5f347f48515215ceee4ae37 upstream.

Introduce these two functions and export them such that the next patch
can add calls to these functions from the SCSI core.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/sysfs/file.c       |   44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sysfs.h |   14 ++++++++++++++
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
@@ -200,6 +200,9 @@ int __must_check sysfs_create_files(stru
 				   const struct attribute **attr);
 int __must_check sysfs_chmod_file(struct kobject *kobj,
 				  const struct attribute *attr, umode_t mode);
+struct kernfs_node *sysfs_break_active_protection(struct kobject *kobj,
+						  const struct attribute *attr);
+void sysfs_unbreak_active_protection(struct kernfs_node *kn);
 void sysfs_remove_file_ns(struct kobject *kobj, const struct attribute *attr,
 			  const void *ns);
 bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr);
@@ -299,6 +302,17 @@ static inline int sysfs_chmod_file(struc
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


