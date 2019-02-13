Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FE220835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083671;
	bh=WssczWAQPtXEu8HrcsYb84bjZEaygsFQWMHLqcly4w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JGOWPPjOd+npZTm8PT8x7GVjZtWmwYyXwir/Bckm+d4xUO8Cq3nlNfnuK1PBLPND+
	 kmlM1jV7CBUweOiB7qteyL/MCxhJ0ridb5HV5VNWgiOBwP0y7h+MO/gdLs9qVO6PY1
	 iWisXPlLd9jN/LtjQ7goOMLWrywJZ4B9RIBpP0XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406572AbfBMSrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406558AbfBMSrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:47:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61DE220835;
        Wed, 13 Feb 2019 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083619;
        bh=WssczWAQPtXEu8HrcsYb84bjZEaygsFQWMHLqcly4w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1iuoDUxIR+DaIGS2uGQYxKeBm+9q0bxzR9adQE7SKwRocdbmkV/4mKC2sJ+jFLG/0
         5QYX8KZMiZaYMonoi7ER44P4TDjIEiWxi9scjOA8pBgy1ukM4+gP3BQ03Y6G8LM83T
         WcBPUd7czQVRb1lcRM4kO6iGo6UFUWImGu+TBHRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.20 18/50] svcrdma: Remove max_sge check at connect time
Date:   Wed, 13 Feb 2019 19:38:23 +0100
Message-Id: <20190213183657.256534170@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit e248aa7be86e8179f20ac0931774ecd746f3f5bf upstream.

