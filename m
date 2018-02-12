Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeBLFGp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:06:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751111AbeBLFGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:06:42 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak8 ALT4 V4 3/3] audit: add new filetypes CREATE_ANON and PARENT_ANON
Date: Mon, 12 Feb 2018 00:02:23 -0500
Message-Id: <da5694417c763e98f30273954fc6e0edc17e00ac.1518411444.git.rgb@redhat.com>
In-Reply-To: <cover.1518411444.git.rgb@redhat.com>
References: <cover.1518411444.git.rgb@redhat.com>
In-Reply-To: <cover.1518411444.git.rgb@redhat.com>
References: <cover.1518411444.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new filetypes PARENT_ANON and CREATE_ANON to indicate the pathname
supplied is incomplete and relative to the anonymous parent mountpoint
of type filesystem noted in the fstype field.

Sample output:
type=PATH msg=audit(1514350593.987:136): item=808 name="events/nfs4/nfs4_setclientid" inode=16778 dev=00:0b mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tracefs_t:s0 nametype=PARENT_ANON cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0 fstype=0x74726163
type=PATH msg=audit(1514350593.987:136): item=809 name="events/nfs4/nfs4_setclientid/format" inode=16783 dev=00:0b mode=0100444 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tracefs_t:s0 nametype=CREATE_ANON cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0 fstype=0x74726163

See: https://github.com/linux-audit/audit-kernel/issues/8
Test case: https://github.com/linux-audit/audit-testsuite/issues/42

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 include/linux/audit.h | 2 ++
 kernel/audit.c        | 6 ++++++
 kernel/auditsc.c      | 6 ++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 2020f1d..828e451 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -105,6 +105,8 @@ struct audit_field {
 #define	AUDIT_TYPE_PARENT	2	/* a parent audit record */
 #define	AUDIT_TYPE_CHILD_DELETE 3	/* a child being deleted */
 #define	AUDIT_TYPE_CHILD_CREATE 4	/* a child being created */
+#define	AUDIT_TYPE_PARENT_ANON	5	/* an anonymous parent audit record */
+#define	AUDIT_TYPE_CHILD_ANON	6	/* an anonymous child being created */
 
 /* maximized args number that audit_socketcall can process */
 #define AUDITSC_ARGS		6
diff --git a/kernel/audit.c b/kernel/audit.c
index 1c9d0a4..64f0025 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2170,6 +2170,12 @@ void audit_log_name(struct audit_context *context, struct audit_names *n,
 	case AUDIT_TYPE_CHILD_CREATE:
 		audit_log_format(ab, "CREATE");
 		break;
+	case AUDIT_TYPE_CHILD_ANON:
+		audit_log_format(ab, "CREATE_ANON");
+		break;
+	case AUDIT_TYPE_PARENT_ANON:
+		audit_log_format(ab, "PARENT_ANON");
+		break;
 	default:
 		audit_log_format(ab, "UNKNOWN");
 		break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b73ede0..903595ec 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1940,7 +1940,7 @@ void __audit_inode_child(struct inode *parent,
 
 	if (!found_parent) {
 		/* create a new, "anonymous" parent record */
-		n = audit_alloc_name(context, AUDIT_TYPE_PARENT);
+		n = audit_alloc_name(context, AUDIT_TYPE_PARENT_ANON);
 		if (!n)
 			return;
 		audit_copy_inode(n, NULL, parent);
@@ -1966,8 +1966,10 @@ void __audit_inode_child(struct inode *parent,
 		audit_copy_inode(found_child, dentry, inode);
 	else
 		found_child->ino = AUDIT_INO_UNSET;
-	if (!found_parent)
+	if (!found_parent) {
 		found_child->dentry = dget(dentry);
+		found_child->type = AUDIT_TYPE_CHILD_ANON;
+	}
 }
 EXPORT_SYMBOL_GPL(__audit_inode_child);
 
-- 
1.8.3.1
