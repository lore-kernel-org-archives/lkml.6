Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C9C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7F720833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GHmIgvxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7F720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeILLtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:49:45 -0400
Received: from m12-12.163.com ([220.181.12.12]:44441 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeILLto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=RIbfASOJERhgtYC2G+
        3LpWB5jK5aAgduOcXnSLKD/Yw=; b=GHmIgvxMmj/8PiFKB1Dj1xXAh/s2rO2iu9
        qKE27/2rZtryrZ6CEta8jF1EpVfPjDrQd6yJC9awzbz+iMEzqEyo+Glf2IYEIVRq
        pxVBs3VrhXoIAzbcPkOq0WyheLI5jXrkndKGbo3A+XFZHqhzHetdshkWNZHBOlPC
        qG8iBlW28=
Received: from localhost.localdomain (unknown [159.226.95.70])
        by smtp8 (Coremail) with SMTP id DMCowABHGJRNtphbV5y5QQ--.30408S4;
        Wed, 12 Sep 2018 14:46:38 +0800 (CST)
From:   My Name <18650033736@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xin Lin <18650033736@163.com>
Subject: [PATCH] kernel: prevent submission of creds with higher privileges inside container
Date:   Wed, 12 Sep 2018 14:46:34 +0800
Message-Id: <20180912064634.2134-1-18650033736@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowABHGJRNtphbV5y5QQ--.30408S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWxAr45Xw13Gry7WryDKFg_yoW8Kw18pF
        sIyrZrGws8J3W7tws7Wr4YvFWrZw4fJry2gas5Kw4aywn2ka48u34q93W5GFnxArW7KayU
        KFW5GrsI9r98Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UUKsbUUUUU=
X-Originating-IP: [159.226.95.70]
X-CM-SenderInfo: rprylkyqqtjlmtwbiqqrwthudrp/xtbBRw6-flO-8FQNAAAAsN
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
 kernel/cred.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/cred.c b/kernel/cred.c
index ecf0365..826c388 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -19,6 +19,11 @@
 #include <linux/security.h>
 #include <linux/binfmts.h>
 #include <linux/cn_proc.h>
+#include <linux/proc_ns.h>
+#include <linux/ipc_namespace.h>
+#include "../fs/mount.h"
+#include <linux/capability.h>
+#include <linux/cgroup.h>
 
 #if 0
 #define kdebug(FMT, ...)						\
@@ -425,6 +430,18 @@ int commit_creds(struct cred *new)
 	struct task_struct *task = current;
 	const struct cred *old = task->real_cred;
 
+	if (task->nsproxy->uts_ns->ns.inum != PROC_UTS_INIT_INO ||
+	task->nsproxy->ipc_ns->ns.inum != PROC_IPC_INIT_INO ||
+	task->nsproxy->mnt_ns->ns.inum != 0xF0000000U ||
+	task->nsproxy->pid_ns_for_children->ns.inum != PROC_PID_INIT_INO ||
+	task->nsproxy->net_ns->ns.inum != 0xF0000098U ||
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
2.17.1


