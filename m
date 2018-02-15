Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710051-2-11665626604941070237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710051; b=cLkcZQTcgQNutRKEJuZnL005KOF58+ZRfkj082FSgefgNuj
    iZhx+0kp67famb5LXTNB4fksS9aVXMUWsGvIjV9SqSVuwN+iu8IeIx7cHg3AdKp9
    ASHXoDlVHWiAQoe1YOR9VOafn4QMrMXfzcbqqRxq/9LZXE7Wa7S2DodtN0vSPZww
    fNHYcPoT2zDEJ68m2CNhJVtXluduo1wQFnLarkZi4tswHetLFAxKEVc57kDaniJt
    4RM2K1d50iUNe1DHO/c7RUflqZUvWqAsU/KeFKgmpc7yjyY++QixGIhOuTOvkp4y
    Z+pE07l5E1dW/BoVlhs56TS0GFF8oOJpbNqwGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710051; bh=/wBLdHA1I4dRmC8XrZ56hIZggD
    zqibpSTuukFzskEnc=; b=oUp6xdQuOXX399XWyquqEn/TYDFxLguEB7QZuWlOSE
    q8cOlefmHPeFqcjFSmDIlAEf1Xa8O5sBUf8i30XUh/5KgRaKs6CHczGeSUCoFieu
    y8RZLhJJrYi6NcNC6tltv3LXgJkIOelNemEb1zGY6oc7jreGmtsiuE9C9cjxGO+j
    FLZv7wEMFfPKizcfhUwB7dzfAzW9YHXP/bVSe0ly4Hez4SC7XEvakk0J+a96SJrH
    1RO+LLb052Cr+rUb/rNT5XBJblY2Inkydf4Oteh8GWMec34OlDE5GqNDZSpir0RJ
    bMfGatq+ElNjxC7GkxJ2pzm9VwrsxB8aR8LEZA/z1FrA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424936AbeBOPrl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:47:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36308 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424903AbeBOPrj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@axis.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.15 196/202] ovl: hash directory inodes for fsnotify
Date: Thu, 15 Feb 2018 16:18:16 +0100
Message-Id: <20180215151722.927896229@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 31747eda41ef3c30c09c5c096b380bf54013746a upstream.

fsnotify pins a watched directory inode in cache, but if directory dentry
is released, new lookup will allocate a new dentry and a new inode.
Directory events will be notified on the new inode, while fsnotify listener
is watching the old pinned inode.

Hash all directory inodes to reuse the pinned inode on lookup. Pure upper
dirs are hashes by real upper inode, merge and lower dirs are hashed by
real lower inode.

The reference to lower inode was being held by the lower dentry object
in the overlay dentry (oe->lowerstack[0]). Releasing the overlay dentry
may drop lower inode refcount to zero. Add a refcount on behalf of the
overlay inode to prevent that.

As a by-product, hashing directory inodes also detects multiple
redirected dirs to the same lower dir and uncovered redirected dir
target on and returns -ESTALE on lookup.

The reported issue dates back to initial version of overlayfs, but this
patch depends on ovl_inode code that was introduced in kernel v4.13.

