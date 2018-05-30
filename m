Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932329AbeE3TuG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:50:06 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:60154
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932295AbeE3Tt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:49:58 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 11/15] CIFS: Pass page offset for calculating signature
Date: Wed, 30 May 2018 12:48:03 -0700
Message-Id: <20180530194807.31657-12-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530194807.31657-1-longli@linuxonhyperv.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfDibnuFYbLcY2kO/XljN2SKYBCz+plOqslMOuLT2xRN13brMygYq7RgUSLiUOfRqUswktyft64Wu9NIrxZ7/em2rILIIxw9wsLyMhQvQrf/38mzbTaN+
 SaGiJLcCz/1A6nY+Zjt1JyWRkV9DouxWB6mt1T9JYH7iiUM6oxMzWBrlSEvO3gw/1W/y8rp3SzUn9rIHmTqwO+SIUNbREOw6TXF+xr3erLxTV4GT8PYG56BL
 kN1Q0KC/PID1iFac4utKjEVFFu9HtBGSgymZ2lee8vEr0QCzp/wl2Lg8HNyNH2oh3GCfhv5qVeuT4FSBDVWIidAPIe8a0fT/ewtWvpeLHetPNSqq1BUBy2ET
 Q9nFVc+bFHDj2wIxun02L+T340N40Ne7F0tZs1aLr/Qx6TlQ7ZQ9uc4nUlQYX6ObWvC4oOX/
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

When calculating signature for the packet, it needs to read into the
correct page offset for the data.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsencrypt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index a6ef088..e88303c 100644
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -68,11 +68,12 @@ int __cifs_calc_signature(struct smb_rqst *rqst,
 
 	/* now hash over the rq_pages array */
 	for (i = 0; i < rqst->rq_npages; i++) {
-		void *kaddr = kmap(rqst->rq_pages[i]);
-		size_t len = rqst->rq_pagesz;
+		void *kaddr;
+		unsigned int len, offset;
 
-		if (i == rqst->rq_npages - 1)
-			len = rqst->rq_tailsz;
+		rqst_page_get_length(rqst, i, &len, &offset);
+
+		kaddr = (char *) kmap(rqst->rq_pages[i]) + offset;
 
 		crypto_shash_update(shash, kaddr, len);
 
-- 
2.7.4
