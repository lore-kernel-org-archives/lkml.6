Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1435C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A28B27441
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KLVz1hRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A28B27441
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966177AbeF1N1L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:27:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753810AbeF1N1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u4kDLeHjogkxVPPVZFNy9kKBP7gADz5yfE3nU2RpLJo=; b=KLVz1hRths1n4WTeVTTqGJK2t
        Ev8IDk13/KY3TAsGJb/bzDePKbQmBPG7n2NLj5trNNsNxcZMSAJcR966IhGwaDskvfVC35Aa+Fi2J
        4c2RjvICRJIsA436ORPGwdOBPWhat62r6U9CFCrsw46h+Dh9dngTFsrdQUJwPgPz7nmfYwvvMuACF
        HS41moSHM49JPB1ZI5Ugui8yj+0eHfA8LbmTfc3ztp2NvzWSNr5XRj36Nr1Jf08S0sL0XZfI1+R96
        ZHobmpSjqYxsZaSUUF8DDcpsExzfLGrZqGqzyreemSAhSPGQ5uo3x/7ftWxc1lEGKIKJni3GBa9ZD
        XKFWsSw/g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYWwt-0000rr-HV; Thu, 28 Jun 2018 13:26:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 4/6] 9p: Remove an unnecessary memory barrier
Date:   Thu, 28 Jun 2018 06:26:27 -0700
Message-Id: <20180628132629.3148-5-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628132629.3148-1-willy@infradead.org>
References: <20180628132629.3148-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And add a comment about why we don't need it.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 net/9p/client.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 602f76de388a..2dce8d8307cc 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -436,13 +436,9 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 {
 	p9_debug(P9_DEBUG_MUX, " tag %d\n", req->tc->tag);
 
-	/*
-	 * This barrier is needed to make sure any change made to req before
-	 * the other thread wakes up will indeed be seen by the waiting side.
-	 */
-	smp_wmb();
 	req->status = status;
 
+	/* wake_up is an implicit write memory barrier */
 	wake_up(&req->wq);
 	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc->tag);
 }
-- 
2.18.0

