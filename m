Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C93C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC9820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC9820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeLIWPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:15:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38164 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727187AbeLIWPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:15:13 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73F-0002iZ-Ke; Sun, 09 Dec 2018 21:55:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003Nh-5k; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dominique Martinet" <dominique.martinet@cea.fr>,
        "Eric Van Hensbergen" <ericvh@gmail.com>,
        "Ron Minnich" <rminnich@sandia.gov>,
        "Latchesar Ionkov" <lucho@ionkov.net>,
        "piaojun" <piaojun@huawei.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.910749847@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 130/328] fs/9p/xattr.c: catch the error of
 p9_client_clunk when setting xattr failed
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

From: piaojun <piaojun@huawei.com>

commit 3111784bee81591ea2815011688d28b65df03627 upstream.

In my testing, v9fs_fid_xattr_set will return successfully even if the
backend ext4 filesystem has no space to store xattr key-value. That will
cause inconsistent behavior between front end and back end. The reason is
that lsetxattr will be triggered by p9_client_clunk, and unfortunately we
did not catch the error. This patch will catch the error to notify upper
caller.

p9_client_clunk (in 9p)
  p9_client_rpc(clnt, P9_TCLUNK, "d", fid->fid);
    v9fs_clunk (in qemu)
      put_fid
        free_fid
          v9fs_xattr_fid_clunk
            v9fs_co_lsetxattr
              s->ops->lsetxattr
                ext4_xattr_user_set (in host ext4 filesystem)

Link: http://lkml.kernel.org/r/5B57EACC.2060900@huawei.com
Signed-off-by: Jun Piao <piaojun@huawei.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Ron Minnich <rminnich@sandia.gov>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/9p/xattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -121,7 +121,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fi
 		   const void *value, size_t value_len, int flags)
 {
 	u64 offset = 0;
-	int retval, msize, write_count;
+	int retval, err, msize, write_count;
 
 	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu flags = %d\n",
 		 name, value_len, flags);
@@ -158,7 +158,9 @@ int v9fs_fid_xattr_set(struct p9_fid *fi
 	}
 	retval = 0;
 err:
-	p9_client_clunk(fid);
+	err = p9_client_clunk(fid);
+	if (!retval && err)
+		retval = err;
 	return retval;
 }
 

