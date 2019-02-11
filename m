Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8347C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88CF21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900304;
	bh=CvxiI0nAxvN+iYp7nAoz9JMbZ6ZRnka4PQCjBLnkrUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RvhfsyJ8yKrK03QqNHQebg+c4KorxrcNZDN8/ytMnmggE4n0l4B855Om5xqXP67Qg
	 bfaOu8LWkNvAxavVcLKuOTPd1ciZISR0j0FcHViqUptrTcB+c2jGeiOVKWM+MYEVZe
	 CZ8cNSGWrlvUuO8qVvyuLKsPqB1AW1DrlOxpla+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfBKPvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731553AbfBKOhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE18D20844;
        Mon, 11 Feb 2019 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895873;
        bh=CvxiI0nAxvN+iYp7nAoz9JMbZ6ZRnka4PQCjBLnkrUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0K5S66hmZOADU2UW/Eb0lznOWrdTXgOkRLxnhJkjh+5iTwyxWUHOdQdZr5cans1wC
         qNY9m/Mbh/BJYasP5KFCAAzY0ooUxKoVH+oA7xzOIy651afbknischMfHOsivarqeE
         qXm0dYtuGXBCR2QZRluJvMjnG2qWqiWtd1IMaxWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.20 352/352] nfsd: Fix error return values for nfsd4_clone_file_range()
Date:   Mon, 11 Feb 2019 15:19:39 +0100
Message-Id: <20190211141909.565234680@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trondmy@gmail.com>

commit e3fdc89ca47ef34dfb6fd5101fec084c3dba5486 upstream.

If the parameter 'count' is non-zero, nfsd4_clone_file_range() will
currently clobber all errors returned by vfs_clone_file_range() and
replace them with EINVAL.

Fixes: 42ec3d4c0218 ("vfs: make remap_file_range functions take and...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/vfs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -544,9 +544,11 @@ __be32 nfsd4_clone_file_range(struct fil
 	loff_t cloned;
 
 	cloned = vfs_clone_file_range(src, src_pos, dst, dst_pos, count, 0);
+	if (cloned < 0)
+		return nfserrno(cloned);
 	if (count && cloned != count)
-		cloned = -EINVAL;
-	return nfserrno(cloned < 0 ? cloned : 0);
+		return nfserrno(-EINVAL);
+	return 0;
 }
 
 ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,


