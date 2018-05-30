Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932297AbeE3Tt6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:49:58 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:57164
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932246AbeE3Ttu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:49:50 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 04/15] CIFS: Add support for direct pages in wdata
Date: Wed, 30 May 2018 12:47:56 -0700
Message-Id: <20180530194807.31657-5-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530194807.31657-1-longli@linuxonhyperv.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfMwOmAkMxSfDSZc4tE7rTC1zDeJKOHQ44FWamfyw6kSwAtThgrWxri+wJQGRNWnyQZi7pgKyFhrTptpTAl9jCxoXVj25RoCRmF2dKnYKviCS7t67MU7q
 FDetk+PRaRooqGG4ZBHAoB9GtFSJgboMF5VMWhw4fXso3RM+KzHeNUdAsi66OiJKvsEWzOF7hp7mzjTvWcaztmdKdWrp65RPX9mKTAsgXIiv+xdT1GGuXaEF
 uEHffLCkQTOmSM4lxn4TE9U2U3BiFn8GdSWbRR9bzljpWl2oKOd0NWi4b2Xo+j48ZGseTSYWj2EVyTZsRJvxRV3vSgsgtF6CzR0M3xN4HpFpVAOGQ3gJ0mgx
 5BNPxRXvGxJ3oDlQXIkdtoUeLgBll/zCas6Lz/8dWfIVjIVrS0vHhOHzSID3W/uyWa6tlJsN
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

Add a function to allocate wdata without allocating pages for data
transfer. This gives the caller an option to pass a number of pages that
point to the data buffer to write to.

wdata is reponsible for free those pages after it's done.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsglob.h  |  2 +-
 fs/cifs/cifsproto.h |  2 ++
 fs/cifs/cifssmb.c   | 17 ++++++++++++++---
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 56864a87..7f62c98 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1205,7 +1205,7 @@ struct cifs_writedata {
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
index c8e4278..5aca336 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1952,6 +1952,7 @@ cifs_writedata_release(struct kref *refcount)
 	if (wdata->cfile)
 		cifsFileInfo_put(wdata->cfile);
 
+	kvfree(wdata->pages);
 	kfree(wdata);
 }
 
@@ -2075,12 +2076,22 @@ cifs_writev_complete(struct work_struct *work)
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
