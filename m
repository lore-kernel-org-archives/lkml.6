Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8102BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4757520855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543926;
	bh=Q5TL262bfmcDZYUgkosnM5tsS6icbg6FqRQFqfpCIoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P/uH9uh7jeb7uCkW76yIfanRgdnqW2l7mjbgmXLB9N2HQFo3ErS8jaVMS8hINT+Q9
	 J52PyIJxufqI3vl4LXi/QiK7DvkzDnJs+X32WxH+AA+I5ceAWY48cScd7mkyNs+Ntt
	 hb+N6LBh2Q1fdQ0ZmdK0PvqfYK/URxq4DBATPK54=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4757520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbeLKP6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731059AbeLKP6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B3D120855;
        Tue, 11 Dec 2018 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543923;
        bh=Q5TL262bfmcDZYUgkosnM5tsS6icbg6FqRQFqfpCIoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJHv33pIf9Cr22mxGEjoqwBxNWhSbnvP+TKUxKD+K1HYYAWycQFXMivdU+eL/Jqis
         lmzAgXbBR701JTYOzDYIMiIh4xpNlXybnSsiUqqtzGEsZHjWIevk8jyOVO4YMV7dKV
         s9+NRI/v3pLl5JgLaKtHHo0LKsrdT+hD0287b044=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        stable@kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 081/118] SUNRPC: Fix leak of krb5p encode pages
Date:   Tue, 11 Dec 2018 16:41:40 +0100
Message-Id: <20181211151647.538663339@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit 8dae5398ab1ac107b1517e8195ed043d5f422bd0 upstream.

call_encode can be invoked more than once per RPC call. Ensure that
each call to gss_wrap_req_priv does not overwrite pointers to
previously allocated memory.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/auth_gss/auth_gss.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1768,6 +1768,7 @@ priv_release_snd_buf(struct rpc_rqst *rq
 	for (i=0; i < rqstp->rq_enc_pages_num; i++)
 		__free_page(rqstp->rq_enc_pages[i]);
 	kfree(rqstp->rq_enc_pages);
+	rqstp->rq_release_snd_buf = NULL;
 }
 
 static int
@@ -1776,6 +1777,9 @@ alloc_enc_pages(struct rpc_rqst *rqstp)
 	struct xdr_buf *snd_buf = &rqstp->rq_snd_buf;
 	int first, last, i;
 
+	if (rqstp->rq_release_snd_buf)
+		rqstp->rq_release_snd_buf(rqstp);
+
 	if (snd_buf->page_len == 0) {
 		rqstp->rq_enc_pages_num = 0;
 		return 0;


