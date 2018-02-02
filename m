Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBBNN4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:13:56 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:61939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeBBNNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:13:33 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        QLogic-Storage-Upstream@cavium.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Chad Dupuis <chad.dupuis@cavium.com>,
        Nilesh Javali <nilesh.javali@cavium.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] scsi: qedf: fix LTO-enabled build
Date: Fri,  2 Feb 2018 14:12:18 +0100
Message-Id: <20180202131225.1658853-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202131225.1658853-1-arnd@arndb.de>
References: <20180202131225.1658853-1-arnd@arndb.de>
X-Provags-ID: V03:K0:XKhv13ABGqX4aYN41QKbFtJrLkp0iWr+AIds93sX+vcv4lFFe6U
 KUbh7FGJuJEHkCF3OcyOShsb/YN6VJ20TdhwtjjtpucA3IMO8MR6Gvr/vxSGxFvdihj+PRE
 HBd5YzFjr0zwAxOweTEHVgyeZKtIDlReRoVNJVM/4vbeaJVp+Z2pnZO08yNKWhGXki6yxvG
 dSujsbxqJlPP1nFtI+Miw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wGzrPlugq/M=:GZMsKMrkuVtNWE/FqCcszu
 /9VJ0ab6K3fRP5uDCsQ9TfutUk4cginQBNMSoeiUJ6TSllFi47qAuBzPLhj6n4jth2MpPYezE
 nmT2zAMsYCLtf32gtVrA2x4W9HtP6GoQM+97dHoUPonGk3Z37+VzK5/+O3o9H9/NQwjkeQBxv
 BYpuL5sFu6sm5FqmbJ08AlsVvXA/G8Phy/12TAElnp+JEHfaTsdu6rGuIDMklybr7Jn0IDu8N
 k6rYvTwdQE2fLFtDhR8/hGfgBN/PAlcqqKDC8iykCABR21HJTmRRlVuLYempdVqyDy2yHMwei
 r5LJvlk94xJQhcuZF5GHv5Y3ZgCWCVZM2PTumo/iWTH5gTbELE9CE2fANSJIN6oqVdpPSE/oU
 ZkuMoOJ5UwZ/jdfVa3/lYdzBX2eWXj7TnHPAAzR/mUdis4PnM7OVvz3iRVPZRXaoW5ZCZIynv
 U2lwbFBlvvSXK1qmOMn/N+gSzItra8nGSjzOjpDMQolA5EHDvfmUoTFBgH3aW5aZdhtTWXIRg
 s0SZmBJQHKa00Sm4OQJdidisaff46vvtWtrVhGn2na/Da5WasHtKf+zH2srdp7xt8nHG9ZFxI
 9ADfiwALbS7xSA8wBhmrYMe1oWIVX5GTwkc36NsXQLUZNQt47R9rY043bEcrFrfNC7blfpYpf
 R4Mws4+k6QXt7TFjOyymqEr9d/T5Y53UaALZ0psz2JMGFYipQd1/Gs0uVaMZUOWyFJj7PmnRS
 L6O0lDpCQU3oTKmuLm9ThkFnbud0ENyPbd76eA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prototype for qedf_dbg_fops/qedf_debugfs_ops doesn't match the definition,
which causes the final link to fail with link-time optimizations:

drivers/scsi/qedf/qedf_main.c:34: error: type of 'qedf_dbg_fops' does not match original declaration [-Werror=lto-type-mismatch]
 extern struct file_operations qedf_dbg_fops;

