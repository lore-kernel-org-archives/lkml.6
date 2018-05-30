Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbeE3Ttz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:49:55 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:51060
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932237AbeE3Ttt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:49:49 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 08/15] CIFS: SMBD: Support page offset in RDMA send
Date: Wed, 30 May 2018 12:48:00 -0700
Message-Id: <20180530194807.31657-9-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530194807.31657-1-longli@linuxonhyperv.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfPcgvQofKi5rY9GShqFu8E5FzrtTGr9bk/wrj/vvvV0h/fXUZ8kw7W8e+vRWst8kTY/Cc84DudGUCXsVFUcuPxigGSFP+3bPsMnkPp8GHM2srJ6wScS3
 phW0DdrL+IG+/jYyUWMG2anVYImzhzPaBU3YRufx2MqaYwlMnczGpglr1/LXqFD5cSCRMkdxzFRu4pLgjvQOoUdjHUEzoGVc2d04FFVS/8h5FkL7CN544Cne
 7h/mqXKKOTkNmWJTubEy8trrrx3peLbYUgYRzFcMHrna14TIxo1QhIT/77uM77tYIpfPWvY9Z0iBrnW0IcE7jRKJgRv2iaiRXtiD4sFL8GYn5oMDJaXsSq/b
 KfwFnRhBOZd58Ki7UgN9lMTLu2SfAYs2MBlrm3hc7RYTAR5PEAwch8wy+6Ga2igGc4JYGiHt
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

The RDMA send function needs to look at offset in the request pages, and
send data starting from there.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index c62f7c9..6141e3c 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -17,6 +17,7 @@
 #include <linux/highmem.h>
 #include "smbdirect.h"
 #include "cifs_debug.h"
+#include "cifsproto.h"
 
 static struct smbd_response *get_empty_queue_buffer(
 		struct smbd_connection *info);
@@ -2082,7 +2083,7 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 	struct kvec vec;
 	int nvecs;
 	int size;
-	int buflen = 0, remaining_data_length;
+	unsigned int buflen = 0, remaining_data_length;
 	int start, i, j;
 	int max_iov_size =
 		info->max_send_size - sizeof(struct smbd_data_transfer);
@@ -2113,10 +2114,17 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 		buflen += iov[i].iov_len;
 	}
 
-	/* add in the page array if there is one */
+	/*
+	 * Add in the page array if there is one. The caller needs to set
+	 * rq_tailsz to PAGE_SIZE when the buffer has multiple pages and
+	 * ends at page boundary
+	 */
 	if (rqst->rq_npages) {
-		buflen += rqst->rq_pagesz * (rqst->rq_npages - 1);
-		buflen += rqst->rq_tailsz;
+		if (rqst->rq_npages == 1)
+			buflen += rqst->rq_tailsz;
+		else
+			buflen += rqst->rq_pagesz * (rqst->rq_npages - 1) -
+					rqst->rq_offset + rqst->rq_tailsz;
 	}
 
 	if (buflen + sizeof(struct smbd_data_transfer) >
@@ -2213,8 +2221,9 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 
 	/* now sending pages if there are any */
 	for (i = 0; i < rqst->rq_npages; i++) {
-		buflen = (i == rqst->rq_npages-1) ?
-			rqst->rq_tailsz : rqst->rq_pagesz;
+		unsigned int offset;
+
+		rqst_page_get_length(rqst, i, &buflen, &offset);
 		nvecs = (buflen + max_iov_size - 1) / max_iov_size;
 		log_write(INFO, "sending pages buflen=%d nvecs=%d\n",
 			buflen, nvecs);
@@ -2225,9 +2234,11 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 			remaining_data_length -= size;
 			log_write(INFO, "sending pages i=%d offset=%d size=%d"
 				" remaining_data_length=%d\n",
-				i, j*max_iov_size, size, remaining_data_length);
+				i, j*max_iov_size+offset, size,
+				remaining_data_length);
 			rc = smbd_post_send_page(
-				info, rqst->rq_pages[i], j*max_iov_size,
+				info, rqst->rq_pages[i],
+				j*max_iov_size + offset,
 				size, remaining_data_length);
 			if (rc)
 				goto done;
-- 
2.7.4
