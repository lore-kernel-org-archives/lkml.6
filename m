Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D41CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E637320839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtheV6jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E637320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbeKLISV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732701AbeKLISU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:20 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC15621527;
        Sun, 11 Nov 2018 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975304;
        bh=eWVwcroubJxb7p98oDmQDuYL7BuhIcsH8EFG8k6XvgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtheV6jyLIDJXwz2o18660/KtCNrCGt5AnB5IzrXRRV7vKUd11aUx4fQOEihVLuxx
         DATbaxdskkHp5I+QO7QMteOOR9en+c42Mw95YVs4RLWLuMB+lZyh/NOnOHXZAxw0Yc
         LVA7Rsh3+vXIJ23RPzwylvPZUIqqtxcZZW6C4EXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 271/361] nfs: Fix a missed page unlock after pg_doio()
Date:   Sun, 11 Nov 2018 14:20:18 -0800
Message-Id: <20181111221655.049764018@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Coddington <bcodding@redhat.com>

commit fdbd1a2e4a71adcb1ae219fcfd964930d77a7f84 upstream.

We must check pg_error and call error_cleanup after any call to pg_doio.
Currently, we are skipping the unlock of a page if we encounter an error in
nfs_pageio_complete() before handing off the work to the RPC layer.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pagelist.c |   40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1111,6 +1111,20 @@ static int nfs_pageio_add_request_mirror
 	return ret;
 }
 
+static void nfs_pageio_error_cleanup(struct nfs_pageio_descriptor *desc)
+{
+	u32 midx;
+	struct nfs_pgio_mirror *mirror;
+
+	if (!desc->pg_error)
+		return;
+
+	for (midx = 0; midx < desc->pg_mirror_count; midx++) {
+		mirror = &desc->pg_mirrors[midx];
+		desc->pg_completion_ops->error_cleanup(&mirror->pg_list);
+	}
+}
+
 int nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 			   struct nfs_page *req)
 {
@@ -1161,25 +1175,11 @@ int nfs_pageio_add_request(struct nfs_pa
 	return 1;
 
 out_failed:
-	/*
-	 * We might have failed before sending any reqs over wire.
-	 * Clean up rest of the reqs in mirror pg_list.
-	 */
-	if (desc->pg_error) {
-		struct nfs_pgio_mirror *mirror;
-		void (*func)(struct list_head *);
-
-		/* remember fatal errors */
-		if (nfs_error_is_fatal(desc->pg_error))
-			nfs_context_set_write_error(req->wb_context,
-						    desc->pg_error);
-
-		func = desc->pg_completion_ops->error_cleanup;
-		for (midx = 0; midx < desc->pg_mirror_count; midx++) {
-			mirror = &desc->pg_mirrors[midx];
-			func(&mirror->pg_list);
-		}
-	}
+	/* remember fatal errors */
+	if (nfs_error_is_fatal(desc->pg_error))
+		nfs_context_set_write_error(req->wb_context,
+						desc->pg_error);
+	nfs_pageio_error_cleanup(desc);
 	return 0;
 }
 
@@ -1251,6 +1251,8 @@ void nfs_pageio_complete(struct nfs_page
 	for (midx = 0; midx < desc->pg_mirror_count; midx++)
 		nfs_pageio_complete_mirror(desc, midx);
 
+	if (desc->pg_error < 0)
+		nfs_pageio_error_cleanup(desc);
 	if (desc->pg_ops->pg_cleanup)
 		desc->pg_ops->pg_cleanup(desc);
 	nfs_pageio_cleanup_mirroring(desc);


