Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCEDC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD3520C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbIChN8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD3520C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390430AbeGKVIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:08:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeGKVIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vims92MzV7pbYx+03vAmr+EMloaq4UlpZcN1+UjUUn8=; b=MbIChN8DbV+Jhv4ytOgvkTugf
        BCbuvylC0cqMqQ2/qOM/SYnQgd0CY93fToYf22V/vOoyhUW8H9QP7DzqR53ro7M28V+VD/k1VUVvs
        EkUKE4DDJhNw5L3FSYmZmB9kwY1N8x7jbbzuUKOCxzPyW4eBsvuhpqhYchmG168TbnMHGdoeLaMn1
        hUsc/85qH9KBYRk4M1h6s5jbQX+cGedCeX/OwXn8GfsBnJF2QGAKXsRRZswO4MtiW8IL3JtoETXFI
        z0ynUVs+RwgtAhPZmqeTC6Y1/ofjAVGS15D8vzbadPRJr6VIVGLH+WNrKd696YpzIQjOH66uZJe9d
        grb7+6INQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdMFp-0005A2-NM; Wed, 11 Jul 2018 21:02:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/6] 9p: Fix comment on smp_wmb
Date:   Wed, 11 Jul 2018 14:02:20 -0700
Message-Id: <20180711210225.19730-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711210225.19730-1-willy@infradead.org>
References: <20180711210225.19730-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous comment misled me into thinking the barrier wasn't needed
at all.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 net/9p/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 18c5271910dc..999eceb8af98 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -447,7 +447,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 
 	/*
 	 * This barrier is needed to make sure any change made to req before
-	 * the other thread wakes up will indeed be seen by the waiting side.
+	 * the status change is visible to another thread
 	 */
 	smp_wmb();
 	req->status = status;
-- 
2.18.0

