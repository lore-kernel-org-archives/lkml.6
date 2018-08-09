Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F500C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CABC217C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lybe2Xzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CABC217C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbeHIMRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:17:54 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:32533 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeHIMRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:17:53 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180809095346epoutp0499e9de521c8452ca11d2c5e11627401d~JLqMwC8Bm1991719917epoutp04w
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 09:53:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180809095346epoutp0499e9de521c8452ca11d2c5e11627401d~JLqMwC8Bm1991719917epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533808426;
        bh=UU6awLZBKNhG9ZzVVxw5F+6WZE2XJi1goAEA6gL9Nmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lybe2XziIbHBem28duDsRj4fAZl66ktwiSdNHKFv7aQWdvSOasitktbUW5xh79Cuw
         2mL1w3C6z3PaW9vBNjQPnsxz5LuCK9J9fvyyqYEe7nmApAKRh7/hjJUiLV48E386rp
         Gz1mfkElmELmb6JfEsg4YKSscuOd8YTPiOVDP8KU=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180809095343epcas1p45bfa76525e68301f7467f0f0a0c08003~JLqKR9Ru83013430134epcas1p4R;
        Thu,  9 Aug 2018 09:53:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.7B.04176.62F0C6B5; Thu,  9 Aug 2018 18:53:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20180809095342epcas1p4481a285a4a96ee10b26d94fc27c9e3fe~JLqI04B8I3013430134epcas1p4O;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180809095342epsmtrp1c2ecdd033197e42ce4ec37f88e14c8f7~JLqIw00ty0614706147epsmtrp1G;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
X-AuditID: b6c32a37-6ddff70000001050-78-5b6c0f2611a9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.22.03759.62F0C6B5; Thu,  9 Aug 2018 18:53:42 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.63.222]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180809095342epsmtip138cea1c17d06fc50894dd1ff7776b381~JLqIldid71957119571epsmtip1r;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jslaby@suse.cz,
        sw0312.kim@samsung.com
Subject: [PATCH 3.18.y 5/5] switch ->setxattr() to passing dentry and inode
 separately
Date:   Thu,  9 Aug 2018 18:53:44 +0900
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1533808424-20649-1-git-send-email-sw0312.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmnq4af060wfxjlhZz1q9hs2hevJ7N
        4vPvXawWl3fNYbNYsPERo8WMyS/ZLB71vWW3OP/3OKsDh8eJGb9ZPPbPXcPu0bdlFaPHmQVH
        2D0+b5Lz2PTkLVMAW1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqt
        kotPgK5bZg7QQUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6VoQ0MjPUMDcz0jIyBtHGtl
        ZApUkpCa0d65g7Xg3SfGismTVjM2MC46yNjFyMEhIWAi0fMltouRi0NIYAejxNNLj1kgnE+M
        Ej1ntjBCON8YJbZtWAfkcIJ17Lu/EapqL1DLzyPsEM5nRonHe94zg1SxCehI7F/ymxXEFhEI
        k1j9cCobiM0sUC9x8/8/MFtYIEJi24JtYFNZBFQlbk7azAKxQUFiwb23YDWcAu4SO9qesYIs
        kBDYwibxa8E9sAZegTKJvTtvsUE0uEhc6frOBGELS7w6voUdwpaSeNnfBmW3M0ocnFkHMWgK
        o8S1v5+gEsYSzxZ2MYFCg1lAU2L9Ln2IQ/kk3n3tYYUEEq9ER5sQRLWKxM6jk9ggwlISszYE
        Q5geEt2T8iHBcIJR4s69brYJjLKzEGYuYGRcxSiWWlCcm55abFhgrFecmFtcmpeul5yfu4kR
        nL60zHcwbjjnc4hRgINRiYf3Al92tBBrYllxZe4hRgkOZiURXu7/QCHelMTKqtSi/Pii0pzU
        4kOMpsDAm8gsJZqcD0yteSXxhqZGxsbGFiaGZqaGhkrivEZ+wdFCAumJJanZqakFqUUwfUwc
        nFINjLm6WSu/P6y9sUvs57/pC5eK3XY4v2/DNKVC08jPy/vWJV0rX6/f9/Xn5MUq9xszb7/2
        mq52Ip3xlZa4WdDdaQtqJ/x751EQp212IV6s/YuwsJ9rw7v3bZ/avfWXmX6w25ZpNsdY41bb
        32lOdmYTFpw9vOVQXrb10tf9km+/6/zfO6fmn5GrLacSS3FGoqEWc1FxIgCRmhWDdQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnK4af060QeM7Tos569ewWTQvXs9m
        8fn3LlaLy7vmsFks2PiI0WLG5JdsFo/63rJbnP97nNWBw+PEjN8sHvvnrmH36NuyitHjzIIj
        7B6fN8l5bHrylimALYrLJiU1J7MstUjfLoEro71zB2vBu0+MFZMnrWZsYFx0kLGLkZNDQsBE
        Yt/9jSxdjFwcQgK7GSX6ls5lhkhIScz9th2oiAPIFpY4fLgYouYjo8TEbzvAmtkEdCT2L/nN
        CmKLCERIHHg2mQ2kiFmglVHizJLDTCAJYYEwiSf9j8CGsgioStyctJkFxOYVcJOYNHc/C8Qy
        BYkF996ygdicAu4SO9qegQ0VEiiRmHn0D/sERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL
        89L1kvNzNzGCw1FLcwfj5SXxhxgFOBiVeHgv8GVHC7EmlhVX5h5ilOBgVhLh5f4PFOJNSays
        Si3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoFR4dcWn173T9ozpypa
        +BdNTXMJ9fjzpufGZ65r6/cJxHOkfJxa/mKxlyufk9R0Cf9dzDl71iw9llbOtVa+u15NbIHu
        nW+MfvXRt+/KP7z02eVKQ1Luvv+u7AkrNELSihw1dNYln+CecX0CzzGx7tX3wo09LF+f0Ilt
        3Pclu3fXR3fl5t8y1TlKLMUZiYZazEXFiQDScGn7QwIAAA==
