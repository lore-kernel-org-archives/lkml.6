Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbeE3TuL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:50:11 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:37634
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932246AbeE3TuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:50:02 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 12/15] CIFS: Pass page offset for encrypting
Date: Wed, 30 May 2018 12:48:04 -0700
Message-Id: <20180530194807.31657-13-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530194807.31657-1-longli@linuxonhyperv.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfAn3YKoohboZ4kBQO0p1jn6WfOA4Mt3/PBMV3NVdeAzof2PdaKxw46LF8OTiK7Cy6jA/BFFL9e1r+xMXP1BOZ13Au7CQBu4PQRYCh3rkBIlrl3Ctxxh6
 crF9XUkxMzEeOhaN0ufj21xk/4Z7sRAr4XPc2teAGS8ebH7Epnp5rIpXS8PBy5iuU4Bc4csayuQzyIWS+Yk8UaK20YId16bzl8PTk+T/1FNiRYyLtV/0wVsX
 YIFA02mPID8pdIQg5fOIf43HM9LM5PLqkwjaqbMw+H4q64qtYKN6Edgqivfk1cAeFoAmMGOQREP0KrV/fBPPaVmRUw6/xzlKW0epiZN+rupHPZl1zzygYr0g
 6ivjoyrX1NpWJFAzEKHtlHqnnb/E101mBFWN4URXY/S5BHiX2xcRBvwstYPzLwxfh9YBbbXL
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

Encryption function needs to read data starting page offset from input
buffer.

This doesn't affect decryption path since it allocates its own page
buffers.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smb2ops.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 1fa1c29..38d19b6 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2189,9 +2189,10 @@ init_sg(struct smb_rqst *rqst, u8 *sign)
 		smb2_sg_set_buf(&sg[i], rqst->rq_iov[i].iov_base,
 						rqst->rq_iov[i].iov_len);
 	for (j = 0; i < sg_len - 1; i++, j++) {
-		unsigned int len = (j < rqst->rq_npages - 1) ? rqst->rq_pagesz
-							: rqst->rq_tailsz;
-		sg_set_page(&sg[i], rqst->rq_pages[j], len, 0);
+		unsigned int len, offset;
+
+		rqst_page_get_length(rqst, j, &len, &offset);
+		sg_set_page(&sg[i], rqst->rq_pages[j], len, offset);
 	}
 	smb2_sg_set_buf(&sg[sg_len - 1], sign, SMB2_SIGNATURE_SIZE);
 	return sg;
@@ -2332,6 +2333,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, struct smb_rqst *new_rq,
 		return rc;
 
 	new_rq->rq_pages = pages;
+	new_rq->rq_offset = old_rq->rq_offset;
 	new_rq->rq_npages = old_rq->rq_npages;
 	new_rq->rq_pagesz = old_rq->rq_pagesz;
 	new_rq->rq_tailsz = old_rq->rq_tailsz;
@@ -2363,10 +2365,14 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, struct smb_rqst *new_rq,
 
 	/* copy pages form the old */
 	for (i = 0; i < npages; i++) {
-		char *dst = kmap(new_rq->rq_pages[i]);
-		char *src = kmap(old_rq->rq_pages[i]);
-		unsigned int len = (i < npages - 1) ? new_rq->rq_pagesz :
-							new_rq->rq_tailsz;
+		char *dst, *src;
+		unsigned int offset, len;
+
+		rqst_page_get_length(new_rq, i, &len, &offset);
+
+		dst = (char *) kmap(new_rq->rq_pages[i]) + offset;
+		src = (char *) kmap(old_rq->rq_pages[i]) + offset;
+
 		memcpy(dst, src, len);
 		kunmap(new_rq->rq_pages[i]);
 		kunmap(old_rq->rq_pages[i]);
-- 
2.7.4
