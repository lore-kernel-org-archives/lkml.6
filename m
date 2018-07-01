Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B48CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC882254E7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC882254E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbeGAQ4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:56:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753669AbeGAQow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:44:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9182892B;
        Sun,  1 Jul 2018 16:44:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.17 180/220] nfsd: restrict rd_maxcount to svc_max_payload in nfsd_encode_readdir
Date:   Sun,  1 Jul 2018 18:23:24 +0200
Message-Id: <20180701160915.736807134@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Mayhew <smayhew@redhat.com>

commit 9c2ece6ef67e9d376f32823086169b489c422ed0 upstream.

nfsd4_readdir_rsize restricts rd_maxcount to svc_max_payload when
estimating the size of the readdir reply, but nfsd_encode_readdir
restricts it to INT_MAX when encoding the reply.  This can result in log
messages like "kernel: RPC request reserved 32896 but used 1049444".

Restrict rd_dircount similarly (no reason it should be larger than
svc_max_payload).

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4xdr.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3651,7 +3651,8 @@ nfsd4_encode_readdir(struct nfsd4_compou
 		nfserr = nfserr_resource;
 		goto err_no_verf;
 	}
-	maxcount = min_t(u32, readdir->rd_maxcount, INT_MAX);
+	maxcount = svc_max_payload(resp->rqstp);
+	maxcount = min_t(u32, readdir->rd_maxcount, maxcount);
 	/*
 	 * Note the rfc defines rd_maxcount as the size of the
 	 * READDIR4resok structure, which includes the verifier above
@@ -3665,7 +3666,7 @@ nfsd4_encode_readdir(struct nfsd4_compou
 
 	/* RFC 3530 14.2.24 allows us to ignore dircount when it's 0: */
 	if (!readdir->rd_dircount)
-		readdir->rd_dircount = INT_MAX;
+		readdir->rd_dircount = svc_max_payload(resp->rqstp);
 
 	readdir->xdr = xdr;
 	readdir->rd_maxcount = maxcount;


