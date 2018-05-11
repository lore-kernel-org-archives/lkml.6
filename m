Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeEKAxH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 20:53:07 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:35253
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752083AbeEKAxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 20:53:04 -0400
X-YMail-OSG: 0njNphcVM1lWG4dtNH3flvo6XH3mn36RBxbtniOMtMpkyeWYcWBUItWfaXRj.vY
 __X1097RPnY45G5v2xR1N9rA.uDMRo_OoSUTd7sdRRvDyQFdpIl7pbRwrAErDoCD3toaHfjPDDPu
 TddBbAjTrQFY6EVk4YePZFTDyBQD.e6x5SRhpia4_OSr_5oxfBXUZkn9zsyhPkYS2xzsqdYbRozU
 POPagD.IDN3GOOPxyxP.fXAqlT3IMFu2BcIxL4cpViY4FuUvngkqWNkXTHsJT2i8.MJu1uG0dKs7
 8CSJ5SvPHF4i_WFx5VnewUXmv4ys56RmIawhcnXtlYLV.TZu83l2Gsm8DLJfxolKaI6WvtH0.SUq
 3jmNLsgv4or.aLOnkSHJQbWs03_A.3GlviryAb.MZ.2ofF9dWDFV0ihXzeHgPhE9lDxKLQgc.PRX
 qisIUbnlbZx.A9VRraAFIVUZN0tMWLp55CKb2P5gNsbjXqOr8a4IRQuxJXahHh5l1NiVagEjh.RL
 I0C62ufCjpV1czDFW0D0D2xlfz0l5BaQAbwfEqBtLpLNTdCW_TsWd8pgE7X9Gq2cLqTKmpjZYFgq
 0hV6JAVPfPd0.Dxn.2LXJqDQeO.s0Ip5za6LPORpJ5fUwSpBshzImtTsXFern1sexnaJyk9u7FpI
 6fmU-
Subject: [PATCH 05/23] SELinux: Abstract use of file security blob
To: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <552c12d4-8254-5805-4586-34aaa5c1f389@schaufler-ca.com>
Date: Thu, 10 May 2018 17:52:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 14:01:52 -0700
Subject: [PATCH 05/23] SELinux: Abstract use of file security blob

Don't use the file->f_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/hooks.c          | 18 +++++++++---------
 security/selinux/include/objsec.h |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f4179eb572e8..1d0a4a9fa08b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -398,7 +398,7 @@ static int file_alloc_security(struct file *file)
 
 static void file_free_security(struct file *file)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	file->f_security = NULL;
 	kmem_cache_free(file_security_cache, fsec);
 }
@@ -1869,7 +1869,7 @@ static int file_has_perm(const struct cred *cred,
 			 struct file *file,
 			 u32 av)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
@@ -2213,7 +2213,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 					struct file *file)
 {
 	u32 sid = task_sid(to);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
@@ -3524,7 +3524,7 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file_inode(file);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode_security_struct *isec;
 	u32 sid = current_sid();
 
@@ -3559,7 +3559,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		u32 requested, u16 cmd)
 {
 	struct common_audit_data ad;
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct inode_security_struct *isec;
 	struct lsm_ioctlop_audit ioctl;
@@ -3811,7 +3811,7 @@ static void selinux_file_set_fowner(struct file *file)
 {
 	struct file_security_struct *fsec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	fsec->fown_sid = current_sid();
 }
 
@@ -3826,7 +3826,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	/* struct fown_struct is never outside the context of a struct file */
 	file = container_of(fown, struct file, f_owner);
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -3850,7 +3850,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 	struct file_security_struct *fsec;
 	struct inode_security_struct *isec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	isec = inode_security(file_inode(file));
 	/*
 	 * Save inode label and policy sequence number
@@ -3990,7 +3990,7 @@ static int selinux_kernel_module_from_file(struct file *file)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
 		rc = avc_has_perm(&selinux_state,
 				  sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index db1c7000ada3..2586fbc7e38c 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -167,4 +167,9 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 	return cred->security;
 }
 
+static inline struct file_security_struct *selinux_file(const struct file *file)
+{
+	return file->f_security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.14.3
