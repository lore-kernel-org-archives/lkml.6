Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3155C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E82214ED
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wFxCpgRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E82214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407198AbeKTDaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:30:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405988AbeKTDay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:30:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E1A214D9;
        Mon, 19 Nov 2018 17:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647196;
        bh=PjdxrXyDJR9PBYU6DjyOe+4XiOvPPTwFHuPLndZlTRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFxCpgRP7GCJxrg8IYtsVtB1xWEePQedIuJ0SNMDrTtsGEaZuDT0nLal+l5aUWuqJ
         fxHpYaIJg41ySWKgHSQxkc0xd0xmi9oTbAtSrrDtbKzx2ewdR/LgUe05e3EIp8WiLL
         tm7RMKciWf+0fnAphTwYE+bwSp+A8aI8tz73wp3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Sorenson <sorenson@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3.18 87/90] sunrpc: correct the computation for page_ptr when truncating
Date:   Mon, 19 Nov 2018 17:30:09 +0100
Message-Id: <20181119162633.751838058@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xdr.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -638,11 +638,10 @@ void xdr_truncate_encode(struct xdr_stre
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


