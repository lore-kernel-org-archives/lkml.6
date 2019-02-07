Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80A2C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE9521916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfBGMpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:45:55 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60792 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbfBGMpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:45:49 -0500
Received: from green.intra.ispras.ru (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6824E5400B6;
        Thu,  7 Feb 2019 15:45:47 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Denis Efremov <efremov@ispras.ru>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] security: fix documentation for the shm_* hooks
Date:   Thu,  7 Feb 2019 15:44:58 +0300
Message-Id: <26eeda9e281a7650f028e554e2f64a25f17cb1d1.1549540487.git.efremov@ispras.ru>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
References: <cover.1549540487.git.efremov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shm_* hooks were changed in the commit
"shm/security: Pass kern_ipc_perm not shmid_kernel into the
shm security hooks" (7191adff2a55). The type of the argument
shp was changed from shmid_kernel to kern_ipc_perm. This patch
updates the documentation for the hooks accordingly.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 include/linux/lsm_hooks.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4bfb6532cbb3..8382dd1bed59 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1137,34 +1137,34 @@
  * Security hooks for System V Shared Memory Segments
  *
  * @shm_alloc_security:
- *	Allocate and attach a security structure to the shp->shm_perm.security
- *	field.  The security field is initialized to NULL when the structure is
+ *	Allocate and attach a security structure to the perm->security
+ *	field. The security field is initialized to NULL when the structure is
  *	first created.
- *	@shp contains the shared memory structure to be modified.
+ *	@perm contains the IPC permissions of the shared memory structure.
  *	Return 0 if operation was successful and permission is granted.
  * @shm_free_security:
  *	Deallocate the security struct for this memory segment.
- *	@shp contains the shared memory structure to be modified.
+ *	@perm contains the IPC permissions of the shared memory structure.
  * @shm_associate:
  *	Check permission when a shared memory region is requested through the
- *	shmget system call.  This hook is only called when returning the shared
+ *	shmget system call. This hook is only called when returning the shared
  *	memory region identifier for an existing region, not when a new shared
  *	memory region is created.
- *	@shp contains the shared memory structure to be modified.
+ *	@perm contains the IPC permissions of the shared memory structure.
  *	@shmflg contains the operation control flags.
  *	Return 0 if permission is granted.
  * @shm_shmctl:
  *	Check permission when a shared memory control operation specified by
- *	@cmd is to be performed on the shared memory region @shp.
- *	The @shp may be NULL, e.g. for IPC_INFO or SHM_INFO.
- *	@shp contains shared memory structure to be modified.
+ *	@cmd is to be performed on the shared memory region with permissions @perm.
+ *	The @perm may be NULL, e.g. for IPC_INFO or SHM_INFO.
+ *	@perm contains the IPC permissions of the shared memory structure.
  *	@cmd contains the operation to be performed.
  *	Return 0 if permission is granted.
  * @shm_shmat:
  *	Check permissions prior to allowing the shmat system call to attach the
- *	shared memory segment @shp to the data segment of the calling process.
- *	The attaching address is specified by @shmaddr.
- *	@shp contains the shared memory structure to be modified.
+ *	shared memory segment with permissions @perm to the data segment of the
+ *	calling process. The attaching address is specified by @shmaddr.
+ *	@perm contains the IPC permissions of the shared memory structure.
  *	@shmaddr contains the address to attach memory region to.
  *	@shmflg contains the operational flags.
  *	Return 0 if permission is granted.
@@ -1625,11 +1625,11 @@ union security_list_options {
 				struct task_struct *target, long type,
 				int mode);
 
-	int (*shm_alloc_security)(struct kern_ipc_perm *shp);
-	void (*shm_free_security)(struct kern_ipc_perm *shp);
-	int (*shm_associate)(struct kern_ipc_perm *shp, int shmflg);
-	int (*shm_shmctl)(struct kern_ipc_perm *shp, int cmd);
-	int (*shm_shmat)(struct kern_ipc_perm *shp, char __user *shmaddr,
+	int (*shm_alloc_security)(struct kern_ipc_perm *perm);
+	void (*shm_free_security)(struct kern_ipc_perm *perm);
+	int (*shm_associate)(struct kern_ipc_perm *perm, int shmflg);
+	int (*shm_shmctl)(struct kern_ipc_perm *perm, int cmd);
+	int (*shm_shmat)(struct kern_ipc_perm *perm, char __user *shmaddr,
 				int shmflg);
 
 	int (*sem_alloc_security)(struct kern_ipc_perm *perm);
-- 
2.17.2