Two and a half years ago, the client was changed to use gathered
Send for larger inline messages, in commit 655fec6987b ("xprtrdma:
Use gathered Send for large inline messages"). Several fixes were
required because there are a few in-kernel device drivers whose
max_sge is 3, and these were broken by the change.

Apparently my memory is going, because some time later, I submitted
commit 25fd86eca11c ("svcrdma: Don't overrun the SGE array in
svc_rdma_send_ctxt"), and after that, commit f3c1fd0ee294 ("svcrdma:
Reduce max_send_sges"). These too incorrectly assumed in-kernel
device drivers would have more than a few Send SGEs available.

The fix for the server side is not the same. This is because the
fundamental problem on the server is that, whether or not the client
has provisioned a chunk for the RPC reply, the server must squeeze
even the most complex RPC replies into a single RDMA Send. Failing
in the send path because of Send SGE exhaustion should never be an
option.

Therefore, instead of failing when the send path runs out of SGEs,
switch to using a bounce buffer mechanism to handle RPC replies that
are too complex for the device to send directly. That allows us to
remove the max_sge check to enable drivers with small max_sge to
work again.

Reported-by: Don Dutile <ddutile@redhat.com>
Fixes: 25fd86eca11c ("svcrdma: Don't overrun the SGE array in ...")
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |  105 +++++++++++++++++++++++++++++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    9 --
 2 files changed, 102 insertions(+), 12 deletions(-)

--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -563,6 +563,99 @@ void svc_rdma_sync_reply_hdr(struct svcx
 				      DMA_TO_DEVICE);
 }
 
+/* If the xdr_buf has more elements than the device can
+ * transmit in a single RDMA Send, then the reply will
+ * have to be copied into a bounce buffer.
+ */
+static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
+				    struct xdr_buf *xdr,
+				    __be32 *wr_lst)
+{
+	int elements;
+
+	/* xdr->head */
+	elements = 1;
+
+	/* xdr->pages */
+	if (!wr_lst) {
+		unsigned int remaining;
+		unsigned long pageoff;
+
+		pageoff = xdr->page_base & ~PAGE_MASK;
+		remaining = xdr->page_len;
+		while (remaining) {
+			++elements;
+			remaining -= min_t(u32, PAGE_SIZE - pageoff,
+					   remaining);
+			pageoff = 0;
+		}
+	}
+
+	/* xdr->tail */
+	if (xdr->tail[0].iov_len)
+		++elements;
+
+	/* assume 1 SGE is needed for the transport header */
+	return elements >= rdma->sc_max_send_sges;
+}
+
+/* The device is not capable of sending the reply directly.
+ * Assemble the elements of @xdr into the transport header
+ * buffer.
+ */
+static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
+				      struct svc_rdma_send_ctxt *ctxt,
+				      struct xdr_buf *xdr, __be32 *wr_lst)
+{
+	unsigned char *dst, *tailbase;
+	unsigned int taillen;
+
+	dst = ctxt->sc_xprt_buf;
+	dst += ctxt->sc_sges[0].length;
+
+	memcpy(dst, xdr->head[0].iov_base, xdr->head[0].iov_len);
+	dst += xdr->head[0].iov_len;
+
+	tailbase = xdr->tail[0].iov_base;
+	taillen = xdr->tail[0].iov_len;
+	if (wr_lst) {
+		u32 xdrpad;
+
+		xdrpad = xdr_padsize(xdr->page_len);
+		if (taillen && xdrpad) {
+			tailbase += xdrpad;
+			taillen -= xdrpad;
+		}
+	} else {
+		unsigned int len, remaining;
+		unsigned long pageoff;
+		struct page **ppages;
+
+		ppages = xdr->pages + (xdr->page_base >> PAGE_SHIFT);
+		pageoff = xdr->page_base & ~PAGE_MASK;
+		remaining = xdr->page_len;
+		while (remaining) {
+			len = min_t(u32, PAGE_SIZE - pageoff, remaining);
+
+			memcpy(dst, page_address(*ppages), len);
+			remaining -= len;
+			dst += len;
+			pageoff = 0;
+		}
+	}
+
+	if (taillen)
+		memcpy(dst, tailbase, taillen);
+
+	ctxt->sc_sges[0].length += xdr->len;
+	ib_dma_sync_single_for_device(rdma->sc_pd->device,
+				      ctxt->sc_sges[0].addr,
+				      ctxt->sc_sges[0].length,
+				      DMA_TO_DEVICE);
+
+	return 0;
+}
+
 /* svc_rdma_map_reply_msg - Map the buffer holding RPC message
  * @rdma: controlling transport
  * @ctxt: send_ctxt for the Send WR
@@ -585,8 +678,10 @@ int svc_rdma_map_reply_msg(struct svcxpr
 	u32 xdr_pad;
 	int ret;
 
-	if (++ctxt->sc_cur_sge_no >= rdma->sc_max_send_sges)
-		return -EIO;
+	if (svc_rdma_pull_up_needed(rdma, xdr, wr_lst))
+		return svc_rdma_pull_up_reply_msg(rdma, ctxt, xdr, wr_lst);
+
+	++ctxt->sc_cur_sge_no;
 	ret = svc_rdma_dma_map_buf(rdma, ctxt,
 				   xdr->head[0].iov_base,
 				   xdr->head[0].iov_len);
@@ -617,8 +712,7 @@ int svc_rdma_map_reply_msg(struct svcxpr
 	while (remaining) {
 		len = min_t(u32, PAGE_SIZE - page_off, remaining);
 
-		if (++ctxt->sc_cur_sge_no >= rdma->sc_max_send_sges)
-			return -EIO;
+		++ctxt->sc_cur_sge_no;
 		ret = svc_rdma_dma_map_page(rdma, ctxt, *ppages++,
 					    page_off, len);
 		if (ret < 0)
@@ -632,8 +726,7 @@ int svc_rdma_map_reply_msg(struct svcxpr
 	len = xdr->tail[0].iov_len;
 tail:
 	if (len) {
-		if (++ctxt->sc_cur_sge_no >= rdma->sc_max_send_sges)
-			return -EIO;
+		++ctxt->sc_cur_sge_no;
 		ret = svc_rdma_dma_map_buf(rdma, ctxt, base, len);
 		if (ret < 0)
 			return ret;
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -478,12 +478,9 @@ static struct svc_xprt *svc_rdma_accept(
 	/* Transport header, head iovec, tail iovec */
 	newxprt->sc_max_send_sges = 3;
 	/* Add one SGE per page list entry */
-	newxprt->sc_max_send_sges += svcrdma_max_req_size / PAGE_SIZE;
-	if (newxprt->sc_max_send_sges > dev->attrs.max_send_sge) {
-		pr_err("svcrdma: too few Send SGEs available (%d needed)\n",
-		       newxprt->sc_max_send_sges);
-		goto errout;
-	}
+	newxprt->sc_max_send_sges += (svcrdma_max_req_size / PAGE_SIZE) + 1;
+	if (newxprt->sc_max_send_sges > dev->attrs.max_send_sge)
+		newxprt->sc_max_send_sges = dev->attrs.max_send_sge;
 	newxprt->sc_max_req_size = svcrdma_max_req_size;
 	newxprt->sc_max_requests = svcrdma_max_requests;
 	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;


