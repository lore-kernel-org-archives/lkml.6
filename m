Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F48C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E85E20815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfBCN7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:59:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53476 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728231AbfBCNty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:54 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9f-0003tv-IT; Sun, 03 Feb 2019 13:49:51 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9b-00073r-GZ; Sun, 03 Feb 2019 14:49:47 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Frank Sorenson" <sorenson@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.257995403@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 142/305] sunrpc: correct the computation for page_ptr
 when truncating
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Sorenson <sorenson@redhat.com>

commit 5d7a5bcb67c70cbc904057ef52d3fcfeb24420bb upstream.

When truncating the encode buffer, the page_ptr is getting
advanced, causing the next page to be skipped while encoding.
The page is still included in the response, so the response
contains a page of bogus data.

We need to adjust the page_ptr backwards to ensure we encode
the next page into the correct place.

We saw this triggered when concurrent directory modifications caused
nfsd4_encode_direct_fattr() to return nfserr_noent, and the resulting
call to xdr_truncate_encode() corrupted the READDIR reply.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sunrpc/xdr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -637,11 +637,10 @@ void xdr_truncate_encode(struct xdr_stre
 		/* xdr->iov should already be NULL */
 		return;
 	}
-	if (fraglen) {
+	if (fraglen)
 		xdr->end = head->iov_base + head->iov_len;
-		xdr->page_ptr--;
-	}
 	/* (otherwise assume xdr->end is already set) */
+	xdr->page_ptr--;
 	head->iov_len = len;
 	buf->len = len;
 	xdr->p = head->iov_base + head->iov_len;

