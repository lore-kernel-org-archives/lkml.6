Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5uGuEJpOGVv4eAAAmS7hNA
	; Thu, 07 Jun 2018 15:27:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 039B0608B8; Thu,  7 Jun 2018 15:27:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gbA5tF1K"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E28E60115;
	Thu,  7 Jun 2018 15:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E28E60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935754AbeFGP1Z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:27:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933417AbeFGO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p+lQr6bAugSImnC9444JxiiPjhXApjVlWYwVp+W2KAI=; b=gbA5tF1KgJmlJfbYcAgk0bwux
        Svd3q/JqkBzlvA9QdOWP9G4JL/32nXM8Sw27EIvRN4TviGguTLfQB0pPbup33NzFeB+davpWZOMrP
        kE0eEPsYbQptIJ1g7x+yTeUabDG4s/ayTfpxe3TJCKyjG3gL5g2gQWjIpJZuyqHy/pCHCJt8GsFQF
        v981eKjb76d/HsvXnr8jkZab19KMCLOn3bLgYI2hYgu5W5lvfEREU595P9SrFWZkTgJP4EY1un4bk
        1rOBBksdq6/JoMCuK0X7NKPZfjPmg830ZwI3RHyZDskD2ZGSrB5qdiVFKBRdyEIrA6BiidOduIlkJ
        y6lz6w2VA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQwLs-0005tn-OG; Thu, 07 Jun 2018 14:57:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH 2/6] Convert infiniband uverbs to struct_size
Date: Thu,  7 Jun 2018 07:57:16 -0700
Message-Id: <20180607145720.22590-3-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607145720.22590-1-willy@infradead.org>
References: <20180607145720.22590-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

The flows were hidden from the C compiler; expose them as a zero-length
array to allow struct_size to work.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 4 ++--
 include/rdma/ib_verbs.h              | 5 +----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index e3662a8ee465..67cab6102f7a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3478,8 +3478,8 @@ int ib_uverbs_ex_create_flow(struct ib_uverbs_file *file,
 		goto err_uobj;
 	}
 
-	flow_attr = kzalloc(sizeof(*flow_attr) + cmd.flow_attr.num_of_specs *
-			    sizeof(union ib_flow_spec), GFP_KERNEL);
+	flow_attr = kzalloc(struct_size(flow_attr, flows,
+				cmd.flow_attr.num_of_specs), GFP_KERNEL);
 	if (!flow_attr) {
 		err = -ENOMEM;
 		goto err_put;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9fc8a825aa28..bb6125ceb187 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2035,10 +2035,7 @@ struct ib_flow_attr {
 	u32	     flags;
 	u8	     num_of_specs;
 	u8	     port;
-	/* Following are the optional layers according to user request
-	 * struct ib_flow_spec_xxx
-	 * struct ib_flow_spec_yyy
-	 */
+	union ib_flow_spec flows[];
 };
 
 struct ib_flow {
-- 
2.17.0
