Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8646FC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC8F20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC8F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeIHG7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:13 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:47264
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbeIHG7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:12 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlWfRM0jWFPMySlWffcwP; Fri, 07 Sep 2018 19:14:26 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySlW-0005E5-CW; Fri, 07 Sep 2018 19:14:26 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 07/16] CIFS: When sending data on socket, pass the correct page offset
Date:   Sat,  8 Sep 2018 02:13:39 +0000
Message-Id: <20180908021348.19956-8-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfH3wLEz7F5Y/hb80dc49JOhZ0gCNPr+ZOf8QbRBCZLc5yBnOfXjo5cFqDxST9SqdS2F/MyKx4CukAenn4PlZA16qYmrA8wPDzFkjfMI5O1hytgiAeoIS
 4QRBIMwoCdj5Lay0IupNKS3hqHT1x6WbFbnhrKF+iZQ97Q5R1qewSiHDL6WYQm90a4+zD9mV1stFVo9SzRmDBGi0bJKkLkEDisl0WkjF/Y0Zs0VF4a4tELKx
 stAz960YEaKhm3kFdyVNw1V1CNzNrS6Un5wDDz7N3dD53q9TwQMDOHq1ThwvPQ6jPjS7db9+E+nOg2HDFOoI4x5F96c/YUEgd471uPSCVIIxi8szCROhnLe1
 qCH6zHU84S9WhhER5RWncSPNDFc+kvaUwpY6PkzbDk9yD4GGuCwRL9v01rCLbAqKVXPT3p/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

