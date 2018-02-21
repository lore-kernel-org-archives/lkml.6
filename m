Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226LT/gth/fqFThcmyk+Cw7J8yQbpgrijmdfMR3TeSdbChg1RWAq85XhwoPwYyJ2WFdxSwTN
ARC-Seal: i=1; a=rsa-sha256; t=1519218327; cv=none;
        d=google.com; s=arc-20160816;
        b=PPfoGV9t4Vk+IL6Fm6kGraI6H+QOQKmzwptGqla0VyKVyhsW3B49/zSwYmPOsv+bMt
         nzcQZqPzUKlNLb5J9vgYi00ClnJ7L/Yja+BaPTpG/pvo5veOvU4XYnIzFMjgAKi1yhoM
         HrkLv0sCJAiwGjXThY3U9hu3/Ax5KwAqegqZ06Ufap56vvyE8XoPPEFs42keIJ8keji2
         fulumiYyKqjWCxXXFz/ObOnNg8K6oEpLVFzszrj2N+QkGJZETMcS7ouGGVRn43JkaLQD
         HyBDnb5Yq1KwP2EEfMaI6e6uMRRORO17zg8mfsZX6hKFj1KQPIXJx+MveZDnXFgJMmZa
         HBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AWNFayF8jj0hQQOzuBqbxGC7UEgpGqaZoV3NLL/oKLA=;
        b=wnFoNVb9qsIxhAnU7zYACvFlLZzbLJkzTxn5uG5JSEQywcxHKWK1lmDPRWoVSeSTVW
         l3xphPJBV0H92dLR+/iIdhsN+ZBLj3kKDWyiTBnrm28QpkyHT6pm9hh7iyXctXWgN7YN
         2EsVpeXPFcLxE7PvX6YPFw1EcMag2OD3TAwhs+kk3zp1k9B2aJ/zhRPCydUJDs8v5GOO
         WsL1zjVd+F3P/yMFcd2Tbb41AvBmatjNKNih+FLtRlY7cPCj7kWVQcPMbeuYFSO8Lmt1
         /HWv4h17pUo3rEyolniJJBfzuvSgexVW/8HZW/mLh1c1hxDD5FwEmbE61SSmlP0lTGAm
         NyRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Niklas Cassel <niklas.cassel@axis.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 167/167] ovl: hash directory inodes for fsnotify
Date: Wed, 21 Feb 2018 13:49:38 +0100
Message-Id: <20180221124533.986181369@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015876541198850?=
X-GMAIL-MSGID: =?utf-8?q?1593015876541198850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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

Cc: <stable@vger.kernel.org> #v4.13
Reported-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Tested-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/inode.c |   37 +++++++++++++++++++++++++++----------
 fs/overlayfs/super.c |    1 +
 fs/overlayfs/util.c  |    4 ++--
 3 files changed, 30 insertions(+), 12 deletions(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -579,6 +579,16 @@ static int ovl_inode_set(struct inode *i
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
@@ -606,6 +616,8 @@ struct inode *ovl_get_inode(struct dentr
 	struct inode *inode;
 	/* Already indexed or could be indexed on copy up? */
 	bool indexed = (index || (ovl_indexdir(dentry->d_sb) && !upperdentry));
+	struct dentry *origin = indexed ? lowerdentry : NULL;
+	bool is_dir;
 
 	if (WARN_ON(upperdentry && indexed && !lowerdentry))
 		return ERR_PTR(-EIO);
@@ -614,15 +626,19 @@ struct inode *ovl_get_inode(struct dentr
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
@@ -643,8 +659,9 @@ struct inode *ovl_get_inode(struct dentr
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
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -200,6 +200,7 @@ static void ovl_destroy_inode(struct ino
 	struct ovl_inode *oi = OVL_I(inode);
 
 	dput(oi->__upperdentry);
+	iput(oi->lower);
 	kfree(oi->redirect);
 	ovl_dir_cache_free(inode);
 	mutex_destroy(&oi->lock);
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -253,7 +253,7 @@ void ovl_inode_init(struct inode *inode,
 	if (upperdentry)
 		OVL_I(inode)->__upperdentry = upperdentry;
 	if (lowerdentry)
-		OVL_I(inode)->lower = d_inode(lowerdentry);
+		OVL_I(inode)->lower = igrab(d_inode(lowerdentry));
 
 	ovl_copyattr(d_inode(upperdentry ?: lowerdentry), inode);
 }
@@ -269,7 +269,7 @@ void ovl_inode_update(struct inode *inod
 	 */
 	smp_wmb();
 	OVL_I(inode)->__upperdentry = upperdentry;
-	if (!S_ISDIR(upperinode->i_mode) && inode_unhashed(inode)) {
+	if (inode_unhashed(inode)) {
 		inode->i_private = upperinode;
 		__insert_inode_hash(inode, (unsigned long) upperinode);
 	}
