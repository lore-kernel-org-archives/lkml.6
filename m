Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932676AbeCBWAh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:00:37 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:39217 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932428AbeCBWAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:00:31 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri,  2 Mar 2018 15:59:15 -0600
Message-Id: <20180302215919.27207-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87r2p287i8.fsf_-_@xmission.com>
References: <87r2p287i8.fsf_-_@xmission.com>
X-XM-SPF: eid=1ersj7-0000ts-2D;;;mid=<20180302215919.27207-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Zz7KVxhZyxVoIB4fNdVSuvTwxWA2eyjY=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1336 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 4.1 (0.3%), b_tie_ro: 2.1 (0.2%), parse: 0.86 (0.1%),
        extract_message_metadata: 11 (0.8%), get_uri_detail_list: 2.5 (0.2%),
        tests_pri_-1000: 5 (0.4%), tests_pri_-950: 1.14 (0.1%), tests_pri_-900: 0.91
        (0.1%), tests_pri_-400: 26 (1.9%), check_bayes: 25 (1.9%), b_tokenize: 10
        (0.7%), b_tok_get_all: 8 (0.6%), b_comp_prob: 2.2 (0.2%), b_tok_touch_all:
        3.3 (0.2%), b_finish: 0.55 (0.0%), tests_pri_0: 1276 (95.5%),
        check_dkim_signature: 0.59 (0.0%), check_dkim_adsp: 2.8 (0.2%),
        tests_pri_500: 7 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v8 2/6] fuse: Simplfiy the posix acl handling logic.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the fuse connection flag posix_acl to cached_posix_acl as that
is what it actually means.  That fuse will cache and operate on the
cached value of the posix acl.

Always use posix_acl_access_xattr_handler so the fuse code benefits
from the generic posix acl handlers as much as possible.  This will
become important as the code works on translation of uid and gid in
the posix acls when fuse is not mounted in the initial user namespace.

Update fuse_get_acl so that it does not cache the acl if the code is
not caching the acl.  This is all that is needed to ensure the
fuse_getxattr calls down into the fuse server when posix_acl_xattr_get
is called.  The updated code goes through fuse_getacl, and as such has
posix acl specific sanity checks and attribute handling but no real
difference from the previous code that skipped it.

It can safely be assumed that fuse filesystems where acls are not
cached in the kernel do not set fc->default_permissions as
default_permissions only checked posix acls if .get_acl was defined
and before the cached acl flag was introduced fuse did not implement a
get_acl method.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fuse/acl.c    | 6 ++++--
 fs/fuse/dir.c    | 2 +-
 fs/fuse/fuse_i.h | 3 +--
 fs/fuse/inode.c  | 3 +--
 fs/fuse/xattr.c  | 5 -----
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index ec85765502f1..cfa58ee0c10b 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -19,7 +19,7 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type)
 	void *value = NULL;
 	struct posix_acl *acl;
 
-	if (!fc->posix_acl || fc->no_getxattr)
+	if (fc->no_getxattr)
 		return NULL;
 
 	if (type == ACL_TYPE_ACCESS)
@@ -44,6 +44,8 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type)
 		acl = ERR_PTR(size);
 
 	kfree(value);
+	if (!IS_ERR(acl) && !fc->cached_posix_acl)
+		acl = to_uncacheable_acl(acl);
 	return acl;
 }
 
@@ -53,7 +55,7 @@ int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	const char *name;
 	int ret;
 
-	if (!fc->posix_acl || fc->no_setxattr)
+	if (fc->no_setxattr)
 		return -EOPNOTSUPP;
 
 	if (type == ACL_TYPE_ACCESS)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 24967382a7b1..43a45e83d313 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1764,7 +1764,7 @@ static int fuse_setattr(struct dentry *entry, struct iattr *attr)
 		 * If filesystem supports acls it may have updated acl xattrs in
 		 * the filesystem, so forget cached acls for the inode.
 		 */
-		if (fc->posix_acl)
+		if (fc->cached_posix_acl)
 			forget_all_cached_acls(inode);
 
 		/* Directory mode changed, may need to revalidate access */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c4c093bbf456..74ce02fb16d6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -619,7 +619,7 @@ struct fuse_conn {
 	unsigned no_lseek:1;
 
 	/** Does the filesystem support posix acls? */
-	unsigned posix_acl:1;
+	unsigned cached_posix_acl:1;
 
 	/** Check permissions based on the file mode or not? */
 	unsigned default_permissions:1;
@@ -974,7 +974,6 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
 int fuse_removexattr(struct inode *inode, const char *name);
 extern const struct xattr_handler *fuse_xattr_handlers[];
-extern const struct xattr_handler *fuse_acl_xattr_handlers[];
 
 struct posix_acl;
 struct posix_acl *fuse_get_acl(struct inode *inode, int type);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 624f18bbfd2b..507f780046c5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -915,8 +915,7 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 				fc->sb->s_time_gran = arg->time_gran;
 			if ((arg->flags & FUSE_POSIX_ACL)) {
 				fc->default_permissions = 1;
-				fc->posix_acl = 1;
-				fc->sb->s_xattr = fuse_acl_xattr_handlers;
+				fc->cached_posix_acl = 1;
 			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 3caac46b08b0..ed64c508585a 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -199,11 +199,6 @@ static const struct xattr_handler fuse_xattr_handler = {
 };
 
 const struct xattr_handler *fuse_xattr_handlers[] = {
-	&fuse_xattr_handler,
-	NULL
-};
-
-const struct xattr_handler *fuse_acl_xattr_handlers[] = {
 	&posix_acl_access_xattr_handler,
 	&posix_acl_default_xattr_handler,
 	&fuse_xattr_handler,
-- 
2.14.1
