Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeE3TwI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:52:08 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:37636
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932252AbeE3Ttw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:49:52 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 05/15] CIFS: Calculate the correct request length based on page offset and tail size
Date: Wed, 30 May 2018 12:47:57 -0700
Message-Id: <20180530194807.31657-6-longli@linuxonhyperv.com>
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

It's possible that the page offset is non-zero in the pages in a request,
change the function to calculate the correct data buffer length.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/transport.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 927226a..d6b5523 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -212,10 +212,24 @@ rqst_len(struct smb_rqst *rqst)
 	for (i = 0; i < rqst->rq_nvec; i++)
 		buflen += iov[i].iov_len;
 
-	/* add in the page array if there is one */
+	/*
+	 * Add in the page array if there is one. The caller needs to make
+	 * sure rq_offset and rq_tailsz are set correctly. If a buffer of
+	 * multiple pages ends at page boundary, rq_tailsz needs to be set to
+	 * PAGE_SIZE.
+	 */
 	if (rqst->rq_npages) {
-		buflen += rqst->rq_pagesz * (rqst->rq_npages - 1);
-		buflen += rqst->rq_tailsz;
+		if (rqst->rq_npages == 1)
+			buflen += rqst->rq_tailsz;
+		else {
+			/*
+			 * If there is more than one page, calculate the
+			 * buffer length based on rq_offset and rq_tailsz
+			 */
+			buflen += rqst->rq_pagesz * (rqst->rq_npages - 1) -
+					rqst->rq_offset;
+			buflen += rqst->rq_tailsz;
+		}
 	}
 
 	return buflen;
-- 
2.7.4
