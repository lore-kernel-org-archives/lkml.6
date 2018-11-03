Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A27CC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85952081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXeYnkle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85952081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeKCOwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 10:52:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38266 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKCOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 10:52:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id p7-v6so1936480plk.5;
        Fri, 02 Nov 2018 22:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dvyllD3jEHWboo3hUel4xP1rOgicy9VSSCAaJP2pUbY=;
        b=AXeYnkleIaoB/fYMJwadfD34eeH2QEt+6DMSw8xz2co/Zu/pTNuM/Im2Tm9/Nvldne
         0vIc0A1UIzKL4Fr5GWv+Wu41QsT+rW+MDeT7sB4RPwnEc3g5tc8ut/z9MFeD1/3rg+Qd
         h7JPt+oaoMer2GHrp9p60oAeYeq91Y99EQ88q1S87Iokn2Annl1fhfMJdrOhwSheQp7l
         LYjxcqyJFp/J3BjMFT5xWQ4Rxh9ocMayZQyLilG4WEVeFC+iphjJWfT5+xm6bZl4rYlT
         sD7fhJkxOe0s/Qy5IHqBnl47kwe2ix7AS4/EN3g1lA2YX5g6NUBeQulb1zu3wqphV+8j
         6U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dvyllD3jEHWboo3hUel4xP1rOgicy9VSSCAaJP2pUbY=;
        b=Cv2tWAJJlRvFAw2J+c+wXtz6OiG+G7Nwlypr1wJbpZ2IafX0LGoyqx4Z2pZzLkVu0w
         MUNhvsqOEF4veYGweNshGIipPmQTNZqWj8VMmxwM93rk9orSJq4JOXJT09OKnHFTC/aa
         7RisQbbBbGdQe/pzlQUKA9dwBzFcKdIn4zi5LQyjU9x2qnsg6mpJkKrwQIhZC7WhcpXd
         yP1OXYzDUUBFkQvYy/azPwQwT/5n+W4Oa2iVYT4UbPNDBtLvpxRwEGpxDK/fpWK/nKPF
         Ehu3arViksX9HcT34GmFAUyy4N4QfRZepOtPBocyv0+dRoFsEW5dCwBanu5SKtE2H1eg
         0T5g==
X-Gm-Message-State: AGRZ1gLHYjH0uOEUHYdcgJv/llvuJPm4oXuAoGI/gKp4U1RMMJzLDpxL
        JRsKIoFn6OX4apJ/eyV2ies=
X-Google-Smtp-Source: AJdET5e/71/8gpIdBkfxUhNsDMsdOTVTcNQWzid+68Z/6yCJTylpAqK4VQKhfB68f6AhjSp1I5A3ww==
X-Received: by 2002:a17:902:5e3:: with SMTP id f90-v6mr14003758plf.222.1541223719304;
        Fri, 02 Nov 2018 22:41:59 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id i186-v6sm40057014pfc.86.2018.11.02.22.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 22:41:58 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, Alan Tull <atull@kernel.org>
Subject: [PATCH v4] of: overlay: user space synchronization
Date:   Fri,  2 Nov 2018 22:40:23 -0700
Message-Id: <1541223623-1910-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

When an overlay is applied or removed, the live devicetree visible in
/proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
changes.  There is no method for user space to determine whether the
live devicetree was modified by overlay actions.

Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
user space to determine if the live devicetree has remained unchanged
while a series of one or more accesses of /proc/device-tree/ occur.

The use of both (1) dynamic devicetree modifications and (2) overlay
apply and removal are not supported during the same boot cycle.  Thus
non-overlay dynamic modifications are not reflected in the value of
tree_version.

Example shell use:

	# set done false (1)
	done=1

	# keep trying until we can make it through the loop without
	# live tree being changed by an overlay changeset during the
	# 'critical region'
	while [ $done = 1 ] ; do

	   pre_version=$(cat /sys/firmware/devicetree/tree_version)

	   # 'critical region'
	   # access /proc/device-tree/ one or more times

	   # check that overlay did not change DT during critical region
	   post_version=$(cat /sys/firmware/devicetree/tree_version)
	   if [ ${post_version} = ${pre_version} ] ; then
	      # set done true (0)
	      done=0
	   fi

	done

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

