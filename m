Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeC3L0b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 07:26:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34931 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeC3L0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 07:26:30 -0400
X-Google-Smtp-Source: AIpwx4+DNRxkrSC3PSi8pvGhjBVkia8a/wtojvgwd0kRHrixp54aPJDzDgfkoc1muR/WXd+Ws/PBLA==
From: Angel Shtilianov <kernel@kyup.com>
To: linux-kernel@vger.kernel.org
Cc: Angel Shtilianov <kernel@kyup.com>
Subject: [PATCH] uts_namespace: Move boot_id in uts namespace
Date: Fri, 30 Mar 2018 14:17:00 +0300
Message-Id: <1522408620-10578-1-git-send-email-kernel@kyup.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the same boot_id is reported for all containers running
on a host node, including the host node itself. Even after restarting
a container it will still have the same persistent boot_id.

This can cause troubles in cases where you have multiple containers
from the same cluster on one host node. The software inside each
container will get the same boot_id and thus fail to join the cluster,
after the first container from the node has already joined.

UTS namespace on other hand keeps the machine specific data, so it
seems to be the correct place to move the boot_id and instantiate it,
so each container will have unique id for its own boot lifetime, if
it has its own uts namespace.

Signed-off-by: Angel Shtilianov <kernel@kyup.com>
---
 drivers/char/random.c   | 4 ++++
 include/linux/utsname.h | 1 +
 kernel/utsname.c        | 4 +++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index ec42c8bb9b0d..e05daf7f38f4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1960,6 +1960,10 @@ static int proc_do_uuid(struct ctl_table *table, int write,
 	unsigned char buf[64], tmp_uuid[16], *uuid;
 
 	uuid = table->data;
+#ifdef CONFIG_UTS_NS
+	if (!!uuid && (uuid == (unsigned char *)sysctl_bootid))
+		uuid = current->nsproxy->uts_ns->sysctl_bootid;
+#endif
 	if (!uuid) {
 		uuid = tmp_uuid;
 		generate_random_uuid(uuid);
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index c8060c2ecd04..f704aca3e95a 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -27,6 +27,7 @@ struct uts_namespace {
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
 	struct ns_common ns;
+	char sysctl_bootid[16];
 } __randomize_layout;
 extern struct uts_namespace init_uts_ns;
 
diff --git a/kernel/utsname.c b/kernel/utsname.c
index 913fe4336d2b..f1749cdcd341 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -34,8 +34,10 @@ static struct uts_namespace *create_uts_ns(void)
 	struct uts_namespace *uts_ns;
 
 	uts_ns = kmalloc(sizeof(struct uts_namespace), GFP_KERNEL);
-	if (uts_ns)
+	if (uts_ns) {
 		kref_init(&uts_ns->kref);
+		memset(uts_ns->sysctl_bootid, 0, 16);
+	}
 	return uts_ns;
 }
 
-- 
2.5.0
