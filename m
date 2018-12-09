Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182B8C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EA62082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EA62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeLIUhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:37:13 -0500
Received: from mail1.windriver.com ([147.11.146.13]:59084 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLIUhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:37:13 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wB9Kapl4025873
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 9 Dec 2018 12:36:51 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 12:36:50 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-security-module@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>
Subject: [PATCH 1/5] security: audit and remove any unnecessary uses of module.h
Date:   Sun, 9 Dec 2018 15:36:29 -0500
Message-ID: <1544387793-32309-2-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
References: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically a lot of these existed because we did not have
a distinction between what was modular code and what was providing
support to modules via EXPORT_SYMBOL and friends.  That changed
when we forked out support for the latter into the export.h file.
This means we should be able to reduce the usage of module.h
in code that is obj-y Makefile or bool Kconfig.

The advantage in removing such instances is that module.h itself
sources about 15 other headers; adding significantly to what we feed
cpp, and it can obscure what headers we are effectively using.

Since module.h might have been the implicit source for init.h
(for __init) and for export.h (for EXPORT_SYMBOL) we consider each
instance for the presence of either and replace as needed.

Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 security/apparmor/apparmorfs.c                   | 2 +-
 security/commoncap.c                             | 1 -
 security/integrity/evm/evm_crypto.c              | 2 +-
 security/integrity/evm/evm_posix_acl.c           | 1 -
 security/integrity/evm/evm_secfs.c               | 2 +-
 security/integrity/iint.c                        | 2 +-
 security/integrity/ima/ima_api.c                 | 1 -
 security/integrity/ima/ima_appraise.c            | 2 +-
 security/integrity/ima/ima_fs.c                  | 2 +-
 security/integrity/ima/ima_init.c                | 2 +-
 security/integrity/ima/ima_policy.c              | 2 +-
 security/integrity/ima/ima_queue.c               | 1 -
 security/keys/encrypted-keys/masterkey_trusted.c | 1 -
 security/keys/gc.c                               | 1 -
 security/keys/key.c                              | 2 +-
 security/keys/keyctl.c                           | 1 -
 security/keys/keyring.c                          | 2 +-
 security/keys/permission.c                       | 2 +-
 security/keys/proc.c                             | 1 -
 security/keys/process_keys.c                     | 1 -
 security/keys/request_key.c                      | 2 +-
 security/keys/request_key_auth.c                 | 1 -
 security/keys/user_defined.c                     | 2 +-
 security/security.c                              | 2 +-
 24 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 8963203319ea..3f80a684c232 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -15,7 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/security.h>
 #include <linux/vmalloc.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/mount.h>
diff --git a/security/commoncap.c b/security/commoncap.c
index 18a4fdf6f6eb..232db019f051 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -9,7 +9,6 @@
 
 #include <linux/capability.h>
 #include <linux/audit.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/lsm_hooks.h>
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 8c25f949ebdb..77ef210a8a6b 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -15,7 +15,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/crypto.h>
 #include <linux/xattr.h>
 #include <linux/evm.h>
diff --git a/security/integrity/evm/evm_posix_acl.c b/security/integrity/evm/evm_posix_acl.c
index 46408b9e62e8..7faf98c20373 100644
--- a/security/integrity/evm/evm_posix_acl.c
+++ b/security/integrity/evm/evm_posix_acl.c
@@ -9,7 +9,6 @@
  * the Free Software Foundation, version 2 of the License.
  */
 
-#include <linux/module.h>
 #include <linux/xattr.h>
 #include <linux/evm.h>
 
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 77de71b7794c..015aea8fdf1e 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -17,7 +17,7 @@
 
 #include <linux/audit.h>
 #include <linux/uaccess.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/mutex.h>
 #include "evm.h"
 
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 1ea05da2323d..88f04b3380d4 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -16,7 +16,7 @@
  *	  using a rbtree tree.
  */
 #include <linux/slab.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
 #include <linux/file.h>
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 99dd1d53fc35..67dfbd1af3ca 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -12,7 +12,6 @@
  *	Implements must_appraise_or_measure, collect_measurement,
  *	appraise_measurement, store_measurement and store_template.
  */
-#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/fs.h>
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index deec1804a00a..2e11e750a067 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -8,7 +8,7 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, version 2 of the License.
  */
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/xattr.h>
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3183cc23d0f8..0af792833f42 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -20,7 +20,7 @@
 
 #include <linux/fcntl.h>
 #include <linux/slab.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 59d834219cd6..6bb42a9c5e47 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -17,7 +17,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/err.h>
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8c9499867c91..3778dc396193 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -10,7 +10,7 @@
  *	- initialize default measure policy rules
  *
  */
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/list.h>
 #include <linux/fs.h>
 #include <linux/security.h>
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index b186819bd5aa..0e41dc1df1d4 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -21,7 +21,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
 #include "ima.h"
diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
index cbf0bc127a73..dc3d18cae642 100644
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ b/security/keys/encrypted-keys/masterkey_trusted.c
@@ -15,7 +15,6 @@
  */
 
 #include <linux/uaccess.h>
-#include <linux/module.h>
 #include <linux/err.h>
 #include <keys/trusted-type.h>
 #include <keys/encrypted-type.h>
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 7207e6094dc1..634e96b380e8 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -9,7 +9,6 @@
  * 2 of the Licence, or (at your option) any later version.
  */
 
-#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <keys/keyring-type.h>
diff --git a/security/keys/key.c b/security/keys/key.c
index d97c9394b5dd..44a80d6741a1 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -9,7 +9,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/poison.h>
 #include <linux/sched.h>
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 18619690ce77..e8093d025966 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -9,7 +9,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 41bcf57e96f2..eadebb92986a 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -9,7 +9,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/security/keys/permission.c b/security/keys/permission.c
index f68dc04d614e..06df9d5e7572 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -9,7 +9,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/security.h>
 #include "internal.h"
 
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 5af2934965d8..d2b802072693 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -9,7 +9,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index d5b25e535d3a..8b8994920620 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -9,7 +9,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/sched/user.h>
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 114f7408feee..301f0e300dbd 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -11,7 +11,7 @@
  * See Documentation/security/keys/request-key.rst
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/kmod.h>
 #include <linux/err.h>
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 424e1d90412e..87ea2f54dedc 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -11,7 +11,6 @@
  * See Documentation/security/keys/request-key.rst
  */
 
-#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/err.h>
 #include <linux/seq_file.h>
diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 9f558bedba23..5666fe0352f7 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -9,7 +9,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
diff --git a/security/security.c b/security/security.c
index 04d173eb93f6..d670136dda2c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -17,7 +17,7 @@
 #include <linux/bpf.h>
 #include <linux/capability.h>
 #include <linux/dcache.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/lsm_hooks.h>
-- 
2.7.4

