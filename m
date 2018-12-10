Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1860EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EE52082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EE52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeLJRRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:17:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0D1930001DF;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 787AA605C5;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B170C224278; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 44/52] fuse: Clear setuid bit even in direct I/O path
Date:   Mon, 10 Dec 2018 12:13:10 -0500
Message-Id: <20181210171318.16998-45-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With cache=never, we fall back to direct IO. pjdfstest chmod test 12.t was
failing because if a file has setuid bit, it should be cleared if an
unpriviledged user opens it for write and writes to it.

Call fuse_remove_privs() even for direct I/O path.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index cb28cf26a6e7..0be5a7380b3c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1679,13 +1679,25 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* Don't allow parallel writes to the same file */
 	inode_lock(inode);
 	res = generic_write_checks(iocb, from);
-	if (res > 0)
-		res = fuse_direct_io(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
+	if (res < 0)
+		goto out_invalidate;
+
+	res = file_remove_privs(iocb->ki_filp);
+	if (res)
+		goto out_invalidate;
+
+	res = fuse_direct_io(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
+	if (res < 0)
+		goto out_invalidate;
+
 	fuse_invalidate_attr(inode);
-	if (res > 0)
-		fuse_write_update_size(inode, iocb->ki_pos);
+	fuse_write_update_size(inode, iocb->ki_pos);
 	inode_unlock(inode);
+	return res;
 
+out_invalidate:
+	fuse_invalidate_attr(inode);
+	inode_unlock(inode);
 	return res;
 }
 
-- 
2.13.6

