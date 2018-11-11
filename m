Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB15C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FE72080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FE72080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeKLF5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:57:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52156 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730988AbeKLF5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:57:04 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtD-0000lJ-Kr; Sun, 11 Nov 2018 19:59:23 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001Oq-DZ; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Scott Mayhew" <smayhew@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.79942609@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 035/366] nfsd: restrict rd_maxcount to
 svc_max_payload in nfsd_encode_readdir
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfsd/nfs4xdr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3343,7 +3343,8 @@ nfsd4_encode_readdir(struct nfsd4_compou
 		nfserr = nfserr_resource;
 		goto err_no_verf;
 	}
-	maxcount = min_t(u32, readdir->rd_maxcount, INT_MAX);
+	maxcount = svc_max_payload(resp->rqstp);
+	maxcount = min_t(u32, readdir->rd_maxcount, maxcount);
 	/*
 	 * Note the rfc defines rd_maxcount as the size of the
 	 * READDIR4resok structure, which includes the verifier above
@@ -3357,7 +3358,7 @@ nfsd4_encode_readdir(struct nfsd4_compou
 
 	/* RFC 3530 14.2.24 allows us to ignore dircount when it's 0: */
 	if (!readdir->rd_dircount)
-		readdir->rd_dircount = INT_MAX;
+		readdir->rd_dircount = svc_max_payload(resp->rqstp);
 
 	readdir->xdr = xdr;
 	readdir->rd_maxcount = maxcount;

