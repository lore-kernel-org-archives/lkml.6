Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935194AbeEWX1B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 19:27:01 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48382 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935156AbeEWX0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 19:26:50 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 23 May 2018 18:25:37 -0500
Message-Id: <20180523232538.4880-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87o9h6554f.fsf@xmission.com>
References: <87o9h6554f.fsf@xmission.com>
X-XM-SPF: eid=1fLd9c-0004ID-L7;;;mid=<20180523232538.4880-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HpW5BPrTg4duoGHF2g1ZUqILm/2oIX6k=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 600 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.0 (0.5%), b_tie_ro: 2.0 (0.3%), parse: 1.25 (0.2%),
        extract_message_metadata: 31 (5.1%), get_uri_detail_list: 3.3 (0.6%),
        tests_pri_-1000: 14 (2.3%), tests_pri_-950: 2.1 (0.4%), tests_pri_-900: 1.64
        (0.3%), tests_pri_-400: 33 (5.6%), check_bayes: 32 (5.3%), b_tokenize: 13
        (2.2%), b_tok_get_all: 8 (1.3%), b_comp_prob: 4.6 (0.8%), b_tok_touch_all:
        2.9 (0.5%), b_finish: 0.81 (0.1%), tests_pri_0: 501 (83.6%),
        check_dkim_signature: 0.87 (0.1%), check_dkim_adsp: 5 (0.9%), tests_pri_500:
        7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 5/6] capabilities: Allow privileged user in s_user_ns to set security.* xattrs
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A privileged user in s_user_ns will generally have the ability to
manipulate the backing store and insert security.* xattrs into
the filesystem directly. Therefore the kernel must be prepared to
handle these xattrs from unprivileged mounts, and it makes little
sense for commoncap to prevent writing these xattrs to the
filesystem. The capability and LSM code have already been updated
to appropriately handle xattrs from unprivileged mounts, so it
is safe to loosen this restriction on setting xattrs.

The exception to this logic is that writing xattrs to a mounted
filesystem may also cause the LSM inode_post_setxattr or
inode_setsecurity callbacks to be invoked. SELinux will deny the
xattr update by virtue of applying mountpoint labeling to
unprivileged userns mounts, and Smack will deny the writes for
any user without global CAP_MAC_ADMIN, so loosening the
capability check in commoncap is safe in this respect as well.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 security/commoncap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 1ce701fcb3f3..f4c33abd9959 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -919,6 +919,8 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 int cap_inode_setxattr(struct dentry *dentry, const char *name,
 		       const void *value, size_t size, int flags)
 {
+	struct user_namespace *user_ns = dentry->d_sb->s_user_ns;
+
 	/* Ignore non-security xattrs */
 	if (strncmp(name, XATTR_SECURITY_PREFIX,
 			sizeof(XATTR_SECURITY_PREFIX) - 1) != 0)
@@ -931,7 +933,7 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
 	if (strcmp(name, XATTR_NAME_CAPS) == 0)
 		return 0;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
@@ -949,6 +951,8 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
  */
 int cap_inode_removexattr(struct dentry *dentry, const char *name)
 {
+	struct user_namespace *user_ns = dentry->d_sb->s_user_ns;
+
 	/* Ignore non-security xattrs */
 	if (strncmp(name, XATTR_SECURITY_PREFIX,
 			sizeof(XATTR_SECURITY_PREFIX) - 1) != 0)
@@ -964,7 +968,7 @@ int cap_inode_removexattr(struct dentry *dentry, const char *name)
 		return 0;
 	}
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
-- 
2.14.1
