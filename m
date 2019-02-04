Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F10EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5193220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277824;
	bh=e1Kf2spMoXULOzrUoU6WGylCZwWgoXenCF3zV799+dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W8gzz3i8xMu0bi0F+3NI/UcCo8ZeN00eUPjctpNhjN9n6qIoNBVHRWUX3H5ThVmR3
	 3HL5Nq+uA2HvV8TdKye0E7DyS7s9F8MycLolIaSCshZlUcD7jWXJBLefbXRdWF0sv/
	 I0sBpfh5GYM6RPYNQcM7EuA8pkKXhHiPZ8C+ATq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbfBDKwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:52:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732545AbfBDKwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:52:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F7E2070C;
        Mon,  4 Feb 2019 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277531;
        bh=e1Kf2spMoXULOzrUoU6WGylCZwWgoXenCF3zV799+dA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2q7k+sKszGKiw8Yyae44PYNyXdFRb8LFAp2qc30j7Bap+hEfDKh9JxLMnV7j1fxkf
         Re4fVui9xf8+MU36nAt6n54clYYKD5Mpcccu9M/tpYb2+FlyJj1DLEcRwsQbLO5f67
         PKby//JKxdiFlIzcNEav7wtH6wYEGlUvF/5uFQsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.20 43/80] NFS: Fix up return value on fatal errors in nfs_page_async_flush()
Date:   Mon,  4 Feb 2019 11:37:03 +0100
Message-Id: <20190204103625.999981233@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: Trond Myklebust <trondmy@gmail.com>

commit 8fc75bed96bb94e23ca51bd9be4daf65c57697bf upstream.

Ensure that we return the fatal error value that caused us to exit
nfs_page_async_flush().

Fixes: c373fff7bd25 ("NFSv4: Don't special case "launder"")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.12+
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/write.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -621,11 +621,12 @@ static int nfs_page_async_flush(struct n
 	nfs_set_page_writeback(page);
 	WARN_ON_ONCE(test_bit(PG_CLEAN, &req->wb_flags));
 
-	ret = 0;
+	ret = req->wb_context->error;
 	/* If there is a fatal error that covers this write, just exit */
-	if (nfs_error_is_fatal_on_server(req->wb_context->error))
+	if (nfs_error_is_fatal_on_server(ret))
 		goto out_launder;
 
+	ret = 0;
 	if (!nfs_pageio_add_request(pgio, req)) {
 		ret = pgio->pg_error;
 		/*
@@ -635,9 +636,9 @@ static int nfs_page_async_flush(struct n
 			nfs_context_set_write_error(req->wb_context, ret);
 			if (nfs_error_is_fatal_on_server(ret))
 				goto out_launder;
-		}
+		} else
+			ret = -EAGAIN;
 		nfs_redirty_request(req);
-		ret = -EAGAIN;
 	} else
 		nfs_add_stats(page_file_mapping(page)->host,
 				NFSIOS_WRITEPAGES, 1);