drivers/scsi/qedf/qedf_debugfs.c:443: note: 'qedf_dbg_fops' was previously declared here
 const struct file_operations qedf_dbg_fops[] = {

drivers/scsi/qedf/qedf_main.c:33: error: type of 'qedf_debugfs_ops' does not match original declaration [-Werror=lto-type-mismatch]
 extern struct qedf_debugfs_ops qedf_debugfs_ops;

drivers/scsi/qedf/qedf_debugfs.c:102: note: 'qedf_debugfs_ops' was previously declared here
 struct qedf_debugfs_ops qedf_debugfs_ops[] = {

This corrects the prototype and moves it into a shared header file where it
belongs. The file operations can also be marked 'const' like the
qedf_debugfs_ops.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/qedf/qedf_dbg.h     | 17 ++++++++++-------
 drivers/scsi/qedf/qedf_debugfs.c |  6 +++---
 drivers/scsi/qedf/qedf_main.c    |  8 +++-----
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_dbg.h b/drivers/scsi/qedf/qedf_dbg.h
index 50083cae84c3..77c27e888969 100644
--- a/drivers/scsi/qedf/qedf_dbg.h
+++ b/drivers/scsi/qedf/qedf_dbg.h
@@ -116,6 +116,14 @@ extern int qedf_create_sysfs_attr(struct Scsi_Host *shost,
 extern void qedf_remove_sysfs_attr(struct Scsi_Host *shost,
 				    struct sysfs_bin_attrs *iter);
 
+struct qedf_debugfs_ops {
+	char *name;
+	struct qedf_list_of_funcs *qedf_funcs;
+};
+
+extern const struct qedf_debugfs_ops qedf_debugfs_ops[];
+extern const struct file_operations qedf_dbg_fops[];
+
 #ifdef CONFIG_DEBUG_FS
 /* DebugFS related code */
 struct qedf_list_of_funcs {
@@ -123,11 +131,6 @@ struct qedf_list_of_funcs {
 	ssize_t (*oper_func)(struct qedf_dbg_ctx *qedf);
 };
 
-struct qedf_debugfs_ops {
-	char *name;
-	struct qedf_list_of_funcs *qedf_funcs;
-};
-
 #define qedf_dbg_fileops(drv, ops) \
 { \
 	.owner  = THIS_MODULE, \
@@ -147,8 +150,8 @@ struct qedf_debugfs_ops {
 }
 
 extern void qedf_dbg_host_init(struct qedf_dbg_ctx *qedf,
-				struct qedf_debugfs_ops *dops,
-				struct file_operations *fops);
+				const struct qedf_debugfs_ops *dops,
+				const struct file_operations *fops);
 extern void qedf_dbg_host_exit(struct qedf_dbg_ctx *qedf);
 extern void qedf_dbg_init(char *drv_name);
 extern void qedf_dbg_exit(void);
diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 2b1ef3075e93..c539a7ae3a7e 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -23,8 +23,8 @@ static struct dentry *qedf_dbg_root;
  **/
 void
 qedf_dbg_host_init(struct qedf_dbg_ctx *qedf,
-		    struct qedf_debugfs_ops *dops,
-		    struct file_operations *fops)
+		    const struct qedf_debugfs_ops *dops,
+		    const struct file_operations *fops)
 {
 	char host_dirname[32];
 	struct dentry *file_dentry = NULL;
@@ -99,7 +99,7 @@ qedf_dbg_exit(void)
 	qedf_dbg_root = NULL;
 }
 
-struct qedf_debugfs_ops qedf_debugfs_ops[] = {
+const struct qedf_debugfs_ops qedf_debugfs_ops[] = {
 	{ "fp_int", NULL },
 	{ "io_trace", NULL },
 	{ "debug", NULL },
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index ccd9a08ea030..284ccb566b19 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -23,6 +23,7 @@
 #include <linux/if_vlan.h>
 #include <linux/cpu.h>
 #include "qedf.h"
+#include "qedf_dbg.h"
 #include <uapi/linux/pci_regs.h>
 
 const struct qed_fcoe_ops *qed_ops;
@@ -30,9 +31,6 @@ const struct qed_fcoe_ops *qed_ops;
 static int qedf_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 static void qedf_remove(struct pci_dev *pdev);
 
-extern struct qedf_debugfs_ops qedf_debugfs_ops;
-extern struct file_operations qedf_dbg_fops;
-
 /*
  * Driver module parameters.
  */
@@ -3155,8 +3153,8 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	}
 
 #ifdef CONFIG_DEBUG_FS
-	qedf_dbg_host_init(&(qedf->dbg_ctx), &qedf_debugfs_ops,
-			    &qedf_dbg_fops);
+	qedf_dbg_host_init(&(qedf->dbg_ctx), qedf_debugfs_ops,
+			    qedf_dbg_fops);
 #endif
 
 	/* Start LL2 */
-- 
2.9.0
