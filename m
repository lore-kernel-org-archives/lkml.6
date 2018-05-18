Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbeERAZX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 20:25:23 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:44438
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752130AbeERAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 20:23:35 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [RFC PATCH 02/09] Change wdata alloc to support direct pages
Date: Thu, 17 May 2018 17:22:07 -0700
Message-Id: <20180518002214.5657-3-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518002214.5657-1-longli@linuxonhyperv.com>
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfAJKzYlkdgYzaSwYT6TRJGL48k3j+wc7soNtoGr2qc9xkjewgOlkiy/ip41ldKn9stJCuwl8NuGP36P9miblNO3sEXRcHdIpE9Jdr9kHplAv29scZQGH
 /2GDrigOoDKjeu7fJm3ncBPu9A8fPBpk9tB5c9yFfj8PV2ht63oqBDMp+EPN+hCtJp5Vi6pyuELa3PcK/pUlxwiIBqb8p+SshHHohVMwXmEO7hr+lPuZFEPw
 ydnhdH/Y4BydeAZtH670wb/kvSXttPdillg/Jrir0N14Ne+kK4vMQtFOYrWX2vCvvl/3PeKKVNPvtRf/N74MwecwFw+FExQ4WkC3d8cP/J4ir7doVBkA1IWP
 r34M7cPdJwTo2iLVGdO0q7S1+Ijg02ja6R4NspSj6Y9d9nJv9C/Vq686YafUtcKe1XQSJsSG
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

When using direct pages from user space, there is no need to allocate pages.

Just ping those user pages for RDMA.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsproto.h |  2 +-
 fs/cifs/cifssmb.c   | 10 +++++++---
 fs/cifs/file.c      |  4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 365a414..94106b9 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -523,7 +523,7 @@ int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
 int cifs_async_writev(struct cifs_writedata *wdata,
 		      void (*release)(struct kref *kref));
 void cifs_writev_complete(struct work_struct *work);
-struct cifs_writedata *cifs_writedata_alloc(unsigned int nr_pages,
+struct cifs_writedata *cifs_writedata_alloc(unsigned int nr_pages, struct page **direct_pages,
 						work_func_t complete);
 void cifs_writedata_release(struct kref *refcount);
 int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 1529a08..3b1731d 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1983,7 +1983,7 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 			tailsz = rest_len - (nr_pages - 1) * PAGE_SIZE;
 		}
 
-		wdata2 = cifs_writedata_alloc(nr_pages, cifs_writev_complete);
+		wdata2 = cifs_writedata_alloc(nr_pages, NULL, cifs_writev_complete);
 		if (!wdata2) {
 			rc = -ENOMEM;
 			break;
@@ -2067,12 +2067,16 @@ cifs_writev_complete(struct work_struct *work)
 }
 
 struct cifs_writedata *
-cifs_writedata_alloc(unsigned int nr_pages, work_func_t complete)
+cifs_writedata_alloc(unsigned int nr_pages, struct page **direct_pages, work_func_t complete)
 {
 	struct cifs_writedata *wdata;
 
 	/* writedata + number of page pointers */
-	wdata = kzalloc(sizeof(*wdata) +
+	if (direct_pages) {
+		wdata = kzalloc(sizeof(*wdata), GFP_NOFS);
+		wdata->direct_pages = direct_pages;
+	} else
+		wdata = kzalloc(sizeof(*wdata) +
 			sizeof(struct page *) * nr_pages, GFP_NOFS);
 	if (wdata != NULL) {
 		kref_init(&wdata->refcount);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 23fd430..a6ec896 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1965,7 +1965,7 @@ wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
 {
 	struct cifs_writedata *wdata;
 
-	wdata = cifs_writedata_alloc((unsigned int)tofind,
+	wdata = cifs_writedata_alloc((unsigned int)tofind, NULL,
 				     cifs_writev_complete);
 	if (!wdata)
 		return NULL;
@@ -2554,7 +2554,7 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 			break;
 
 		nr_pages = get_numpages(wsize, len, &cur_len);
-		wdata = cifs_writedata_alloc(nr_pages,
+		wdata = cifs_writedata_alloc(nr_pages, NULL,
 					     cifs_uncached_writev_complete);
 		if (!wdata) {
 			rc = -ENOMEM;
-- 
2.7.4
