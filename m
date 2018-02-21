Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeBUUbz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:31:55 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:44179 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeBUUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:30:58 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 21 Feb 2018 14:29:07 -0600
Message-Id: <20180221202908.17258-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878tbmf5vl.fsf@xmission.com>
References: <878tbmf5vl.fsf@xmission.com>
X-XM-SPF: eid=1eob2W-0004Av-4N;;;mid=<20180221202908.17258-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18U1y7IYwmGWfdGEOW38yu3JNrXdJ2cVTA=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 720 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.2 (0.4%), b_tie_ro: 2.2 (0.3%), parse: 1.41 (0.2%),
        extract_message_metadata: 27 (3.8%), get_uri_detail_list: 3.7 (0.5%),
        tests_pri_-1000: 10 (1.4%), tests_pri_-950: 2.1 (0.3%), tests_pri_-900: 1.66
        (0.2%), tests_pri_-400: 37 (5.2%), check_bayes: 36 (4.9%), b_tokenize: 15
        (2.0%), b_tok_get_all: 9 (1.2%), b_comp_prob: 4.1 (0.6%), b_tok_touch_all:
        3.8 (0.5%), b_finish: 2.1 (0.3%), tests_pri_0: 624 (86.7%),
        check_dkim_signature: 0.95 (0.1%), check_dkim_adsp: 4.2 (0.6%),
        tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v6 4/5] fuse: Ensure posix acls are translated outside of init_user_ns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the translation happens by failing to read or write
posix acls when the filesystem has not indicated it supports
posix acls.

This ensures that modern cached posix acl support is available
and used when dealing with posix acls.  This is important
because only that path has the code to convernt the uids and
gids in posix acls into the user namespace of a fuse filesystem.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fuse/fuse_i.h |  1 +
 fs/fuse/inode.c  |  7 +++++++
 fs/fuse/xattr.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7772e2b4057e..986fa2b043ab 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -979,6 +979,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
 int fuse_removexattr(struct inode *inode, const char *name);
 extern const struct xattr_handler *fuse_xattr_handlers[];
 extern const struct xattr_handler *fuse_acl_xattr_handlers[];
+extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
 
 struct posix_acl;
 struct posix_acl *fuse_get_acl(struct inode *inode, int type);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e018dc3999f4..a52cf2019a58 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1097,6 +1097,13 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	    file->f_cred->user_ns != sb->s_user_ns)
 		goto err_fput;
 
+	/*
+	 * If we are not in the initial user namespace posix
+	 * acls must be translated.
+	 */
+	if (sb->s_user_ns != &init_user_ns)
+		sb->s_xattr = fuse_no_acl_xattr_handlers;
+
 	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
 	err = -ENOMEM;
 	if (!fc)
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 3caac46b08b0..433717640f78 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -192,6 +192,26 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
 	return fuse_setxattr(inode, name, value, size, flags);
 }
 
+static bool no_xattr_list(struct dentry *dentry)
+{
+	return false;
+}
+
+static int no_xattr_get(const struct xattr_handler *handler,
+			struct dentry *dentry, struct inode *inode,
+			const char *name, void *value, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
+static int no_xattr_set(const struct xattr_handler *handler,
+			struct dentry *dentry, struct inode *nodee,
+			const char *name, const void *value,
+			size_t size, int flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static const struct xattr_handler fuse_xattr_handler = {
 	.prefix = "",
 	.get    = fuse_xattr_get,
@@ -209,3 +229,26 @@ const struct xattr_handler *fuse_acl_xattr_handlers[] = {
 	&fuse_xattr_handler,
 	NULL
 };
+
+static const struct xattr_handler fuse_no_acl_access_xattr_handler = {
+	.name  = XATTR_NAME_POSIX_ACL_ACCESS,
+	.flags = ACL_TYPE_ACCESS,
+	.list  = no_xattr_list,
+	.get   = no_xattr_get,
+	.set   = no_xattr_set,
+};
+
+static const struct xattr_handler fuse_no_acl_default_xattr_handler = {
+	.name  = XATTR_NAME_POSIX_ACL_DEFAULT,
+	.flags = ACL_TYPE_ACCESS,
+	.list  = no_xattr_list,
+	.get   = no_xattr_get,
+	.set   = no_xattr_set,
+};
+
+const struct xattr_handler *fuse_no_acl_xattr_handlers[] = {
+	&fuse_no_acl_access_xattr_handler,
+	&fuse_no_acl_default_xattr_handler,
+	&fuse_xattr_handler,
+	NULL
+};
-- 
2.14.1
