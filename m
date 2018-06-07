Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mt7pOuZOGVtmegAAmS7hNA
	; Thu, 07 Jun 2018 15:27:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C9DD4608BF; Thu,  7 Jun 2018 15:27:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dmZRTYzI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 620AC601B4;
	Thu,  7 Jun 2018 15:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 620AC601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbeFGP1c (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:27:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933434AbeFGO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xsb0j3/KujJNiCnPZvcvW92k5DtDb55gHp7c0RLDjgA=; b=dmZRTYzIwVu26IZrJChBPkz8y
        vNKA3qg4ZSVUdN+IYrtxAruYr9DAJ3D+MYfJ9CabNI5+VNOa0Az/qOUCBYOxv/7ocH6mhVEk4VFBj
        NBg8vxtRdubQPip6QfnLQrjt9uzb50wfqHjCS2OwUv+GbuO+g6TIjJRoLfHoHpWUPNBlAJCVmo/Rn
        3MJBROaL9nDKxSVMJhLbJ/UDIYto8z9hj35c34TKyYFmSmD04zu+2fb0n84lOSxzUdnBR5pwAC7FN
        YLyzPP+LRnouQQAaout6hh/gu5pBWvnAkmPfoZtr2ufXhWzuPWnD7pucBBtlCnqlb8IMPXX6eADik
        t0nV1w63w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQwLt-0005tr-0u; Thu, 07 Jun 2018 14:57:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH 3/6] Convert v4l2 event to struct_size
Date: Thu,  7 Jun 2018 07:57:17 -0700
Message-Id: <20180607145720.22590-4-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607145720.22590-1-willy@infradead.org>
References: <20180607145720.22590-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/media/v4l2-core/v4l2-event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
index 968c2eb08b5a..127fe6eb91d9 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -215,8 +215,7 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
 	if (elems < 1)
 		elems = 1;
 
-	sev = kvzalloc(sizeof(*sev) + sizeof(struct v4l2_kevent) * elems,
-		       GFP_KERNEL);
+	sev = kvzalloc(struct_size(sev, events, elems), GFP_KERNEL);
 	if (!sev)
 		return -ENOMEM;
 	for (i = 0; i < elems; i++)
-- 
2.17.0
