Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PpcKDPJOGVuzegAAmS7hNA
	; Thu, 07 Jun 2018 15:27:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1285F6089E; Thu,  7 Jun 2018 15:27:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sOgQKHIB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9A45860115;
	Thu,  7 Jun 2018 15:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A45860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbeFGP1a (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:27:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933409AbeFGO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dsa6ThT7gJQj3Ut/gWAzUKn6yLlkNfnBJLsuPvCngig=; b=sOgQKHIBw/iveujMEslcvBZ8W
        NB/53bpDMlpuIeBlqLkYv/sm0tdyNz+1e5Ew0WwddUtGhwqJeo7h5QEASuSgvV+y+nK0J+wxz4TYi
        G/6UKnE8tDk/Eglhj/V5TpstkR69Rt4GTJT1aMEABqgyy5vGO/fN9UBupCHZpstcbZ7ZLDJQZKs/U
        3IM67p/B+4YQDTDDr4oX3FlNpGu/F6PQ6782NyiaPbwzMP+GA0mpjsAKP7+LJyd8cW+selugppQMs
        6xteMiMa5qXeRlVwpv14OXFvR4hjh8kbIUvFywS1P/GLsPrPTUPjDPfsMpkqybeQhzhHvb0BM7Mh/
        aHyYbr35w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQwLt-0005tx-9b; Thu, 07 Jun 2018 14:57:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH 4/6] Convert vhost to struct_size
Date: Thu,  7 Jun 2018 07:57:18 -0700
Message-Id: <20180607145720.22590-5-willy@infradead.org>
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
 drivers/vhost/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 895eaa25807c..f9bce818da11 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1286,7 +1286,8 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
 		return -EOPNOTSUPP;
 	if (mem.nregions > max_mem_regions)
 		return -E2BIG;
-	newmem = kvzalloc(size + mem.nregions * sizeof(*m->regions), GFP_KERNEL);
+	newmem = kvzalloc(struct_size(newmem, regions, mem.nregions),
+			GFP_KERNEL);
 	if (!newmem)
 		return -ENOMEM;
 
-- 
2.17.0
