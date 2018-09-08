Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBAFC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50D92086C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50D92086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeIHG7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:17 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:36876
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbeIHG7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:16 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlafkWhT4ToEySlafAVgn; Fri, 07 Sep 2018 19:14:30 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySla-0005EI-3m; Fri, 07 Sep 2018 19:14:30 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 09/16] CIFS: SMBD: Support page offset in RDMA recv
Date:   Sat,  8 Sep 2018 02:13:41 +0000
Message-Id: <20180908021348.19956-10-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfCS9wzXg1gTRap0zIXqhWFNyN1nJ+32h/X6IlVi+4Kct8tkJeUGMzQkzt5lLPhsz/xIsCl8nloz53ZCrwkH3nsnHhSCBUXGgSGM3WNYQy/iRoCRHEtRz
 Mz62Gze3exB1gPbfhQkOd7n3T3bsrZCp3p7KdVQ6Ac0UHkFTKeh2UITay0TH7pWrOeuGX/ubuCpL6Kf12tBir7iMP5qUyejEF54aVZt5AbASIiqUOPv8jhOx
 0UM21EwVUd/XfM9iy5x3u/G+YJ1DwiBE5XO6LkwV1TAI0CHUDwrTs8dsSLssVLO1P92E2UqBPhWK2N5K1MWHf3x8zd07/6DmTdFPU11l9chVvfpPmKZt37lI
 WyP/+LHPKnVDgurwKMvlRWfKnmFPHlVV8FeaMMc0dv+YgqApS0gnW6AMC1WrUCb2r0WWS0HJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

RDMA recv function needs to place data to the correct place starting at
page offset.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 6141e3c..ba53c52 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2004,10 +2004,12 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
  * return value: actual data read
  */
 static int smbd_recv_page(struct smbd_connection *info,
-		struct page *page, unsigned int to_read)
+		struct page *page, unsigned int page_offset,
+		unsigned int to_read)
 {
 	int ret;
 	char *to_address;
+	void *page_address;
 
 	/* make sure we have the page ready for read */
 	ret = wait_event_interruptible(
@@ -2015,16 +2017,17 @@ static int smbd_recv_page(struct smbd_connection *info,
 		info->reassembly_data_length >= to_read ||
 			info->transport_status != SMBD_CONNECTED);
 	if (ret)
-		return 0;
+		return ret;
 
 	/* now we can read from reassembly queue and not sleep */
-	to_address = kmap_atomic(page);
+	page_address = kmap_atomic(page);
+	to_address = (char *) page_address + page_offset;
 
 	log_read(INFO, "reading from page=%p address=%p to_read=%d\n",
 		page, to_address, to_read);
 
 	ret = smbd_recv_buf(info, to_address, to_read);
-	kunmap_atomic(to_address);
+	kunmap_atomic(page_address);
 
 	return ret;
 }
@@ -2038,7 +2041,7 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 {
 	char *buf;
 	struct page *page;
-	unsigned int to_read;
+	unsigned int to_read, page_offset;
 	int rc;
 
 	info->smbd_recv_pending++;
@@ -2052,15 +2055,16 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 
 	case READ | ITER_BVEC:
 		page = msg->msg_iter.bvec->bv_page;
+		page_offset = msg->msg_iter.bvec->bv_offset;
 		to_read = msg->msg_iter.bvec->bv_len;
-		rc = smbd_recv_page(info, page, to_read);
+		rc = smbd_recv_page(info, page, page_offset, to_read);
 		break;
 
 	default:
 		/* It's a bug in upper layer to get there */
 		cifs_dbg(VFS, "CIFS: invalid msg type %d\n",
 			msg->msg_iter.type);
-		rc = -EIO;
+		rc = -EINVAL;
 	}
 
 	info->smbd_recv_pending--;
-- 
2.7.4

