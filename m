Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2199CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF19A20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF19A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeIHG70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:26 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:47276
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726924AbeIHG7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:24 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlifRM6RWFPMySliffd0t; Fri, 07 Sep 2018 19:14:38 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySli-0005Ea-1C; Fri, 07 Sep 2018 19:14:38 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 12/16] CIFS: Pass page offset for calculating signature
Date:   Sat,  8 Sep 2018 02:13:44 +0000
Message-Id: <20180908021348.19956-13-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfEf7XrAtleugwZSn2k4AGIUVnAcrhhMEe3q6Pl73FaxK94SIT5r86E38o9hVY9BFMS5gFz6Ib7HIOkwI6iTNXv+lz0xy51G73pOefQzRXXjwnWPq7jQr
 Xoyw+RJArPfjwq37a72Il4+FINqNmi9/SeBh91+Im9eayaFfmNLqxbsAruz7t9/iRGsCDYZaAr8RnXqMJRF6XLCEsl3PhGMrQtNPlKQZC7ZoRWTVp5ouqs38
 ysHwAAl/PnGUc0d0RnKb5Sj/I69SJoHm00SXlzMt4cvc65/arR2qREUNhgS73tOMFUYutV5rHCOlyYAviRtT6YYRbqowBH/kGccQ3zrvkmdJHeTt6uNUGwRI
 F9ARafu4kZvb1+GbaYLJF9PWTos0pnOIeFIge5rzXlhAezTz4edj59o1YQH24uR2YuKGyuLp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