changes since version 3:
   - Use mutex in sysfs show function for tree_version.  The mutex
     provides the required synchronization.  This also removes the
     need to increment tree_version twice per overlay apply or
     remove, simplifying the use of tree_version in user space.
   - Update documentation to reflect code changes.
   - Update documentation to show simpler user space usage.
   - Change tree_version from 32 bit to 64 bit to prevent problems
     with excessively rapid overlay applies and removes.  This
     problem should not occur on a system that is using overlays
     as intended, but the cost of prevention is negligible.

 Documentation/ABI/testing/sysfs-firmware-ofw | 91 +++++++++++++++++++++++++---
 drivers/of/base.c                            | 75 +++++++++++++++++++++++
 drivers/of/of_private.h                      |  2 +
 drivers/of/overlay.c                         |  6 ++
 4 files changed, 167 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-ofw b/Documentation/ABI/testing/sysfs-firmware-ofw
index edcab3ccfcc0..c441d54b721c 100644
--- a/Documentation/ABI/testing/sysfs-firmware-ofw
+++ b/Documentation/ABI/testing/sysfs-firmware-ofw
@@ -1,4 +1,10 @@
-What:		/sys/firmware/devicetree/*
+What:		/sys/firmware/devicetree/
+Date:		November 2013
+Contact:	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
+Description:
+		Top level Open Firmware, aka devicetree, sysfs directory.
+
+What:		/sys/firmware/devicetree/base
 Date:		November 2013
 Contact:	Grant Likely <grant.likely@arm.com>, devicetree@vger.kernel.org
 Description:
@@ -6,11 +12,6 @@ Description:
 		hardware, the device tree structure will be exposed in this
 		directory.
 
-		It is possible for multiple device-tree directories to exist.
-		Some device drivers use a separate detached device tree which
-		have no attachment to the system tree and will appear in a
-		different subdirectory under /sys/firmware/devicetree.
-
 		Userspace must not use the /sys/firmware/devicetree/base
 		path directly, but instead should follow /proc/device-tree
 		symlink. It is possible that the absolute path will change
@@ -20,13 +21,89 @@ Description:
 		filesystem support, and has largely the same semantics and
 		should be compatible with existing userspace.
 
-		The contents of /sys/firmware/devicetree/ is a
+		The /sys/firmware/devicetree/base directory is the root
+		node of the devicetree.
+
+		The contents of /sys/firmware/devicetree/base is a
 		hierarchy of directories, one per device tree node. The
 		directory name is the resolved path component name (node
 		name plus address). Properties are represented as files
 		in the directory. The contents of each file is the exact
 		binary data from the device tree.
 
+What:		/sys/firmware/devicetree/tree_version
+Date:		October 2018
+KernelVersion:	4.20
+Contact:	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
+Description:
+		When an overlay is applied or removed, the live devicetree
+		visible in /proc/device-tree/, aka
+		/sys/firmware/devicetree/base/, reflects the changes.
+
+		tree_version provides a way for user space to determine if the
+		live devicetree has remained unchanged while a series of one
+		or more accesses of /proc/device-tree/ occur.
+
+		Details about the value of tree_version:
+
+		   - tree_version is never decremented
+
+		   - tree_version is incremented for each overlay changeset
+		     that is applied or removed
+
+		   - when the tree is locked to apply or remove an overlay
+		     changeset, tree_version is incremented
+
+		   - while the tree is locked, all reads of tree_version
+		     will block
+
+		   - when the overlay changeset apply or remove is completed
+		     (or an error aborts the overlay changeset apply or
+		     remove), the tree is unlocked
+
+		   - the granularity of tree_version is based on overlay
+		     changesets; it will never be smaller than a changeset,
+		     but may in the future be extended to cover apply and
+		     remove of non-overlay changesets
+
+		   - the value of tree_version is initially 0 at the start
+		     of kernel boot, but may increase during the boot process,
+		     for example due to devicetree unittest activity
+
+		   - tree_version is the ascii representation of a kernel
+		     unsigned 64 bit int variable, and when incremented
+		     from maximum value, it wraps around to 0
+
+		The use of both dynamic devicetree modifications and overlay
+		apply and removal are not supported during the same boot
+		cycle.  Thus non-overlay dynamic modifications are not
+		reflected in the value of tree_version.
+
+		Example shell use of tree_version:
+
+		# set done false (1)
+		done=1
+
+		# keep trying until we can make it through the loop without
+		# live tree being changed by an overlay changeset during the
+		# 'critical region'
+		while [ $done = 1 ] ; do
+
+		   pre_version=$(cat /sys/firmware/devicetree/tree_version)
+
+		   # 'critical region'
+		   # access /proc/device-tree/ one or more times
+
+		   # check that overlay did not change DT during critical region
+		   post_version=$(cat /sys/firmware/devicetree/tree_version)
+		   if [ ${post_version} = ${pre_version} ] ; then
+		      # set done true (0)
+		      done=0
+		   fi
+
+		done
+
+
 What:		/sys/firmware/fdt
 Date:		February 2015
 KernelVersion:	3.19
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 466e3c8582f0..75a651db4976 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -151,9 +151,80 @@ int of_free_phandle_cache(void)
 late_initcall_sync(of_free_phandle_cache);
 #endif
 
+#define show_one_under_of_mutex(object)					\
+	static ssize_t show_##object					\
+	(struct kobject *kobj, struct attribute *attr, char *buf)	\
+	{								\
+		ssize_t ret;						\
+									\
+		mutex_lock(&of_mutex);					\
+		ret = sprintf(buf, "%llu\n", object);			\
+		mutex_unlock(&of_mutex);				\
+		return ret;						\
+	}
+
+struct global_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct kobject *kobj,
+			struct attribute *attr, char *buf);
+	ssize_t (*store)(struct kobject *a, struct attribute *b,
+			 const char *c, size_t count);
+};
+
+#define define_one_global_ro(_name)		\
+static struct global_attr attr_##_name =	\
+__ATTR(_name, 0444, show_##_name, NULL)
+
+/*
+ * unsigned so it will wrap from maximum value to zero.
+ *
+ * If 32 bit, then continuously applying and removing an overlay at the
+ * rate of once per millisecond would cause a wrap in slightly over
+ * one hour.  This rate is not realistic, except possibly in a test
+ * system.  None the less, prevent this (extremely remote) possibility
+ * by using an unsigned 64 bit.
+ */
+static u64 tree_version;
+
+show_one_under_of_mutex(tree_version);
+
+define_one_global_ro(tree_version);
+
+static struct attribute *of_attributes[] = {
+	&attr_tree_version.attr,
+	NULL
+};
+
+static const struct attribute_group of_attr_group = {
+	.attrs = of_attributes,
+};
+
+/*
+ * internal documentation
+ * tree_version_increment() - increment base version
+ *
+ * Before an overlay apply or overlay remove modifies the live devicetree,
+ * call this function while holding of_mutex.  The mutex must be held until
+ * all modifications to the live devicetree are completed.
+ *
+ * Userspace can use the value of this variable to determine whether the
+ * devicetree has changed while accessing the devicetree.  The sysfs show
+ * function acquires of_mutex to ensure that user space access of tree_version
+ * will block while an overlay apply or remove is in progress.
+ *
+ * The use of both (1) dynamic devicetree modifications and (2) overlay apply
+ * and removal are not supported during the same boot cycle.  Thus non-overlay
+ * dynamic modifications are not reflected in the value of tree_version.
+ */
+void tree_version_increment(void)
+{
+	tree_version++;
+}
+
 void __init of_core_init(void)
 {
 	struct device_node *np;
+	int ret;
 
 	of_populate_phandle_cache();
 
@@ -172,6 +243,10 @@ void __init of_core_init(void)
 	/* Symlink in /proc as required by userspace ABI */
 	if (of_root)
 		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
+
+	ret = sysfs_create_group(&of_kset->kobj, &of_attr_group);
+	if (ret)
+		pr_err("sysfs_create_group of_attr_group failed: %d\n", ret);
 }
 
 static struct property *__of_find_property(const struct device_node *np,
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 216175d11d3d..adf89f6bad81 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -31,6 +31,8 @@ struct alias_prop {
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
 
+void tree_version_increment(void);
+
 #if defined(CONFIG_OF_DYNAMIC)
 extern int of_property_notify(int action, struct device_node *np,
 			      struct property *prop, struct property *old_prop);
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index eda57ef12fd0..77ae643d91b8 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -770,6 +770,9 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	of_overlay_mutex_lock();
 	mutex_lock(&of_mutex);
 
+	/* live tree may change after this point, user space synchronization */
+	tree_version_increment();
+
 	ret = of_resolve_phandles(tree);
 	if (ret)
 		goto err_free_tree;
@@ -1028,6 +1031,9 @@ int of_overlay_remove(int *ovcs_id)
 
 	mutex_lock(&of_mutex);
 
+	/* live tree may change after this point, user space synchronization */
+	tree_version_increment();
+
 	ovcs = idr_find(&ovcs_idr, *ovcs_id);
 	if (!ovcs) {
 		ret = -ENODEV;
-- 
Frank Rowand <frank.rowand@sony.com>