Message-Id: <20180809095342epcas1p4481a285a4a96ee10b26d94fc27c9e3fe~JLqI04B8I3013430134epcas1p4O@epcas1p4.samsung.com>
X-CMS-MailID: 20180809095342epcas1p4481a285a4a96ee10b26d94fc27c9e3fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180809095342epcas1p4481a285a4a96ee10b26d94fc27c9e3fe
References: <20180705005205.GC30522@ZenIV.linux.org.uk>
        <1533808424-20649-1-git-send-email-sw0312.kim@samsung.com>
        <CGME20180809095342epcas1p4481a285a4a96ee10b26d94fc27c9e3fe@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

smack ->d_instantiate() uses ->setxattr(), so to be able to call it before
we'd hashed the new dentry and attached it to inode, we need ->setxattr()
instances getting the inode as an explicit argument rather than obtaining
it from dentry.

Similar change for ->getxattr() had been done in commit ce23e64.  Unlike
->getxattr() (which is used by both selinux and smack instances of
->d_instantiate()) ->setxattr() is used only by smack one and unfortunately
it got missed back then.

Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Tested-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

[sw0312.kim: backport to 3.18]
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
It is not clear, a26feccaba29 ("ceph: Get rid of d_find_alias in ceph_set_acl")
is required backport for ceph or not.
---
 Documentation/filesystems/porting                  |    7 +++++++
 .../staging/lustre/lustre/llite/llite_internal.h   |    4 ++--
 drivers/staging/lustre/lustre/llite/xattr.c        |    6 ++----
 fs/bad_inode.c                                     |    4 ++--
 fs/btrfs/xattr.c                                   |   12 +++++++-----
 fs/btrfs/xattr.h                                   |    5 +++--
 fs/ceph/super.h                                    |    4 ++--
 fs/ceph/xattr.c                                    |    7 ++++---
 fs/cifs/cifsfs.h                                   |    4 ++--
 fs/cifs/xattr.c                                    |   13 +++++++------
 fs/ecryptfs/crypto.c                               |    9 +++++----
 fs/ecryptfs/ecryptfs_kernel.h                      |    4 ++--
 fs/ecryptfs/inode.c                                |    7 ++++---
 fs/ecryptfs/mmap.c                                 |    3 ++-
 fs/fuse/dir.c                                      |    6 +++---
 fs/gfs2/inode.c                                    |    9 +++++----
 fs/hfs/attr.c                                      |    6 +++---
 fs/hfs/hfs_fs.h                                    |    2 +-
 fs/jfs/jfs_xattr.h                                 |    4 ++--
 fs/jfs/xattr.c                                     |   10 +++++-----
 fs/kernfs/inode.c                                  |   11 ++++++-----
 fs/kernfs/kernfs-internal.h                        |    3 ++-
 fs/overlayfs/inode.c                               |    5 +++--
 fs/overlayfs/overlayfs.h                           |    5 +++--
 fs/reiserfs/xattr.c                                |    8 ++++----
 fs/reiserfs/xattr.h                                |    5 +++--
 fs/ubifs/ubifs.h                                   |    2 +-
 fs/ubifs/xattr.c                                   |    4 ++--
 fs/xattr.c                                         |    9 +++++----
 include/linux/fs.h                                 |    3 ++-
 include/linux/xattr.h                              |    3 ++-
 mm/shmem.c                                         |   10 ++++++----
 security/smack/smack_lsm.c                         |    2 +-
 33 files changed, 110 insertions(+), 86 deletions(-)

diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index daf9acd..51bdd4a 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -469,3 +469,10 @@ in your dentry operations instead.
 	dentry might be yet to be attached to inode, so do _not_ use its ->d_inode
 	in the instances.  Rationale: !@#!@# security_d_instantiate() needs to be
 	called before we attach dentry to inode.
+--
+[mandatory]
+	->setxattr() and xattr_handler.set() get dentry and inode passed separately.
+	dentry might be yet to be attached to inode, so do _not_ use its ->d_inode
+	in the instances.  Rationale: !@#!@# security_d_instantiate() needs to be
+	called before we attach dentry to inode and !@#!@##!@$!$#!@#$!@$!@$ smack
+	->d_instantiate() uses not just ->getxattr() but ->setxattr() as well.
diff --git a/drivers/staging/lustre/lustre/llite/llite_internal.h b/drivers/staging/lustre/lustre/llite/llite_internal.h
index 442fe5b..d7ac9bc 100644
--- a/drivers/staging/lustre/lustre/llite/llite_internal.h
+++ b/drivers/staging/lustre/lustre/llite/llite_internal.h
@@ -1068,8 +1068,8 @@ static inline __u64 ll_file_maxbytes(struct inode *inode)
 }
 
 /* llite/xattr.c */
-int ll_setxattr(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags);
+int ll_setxattr(struct dentry *dentry, struct inode *inode,
+		const char *name, const void *value, size_t size, int flags);
 ssize_t ll_getxattr(struct dentry *dentry, struct inode *inode,
 		    const char *name, void *buffer, size_t size);
 ssize_t ll_listxattr(struct dentry *dentry, char *buffer, size_t size);
diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index fc4b95d3..3edbbd2 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -212,11 +212,9 @@ int ll_setxattr_common(struct inode *inode, const char *name,
 	return 0;
 }
 
-int ll_setxattr(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags)
+int ll_setxattr(struct dentry *dentry, struct inode *inode,
+		const char *name, const void *value, size_t size, int flags)
 {
-	struct inode *inode = dentry->d_inode;
-
 	LASSERT(inode);
 	LASSERT(name);
 
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 336c284..5c29455 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -247,8 +247,8 @@ static int bad_inode_setattr(struct dentry *direntry, struct iattr *attrs)
 	return -EIO;
 }
 
-static int bad_inode_setxattr(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags)
+static int bad_inode_setxattr(struct dentry *dentry, struct inode *inode,
+		const char *name, const void *value, size_t size, int flags)
 {
 	return -EIO;
 }
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 6fa0196..22291af 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -412,10 +412,11 @@ ssize_t btrfs_getxattr(struct dentry *dentry, struct inode *inode,
 	return __btrfs_getxattr(inode, name, buffer, size);
 }
 
