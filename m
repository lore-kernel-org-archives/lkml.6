Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9DBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0652083F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0652083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbeGaVxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:53:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbeGaVxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:53:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD26887A74;
        Tue, 31 Jul 2018 20:11:52 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D37162026D7E;
        Tue, 31 Jul 2018 20:11:49 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     luto@kernel.org, carlos@redhat.com, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, simo@redhat.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak90 (was ghak32) V4 10/10] debug audit: read container ID of a process
Date:   Tue, 31 Jul 2018 16:07:45 -0400
Message-Id: <dfe41da856b2ace574be9df3664cfdce9b47adf5.1533065887.git.rgb@redhat.com>
In-Reply-To: <cover.1533065887.git.rgb@redhat.com>
References: <cover.1533065887.git.rgb@redhat.com>
In-Reply-To: <cover.1533065887.git.rgb@redhat.com>
References: <cover.1533065887.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 31 Jul 2018 20:11:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 31 Jul 2018 20:11:53 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reading the audit container identifier from the proc
filesystem.

This is a read from the proc entry of the form
/proc/PID/audit_containerid where PID is the process ID of the task
whose audit container identifier is sought.

The read expects up to a u64 value (unset: 18446744073709551615).

This read requires CAP_AUDIT_CONTROL.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 fs/proc/base.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1b3cda1..95fc64a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1261,6 +1261,24 @@ static ssize_t proc_sessionid_read(struct file * file, char __user * buf,
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t proc_contid_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct inode *inode = file_inode(file);
+	struct task_struct *task = get_proc_task(inode);
+	ssize_t length;
+	char tmpbuf[TMPBUFLEN*2];
+
+	if (!task)
+		return -ESRCH;
+	/* if we don't have caps, reject */
+	if (!capable(CAP_AUDIT_CONTROL))
+		return -EPERM;
+	length = scnprintf(tmpbuf, TMPBUFLEN*2, "%llu", audit_get_contid(task));
+	put_task_struct(task);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
 static ssize_t proc_contid_write(struct file *file, const char __user *buf,
 				   size_t count, loff_t *ppos)
 {
@@ -1291,6 +1309,7 @@ static ssize_t proc_contid_write(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations proc_contid_operations = {
+	.read		= proc_contid_read,
 	.write		= proc_contid_write,
 	.llseek		= generic_file_llseek,
 };
@@ -2987,7 +3006,7 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 #ifdef CONFIG_AUDITSYSCALL
 	REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
 	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
-	REG("audit_containerid", S_IWUSR, proc_contid_operations),
+	REG("audit_containerid", S_IWUSR|S_IRUSR, proc_contid_operations),
 #endif
 #ifdef CONFIG_FAULT_INJECTION
 	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
@@ -3373,7 +3392,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
 #ifdef CONFIG_AUDITSYSCALL
 	REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
 	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
-	REG("audit_containerid", S_IWUSR, proc_contid_operations),
+	REG("audit_containerid", S_IWUSR|S_IRUSR, proc_contid_operations),
 #endif
 #ifdef CONFIG_FAULT_INJECTION
 	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
-- 
1.8.3.1

