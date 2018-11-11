Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212F8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B2820818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B2820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbeKLFsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50604 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729628AbeKLFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:23 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsi-0000l9-Nu; Sun, 11 Nov 2018 19:58:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001qK-No; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jeff Layton" <jlayton@redhat.com>,
        "Donatas Abraitis" <donatas.abraitis@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>,
        "Bryan Henderson" <bryanh@giraffe-data.com>,
        "Ilya Dryomov" <idryomov@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.835092825@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 326/366] ceph: don't set req->r_locked_dir in
 ceph_d_revalidate
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

From: Jeff Layton <jlayton@redhat.com>

commit c3f4688a08fd86f1bf8e055724c84b7a40a09733 upstream.

This function sets req->r_locked_dir which is supposed to indicate to
ceph_fill_trace that the parent's i_rwsem is locked for write.
Unfortunately, there is no guarantee that the dir will be locked when
d_revalidate is called, so we really don't want ceph_fill_trace to do
any dcache manipulation from this context. Clear req->r_locked_dir since
it's clearly not safe to do that.

What we really want to know with d_revalidate is whether the dentry
still points to the same inode. ceph_fill_trace installs a pointer to
the inode in req->r_target_inode, so we can just compare that to
d_inode(dentry) to see if it's the same one after the lookup.

Also, since we aren't generally interested in the parent here, we can
switch to using a GETATTR to hint that to the MDS, which also means that
we only need to reserve one cap.

Finally, just remove the d_unhashed check. That's really outside the
purview of a filesystem's d_revalidate. If the thing became unhashed
while we're checking it, then that's up to the VFS to handle anyway.

Fixes: 200fd27c8fa2 ("ceph: use lookup request to revalidate dentry")
Link: http://tracker.ceph.com/issues/18041
Reported-by: Donatas Abraitis <donatas.abraitis@gmail.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Cc: Bryan Henderson <bryanh@giraffe-data.com>
[bwh: Backported to 3.16: s/d_really_is_(positive|negative)/d_is_\1/ since
 we don't have to consider overlayfs]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ceph/dir.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1071,26 +1071,30 @@ static int ceph_d_revalidate(struct dent
 		int op, mask, err;
 
 		op = ceph_snap(dir) == CEPH_SNAPDIR ?
-			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_LOOKUP;
+			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_GETATTR;
 		req = ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);
 		if (!IS_ERR(req)) {
 			req->r_dentry = dget(dentry);
-			req->r_num_caps = 2;
+			req->r_num_caps = op == CEPH_MDS_OP_GETATTR ? 1 : 2;
 
 			mask = CEPH_STAT_CAP_INODE | CEPH_CAP_AUTH_SHARED;
 			if (ceph_security_xattr_wanted(dir))
 				mask |= CEPH_CAP_XATTR_SHARED;
 			req->r_args.getattr.mask = mask;
 
-			req->r_locked_dir = dir;
 			err = ceph_mdsc_do_request(mdsc, NULL, req);
-			if (err == 0 || err == -ENOENT) {
-				if (dentry == req->r_dentry) {
-					valid = !d_unhashed(dentry);
-				} else {
-					d_invalidate(req->r_dentry);
-					err = -EAGAIN;
-				}
+			switch (err) {
+			case 0:
+				if (d_is_positive(dentry) &&
+				    d_inode(dentry) == req->r_target_inode)
+					valid = 1;
+				break;
+			case -ENOENT:
+				if (d_is_negative(dentry))
+					valid = 1;
+				/* Fallthrough */
+			default:
+				break;
 			}
 			ceph_mdsc_put_request(req);
 			dout("d_revalidate %p lookup result=%d\n",