-int btrfs_setxattr(struct dentry *dentry, const char *name, const void *value,
+int btrfs_setxattr(struct dentry *dentry, struct inode *inode,
+		   const char *name, const void *value,
 		   size_t size, int flags)
 {
-	struct btrfs_root *root = BTRFS_I(dentry->d_inode)->root;
+	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int ret;
 
 	/*
@@ -431,20 +432,21 @@ int btrfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	 * for it via sb->s_xattr.
 	 */
 	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_setxattr(dentry, name, value, size, flags);
+		return generic_setxattr(dentry, inode, name, value,
+					size, flags);
 
 	ret = btrfs_is_valid_xattr(name);
 	if (ret)
 		return ret;
 
 	if (!strncmp(name, XATTR_BTRFS_PREFIX, XATTR_BTRFS_PREFIX_LEN))
-		return btrfs_set_prop(dentry->d_inode, name,
+		return btrfs_set_prop(inode, name,
 				      value, size, flags);
 
 	if (size == 0)
 		value = "";  /* empty EA, do not remove */
 
-	return __btrfs_setxattr(NULL, dentry->d_inode, name, value, size,
+	return __btrfs_setxattr(NULL, inode, name, value, size,
 				flags);
 }
 
diff --git a/fs/btrfs/xattr.h b/fs/btrfs/xattr.h
index 8ee4329..bbd23f3 100644
--- a/fs/btrfs/xattr.h
+++ b/fs/btrfs/xattr.h
@@ -30,8 +30,9 @@ extern int __btrfs_setxattr(struct btrfs_trans_handle *trans,
 			    const void *value, size_t size, int flags);
 extern ssize_t btrfs_getxattr(struct dentry *dentry, struct inode *inode,
 			      const char *name, void *buffer, size_t size);
-extern int btrfs_setxattr(struct dentry *dentry, const char *name,
-		const void *value, size_t size, int flags);
+extern int btrfs_setxattr(struct dentry *dentry, struct inode *inode,
+			  const char *name, const void *value,
+			  size_t size, int flags);
 extern int btrfs_removexattr(struct dentry *dentry, const char *name);
 
 extern int btrfs_xattr_security_init(struct btrfs_trans_handle *trans,
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 82dd063..2783da8 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -722,8 +722,8 @@ extern int ceph_getattr(struct vfsmount *mnt, struct dentry *dentry,
 			struct kstat *stat);
 
 /* xattr.c */
-extern int ceph_setxattr(struct dentry *, const char *, const void *,
-			 size_t, int);
+extern int ceph_setxattr(struct dentry *, struct inode *, const char *,
+			 const void *, size_t, int);
 int __ceph_setxattr(struct dentry *, const char *, const void *, size_t, int);
 ssize_t __ceph_getxattr(struct inode *, const char *, void *, size_t);
 int __ceph_removexattr(struct dentry *, const char *);
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 59640c0..663cecc 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -995,14 +995,15 @@ out:
 	return err;
 }
 
-int ceph_setxattr(struct dentry *dentry, const char *name,
+int ceph_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 		  const void *value, size_t size, int flags)
 {
-	if (ceph_snap(dentry->d_inode) != CEPH_NOSNAP)
+	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EROFS;
 
 	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_setxattr(dentry, name, value, size, flags);
+		return generic_setxattr(dentry, inode, name, value, size,
+					flags);
 
 	return __ceph_setxattr(dentry, name, value, size, flags);
 }
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index b0eac15..bda690e 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -122,8 +122,8 @@ extern int cifs_readlink(struct dentry *direntry, char __user *buffer,
 extern int cifs_symlink(struct inode *inode, struct dentry *direntry,
 			const char *symname);
 extern int	cifs_removexattr(struct dentry *, const char *);
-extern int	cifs_setxattr(struct dentry *, const char *, const void *,
-			size_t, int);
+extern int	cifs_setxattr(struct dentry *, struct inode *, const char *,
+			const void *, size_t, int);
 extern ssize_t	cifs_getxattr(struct dentry *, struct inode *, const char *, void *, size_t);
 extern ssize_t	cifs_listxattr(struct dentry *, char *, size_t);
 extern long cifs_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index d2c738e..2d7e6de 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -97,8 +97,9 @@ remove_ea_exit:
 	return rc;
 }
 
-int cifs_setxattr(struct dentry *direntry, const char *ea_name,
-		  const void *ea_value, size_t value_size, int flags)
+int cifs_setxattr(struct dentry *direntry, struct inode *inode,
+		  const char *ea_name, const void *ea_value, size_t value_size,
+		  int flags)
 {
 	int rc = -EOPNOTSUPP;
 #ifdef CONFIG_CIFS_XATTR
@@ -111,9 +112,9 @@ int cifs_setxattr(struct dentry *direntry, const char *ea_name,
 
 	if (direntry == NULL)
 		return -EIO;
-	if (direntry->d_inode == NULL)
+	if (inode == NULL)
 		return -EIO;
-	sb = direntry->d_inode->i_sb;
+	sb = inode->i_sb;
 	if (sb == NULL)
 		return -EIO;
 
@@ -177,12 +178,12 @@ int cifs_setxattr(struct dentry *direntry, const char *ea_name,
 			memcpy(pacl, ea_value, value_size);
 			if (pTcon->ses->server->ops->set_acl)
 				rc = pTcon->ses->server->ops->set_acl(pacl,
-						value_size, direntry->d_inode,
+						value_size, inode,
 						full_path, CIFS_ACL_DACL);
 			else
 				rc = -EOPNOTSUPP;
 			if (rc == 0) /* force revalidate of the inode */
-				CIFS_I(direntry->d_inode)->time = 0;
+				CIFS_I(inode)->time = 0;
 			kfree(pacl);
 		}
 #else
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index bc82bf3..1523f21 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1149,12 +1149,13 @@ ecryptfs_write_metadata_to_contents(struct inode *ecryptfs_inode,
 
 static int
 ecryptfs_write_metadata_to_xattr(struct dentry *ecryptfs_dentry,
+				 struct inode *ecryptfs_inode,
 				 char *page_virt, size_t size)
 {
 	int rc;
 
-	rc = ecryptfs_setxattr(ecryptfs_dentry, ECRYPTFS_XATTR_NAME, page_virt,
-			       size, 0);
+	rc = ecryptfs_setxattr(ecryptfs_dentry, ecryptfs_inode,
+			       ECRYPTFS_XATTR_NAME, page_virt, size, 0);
 	return rc;
 }
 
@@ -1223,8 +1224,8 @@ int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
 		goto out_free;
 	}
 	if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR)
-		rc = ecryptfs_write_metadata_to_xattr(ecryptfs_dentry, virt,
-						      size);
+		rc = ecryptfs_write_metadata_to_xattr(ecryptfs_dentry, ecryptfs_inode,
+						      virt, size);
 	else
 		rc = ecryptfs_write_metadata_to_contents(ecryptfs_inode, virt,
 							 virt_len);
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 0030865..567fbd7 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -621,8 +621,8 @@ ssize_t
 ecryptfs_getxattr_lower(struct dentry *lower_dentry, struct inode *lower_inode,
 			const char *name, void *value, size_t size);
 int
-ecryptfs_setxattr(struct dentry *dentry, const char *name, const void *value,
-		  size_t size, int flags);
+ecryptfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
+		  const void *value, size_t size, int flags);
 int ecryptfs_read_xattr_region(char *page_virt, struct inode *ecryptfs_inode);
 #ifdef CONFIG_ECRYPT_FS_MESSAGING
 int ecryptfs_process_response(struct ecryptfs_daemon *daemon,
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 4fb21a7..80006b1 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1016,7 +1016,8 @@ static int ecryptfs_getattr(struct vfsmount *mnt, struct dentry *dentry,
 }
 
 int
-ecryptfs_setxattr(struct dentry *dentry, const char *name, const void *value,
+ecryptfs_setxattr(struct dentry *dentry, struct inode *inode,
+		  const char *name, const void *value,
 		  size_t size, int flags)
 {
 	int rc = 0;
@@ -1029,8 +1030,8 @@ ecryptfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	}
 
 	rc = vfs_setxattr(lower_dentry, name, value, size, flags);
-	if (!rc && dentry->d_inode)
-		fsstack_copy_attr_all(dentry->d_inode, lower_dentry->d_inode);
+	if (!rc && inode)
+		fsstack_copy_attr_all(inode, lower_dentry->d_inode);
 out:
 	return rc;
 }
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 4ee2cac..5099360 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -443,7 +443,8 @@ static int ecryptfs_write_inode_size_to_xattr(struct inode *ecryptfs_inode)
 	if (size < 0)
 		size = 8;
 	put_unaligned_be64(i_size_read(ecryptfs_inode), xattr_virt);
-	rc = lower_inode->i_op->setxattr(lower_dentry, ECRYPTFS_XATTR_NAME,
+	rc = lower_inode->i_op->setxattr(lower_dentry, lower_inode,
+					 ECRYPTFS_XATTR_NAME,
 					 xattr_virt, size, 0);
 	mutex_unlock(&lower_inode->i_mutex);
 	if (rc)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index bef1ee3..1dbc7c1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1845,10 +1845,10 @@ static int fuse_getattr(struct vfsmount *mnt, struct dentry *entry,
 	return fuse_update_attributes(inode, stat, NULL, NULL);
 }
 
-static int fuse_setxattr(struct dentry *entry, const char *name,
-			 const void *value, size_t size, int flags)
+static int fuse_setxattr(struct dentry *unused, struct inode *inode,
+			 const char *name, const void *value,
+			 size_t size, int flags)
 {
-	struct inode *inode = entry->d_inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_req *req;
 	struct fuse_setxattr_in inarg;
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index ee95780..eb10bd8 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1851,10 +1851,10 @@ static int gfs2_getattr(struct vfsmount *mnt, struct dentry *dentry,
 	return 0;
 }
 
-static int gfs2_setxattr(struct dentry *dentry, const char *name,
-			 const void *data, size_t size, int flags)
+static int gfs2_setxattr(struct dentry *dentry, struct inode *inode,
+			 const char *name, const void *data, size_t size,
+			 int flags)
 {
-	struct inode *inode = dentry->d_inode;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	int ret;
@@ -1864,7 +1864,8 @@ static int gfs2_setxattr(struct dentry *dentry, const char *name,
 	if (ret == 0) {
 		ret = gfs2_rs_alloc(ip);
 		if (ret == 0)
-			ret = generic_setxattr(dentry, name, data, size, flags);
+			ret = generic_setxattr(dentry, inode, name, data,
+					       size, flags);
 		gfs2_glock_dq(&gh);
 	}
 	gfs2_holder_uninit(&gh);
diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c
index ce9719c..39b7123 100644
--- a/fs/hfs/attr.c
+++ b/fs/hfs/attr.c
@@ -13,10 +13,10 @@
 #include "hfs_fs.h"
 #include "btree.h"
 
-int hfs_setxattr(struct dentry *dentry, const char *name,
-		 const void *value, size_t size, int flags)
+int hfs_setxattr(struct dentry *unused, struct inode *inode,
+		 const char *name, const void *value,
+		 size_t size, int flags)
 {
-	struct inode *inode = dentry->d_inode;
 	struct hfs_find_data fd;
 	hfs_cat_rec rec;
 	struct hfs_cat_file *file;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index f234e2a..f052215 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -211,7 +211,7 @@ extern void hfs_evict_inode(struct inode *);
 extern void hfs_delete_inode(struct inode *);
 
 /* attr.c */
-extern int hfs_setxattr(struct dentry *dentry, const char *name,
+extern int hfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 			const void *value, size_t size, int flags);
 extern ssize_t hfs_getxattr(struct dentry *dentry, struct inode *inode,
 			    const char *name, void *value, size_t size);
diff --git a/fs/jfs/jfs_xattr.h b/fs/jfs/jfs_xattr.h
index e69e14f..01c47b1 100644
--- a/fs/jfs/jfs_xattr.h
+++ b/fs/jfs/jfs_xattr.h
@@ -54,8 +54,8 @@ struct jfs_ea_list {
 
 extern int __jfs_setxattr(tid_t, struct inode *, const char *, const void *,
 			  size_t, int);
-extern int jfs_setxattr(struct dentry *, const char *, const void *, size_t,
-			int);
+extern int jfs_setxattr(struct dentry *, struct inode *, const char *,
+			const void *, size_t, int);
 extern ssize_t __jfs_getxattr(struct inode *, const char *, void *, size_t);
 extern ssize_t jfs_getxattr(struct dentry *, struct inode *, const char *, void *, size_t);
 extern ssize_t jfs_listxattr(struct dentry *, char *, size_t);
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 7b9a8f9..a942358 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -846,10 +846,9 @@ int __jfs_setxattr(tid_t tid, struct inode *inode, const char *name,
 	return rc;
 }
 
-int jfs_setxattr(struct dentry *dentry, const char *name, const void *value,
-		 size_t value_len, int flags)
+int jfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
+		 const void *value, size_t value_len, int flags)
 {
-	struct inode *inode = dentry->d_inode;
 	struct jfs_inode_info *ji = JFS_IP(inode);
 	int rc;
 	tid_t tid;
@@ -860,7 +859,8 @@ int jfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	 * for it via sb->s_xattr.
 	 */
 	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_setxattr(dentry, name, value, value_len, flags);
+		return generic_setxattr(dentry, inode, name, value, value_len,
+					flags);
 
 	if ((rc = can_set_xattr(inode, name, value, value_len)))
 		return rc;
@@ -872,7 +872,7 @@ int jfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 
 	tid = txBegin(inode->i_sb, 0);
 	mutex_lock(&ji->commit_mutex);
-	rc = __jfs_setxattr(tid, dentry->d_inode, name, value, value_len,
+	rc = __jfs_setxattr(tid, inode, name, value, value_len,
 			    flags);
 	if (!rc)
 		rc = txCommit(tid, 1, &inode, 0);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 332ccaf..d422c76 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -169,10 +169,11 @@ static int kernfs_node_setsecdata(struct kernfs_node *kn, void **secdata,
 	return 0;
 }
 
-int kernfs_iop_setxattr(struct dentry *dentry, const char *name,
-			const void *value, size_t size, int flags)
+int kernfs_iop_setxattr(struct dentry *unused, struct inode *inode,
+			const char *name, const void *value,
+			size_t size, int flags)
 {
-	struct kernfs_node *kn = dentry->d_fsdata;
+	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
 	void *secdata;
 	int error;
@@ -184,11 +185,11 @@ int kernfs_iop_setxattr(struct dentry *dentry, const char *name,
 
 	if (!strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN)) {
 		const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
-		error = security_inode_setsecurity(dentry->d_inode, suffix,
+		error = security_inode_setsecurity(inode, suffix,
 						value, size, flags);
 		if (error)
 			return error;
-		error = security_inode_getsecctx(dentry->d_inode,
+		error = security_inode_getsecctx(inode,
 						&secdata, &secdata_len);
 		if (error)
 			return error;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 35b9ee1..b7469cf 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -82,7 +82,8 @@ int kernfs_iop_permission(struct inode *inode, int mask);
 int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr);
 int kernfs_iop_getattr(struct vfsmount *mnt, struct dentry *dentry,
 		       struct kstat *stat);
-int kernfs_iop_setxattr(struct dentry *dentry, const char *name, const void *value,
+int kernfs_iop_setxattr(struct dentry *dentry, struct inode *inode,
+			const char *name, const void *value,
 			size_t size, int flags);
 int kernfs_iop_removexattr(struct dentry *dentry, const char *name);
 ssize_t kernfs_iop_getxattr(struct dentry *dentry, struct inode *inode,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 04b5520..810969d 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -213,8 +213,9 @@ bool ovl_is_private_xattr(const char *name)
 	return strncmp(name, "trusted.overlay.", 14) == 0;
 }
 
-int ovl_setxattr(struct dentry *dentry, const char *name,
-		 const void *value, size_t size, int flags)
+int ovl_setxattr(struct dentry *dentry, struct inode *inode,
+		 const char *name, const void *value,
+		 size_t size, int flags)
 {
 	int err;
 	struct dentry *upperdentry;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 66b56ea..214baf0 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -159,8 +159,9 @@ void ovl_cache_free(struct list_head *list);
 /* inode.c */
 int ovl_setattr(struct dentry *dentry, struct iattr *attr);
 int ovl_permission(struct inode *inode, int mask);
-int ovl_setxattr(struct dentry *dentry, const char *name,
-		 const void *value, size_t size, int flags);
+int ovl_setxattr(struct dentry *dentry, struct inode *inode,
+		 const char *name, const void *value,
+		 size_t size, int flags);
 ssize_t ovl_getxattr(struct dentry *dentry, struct inode *inode,
 		     const char *name, void *value, size_t size);
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index b5d64cc..5251955 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -787,8 +787,8 @@ reiserfs_getxattr(struct dentry *dentry, struct inode *inode,
  * dentry->d_inode->i_mutex down
  */
 int
-reiserfs_setxattr(struct dentry *dentry, const char *name, const void *value,
-		  size_t size, int flags)
+reiserfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
+		  const void *value, size_t size, int flags)
 {
 	const struct xattr_handler *handler;
 
@@ -797,8 +797,8 @@ reiserfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	if (!handler || get_inode_sd_version(dentry->d_inode) == STAT_DATA_V1)
 		return -EOPNOTSUPP;
 
-	return handler->set(dentry, dentry->d_inode, name, value, size,
-			    flags, handler->flags);
+	return handler->set(dentry, inode, name, value, size, flags,
+			    handler->flags);
 }
 
 /*
diff --git a/fs/reiserfs/xattr.h b/fs/reiserfs/xattr.h
index 033bac1..0762779 100644
--- a/fs/reiserfs/xattr.h
+++ b/fs/reiserfs/xattr.h
@@ -20,8 +20,9 @@ int reiserfs_permission(struct inode *inode, int mask);
 #define has_xattr_dir(inode) (REISERFS_I(inode)->i_flags & i_has_xattr_dir)
 ssize_t reiserfs_getxattr(struct dentry *dentry, struct inode *inode,
 			  const char *name, void *buffer, size_t size);
-int reiserfs_setxattr(struct dentry *dentry, const char *name,
-		      const void *value, size_t size, int flags);
+int reiserfs_setxattr(struct dentry *dentry, struct inode *inode,
+		      const char *name, const void *value, size_t size,
+		      int flags);
 ssize_t reiserfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
 int reiserfs_removexattr(struct dentry *dentry, const char *name);
 
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index c35436f..7b022a9 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1748,7 +1748,7 @@ int ubifs_getattr(struct vfsmount *mnt, struct dentry *dentry,
 		  struct kstat *stat);
 
 /* xattr.c */
-int ubifs_setxattr(struct dentry *dentry, const char *name,
+int ubifs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 		   const void *value, size_t size, int flags);
 ssize_t ubifs_getxattr(struct dentry *dentry, struct inode *host,
 		       const char *name, void *buf, size_t size);
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 698194f..13104e4 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -294,10 +294,10 @@ static struct inode *iget_xattr(struct ubifs_info *c, ino_t inum)
 	return ERR_PTR(-EINVAL);
 }
 
-int ubifs_setxattr(struct dentry *dentry, const char *name,
+int ubifs_setxattr(struct dentry *dentry, struct inode *host, const char *name,
 		   const void *value, size_t size, int flags)
 {
-	struct inode *inode, *host = dentry->d_inode;
+	struct inode *inode;
 	struct ubifs_info *c = host->i_sb->s_fs_info;
 	struct qstr nm = QSTR_INIT(name, strlen(name));
 	struct ubifs_dent_node *xent;
diff --git a/fs/xattr.c b/fs/xattr.c
index 87bd926..d6351cb 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -100,7 +100,7 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	if (issec)
 		inode->i_flags &= ~S_NOSEC;
 	if (inode->i_op->setxattr) {
-		error = inode->i_op->setxattr(dentry, name, value, size, flags);
+		error = inode->i_op->setxattr(dentry, inode, name, value, size, flags);
 		if (!error) {
 			fsnotify_xattr(dentry);
 			security_inode_post_setxattr(dentry, name, value,
@@ -764,7 +764,8 @@ generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
  * Find the handler for the prefix and dispatch its set() operation.
  */
 int
-generic_setxattr(struct dentry *dentry, const char *name, const void *value, size_t size, int flags)
+generic_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
+		 const void *value, size_t size, int flags)
 {
 	const struct xattr_handler *handler;
 
@@ -773,8 +774,8 @@ generic_setxattr(struct dentry *dentry, const char *name, const void *value, siz
 	handler = xattr_resolve_name(dentry->d_sb->s_xattr, &name);
 	if (!handler)
 		return -EOPNOTSUPP;
-	return handler->set(dentry, dentry->d_inode, name, value, size,
-			    flags, handler->flags);
+	return handler->set(dentry, inode, name, value, size, flags,
+			    handler->flags);
 }
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7586207..ba463aa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1537,7 +1537,8 @@ struct inode_operations {
 			struct inode *, struct dentry *, unsigned int);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
-	int (*setxattr) (struct dentry *, const char *,const void *,size_t,int);
+	int (*setxattr) (struct dentry *, struct inode *,
+			 const char *, const void *, size_t, int);
 	ssize_t (*getxattr) (struct dentry *, struct inode *,
 			     const char *, void *, size_t);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 0027b04..ac6e270 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -46,7 +46,8 @@ int vfs_removexattr(struct dentry *, const char *);
 
 ssize_t generic_getxattr(struct dentry *dentry, struct inode *inode, const char *name, void *buffer, size_t size);
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
-int generic_setxattr(struct dentry *dentry, const char *name, const void *value, size_t size, int flags);
+int generic_setxattr(struct dentry *dentry, struct inode *inode,
+		     const char *name, const void *value, size_t size, int flags);
 int generic_removexattr(struct dentry *dentry, const char *name);
 ssize_t vfs_getxattr_alloc(struct dentry *dentry, const char *name,
 			   char **xattr_value, size_t size, gfp_t flags);
diff --git a/mm/shmem.c b/mm/shmem.c
index 8be47d4..f926e5e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2597,10 +2597,11 @@ static ssize_t shmem_getxattr(struct dentry *dentry, struct inode *inode,
 	return simple_xattr_get(&info->xattrs, name, buffer, size);
 }
 
-static int shmem_setxattr(struct dentry *dentry, const char *name,
-			  const void *value, size_t size, int flags)
+static int shmem_setxattr(struct dentry *dentry, struct inode *inode,
+			  const char *name, const void *value, size_t size,
+			  int flags)
 {
-	struct shmem_inode_info *info = SHMEM_I(dentry->d_inode);
+	struct shmem_inode_info *info = SHMEM_I(inode);
 	int err;
 
 	/*
@@ -2609,7 +2610,8 @@ static int shmem_setxattr(struct dentry *dentry, const char *name,
 	 * for it via sb->s_xattr.
 	 */
 	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return generic_setxattr(dentry, name, value, size, flags);
+		return generic_setxattr(dentry, inode, name, value, size,
+					flags);
 
 	err = shmem_xattr_validate(name);
 	if (err)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 764e521..444a619 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3139,7 +3139,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 			 */
 			if (isp->smk_flags & SMK_INODE_CHANGED) {
 				isp->smk_flags &= ~SMK_INODE_CHANGED;
-				rc = inode->i_op->setxattr(dp,
+				rc = inode->i_op->setxattr(dp, inode,
 					XATTR_NAME_SMACKTRANSMUTE,
 					TRANS_TRUE, TRANS_TRUE_SIZE,
 					0);
-- 
1.7.4.1

