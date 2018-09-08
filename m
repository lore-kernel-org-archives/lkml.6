Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E12C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB18B2086C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB18B2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeIHG7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:16 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:36584
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbeIHG7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:15 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlYfa5lnTEX4ySlYf1lFo; Fri, 07 Sep 2018 19:14:28 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySlY-0005EB-OQ; Fri, 07 Sep 2018 19:14:28 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 08/16] CIFS: SMBD: Support page offset in RDMA send
Date:   Sat,  8 Sep 2018 02:13:40 +0000
Message-Id: <20180908021348.19956-9-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfMykow4rDH/fzM3DYOmR7Bjg5DM6LS9k3Tn9aoVF284pAN9fBwcs/ks638clomLmm2xjNvWxNscSm0o/B5qKkedDWOTSRiRiUFwFNwrLrCFEfJX/B0PW
 ePURqOG4uTCVU6HUdf5bxTTkPwpIYfpL795ioLlRdLQ1qgKKdeRbhwaSRpTF0IxGCaUGTNvd6GlKlQNH4ypsDTpngv1CJvVt5d1YeC1lq9OxxhspbXFOEwPy
 5UAqp8y2l+/p1Y/uT+z3sSjxOnM6Csy2mn+X0QlO3D0hrmFlqPLyF6I85jCsXVWKOFB6vFETHPM3f6BnTLZMStKZ8FLxWMB9LGCFPt1SLJOmcQCxLiVIJDDb
 uFVL54OdeGP9K13g1BknLcmnLHWcfHiRGFLt6AH4YtDYtstYKoxr6HbPCWn0ZZe8h/IjNuEs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

