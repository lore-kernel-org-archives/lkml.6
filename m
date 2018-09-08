Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E671C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AA420855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AA420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeIHG7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:10 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:47276
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbeIHG7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:10 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlOfRLweWFPMySlOffct4; Fri, 07 Sep 2018 19:14:22 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySlO-0005Dp-0w; Fri, 07 Sep 2018 19:14:18 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 05/16] CIFS: Calculate the correct request length based on page offset and tail size
Date:   Sat,  8 Sep 2018 02:13:37 +0000
Message-Id: <20180908021348.19956-6-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfNnkn2GQr754MkbBwSuvZi90bTU6AleeQvB9vJSMf4YDPVNjuFu9iKbGq2bLfNHQ/iBZ6uY69EP8t3FYzToGO8usTpv1da36Fu3R+AIZdi1GXTkB4BEO
 hCscCnAoWn4WVjYYlP89mVQnBDd+Jhgx1Xob3KXXgvymnGePjpn41mdAIjy1LbS+SSRgGiNE27aEQSaebpTLRoW/LGY+KxP2wjsEGs49apEf6cX3EEeqXEdC
 QQBU6h6VyVq1lgAOmzc69Hh0l+SEmMA7yTo32Nyix390vu5hk1Sll7O12w5Merx+7UMwVcxE0vVKVEfdTE698NL7cfEHeX2Cgd8wD2DHogxlHziAukK9LQSY
 JfPsELPkiy9KI3/FjpiTHvEcrC9axcVXTEDYuFncUMk6mCOfkWI0muadDFDhl/l83QOgrzNp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

