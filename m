Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78459C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1BF20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1BF20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeIHG7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:09 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:47266
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbeIHG7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:09 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlKfRLunWFPMySlKffcrV; Fri, 07 Sep 2018 19:14:22 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySlK-0005Dj-RE; Fri, 07 Sep 2018 19:14:14 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 04/16] CIFS: pass page offset when issuing SMB write
Date:   Sat,  8 Sep 2018 02:13:36 +0000
Message-Id: <20180908021348.19956-5-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfJ1feJ/TGt2PGk3lQEMBaXYiUMCSWvMRHiScg/MqSq4873sTxqzx/haTexSzlG+EAEsFNPmQ7qj5ph4kNz/fBF2F6xaA5MmWJxI6jXKU+RLb/Qugj8T/
 PsBiHi+jf7+v6yZRYIfCMIwMdoNFG7J+InZ3Ts+FxIHShHPt7PO8JEklFopKbKWT+l0CwyG/f2oRKZp+fefw3cJqpdP+uVpAGVXpj8HQi3T1qQ8xK0ggiBnc
 HszmYWJa8fb9K2NUW2TjVbe6ZSWJVlbheA811NGr73fd4fb5yXiEmS9ebsAwD29MX0zJ81lNNfg6QZO9IAju7e+J0S4ouFwAD7OlQ1ehlw5LhfVwO9AECG71
 tjOt8pI976H7aQHMF0RLqZsiYskBMJ8TUj8ilrcaaIELfJx4tSpyrBGKV0TrwklHklCq3LxA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

When issuing SMB writes, pass along the write data page offset to transport.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifssmb.c | 1 +
 fs/cifs/smb2pdu.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 503e0ed..0a57c61 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -2200,6 +2200,7 @@ cifs_async_writev(struct cifs_writedata *wdata,
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 2;
 	rqst.rq_pages = wdata->pages;
+	rqst.rq_offset = wdata->page_offset;
 	rqst.rq_npages = wdata->nr_pages;
 	rqst.rq_pagesz = wdata->pagesz;
 	rqst.rq_tailsz = wdata->tailsz;
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 6c22da8..f603fbe 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3046,6 +3046,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 2;
 	rqst.rq_pages = wdata->pages;
+	rqst.rq_offset = wdata->page_offset;
 	rqst.rq_npages = wdata->nr_pages;
 	rqst.rq_pagesz = wdata->pagesz;
 	rqst.rq_tailsz = wdata->tailsz;
-- 
2.7.4

