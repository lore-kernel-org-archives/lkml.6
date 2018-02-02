Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeBBNOd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:14:33 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:52782 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeBBNOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:14:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        QLogic-Storage-Upstream@cavium.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Manish Rangankar <Manish.Rangankar@cavium.com>,
        Tomer Tayar <Tomer.Tayar@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ariel Elior <Ariel.Elior@cavium.com>, Arun Easi <arun.easi@cavium.com>,
        Nilesh Javali <nilesh.javali@cavium.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] scsi: qedi: fix building with LTO
Date: Fri,  2 Feb 2018 14:12:19 +0100
Message-Id: <20180202131225.1658853-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202131225.1658853-1-arnd@arndb.de>
References: <20180202131225.1658853-1-arnd@arndb.de>
X-Provags-ID: V03:K0:X/vEzoBnno762QFfYBVKwukKJN1Hh/T597k/Iji1/SPkM5DuoFn
 mqtr0Cj96mJa16e0fqqLZ8IyUwQapSmcZuwBWu/qorXEx8ACCylNtFKCIICuYV/cmXWkvM2
 aJzsvmyYKtoBrIWXxGZMQPpvhSYzr3iYKME+vNIOfc3kkBxFHvislL+qbuVratdxAgWtsOI
 kAeMs21DaJVIZ3U6WKuWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eH6g0VIrow4=:5Xg9G5SUwszN+xwxnolInE
 xWgDu7l+fKaA0K4cA90HkeJM9kshrLrDp7L/Aux/b8Je0MsX9VHeKJQ4E6RYhPf8iNlpMeXxI
 j7mplH8Uo9BFlLTIeozP9yljVc02/1pfvHLSEADoVWKnYZ/Iz+U7OGZc1yKPbZEiV4oCltxGG
 v4L1mcqG4YLZr8zLO7W10zJXMbYDdUU/y325EzMoFMKGS47kRUXxRkBKwj/QE19GS3V04LgFA
 32igcFL9We0qAWjk4fcwD2mLa8HjdctOX/sArsQLulk44WiGsT/HZXpAJOU+sia/OZsZ5EeBc
 BTIbz/a/vRUNVUeEVdNVmhnX+g96PGl/lWzeU4eNQBGOYcUEG9hjdCFhyuxiJqB/lOr6lPMFj
 9f8KhZWLaU1TbJvfrnIOd0ViowDOGVLxFjJ9O8Chw0bUZHRPqvyPhiLDYtfkjHL9uZf6GtB5n
 hvqY4IIyzxfcZq61do/QWyW/Bu8OdOgSbXtw70VrWPiOUiUIqE7WE+HccjKFD7dzt0Pcl7TtP
 GZ1smro7b+/o4LKFw5VMVnNGSQE0UcS0fHhRbtpESMJ0GZq+zjzAaHB418on7wXH/+aw5YIQq
 o5kSYwj5XCb+dWdwLN2tDz0+bJRFh3j++8ASxGLsmwsCG3sCHzeYDqW3Au63hM/dO399i4pab
 0ecs770buaYE8Z+S3aMvDpC8pEG48ZcBKcw3H/u+C2s3jQnGXmSgxvmli/18CDGVWvNLtWBgm
 W/dHI1iE7iJjgWvb5Uvmf8viEeT3qzwOG0zntg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When link-time optimizations are enabled, qedi fails to build because
of mismatched prototypes:

drivers/scsi/qedi/qedi_gbl.h:27:37: error: type of 'qedi_dbg_fops' does not match original declaration [-Werror=lto-type-mismatch]
 extern const struct file_operations qedi_dbg_fops;
                                     ^