Reported-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Tested-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/inode.c |   39 ++++++++++++++++++++++++++++-----------
 fs/overlayfs/super.c |    1 +
 fs/overlayfs/util.c  |    4 ++--
 3 files changed, 31 insertions(+), 13 deletions(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -606,6 +606,16 @@ static int ovl_inode_set(struct inode *i
 static bool ovl_verify_inode(struct inode *inode, struct dentry *lowerdentry,
 			     struct dentry *upperdentry)
 {
+	if (S_ISDIR(inode->i_mode)) {
+		/* Real lower dir moved to upper layer under us? */
+		if (!lowerdentry && ovl_inode_lower(inode))
+			return false;
+
+		/* Lookup of an uncovered redirect origin? */
+		if (!upperdentry && ovl_inode_upper(inode))
+			return false;
+	}
+
 	/*
 	 * Allow non-NULL lower inode in ovl_inode even if lowerdentry is NULL.
 	 * This happens when finding a copied up overlay inode for a renamed
@@ -633,6 +643,8 @@ struct inode *ovl_get_inode(struct dentr
 	struct inode *inode;
 	/* Already indexed or could be indexed on copy up? */
 	bool indexed = (index || (ovl_indexdir(dentry->d_sb) && !upperdentry));
+	struct dentry *origin = indexed ? lowerdentry : NULL;
+	bool is_dir;
 
 	if (WARN_ON(upperdentry && indexed && !lowerdentry))
 		return ERR_PTR(-EIO);
@@ -641,15 +653,19 @@ struct inode *ovl_get_inode(struct dentr
 		realinode = d_inode(lowerdentry);
 
 	/*
-	 * Copy up origin (lower) may exist for non-indexed upper, but we must
-	 * not use lower as hash key in that case.
-	 * Hash inodes that are or could be indexed by origin inode and
-	 * non-indexed upper inodes that could be hard linked by upper inode.
+	 * Copy up origin (lower) may exist for non-indexed non-dir upper, but
+	 * we must not use lower as hash key in that case.
+	 * Hash non-dir that is or could be indexed by origin inode.
+	 * Hash dir that is or could be merged by origin inode.
+	 * Hash pure upper and non-indexed non-dir by upper inode.
 	 */
-	if (!S_ISDIR(realinode->i_mode) && (upperdentry || indexed)) {
-		struct inode *key = d_inode(indexed ? lowerdentry :
-						      upperdentry);
-		unsigned int nlink;
+	is_dir = S_ISDIR(realinode->i_mode);
+	if (is_dir)
+		origin = lowerdentry;
+
+	if (upperdentry || origin) {
+		struct inode *key = d_inode(origin ?: upperdentry);
+		unsigned int nlink = is_dir ? 1 : realinode->i_nlink;
 
 		inode = iget5_locked(dentry->d_sb, (unsigned long) key,
 				     ovl_inode_test, ovl_inode_set, key);
@@ -670,8 +686,9 @@ struct inode *ovl_get_inode(struct dentr
 			goto out;
 		}
 
-		nlink = ovl_get_nlink(lowerdentry, upperdentry,
-				      realinode->i_nlink);
+		/* Recalculate nlink for non-dir due to indexing */
+		if (!is_dir)
+			nlink = ovl_get_nlink(lowerdentry, upperdentry, nlink);
 		set_nlink(inode, nlink);
 	} else {
 		inode = new_inode(dentry->d_sb);
@@ -685,7 +702,7 @@ struct inode *ovl_get_inode(struct dentr
 		ovl_set_flag(OVL_IMPURE, inode);
 
 	/* Check for non-merge dir that may have whiteouts */
-	if (S_ISDIR(realinode->i_mode)) {
+	if (is_dir) {
 		struct ovl_entry *oe = dentry->d_fsdata;
 
 		if (((upperdentry && lowerdentry) || oe->numlower > 1) ||
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -211,6 +211,7 @@ static void ovl_destroy_inode(struct ino
 	struct ovl_inode *oi = OVL_I(inode);
 
 	dput(oi->__upperdentry);
+	iput(oi->lower);
 	kfree(oi->redirect);
 	ovl_dir_cache_free(inode);
 	mutex_destroy(&oi->lock);
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -257,7 +257,7 @@ void ovl_inode_init(struct inode *inode,
 	if (upperdentry)
 		OVL_I(inode)->__upperdentry = upperdentry;
 	if (lowerdentry)
-		OVL_I(inode)->lower = d_inode(lowerdentry);
+		OVL_I(inode)->lower = igrab(d_inode(lowerdentry));
 
 	ovl_copyattr(d_inode(upperdentry ?: lowerdentry), inode);
 }
@@ -273,7 +273,7 @@ void ovl_inode_update(struct inode *inod
 	 */
 	smp_wmb();
 	OVL_I(inode)->__upperdentry = upperdentry;
-	if (!S_ISDIR(upperinode->i_mode) && inode_unhashed(inode)) {
+	if (inode_unhashed(inode)) {
 		inode->i_private = upperinode;
 		__insert_inode_hash(inode, (unsigned long) upperinode);
 	}
