Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A3EC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F4620855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F4620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeIHG72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:28 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:36876
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727108AbeIHG71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:27 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlkfkWmb4ToEySlkfAVkc; Fri, 07 Sep 2018 19:14:40 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySlk-0005Eg-Ig; Fri, 07 Sep 2018 19:14:40 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 13/16] CIFS: Pass page offset for encrypting
Date:   Sat,  8 Sep 2018 02:13:45 +0000
Message-Id: <20180908021348.19956-14-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfPShpMJxpLCl9pzlIXNUaZ5qjywJNO7H6CXS9/E3a1IWRmvPkp2LUIjna7+3hHAR5jMCIN7SIfFx1QRCvdagjxfoN8gaRFnVrObXigAK8EfPGeM0d0lp
 F/E5HwqZrkBOW7KKyLS2ZKzJjZWBsGzGolE+chM+zkS0KGWuZ9Ogq6SAtE11lNsX8yuw0+f0XF1VVe4CRJ6HDVwJpNQOZY5ovol4iZucdj0kk1jnKwEkl6rk
 06XVgW1iig4I8gNsktrcAURz0Entty48fzFEFtJJQKXt2U43DyccjWDRugdIUXa3Wm3uQ2VdSws0XZGnnVl9oDePbel9SwaHqDgXR1aPz+m1jWUmPfjlDvW6
 Qkm3HUr7JAQGLPxts7BTc/stNun9+XgjvAYEjuS7HK99jdSanywt/ZCtF9I1v0JJKaAshm9/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

