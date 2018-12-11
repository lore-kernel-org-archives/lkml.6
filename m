Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4293C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CED420880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543464;
	bh=ZShHpVnuuL/xjVxHnef/pKWMk+2XiMoqV21r/CH7YFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fG+But9752Oo5W/izEi4bmWlPZNkf6LDvHa6PHwsvfgmfZRe7VnmgKZyT4PHmuOz+
	 Drl057wXi+ripUZ5rP09mRVs3Ighzaf0aD5xUaukml/x4ax0LKFjR8VKBBGaUiKFov
	 WyBYxBzwY8gQVJNrN5XnppcQ/qCyvlTk7GtFZcAw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CED420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbeLKPvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:51:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728634AbeLKPvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:51:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F410C20855;
        Tue, 11 Dec 2018 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543459;
        bh=ZShHpVnuuL/xjVxHnef/pKWMk+2XiMoqV21r/CH7YFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMWq7FW59meD3ztxm9kvEOjXfk47wo3wPVJ5grPGTvyp5ypmU1FNgjB+4Xk8EERGJ
         26XfTDBEc6y45G1lw7iHHKRDuZnQBNGWu0qecc8RSTQqqnB43hKsl07gQt7aFu1JWu
         fgUWEt80k+l/CdOTRBxh2puFCHxc4q0JAIdtdM2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        stable@kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.9 32/51] SUNRPC: Fix leak of krb5p encode pages
Date:   Tue, 11 Dec 2018 16:41:40 +0100
Message-Id: <20181211151616.755917173@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1736,6 +1736,7 @@ priv_release_snd_buf(struct rpc_rqst *rq
 	for (i=0; i < rqstp->rq_enc_pages_num; i++)
 		__free_page(rqstp->rq_enc_pages[i]);
 	kfree(rqstp->rq_enc_pages);
+	rqstp->rq_release_snd_buf = NULL;
 }
 
 static int
@@ -1744,6 +1745,9 @@ alloc_enc_pages(struct rpc_rqst *rqstp)
 	struct xdr_buf *snd_buf = &rqstp->rq_snd_buf;
 	int first, last, i;
 
+	if (rqstp->rq_release_snd_buf)
+		rqstp->rq_release_snd_buf(rqstp);
+
 	if (snd_buf->page_len == 0) {
 		rqstp->rq_enc_pages_num = 0;
 		return 0;


