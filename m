Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E3EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D27A21534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D27A21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbeIUDFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:05:21 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:60442
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbeIUDFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:05:21 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 36LdgmcmFwkZt36LdgKqpX; Thu, 20 Sep 2018 14:18:53 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1g36Lc-0003Zz-SZ; Thu, 20 Sep 2018 14:18:52 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH V3 (resend) 1/7] CIFS: pass page offsets on SMB1 read/write
Date:   Thu, 20 Sep 2018 21:18:38 +0000
Message-Id: <20180920211842.13721-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfAFWS3dU56MY0CJdB1QajlXDb6ZazfoX6AByb4S2jcO/BB06WA/VotPgmXG/nmKXI704C2DAh+ikKvfvjOn8kxIu5ZkHIMWsVZ2koBjQu10FCHDCzsHN
 Ma2rAgS4cZwA7rgvAgjDkYKi/lbUIPA3Bc6lej2QAg5gkFQb9x3d2ATgsp3Xh21KyPwMASMNwRY4LNgWrfVFqC1V5Bmx4fU3smCLSFo5ojJ6QJwfObTIiaA3
 6iroqrodFT1vG/szGK7XN9ZhZBbtPYIyu2gyZuZINnmlb56ANg/E9Rib196OIWzaU3NcPb0Z4d30E5hoPCv1vuzl9ih3pg3AhrJ8kyqwj0QZ5E+Tj63u0YqG
 1Hv69Hn/hnu4GhbCR3eeYOa4Sk0CvIXGm/O9IGRZ1iyDHfIrJfDtjq+dF/sSpu79B3QMKNXN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

When issuing SMB1 read/write, pass the page offset to transport.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifssmb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 41329f4..f82fd34 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1607,6 +1607,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
 				 .rq_pages = rdata->pages,
+				 .rq_offset = rdata->page_offset,
 				 .rq_npages = rdata->nr_pages,
 				 .rq_pagesz = rdata->pagesz,
 				 .rq_tailsz = rdata->tailsz };
@@ -2210,6 +2211,7 @@ cifs_async_writev(struct cifs_writedata *wdata,
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 2;
 	rqst.rq_pages = wdata->pages;
+	rqst.rq_offset = wdata->page_offset;
 	rqst.rq_npages = wdata->nr_pages;
 	rqst.rq_pagesz = wdata->pagesz;
 	rqst.rq_tailsz = wdata->tailsz;
-- 
2.7.4

