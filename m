Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06E2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543C820853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dWz7EaR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543C820853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeINQJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:09:46 -0400
Received: from m50-133.163.com ([123.125.50.133]:47625 "EHLO m50-133.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbeINQJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=8KoSZbUYztV9OOS36K
        mzY/EPI4k/1Ig+NKtcxAEHfEc=; b=dWz7EaR8euIc7w906JpO6hcOwVPToPu+45
        n1HbSchXgBckkNY51iCXMEZJKoVCxpTyA/L6gO8DP7Qo+NUtn1AYai7Yrf37TYpc
        binZdayp2+X/trA9YeT9SdkTqFjCcVeoKz+QDYny8zI/7pqiJ/3lSP379s115b4V
        WMcGfg728=
Received: from lx-virtual-machine.localdomain (unknown [159.226.94.148])
        by smtp3 (Coremail) with SMTP id DdGowADHYCSok5tbIuQrAA--.12S3;
        Fri, 14 Sep 2018 18:55:45 +0800 (CST)
From:   My Name <18650033736@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xin Lin <18650033736@163.com>
Subject: [PATCH] kernel: prevent submission of creds with higher privileges inside container
Date:   Fri, 14 Sep 2018 18:55:36 +0800
Message-Id: <1536922536-5803-1-git-send-email-18650033736@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DdGowADHYCSok5tbIuQrAA--.12S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrykCFy3ZF4DtF47tr47urg_yoW5XrW7pF
        sFkr9xGws5J3W7tan7Wr4YvFWfAw4fAry2gas5Kw4Yvwn2ka48u34ku3W3GFnrurW7KayU
        KFW5GrsIgrZ8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeUDXUUUUU=
X-Originating-IP: [159.226.94.148]
X-CM-SenderInfo: rprylkyqqtjlmtwbiqqrwthudrp/xtbBRx3BflO-8G7GFgAAsH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Lin <18650033736@163.com>

Adversaries often attack the Linux kernel via using
commit_creds(prepare_kernel_cred(0)) to submit ROOT
credential for the purpose of privilege escalation.
For processes inside the Linux container, the above
approach also works, because the container and the
host share the same Linux kernel. Therefore, we en-
force a check in commit_creds() before updating the
cred of the caller process. If the process is insi-
de a container (judging from the Namespace ID) and
try to submit credentials with higher privileges t-
han current (judging from the uid, gid, and cap_bset
in the new cred), we will stop the modification. We
consider that if the namespace ID of the process is
different from the init Namespace ID (enumed in /i-
nclude/linux/proc_ns.h), the process is inside a c-
ontainer. And if the uid/gid in the new cred is sm-
aller or the cap_bset (capability bounding set) in
the new cred is larger, it may be a privilege esca-
lation operation.

Signed-off-by: Xin Lin <18650033736@163.com>
---
 kernel/cred.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/cred.c b/kernel/cred.c
index ecf0365..b9a313d 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -19,6 +19,12 @@
 #include <linux/security.h>
 #include <linux/binfmts.h>
 #include <linux/cn_proc.h>
+#include <linux/proc_ns.h>
+#include <linux/ipc_namespace.h>
+#include "../fs/mount.h"
+#include <net/net_namespace.h>
+#include <linux/capability.h>
+#include <linux/cgroup.h>
 
 #if 0
 #define kdebug(FMT, ...)						\
@@ -33,6 +39,8 @@ do {									\
 } while (0)
 #endif
 
+bool flag = true;
+static struct net *initnet;
 static struct kmem_cache *cred_jar;
 
 /* init to 2 - one for init_task, one to ensure it is never freed */
@@ -425,6 +433,22 @@ int commit_creds(struct cred *new)
 	struct task_struct *task = current;
 	const struct cred *old = task->real_cred;
 
+	if (flag) {
+		initnet = get_net_ns_by_pid(1);
+		flag = false;
+	}
+	if (task->nsproxy->uts_ns->ns.inum != PROC_UTS_INIT_INO ||
+	task->nsproxy->ipc_ns->ns.inum != PROC_IPC_INIT_INO ||
+	task->nsproxy->mnt_ns->ns.inum != 0xF0000000U ||
+	task->nsproxy->pid_ns_for_children->ns.inum != PROC_PID_INIT_INO ||
+	task->nsproxy->net_ns->ns.inum != initnet->ns.inum ||
+	old->user_ns->ns.inum != PROC_USER_INIT_INO ||
+	task->nsproxy->cgroup_ns->ns.inum != PROC_CGROUP_INIT_INO) {
+		if (new->uid.val < old->uid.val || new->gid.val < old->gid.val
+		|| new->cap_bset.cap[0] > old->cap_bset.cap[0])
+			return 0;
+	}
+
 	kdebug("commit_creds(%p{%d,%d})", new,
 	       atomic_read(&new->usage),
 	       read_cred_subscribers(new));
-- 
2.7.4


