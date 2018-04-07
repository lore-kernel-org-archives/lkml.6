Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbeDGLZj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 07:25:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34494 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeDGLZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 07:25:22 -0400
From: Dongli Zhang <dongli.zhang@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, jgross@suse.com, ian.jackson@eu.citrix.com,
        wei.liu2@citrix.com, srinivas.eeda@oracle.com
Subject: [PATCH RFC xen 2/2] libxl: introduce xenwatch multithreading to xen toolstack
Date: Sat,  7 Apr 2018 19:25:55 +0800
Message-Id: <1523100355-27647-3-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
References: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8855 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=830
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804070121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is based on xen-4.10.0.

This patch introduces xenwatch multithreading (or multithreaded xenwatch,
abbreviated as 'mtwatch') on xen toolstack side.

In addition to the existing single xenwatch thread, each domU has its own
kernel thread ([xen-mtwatch-<domid>]) to process its xenwatch event.

The create/destroy of each per-domU mtwatch thread is controlled by
xenstore. The dom0 kernel watches at node '/local/domain/0/mtwatch', under
which each domU has an entry. The node '/local/domain/0/mtwatch/<domid>' is
written to xenstore first during domU creation, while the same node is
removed from xenstore as the last xenstore operation during the domU
destroy. The corresponding watch callback would create or destroy the
per-domU mtwatch thread.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 tools/libxl/libxl_create.c | 12 ++++++++++++
 tools/libxl/libxl_domain.c | 26 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/libxl/libxl_create.c b/tools/libxl/libxl_create.c
index f15fb21..579216a 100644
--- a/tools/libxl/libxl_create.c
+++ b/tools/libxl/libxl_create.c
@@ -527,6 +527,7 @@ int libxl__domain_make(libxl__gc *gc, libxl_domain_config *d_config,
     const char *dom_type;
     char *uuid_string;
     char *dom_path, *vm_path, *libxl_path;
+    char *mtwatch_path;
     struct xs_permissions roperm[2];
     struct xs_permissions rwperm[1];
     struct xs_permissions noperm[1];
@@ -601,6 +602,14 @@ int libxl__domain_make(libxl__gc *gc, libxl_domain_config *d_config,
         goto out;
     }
 
+    mtwatch_path = GCSPRINTF("%s/mtwatch/%d",
+                             libxl__xs_get_dompath(gc, 0), *domid);
+    if (!mtwatch_path) {
+        LOGD(ERROR, *domid, "cannot allocate mtwatch path");
+        rc = ERROR_FAIL;
+        goto out;
+    }
+
     noperm[0].id = 0;
     noperm[0].perms = XS_PERM_NONE;
 
@@ -615,6 +624,9 @@ int libxl__domain_make(libxl__gc *gc, libxl_domain_config *d_config,
 retry_transaction:
     t = xs_transaction_start(ctx->xsh);
 
+    xs_rm(ctx->xsh, t, mtwatch_path);
+    libxl__xs_mknod(gc, t, mtwatch_path, noperm, ARRAY_SIZE(noperm));
+
     xs_rm(ctx->xsh, t, dom_path);
     libxl__xs_mknod(gc, t, dom_path, roperm, ARRAY_SIZE(roperm));
 
diff --git a/tools/libxl/libxl_domain.c b/tools/libxl/libxl_domain.c
index 814f812..6638f66 100644
--- a/tools/libxl/libxl_domain.c
+++ b/tools/libxl/libxl_domain.c
@@ -1051,6 +1051,30 @@ out:
     return;
 }
 
+static void libxl_rm_mtwatch_node(libxl__gc *gc, uint32_t domid)
+{
+    char *mtwatch_path;
+    xs_transaction_t t = 0;
+    int rc;
+
+    mtwatch_path = GCSPRINTF("%s/mtwatch/%d",
+                             libxl__xs_get_dompath(gc, 0), domid);
+    if (!mtwatch_path) {
+        LOGD(ERROR, domid, "cannot allocate mtwatch path");
+        return;
+    }
+
+    rc = libxl__xs_transaction_start(gc, &t);
+    if (rc) goto out;
+
+    libxl__xs_path_cleanup(gc, t, mtwatch_path);
+
+    libxl__xs_transaction_commit(gc, &t);
+
+out:
+    libxl__xs_transaction_abort(gc, &t);
+}
+
 static void devices_destroy_cb(libxl__egc *egc,
                                libxl__devices_remove_state *drs,
                                int rc)
@@ -1083,6 +1107,8 @@ static void devices_destroy_cb(libxl__egc *egc,
     xs_rm(ctx->xsh, XBT_NULL, libxl__xs_libxl_path(gc, domid));
     xs_rm(ctx->xsh, XBT_NULL, GCSPRINTF( "/local/domain/%d/hvmloader", domid));
 
+    libxl_rm_mtwatch_node(gc, domid);
+
     /* This is async operation, we already hold CTX lock */
     lock = libxl__lock_domain_userdata(gc, domid);
     if (!lock) {
-- 
2.7.4
