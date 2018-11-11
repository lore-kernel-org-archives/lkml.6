Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF8C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691BD21508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691BD21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbeKLFsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50704 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730488AbeKLFsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:24 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsk-0000tu-0Y; Sun, 11 Nov 2018 19:58:54 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001qF-M6; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Yan, Zheng" <zyan@redhat.com>,
        "Bryan Henderson" <bryanh@giraffe-data.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.343995860@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 325/366] ceph: use lookup request to revalidate dentry
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Yan, Zheng" <zyan@redhat.com>

commit 200fd27c8fa2ba8bb4529033967b69a7cbfa2c2e upstream.

If dentry has no lease, ceph_d_revalidate() previously return 0.
This causes VFS to invalidate the dentry and create a new dentry
for later lookup. Invalidating a dentry also detach any underneath
mount points. So mount point inside cephfs can disapear mystically
(even the mount point is not modified by other hosts).

The fix is using lookup request to revalidate dentry without lease.
This can partly solve the mount points disapear issue (as long as
the mount point is not modified by other hosts)

Signed-off-by: Yan, Zheng <zyan@redhat.com>
Cc: Bryan Henderson <bryanh@giraffe-data.com>
[bwh: Backported to 3.16: Add the ceph_security_xattr_wanted() function]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ceph/dir.c   | 34 ++++++++++++++++++++++++++++++++++
 fs/ceph/inode.c |  1 +
 2 files changed, 35 insertions(+)

--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1064,6 +1064,40 @@ static int ceph_d_revalidate(struct dent
 			valid = 1;
 	}
 
+	if (!valid) {
+		struct ceph_mds_client *mdsc =
+			ceph_sb_to_client(dir->i_sb)->mdsc;
+		struct ceph_mds_request *req;
+		int op, mask, err;
+
+		op = ceph_snap(dir) == CEPH_SNAPDIR ?
+			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_LOOKUP;
+		req = ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);
+		if (!IS_ERR(req)) {
+			req->r_dentry = dget(dentry);
+			req->r_num_caps = 2;
+
+			mask = CEPH_STAT_CAP_INODE | CEPH_CAP_AUTH_SHARED;
+			if (ceph_security_xattr_wanted(dir))
+				mask |= CEPH_CAP_XATTR_SHARED;
+			req->r_args.getattr.mask = mask;
+
+			req->r_locked_dir = dir;
+			err = ceph_mdsc_do_request(mdsc, NULL, req);
+			if (err == 0 || err == -ENOENT) {
+				if (dentry == req->r_dentry) {
+					valid = !d_unhashed(dentry);
+				} else {
+					d_invalidate(req->r_dentry);
+					err = -EAGAIN;
+				}
+			}
+			ceph_mdsc_put_request(req);
+			dout("d_revalidate %p lookup result=%d\n",
+			     dentry, err);
+		}
+	}
+
 	dout("d_revalidate %p %s\n", dentry, valid ? "valid" : "invalid");
 	if (valid) {
 		ceph_dentry_lru_touch(dentry);
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1251,6 +1251,7 @@ retry_lookup:
 			dout(" %p links to %p %llx.%llx, not %llx.%llx\n",
 			     dn, dn->d_inode, ceph_vinop(dn->d_inode),
 			     ceph_vinop(in));
+			d_invalidate(dn);
 			have_lease = false;
 		}
 
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -736,6 +736,15 @@ extern void __ceph_destroy_xattrs(struct
 extern void __init ceph_xattr_init(void);
 extern void ceph_xattr_exit(void);
 
+#ifdef CONFIG_SECURITY
+extern bool ceph_security_xattr_wanted(struct inode *in);
+#else
+static inline bool ceph_security_xattr_wanted(struct inode *in)
+{
+	return false;
+}
+#endif
+
 /* acl.c */
 extern const struct xattr_handler *ceph_xattr_handlers[];
 
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1128,3 +1128,10 @@ int ceph_removexattr(struct dentry *dent
 
 	return __ceph_removexattr(dentry, name);
 }
+
+#ifdef CONFIG_SECURITY
+bool ceph_security_xattr_wanted(struct inode *in)
+{
+	return in->i_security != NULL;
+}
+#endif