drivers/scsi/qedi/qedi_debugfs.c:239:30: note: 'qedi_dbg_fops' was previously declared here
 const struct file_operations qedi_dbg_fops[] = {
                              ^
drivers/scsi/qedi/qedi_gbl.h:26:32: error: type of 'qedi_debugfs_ops' does not match original declaration [-Werror=lto-type-mismatch]
 extern struct qedi_debugfs_ops qedi_debugfs_ops;
                                ^
drivers/scsi/qedi/qedi_debugfs.c:102:25: note: 'qedi_debugfs_ops' was previously declared here
 struct qedi_debugfs_ops qedi_debugfs_ops[] = {

This changes the declaration to match the definition, and adapts the
users as necessary. Since both array can be constant here, I'm adding
the 'const' everywhere for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/qedi/qedi_dbg.h     | 2 +-
 drivers/scsi/qedi/qedi_debugfs.c | 4 ++--
 drivers/scsi/qedi/qedi_gbl.h     | 4 ++--
 drivers/scsi/qedi/qedi_main.c    | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_dbg.h b/drivers/scsi/qedi/qedi_dbg.h
index c55572badfb0..358f40567849 100644
--- a/drivers/scsi/qedi/qedi_dbg.h
+++ b/drivers/scsi/qedi/qedi_dbg.h
@@ -134,7 +134,7 @@ struct qedi_debugfs_ops {
 }
 
 void qedi_dbg_host_init(struct qedi_dbg_ctx *qedi,
-			struct qedi_debugfs_ops *dops,
+			const struct qedi_debugfs_ops *dops,
 			const struct file_operations *fops);
 void qedi_dbg_host_exit(struct qedi_dbg_ctx *qedi);
 void qedi_dbg_init(char *drv_name);
diff --git a/drivers/scsi/qedi/qedi_debugfs.c b/drivers/scsi/qedi/qedi_debugfs.c
index fd8a1eea3163..fd914ca4149a 100644
--- a/drivers/scsi/qedi/qedi_debugfs.c
+++ b/drivers/scsi/qedi/qedi_debugfs.c
@@ -19,7 +19,7 @@ static struct dentry *qedi_dbg_root;
 
 void
 qedi_dbg_host_init(struct qedi_dbg_ctx *qedi,
-		   struct qedi_debugfs_ops *dops,
+		   const struct qedi_debugfs_ops *dops,
 		   const struct file_operations *fops)
 {
 	char host_dirname[32];
@@ -99,7 +99,7 @@ static struct qedi_list_of_funcs qedi_dbg_do_not_recover_ops[] = {
 	{ NULL, NULL }
 };
 
-struct qedi_debugfs_ops qedi_debugfs_ops[] = {
+const struct qedi_debugfs_ops qedi_debugfs_ops[] = {
 	{ "gbl_ctx", NULL },
 	{ "do_not_recover", qedi_dbg_do_not_recover_ops},
 	{ "io_trace", NULL },
diff --git a/drivers/scsi/qedi/qedi_gbl.h b/drivers/scsi/qedi/qedi_gbl.h
index f5b5a31999aa..a2aa06ed1620 100644
--- a/drivers/scsi/qedi/qedi_gbl.h
+++ b/drivers/scsi/qedi/qedi_gbl.h
@@ -23,8 +23,8 @@ extern uint qedi_io_tracing;
 extern struct scsi_host_template qedi_host_template;
 extern struct iscsi_transport qedi_iscsi_transport;
 extern const struct qed_iscsi_ops *qedi_ops;
-extern struct qedi_debugfs_ops qedi_debugfs_ops;
-extern const struct file_operations qedi_dbg_fops;
+extern const struct qedi_debugfs_ops qedi_debugfs_ops[];
+extern const struct file_operations qedi_dbg_fops[];
 extern struct device_attribute *qedi_shost_attrs[];
 
 int qedi_alloc_sq(struct qedi_ctx *qedi, struct qedi_endpoint *ep);
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 029e2e69b29f..e992f9d3ef00 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2303,8 +2303,8 @@ static int __qedi_probe(struct pci_dev *pdev, int mode)
 	}
 
 #ifdef CONFIG_DEBUG_FS
-	qedi_dbg_host_init(&qedi->dbg_ctx, &qedi_debugfs_ops,
-			   &qedi_dbg_fops);
+	qedi_dbg_host_init(&qedi->dbg_ctx, qedi_debugfs_ops,
+			   qedi_dbg_fops);
 #endif
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
 		  "QLogic FastLinQ iSCSI Module qedi %s, FW %d.%d.%d.%d\n",
-- 
2.9.0
