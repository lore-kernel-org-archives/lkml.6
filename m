Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ESxuNnBIGVt+SAAAmS7hNA
	; Thu, 07 Jun 2018 15:00:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 436B2607E7; Thu,  7 Jun 2018 15:00:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ADBC0601C3;
	Thu,  7 Jun 2018 15:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADBC0601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935841AbeFGPA4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:00:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41360 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935192AbeFGPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:00:53 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbo-0005Zl-Ut; Thu, 07 Jun 2018 15:09:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb2-0002rb-Fq; Thu, 07 Jun 2018 15:09:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Trond Myklebust" <trond.myklebust@primarydata.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.388325115@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 128/410] NFS: Fix 2 use after free issues in the I/O code
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit 196639ebbe63a037fe9a80669140bd292d8bcd80 upstream.

The writeback code wants to send a commit after processing the pages,
which is why we want to delay releasing the struct path until after
that's done.

Also, the layout code expects that we do not free the inode before
we've put the layout segments in pnfs_writehdr_free() and
pnfs_readhdr_free()

Fixes: 919e3bd9a875 ("NFS: Ensure we commit after writeback is complete")
Fixes: 4714fb51fd03 ("nfs: remove pgio_header refcount, related cleanup")
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfs/internal.h |  1 -
 fs/nfs/pagelist.c | 26 ++++++++++++--------------
 fs/nfs/pnfs.c     |  2 --
 3 files changed, 12 insertions(+), 17 deletions(-)

--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -249,7 +249,6 @@ int nfs_iocounter_wait(struct nfs_io_cou
 extern const struct nfs_pageio_ops nfs_pgio_rw_ops;
 struct nfs_pgio_header *nfs_pgio_header_alloc(const struct nfs_rw_ops *);
 void nfs_pgio_header_free(struct nfs_pgio_header *);
-void nfs_pgio_data_destroy(struct nfs_pgio_header *);
 int nfs_generic_pgio(struct nfs_pageio_descriptor *, struct nfs_pgio_header *);
 int nfs_initiate_pgio(struct rpc_clnt *, struct nfs_pgio_header *,
 		      const struct rpc_call_ops *, int, int);
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -508,16 +508,6 @@ struct nfs_pgio_header *nfs_pgio_header_
 }
 EXPORT_SYMBOL_GPL(nfs_pgio_header_alloc);
 
-/*
- * nfs_pgio_header_free - Free a read or write header
- * @hdr: The header to free
- */
-void nfs_pgio_header_free(struct nfs_pgio_header *hdr)
-{
-	hdr->rw_ops->rw_free_header(hdr);
-}
-EXPORT_SYMBOL_GPL(nfs_pgio_header_free);
-
 /**
  * nfs_pgio_data_destroy - make @hdr suitable for reuse
  *
@@ -526,14 +516,24 @@ EXPORT_SYMBOL_GPL(nfs_pgio_header_free);
  *
  * @hdr: A header that has had nfs_generic_pgio called
  */
-void nfs_pgio_data_destroy(struct nfs_pgio_header *hdr)
+static void nfs_pgio_data_destroy(struct nfs_pgio_header *hdr)
 {
 	if (hdr->args.context)
 		put_nfs_open_context(hdr->args.context);
 	if (hdr->page_array.pagevec != hdr->page_array.page_array)
 		kfree(hdr->page_array.pagevec);
 }
-EXPORT_SYMBOL_GPL(nfs_pgio_data_destroy);
+
+/*
+ * nfs_pgio_header_free - Free a read or write header
+ * @hdr: The header to free
+ */
+void nfs_pgio_header_free(struct nfs_pgio_header *hdr)
+{
+	nfs_pgio_data_destroy(hdr);
+	hdr->rw_ops->rw_free_header(hdr);
+}
+EXPORT_SYMBOL_GPL(nfs_pgio_header_free);
 
 /**
  * nfs_pgio_rpcsetup - Set up arguments for a pageio call
@@ -648,7 +648,6 @@ static int nfs_pgio_error(struct nfs_pag
 			  struct nfs_pgio_header *hdr)
 {
 	set_bit(NFS_IOHDR_REDO, &hdr->flags);
-	nfs_pgio_data_destroy(hdr);
 	hdr->completion_ops->completion(hdr);
 	desc->pg_completion_ops->error_cleanup(&desc->pg_list);
 	return -ENOMEM;
@@ -663,7 +662,6 @@ static void nfs_pgio_release(void *calld
 	struct nfs_pgio_header *hdr = calldata;
 	if (hdr->rw_ops->rw_release)
 		hdr->rw_ops->rw_release(hdr);
-	nfs_pgio_data_destroy(hdr);
 	hdr->completion_ops->completion(hdr);
 }
 
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1557,7 +1557,6 @@ pnfs_write_through_mds(struct nfs_pageio
 		nfs_pageio_reset_write_mds(desc);
 		desc->pg_recoalesce = 1;
 	}
-	nfs_pgio_data_destroy(hdr);
 	hdr->release(hdr);
 }
 
@@ -1695,7 +1694,6 @@ pnfs_read_through_mds(struct nfs_pageio_
 		nfs_pageio_reset_read_mds(desc);
 		desc->pg_recoalesce = 1;
 	}
-	nfs_pgio_data_destroy(hdr);
 	hdr->release(hdr);
 }
 
