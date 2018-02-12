Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeBLFHF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:07:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750980AbeBLFGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:06:40 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak8 ALT4 V4 2/3] audit: append new fstype field for anonymous PATH records
Date: Mon, 12 Feb 2018 00:02:22 -0500
Message-Id: <f6249f0ef7ac354d3678786fe263864b95494ed8.1518411444.git.rgb@redhat.com>
In-Reply-To: <cover.1518411444.git.rgb@redhat.com>
References: <cover.1518411444.git.rgb@redhat.com>
In-Reply-To: <cover.1518411444.git.rgb@redhat.com>
References: <cover.1518411444.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append a new fstype field that gives the filesystem type magic value in
hexadecimal to help identify previously null PATH records produced by
audit_inode_child logging requests on inodes with anonymous parents.

Sample output:
type=PROCTITLE msg=audit(1488317694.446:143): proctitle=2F7362696E2F6D6F6470726F6265002D71002D2D006E66737634
type=PATH msg=audit(1488317694.446:143): item=797 name=events/nfs4/nfs4_setclientid/format inode=15969 dev=00:09 mode=0100444 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tracefs_t:s0 nametype=CREATE cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0 fstype=74726163
type=PATH msg=audit(1488317694.446:143): item=796 name=events/nfs4/nfs4_setclientid inode=15964 dev=00:09 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tracefs_t:s0 nametype=PARENT cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0 fstype=74726163
...
type=PATH msg=audit(1488317694.446:143): item=1 name=events/nfs4 inode=15571 dev=00:09 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tracefs_t:s0 nametype=CREATE cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0 fstype=74726163
type=PATH msg=audit(1488317694.446:143): item=0 name=events inode=119 dev=00:09 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tracefs_t:s0 nametype=PARENT cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0 fstype=74726163
type=KERN_MODULE msg=audit(1488317694.446:143): name="nfsv4"
type=SYSCALL msg=audit(1488317694.446:143): arch=c000003e syscall=313 success=yes exit=0 a0=1 a1=55d5a35ce106 a2=0 a3=1 items=798 ppid=6 pid=528 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="modprobe" exe="/usr/bin/kmod" subj=system_u:system_r:insmod_t:s0 key="mod-load"

See: https://github.com/linux-audit/audit-kernel/issues/8
Test case: https://github.com/linux-audit/audit-testsuite/issues/42

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/audit.c b/kernel/audit.c
index 0c8d5a8..1c9d0a4 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2076,6 +2076,8 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
 		    const struct path *path, int record_num, int *call_panic)
 {
 	struct audit_buffer *ab;
+	unsigned long fstype;
+	
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_PATH);
 	if (!ab)
 		return;
@@ -2120,6 +2122,7 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
 		}
 		audit_log_format(ab, " name=");
 		audit_log_untrustedstring(ab, fullpathp ?: "?");
+	  	fstype = n->dentry->d_sb->s_magic;
 		if (fullpath)
 			kfree(fullpath);
 	} else {
@@ -2173,6 +2176,10 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
 	}
 
 	audit_log_fcaps(ab, n);
+	if (fstype)
+		audit_log_format(ab, " fstype=0x%lx", fstype);
+	else
+		audit_log_format(ab, " fstype=?");
 	audit_log_end(ab);
 }
 
-- 
1.8.3.1
