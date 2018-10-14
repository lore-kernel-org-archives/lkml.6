Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A6BC7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617A720645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617A720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeJNXqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:46:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35655 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbeJNXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0004cS-FO; Sun, 14 Oct 2018 16:30:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000Lg-Ol; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Yan, Zheng" <zyan@redhat.com>,
        "Ilya Dryomov" <idryomov@gmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.646783338@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 153/366] ceph: always update atime/mtime/ctime for
 new inode
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Yan, Zheng" <zyan@redhat.com>

commit ffdeec7aa41aa61ca4ee68fddf4669df9ce661d1 upstream.

For new inode, atime/mtime/ctime are uninitialized.  Don't compare
against them.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ceph/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -599,13 +599,15 @@ void ceph_fill_file_time(struct inode *i
 		      CEPH_CAP_FILE_BUFFER|
 		      CEPH_CAP_AUTH_EXCL|
 		      CEPH_CAP_XATTR_EXCL)) {
-		if (timespec_compare(ctime, &inode->i_ctime) > 0) {
+		if (ci->i_version == 0 ||
+		    timespec_compare(ctime, &inode->i_ctime) > 0) {
 			dout("ctime %ld.%09ld -> %ld.%09ld inc w/ cap\n",
 			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
 			     ctime->tv_sec, ctime->tv_nsec);
 			inode->i_ctime = *ctime;
 		}
-		if (ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
+		if (ci->i_version == 0 ||
+		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
 			/* the MDS did a utimes() */
 			dout("mtime %ld.%09ld -> %ld.%09ld "
 			     "tw %d -> %d\n",
@@ -719,7 +721,6 @@ static int fill_inode(struct inode *inod
 	new_issued = ~issued & le32_to_cpu(info->cap.caps);
 
 	/* update inode */
-	ci->i_version = le64_to_cpu(info->version);
 	inode->i_version++;
 	inode->i_rdev = le32_to_cpu(info->rdev);
 	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
@@ -779,6 +780,9 @@ static int fill_inode(struct inode *inod
 		xattr_blob = NULL;
 	}
 
+	/* finally update i_version */
+	ci->i_version = le64_to_cpu(info->version);
+
 	inode->i_mapping->a_ops = &ceph_aops;
 	inode->i_mapping->backing_dev_info =
 		&ceph_sb_to_client(inode->i_sb)->backing_dev_info;

