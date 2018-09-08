Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E66DC43143
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584E320861
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584E320861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeIHG7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:11 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:47266
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbeIHG7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:10 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlRfRLyRWFPMySlRffcuS; Fri, 07 Sep 2018 19:14:22 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySlR-0005Dv-F8; Fri, 07 Sep 2018 19:14:21 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 06/16] CIFS: Introduce helper function to get page offset and length in smb_rqst
Date:   Sat,  8 Sep 2018 02:13:38 +0000
Message-Id: <20180908021348.19956-7-longli@linuxonhyperv.com>
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

Introduce a function rqst_page_get_length to return the page offset and
length for a given page in smb_rqst. This function is to be used by
following patches.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsproto.h |  3 +++
 fs/cifs/misc.c      | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 7933c5f..89dda14 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -557,4 +557,7 @@ int cifs_alloc_hash(const char *name, struct crypto_shash **shash,
 		    struct sdesc **sdesc);
 void cifs_free_hash(struct crypto_shash **shash, struct sdesc **sdesc);
 
+extern void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
+				unsigned int *len, unsigned int *offset);
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 96849b5..e951417 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -905,3 +905,20 @@ cifs_free_hash(struct crypto_shash **shash, struct sdesc **sdesc)
 		crypto_free_shash(*shash);
 	*shash = NULL;
 }
+
+/**
+ * rqst_page_get_length - obtain the length and offset for a page in smb_rqst
+ * Input: rqst - a smb_rqst, page - a page index for rqst
+ * Output: *len - the length for this page, *offset - the offset for this page
+ */
+void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
+				unsigned int *len, unsigned int *offset)
+{
+	*len = rqst->rq_pagesz;
+	*offset = (page == 0) ? rqst->rq_offset : 0;
+
+	if (rqst->rq_npages == 1 || page == rqst->rq_npages-1)
+		*len = rqst->rq_tailsz;
+	else if (page == 0)
+		*len = rqst->rq_pagesz - rqst->rq_offset;
+}
-- 
2.7.4

