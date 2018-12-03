Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B64C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD8920850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD8920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLCXgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:36:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbeLCXgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:36:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D31F187622;
        Mon,  3 Dec 2018 23:36:11 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-188.rdu2.redhat.com [10.10.120.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A312600C1;
        Mon,  3 Dec 2018 23:36:09 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <balbirs@au1.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Vivek Kini <vkini@nvidia.com>
Subject: [RFC PATCH 09/14] mm/hms: hbind() for heterogeneous memory system (aka mbind() for HMS)
Date:   Mon,  3 Dec 2018 18:35:04 -0500
Message-Id: <20181203233509.20671-10-jglisse@redhat.com>
In-Reply-To: <20181203233509.20671-1-jglisse@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 03 Dec 2018 23:36:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

With the advance of heterogeneous computing and the new kind of memory
topology that are now becoming more widespread (CPU HBM, persistent
memory, ...). We no longer just have a flat memory topology inside a
numa node. Instead there is a hierarchy of memory for instance HBM for
CPU versus main memory. Moreover there is also device memory a good
example is GPU which have a large amount of memory (several giga bytes
and it keeps growing).

In face of this the mbind() API is too limited to allow precise selection
of which memory to use inside a node. This is why this patchset introduce
a new API hbind() for heterogeneous bind, that allow to bind any kind of
memory wether it is some specific memory like CPU's HBM in a node, or some
device memory.

Instead of using a bitmap, hbind() take an array of uid and each uid is
a unique memory target inside the new HMS topology description.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Haggai Eran <haggaie@mellanox.com>
Cc: Balbir Singh <balbirs@au1.ibm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Paul Blinzer <Paul.Blinzer@amd.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: Vivek Kini <vkini@nvidia.com>
Cc: linux-mm@kvack.org
---
 include/uapi/linux/hbind.h |  46 +++++++++++
 mm/Makefile                |   1 +
 mm/hms.c                   | 158 +++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 include/uapi/linux/hbind.h
 create mode 100644 mm/hms.c

diff --git a/include/uapi/linux/hbind.h b/include/uapi/linux/hbind.h
new file mode 100644
index 000000000000..a9aba17ab142
--- /dev/null
+++ b/include/uapi/linux/hbind.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2018 Red Hat Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Authors:
+ * Jérôme Glisse <jglisse@redhat.com>
+ */
+/* Heterogeneous memory system (HMS) see Documentation/vm/hms.rst */
+#ifndef LINUX_UAPI_HBIND
+#define LINUX_UAPI_HBIND
+
+
+/* For now just freak out if it is bigger than a page. */
+#define HBIND_MAX_TARGETS (4096 / 4)
+#define HBIND_MAX_ATOMS (4096 / 4)
+
+
+struct hbind_params {
+	uint64_t start;
+	uint64_t end;
+	uint32_t ntargets;
+	uint32_t natoms;
+	uint64_t targets;
+	uint64_t atoms;
+};
+
+
+#define HBIND_ATOM_GET_DWORDS(v) (((v) >> 20) & 0xfff)
+#define HBIND_ATOM_SET_DWORDS(v) (((v) & 0xfff) << 20)
+#define HBIND_ATOM_GET_CMD(v) ((v) & 0xfffff)
+#define HBIND_ATOM_SET_CMD(v) ((v) & 0xfffff)
+
+
+#define HBIND_IOCTL		_IOWR('H', 0x00, struct hbind_params)
+
+
+#endif /* LINUX_UAPI_HBIND */
diff --git a/mm/Makefile b/mm/Makefile
index d210cc9d6f80..0537a95f6cbd 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -99,3 +99,4 @@ obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
 obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
 obj-$(CONFIG_HMM) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
+obj-$(CONFIG_HMS) += hms.o
diff --git a/mm/hms.c b/mm/hms.c
new file mode 100644
index 000000000000..bf328bd577dc
--- /dev/null
+++ b/mm/hms.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright 2018 Red Hat Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Authors:
+ * Jérôme Glisse <jglisse@redhat.com>
+ */
+/* Heterogeneous memory system (HMS) see Documentation/vm/hms.rst */
+#define pr_fmt(fmt) "hms: " fmt
+
+#include <linux/miscdevice.h>
+#include <linux/sched/mm.h>
+#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/hms.h>
+#include <linux/fs.h>
+
+#include <uapi/linux/hbind.h>
+
+
+#define HBIND_FIX_ARRAY 64
+
+
+static ssize_t hbind_read(struct file *file, char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+static ssize_t hbind_write(struct file *file, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+static long hbind_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+{
+	uint32_t *targets, *_dtargets = NULL, _ftargets[HBIND_FIX_ARRAY];
+	uint32_t *atoms, *_datoms = NULL, _fatoms[HBIND_FIX_ARRAY];
+	void __user *uarg = (void __user *)arg;
+	struct hbind_params params;
+	uint32_t i, ndwords;
+	int ret;
+
+	switch(cmd) {
+	case HBIND_IOCTL:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = copy_from_user(&params, uarg, sizeof(params));
+	if (ret)
+		return ret;
+
+	/* Some sanity checks */
+	params.start &= PAGE_MASK;
+	params.end = PAGE_ALIGN(params.end);
+	if (params.end <= params.start)
+		return -EINVAL;
+
+	/* More sanity checks */
+	if (params.ntargets > HBIND_MAX_TARGETS)
+		return -EINVAL;
+
+	/* We need at least one atoms. */
+	if (!params.natoms || params.natoms > HBIND_MAX_ATOMS)
+		return -EINVAL;
+
+	/* Let's allocate memory for parameters. */
+	if (params.ntargets > HBIND_FIX_ARRAY) {
+		_dtargets = kzalloc(4 * params.ntargets, GFP_KERNEL);
+		if (_dtargets == NULL)
+			return -ENOMEM;
+		targets = _dtargets;
+	} else {
+		targets = _ftargets;
+	}
+	if (params.natoms > HBIND_FIX_ARRAY) {
+		_datoms = kzalloc(4 * params.natoms, GFP_KERNEL);
+		if (_datoms == NULL) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		atoms = _datoms;
+	} else {
+		atoms = _fatoms;
+	}
+
+	/* Let's fetch hbind() parameters. */
+	ret = copy_from_user(atoms, (void __user *)params.atoms,
+			     4 * params.natoms);
+	if (ret)
+		goto out;
+	ret = copy_from_user(targets, (void __user *)params.targets,
+			     4 * params.ntargets);
+	if (ret)
+		goto out;
+
+	mmget(current->mm);
+
+	/* Sanity checks atoms and execute them. */
+	for (i = 0, ndwords = 1; i < params.natoms; i += ndwords) {
+		ndwords = 1 + HBIND_ATOM_GET_DWORDS(atoms[i]);
+		switch (HBIND_ATOM_GET_CMD(atoms[i])) {
+		default:
+			ret = -EINVAL;
+			goto out_mm;
+		}
+	}
+
+out_mm:
+	copy_to_user((void __user *)params.atoms, atoms, 4 * params.natoms);
+	mmput(current->mm);
+out:
+	kfree(_dtargets);
+	kfree(_datoms);
+	return ret;
+}
+
+const struct file_operations hbind_fops = {
+	.llseek		= no_llseek,
+	.read		= hbind_read,
+	.write		= hbind_write,
+	.unlocked_ioctl	= hbind_ioctl,
+	.owner		= THIS_MODULE,
+};
+
+static struct miscdevice hbind_device = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.fops = &hbind_fops,
+	.name = "hbind",
+};
+
+int __init hbind_init(void)
+{
+	pr_info("Heterogeneous memory system (HMS) hbind() driver\n");
+	return misc_register(&hbind_device);
+}
+
+void __exit hbind_fini(void)
+{
+	misc_deregister(&hbind_device);
+}
+
+module_init(hbind_init);
+module_exit(hbind_fini);
-- 
2.17.2

