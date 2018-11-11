Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BBFC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A3220818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbeKLGSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:18:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50594 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729629AbeKLFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:23 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsi-0000l8-MK; Sun, 11 Nov 2018 19:58:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001qP-PT; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Sage Weil" <sage@redhat.com>,
        "Jeff Layton" <jlayton@redhat.com>,
        "Bryan Henderson" <bryanh@giraffe-data.com>,
        "Ilya Dryomov" <idryomov@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.29486707@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 327/366] ceph: fix endianness of getattr mask in
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

commit 1097680d759918ce4a8705381c0ab2ed7bd60cf1 upstream.

sparse says:

    fs/ceph/dir.c:1248:50: warning: incorrect type in assignment (different base types)
    fs/ceph/dir.c:1248:50:    expected restricted __le32 [usertype] mask
    fs/ceph/dir.c:1248:50:    got int [signed] [assigned] mask

Fixes: 200fd27c8fa2 ("ceph: use lookup request to revalidate dentry")
Signed-off-by: Jeff Layton <jlayton@redhat.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Cc: Bryan Henderson <bryanh@giraffe-data.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ceph/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1068,7 +1068,8 @@ static int ceph_d_revalidate(struct dent
 		struct ceph_mds_client *mdsc =
 			ceph_sb_to_client(dir->i_sb)->mdsc;
 		struct ceph_mds_request *req;
-		int op, mask, err;
+		int op, err;
+		u32 mask;
 
 		op = ceph_snap(dir) == CEPH_SNAPDIR ?
 			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_GETATTR;
@@ -1080,7 +1081,7 @@ static int ceph_d_revalidate(struct dent
 			mask = CEPH_STAT_CAP_INODE | CEPH_CAP_AUTH_SHARED;
 			if (ceph_security_xattr_wanted(dir))
 				mask |= CEPH_CAP_XATTR_SHARED;
-			req->r_args.getattr.mask = mask;
+			req->r_args.getattr.mask = cpu_to_le32(mask);
 
 			err = ceph_mdsc_do_request(mdsc, NULL, req);
 			switch (err) {

