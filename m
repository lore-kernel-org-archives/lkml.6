Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2DEC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC0C20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC0C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeIHG7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:04 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:36876
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbeIHG7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:04 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlDfkWUF4ToEySlDfAVX2; Fri, 07 Sep 2018 19:14:17 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySlD-0005DR-Ns; Fri, 07 Sep 2018 19:14:07 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 01/16] CIFS: Add support for direct pages in rdata
Date:   Sat,  8 Sep 2018 02:13:33 +0000
Message-Id: <20180908021348.19956-2-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfIfGN4mRFPBQgnHRoeQJ6PejviETpxrjv5MN0mrQyc6A8Vxcjoidhhk7+9pWVEygPVnIFy+joCHMdP+eYaWXOoMI+Ejn7wz0n/L0HTayLx+gzwppLsUU
 DTQ0ofbcm/13FOZdmDdkR4KggWnqEh6olmpwlZ1UF06dscXVCe09QX4KsjuKsCRKwGPVR7dhohWJI8G3luANjSDXSHyR7YgghKeRiCqovjn8fQz2KQOQvTAX
 /JhRFna6P/MvpgLoOLnT3iZb2dFQZ/Fkew5kqWlGFDhns0sJMfI+TmUen7T6fcNvmMCZLxqLURWew/BM1AF48xjg2t5LNWPnOYrt6w/YYNISKwRvSBSrD/QI
 eKONr3TFFhoyzsZL0Hokkqf+7678Deq5YwLfoDE+t+sR5mQC50MOk+C5PmM42AXGl4vZHnjN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

Add a function to allocate rdata without allocating pages for data
transfer. This gives the caller an option to pass a number of pages
that point to the data buffer.

rdata is reponsible for free those pages after it's done.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsglob.h |  3 +--
 fs/cifs/file.c     | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 80a34ce..166e140 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1173,14 +1173,13 @@ struct cifs_readdata {
 	struct kvec			iov[2];
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
 
 struct cifs_writedata;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 23fd430..1c98293 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2880,13 +2880,13 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
 }
 
 static struct cifs_readdata *
-cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
+cifs_readdata_direct_alloc(struct page **pages, work_func_t complete)
 {
 	struct cifs_readdata *rdata;
 
-	rdata = kzalloc(sizeof(*rdata) + (sizeof(struct page *) * nr_pages),
-			GFP_KERNEL);
+	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
 	if (rdata != NULL) {
+		rdata->pages = pages;
 		kref_init(&rdata->refcount);
 		INIT_LIST_HEAD(&rdata->list);
 		init_completion(&rdata->done);
@@ -2896,6 +2896,22 @@ cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
 	return rdata;
 }
 
+static struct cifs_readdata *
+cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
+{
+	struct page **pages =
+		kzalloc(sizeof(struct page *) * nr_pages, GFP_KERNEL);
+	struct cifs_readdata *ret = NULL;
+
+	if (pages) {
+		ret = cifs_readdata_direct_alloc(pages, complete);
+		if (!ret)
+			kfree(pages);
+	}
+
+	return ret;
+}
+
 void
 cifs_readdata_release(struct kref *refcount)
 {
@@ -2910,6 +2926,7 @@ cifs_readdata_release(struct kref *refcount)
 	if (rdata->cfile)
 		cifsFileInfo_put(rdata->cfile);
 
+	kvfree(rdata->pages);
 	kfree(rdata);
 }
 
-- 
2.7.4

