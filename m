Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC7C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920EC20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kM6zKE8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920EC20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeIKMm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:42:57 -0400
Received: from m50-132.163.com ([123.125.50.132]:48909 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbeIKMm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:42:56 -0400
X-Greylist: delayed 925 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Sep 2018 08:42:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=72QmMu4gLD0A6PNoTI
        wnn4sPfub86CGJxhsSyY+Z7Tg=; b=kM6zKE8GvpmlPOA0srT4LQUncBweugmGnI
        zUS/eqL/QYc+Y8OmvFuNZNOfzKgXTvgaW2o7Uag/Cs+/b+C5IW8PRzzwhDjNpqel
        PNIPf6ja6j+TRfEN9mOXG9mFBNa1KcumvJzN7SeohB5v8t66HRkYB0HCrjw7xUJP
        nmRZ4eli8=
Received: from lx-virtual-machine.localdomain (unknown [111.207.250.32])
        by smtp2 (Coremail) with SMTP id DNGowAA3qZnRbpdbw0EIAA--.91S3;
        Tue, 11 Sep 2018 15:29:21 +0800 (CST)
From:   My Name <18650033736@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xin Lin <18650033736@163.com>
Subject: [PATCH] kernel: prevent submission of creds with higher privileges inside container
Date:   Tue, 11 Sep 2018 15:29:19 +0800
Message-Id: <1536650959-5057-1-git-send-email-18650033736@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DNGowAA3qZnRbpdbw0EIAA--.91S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWxAr45Xw13Gry7WryDKFg_yoW8Kw18pF
        sIkFyDGws8J3W7tws7Wr4YvFWrZw4fJry2gas5Kw4ayws2ka48u34v93W5GFnxArW7KayU
        KFW5GrsIgr98Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnTmDUUUUU=
X-Originating-IP: [111.207.250.32]
X-CM-SenderInfo: rprylkyqqtjlmtwbiqqrwthudrp/1tbiyhW+flQG-28F2QAAsB
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
index ecf0365..b6d4fb23 100644
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
+	task->nsproxy->net_ns->ns.inum != 0xF0000075U ||
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


