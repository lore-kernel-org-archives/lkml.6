Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6858AC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABEE20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABEE20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeIHG7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:10 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:47264
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbeIHG7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:09 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlIfRLtgWFPMySlIffcqc; Fri, 07 Sep 2018 19:14:22 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySlI-0005Dd-Ou; Fri, 07 Sep 2018 19:14:12 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 03/16] CIFS: Add support for direct pages in wdata
Date:   Sat,  8 Sep 2018 02:13:35 +0000
Message-Id: <20180908021348.19956-4-longli@linuxonhyperv.com>
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

Add a function to allocate wdata without allocating pages for data
transfer. This gives the caller an option to pass a number of pages that
point to the data buffer to write to.

wdata is reponsible for free those pages after it's done.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsglob.h  |  3 +--
 fs/cifs/cifsproto.h |  2 ++
 fs/cifs/cifssmb.c   | 17 ++++++++++++++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 166e140..7f62c98 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1199,14 +1199,13 @@ struct cifs_writedata {
 	int				result;
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	struct smbd_mr			*mr;
-	struct page			**direct_pages;
 #endif
 	unsigned int			pagesz;
 	unsigned int			page_offset;
 	unsigned int			tailsz;
 	unsigned int			credits;
 	unsigned int			nr_pages;
-	struct page			*pages[];
+	struct page			**pages;
 };
 
 /*
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 1f27d8e..7933c5f 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -533,6 +533,8 @@ int cifs_async_writev(struct cifs_writedata *wdata,
 void cifs_writev_complete(struct work_struct *work);
 struct cifs_writedata *cifs_writedata_alloc(unsigned int nr_pages,
 						work_func_t complete);
+struct cifs_writedata *cifs_writedata_direct_alloc(struct page **pages,
+						work_func_t complete);
 void cifs_writedata_release(struct kref *refcount);
 int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 			  struct cifs_sb_info *cifs_sb,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index a1af258..503e0ed 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1953,6 +1953,7 @@ cifs_writedata_release(struct kref *refcount)
 	if (wdata->cfile)
 		cifsFileInfo_put(wdata->cfile);
 
+	kvfree(wdata->pages);
 	kfree(wdata);
 }
 
@@ -2076,12 +2077,22 @@ cifs_writev_complete(struct work_struct *work)
 struct cifs_writedata *
 cifs_writedata_alloc(unsigned int nr_pages, work_func_t complete)
 {
+	struct page **pages =
+		kzalloc(sizeof(struct page *) * nr_pages, GFP_NOFS);
+	if (pages)
+		return cifs_writedata_direct_alloc(pages, complete);
+
+	return NULL;
+}
+
+struct cifs_writedata *
+cifs_writedata_direct_alloc(struct page **pages, work_func_t complete)
+{
 	struct cifs_writedata *wdata;
 
-	/* writedata + number of page pointers */
-	wdata = kzalloc(sizeof(*wdata) +
-			sizeof(struct page *) * nr_pages, GFP_NOFS);
+	wdata = kzalloc(sizeof(*wdata), GFP_NOFS);
 	if (wdata != NULL) {
+		wdata->pages = pages;
 		kref_init(&wdata->refcount);
 		INIT_LIST_HEAD(&wdata->list);
 		init_completion(&wdata->done);
-- 
2.7.4

