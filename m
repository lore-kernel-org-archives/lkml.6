Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74402C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAED20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gYXnGkjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAED20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeIKHVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 03:21:18 -0400
Received: from m50-135.163.com ([123.125.50.135]:60868 "EHLO m50-135.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbeIKHVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 03:21:18 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Sep 2018 03:21:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=pp7s9xYztg7cLKTU0I
        9bpyZUN4Ij1DTLYlOoVfZcNlg=; b=gYXnGkjHao3vc7mOWgXgfgFOjG7/SIC9c7
        7lYd8BU2tnJbWEqK9OrGXGlexD19lXp2kPSaa48av/utVNEYK86xY6gPlVO4ZHIv
        MrHmfHeU1C02nxKSt0RDGDHGMolu/b/Eb65QWuW+3+b1mqmbYH3WNg39J4SbPv47
        nFgOM45mc=
Received: from lx-virtual-machine.localdomain (unknown [111.207.250.32])
        by smtp5 (Coremail) with SMTP id D9GowAA3T_W8I5dbUQBaAg--.136S3;
        Tue, 11 Sep 2018 10:09:04 +0800 (CST)
From:   My Name <18650033736@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xin Lin <18650033736@163.com>
Subject: [PATCH] kernel: prevent submission of creds with higher privileges inside container
Date:   Tue, 11 Sep 2018 10:08:57 +0800
Message-Id: <1536631737-5161-1-git-send-email-18650033736@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: D9GowAA3T_W8I5dbUQBaAg--.136S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWxAr45Xw13Gry7WryDKFg_yoW8ury8pF
        sIyr9rKw4kJ3ZFyws7WrsYvFWrA3yfA342gas5Kw4Svw4kGa48u34j93W5GFnxWr47Kayj
        vFWrGFnFgrnxZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRLmRbUUUUU=
X-Originating-IP: [111.207.250.32]
X-CM-SenderInfo: rprylkyqqtjlmtwbiqqrwthudrp/1tbiygS+flQG-2vExQAAsJ
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
 kernel/cred.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/cred.c b/kernel/cred.c
index ecf0365..968a92c 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -425,6 +425,18 @@ int commit_creds(struct cred *new)
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


