Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B577AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684B72083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684B72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbeIHCP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:15:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeIHCP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:15:56 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 905C8D6B;
        Fri,  7 Sep 2018 21:33:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Piao <piaojun@huawei.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 4.9 15/63] fs/9p/xattr.c: catch the error of p9_client_clunk when setting xattr failed
Date:   Fri,  7 Sep 2018 23:09:46 +0200
Message-Id: <20180907211013.846927384@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/9p/xattr.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -105,7 +105,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fi
 {
 	struct kvec kvec = {.iov_base = (void *)value, .iov_len = value_len};
 	struct iov_iter from;
-	int retval;
+	int retval, err;
 
 	iov_iter_kvec(&from, WRITE | ITER_KVEC, &kvec, 1, value_len);
 
@@ -126,7 +126,9 @@ int v9fs_fid_xattr_set(struct p9_fid *fi
 			 retval);
 	else
 		p9_client_write(fid, 0, &from, &retval);
-	p9_client_clunk(fid);
+	err = p9_client_clunk(fid);
+	if (!retval && err)
+		retval = err;
 	return retval;
 }
 


