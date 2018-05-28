Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938179AbeE1LZ4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932603AbeE1LZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:25:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.16 009/272] fix breakage caused by d_find_alias() semantics change
Date: Mon, 28 May 2018 12:00:42 +0200
Message-Id: <20180528100240.988073616@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit b127125d9db23e4856156a7c909a3c8e18b69f99 upstream.

"VFS: don't keep disconnected dentries on d_anon" had a non-trivial
side-effect - d_unhashed() now returns true for those dentries,
making d_find_alias() skip them altogether.  For most of its callers
that's fine - we really want a connected alias there.  However,
there is a codepath where we relied upon picking such aliases
if nothing else could be found - selinux delayed initialization
of contexts for inodes on already mounted filesystems used to
rely upon that.

Cc: stable@kernel.org # f1ee616214cb "VFS: don't keep disconnected dentries on d_anon"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/hooks.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1532,8 +1532,15 @@ static int inode_doinit_with_dentry(stru
 			/* Called from d_instantiate or d_splice_alias. */
 			dentry = dget(opt_dentry);
 		} else {
-			/* Called from selinux_complete_init, try to find a dentry. */
+			/*
+			 * Called from selinux_complete_init, try to find a dentry.
+			 * Some filesystems really want a connected one, so try
+			 * that first.  We could split SECURITY_FS_USE_XATTR in
+			 * two, depending upon that...
+			 */
 			dentry = d_find_alias(inode);
+			if (!dentry)
+				dentry = d_find_any_alias(inode);
 		}
 		if (!dentry) {
 			/*
@@ -1636,14 +1643,19 @@ static int inode_doinit_with_dentry(stru
 		if ((sbsec->flags & SE_SBGENFS) && !S_ISLNK(inode->i_mode)) {
 			/* We must have a dentry to determine the label on
 			 * procfs inodes */
-			if (opt_dentry)
+			if (opt_dentry) {
 				/* Called from d_instantiate or
 				 * d_splice_alias. */
 				dentry = dget(opt_dentry);
-			else
+			} else {
 				/* Called from selinux_complete_init, try to
-				 * find a dentry. */
+				 * find a dentry.  Some filesystems really want
+				 * a connected one, so try that first.
+				 */
 				dentry = d_find_alias(inode);
+				if (!dentry)
+					dentry = d_find_any_alias(inode);
+			}
 			/*
 			 * This can be hit on boot when a file is accessed
 			 * before the policy is loaded.  When we load policy we
