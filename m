Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeE3TwM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:52:12 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:37634
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932251AbeE3Ttw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:49:52 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 07/15] CIFS: When sending data on socket, pass the correct page offset
Date: Wed, 30 May 2018 12:47:59 -0700
Message-Id: <20180530194807.31657-8-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530194807.31657-1-longli@linuxonhyperv.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfO8CRb4B9gkMMC+3Kk7nmLvb1eLbHisriOoSpwinepjpeNH3pTC19tHDS3ndrePv3yW3mFFJOd8WeXKhjnfbFnVfs59BMXf8RGEpkI0tXES25Dm9xyYt
 z5IZzT7YLNhg3A5RM8z9HkALCDyggSU3iS2nSrJSwgzvjEaazCKPcRM9+9Yd7vGQhBTnDk5y32XJ9ifldv5M4RmnVqwfHmZpu/ppR1O6N09Z99HGg/fyARPj
 ciiGSlaiHBXjrq2fXzhaZ/DzboNn7P3q2Eyxwko8H6HhUewLiwmkpEJcF80dZ8LnxBfIQo7ofjm2T/KBjg1ot6Kj2pmHqI1uhCeg7k97tJu8PqfueAok2ZeV
 CTANKB0T8hXUEk3WH3gUhdvFBvboiHyl4ZrEwpijCTA/+4/gKN1VsQZ9crtiyUq1GXgHdT1K
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

It's possible that the offset is non-zero in the page to send, change the
function to pass this offset to socket.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/transport.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index d6b5523..5c96ee8 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -288,15 +288,13 @@ __smb_send_rqst(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 
 	/* now walk the page array and send each page in it */
 	for (i = 0; i < rqst->rq_npages; i++) {
-		size_t len = i == rqst->rq_npages - 1
-				? rqst->rq_tailsz
-				: rqst->rq_pagesz;
-		struct bio_vec bvec = {
-			.bv_page = rqst->rq_pages[i],
-			.bv_len = len
-		};
+		struct bio_vec bvec;
+
+		bvec.bv_page = rqst->rq_pages[i];
+		rqst_page_get_length(rqst, i, &bvec.bv_len, &bvec.bv_offset);
+
 		iov_iter_bvec(&smb_msg.msg_iter, WRITE | ITER_BVEC,
-			      &bvec, 1, len);
+			      &bvec, 1, bvec.bv_len);
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
 			break;
-- 
2.7.4
