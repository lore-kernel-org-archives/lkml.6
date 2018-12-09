Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBE8C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E897020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E897020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeLIVzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35566 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbeLIVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:27 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72q-0002ib-Cp; Sun, 09 Dec 2018 21:55:24 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72m-0003hr-0m; Sun, 09 Dec 2018 21:55:20 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, kanda.motohiro@gmail.com,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Dave Chinner" <dchinner@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.761738366@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 327/328] xfs: don't fail when converting shortform
 attr to long form during ATTR_REPLACE
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Darrick J. Wong" <darrick.wong@oracle.com>

commit 7b38460dc8e4eafba06c78f8e37099d3b34d473c upstream.

Kanda Motohiro reported that expanding a tiny xattr into a large xattr
fails on XFS because we remove the tiny xattr from a shortform fork and
then try to re-add it after converting the fork to extents format having
not removed the ATTR_REPLACE flag.  This fails because the attr is no
longer present, causing a fs shutdown.

This is derived from the patch in his bug report, but we really
shouldn't ignore a nonzero retval from the remove call.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199119
Reported-by: kanda.motohiro@gmail.com
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/xfs/xfs_attr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/xfs/xfs_attr.c
+++ b/fs/xfs/xfs_attr.c
@@ -540,7 +540,14 @@ xfs_attr_shortform_addname(xfs_da_args_t
 		if (args->flags & ATTR_CREATE)
 			return(retval);
 		retval = xfs_attr_shortform_remove(args);
-		ASSERT(retval == 0);
+		if (retval)
+			return retval;
+		/*
+		 * Since we have removed the old attr, clear ATTR_REPLACE so
+		 * that the leaf format add routine won't trip over the attr
+		 * not being around.
+		 */
+		args->flags &= ~ATTR_REPLACE;
 	}
 
 	if (args->namelen >= XFS_ATTR_SF_ENTSIZE_MAX ||

