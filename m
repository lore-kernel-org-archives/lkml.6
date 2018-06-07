Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zzvgK/hOGVvWegAAmS7hNA
	; Thu, 07 Jun 2018 15:27:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 67781608B8; Thu,  7 Jun 2018 15:27:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pELKZo7S"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F3403601B4;
	Thu,  7 Jun 2018 15:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3403601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeFGP11 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:27:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933435AbeFGO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=doiA9w6bwh4vkmXFcmeOJC1Xglpt77A5WEvXygAnia4=; b=pELKZo7SYYzlacQUvbgFtM3E/
        3887Su0JeKqxucWgXuIYzKo77YpMhtZ8UaAzt3O8Mbs+q3E/K3VOjfGtySDiQwH2ww3bwY0BCyH8E
        wDoKiCIZb6CBs7FhAdqCDQ/Wj63Q/+bXfAIAwRPKvW771SFJgCgefsW6f0uXsHQiOnTPncCm5Q34U
        ox+EGCNZQYFN3x9tORJBytpKV8WtWK0VBPtujegNNmP9I1u7bBBMZ9I7zF4lBI51Rm9NJqOFlXz2F
        9ylOtp2PkukQtFFXyORkrjmyVRgFTrzWNQAgqUK1b8u8PgDoVxzmuQZ5xaDrZLPbeLrRzICU+vgfJ
        P8N2nxAjQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQwLt-0005u1-GK; Thu, 07 Jun 2018 14:57:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH 5/6] Convert jffs2 acl to struct_size
Date: Thu,  7 Jun 2018 07:57:19 -0700
Message-Id: <20180607145720.22590-6-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180607145720.22590-1-willy@infradead.org>
References: <20180607145720.22590-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Need to tell the compiler that the acl entries follow the acl header.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/jffs2/acl.c | 3 ++-
 fs/jffs2/acl.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 7ebacf14837f..093ffbd82395 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -133,7 +133,8 @@ static void *jffs2_acl_to_medium(const struct posix_acl *acl, size_t *size)
 	size_t i;
 
 	*size = jffs2_acl_size(acl->a_count);
-	header = kmalloc(sizeof(*header) + acl->a_count * sizeof(*entry), GFP_KERNEL);
+	header = kmalloc(struct_size(header, a_entries, acl->a_count),
+			GFP_KERNEL);
 	if (!header)
 		return ERR_PTR(-ENOMEM);
 	header->a_version = cpu_to_je32(JFFS2_ACL_VERSION);
diff --git a/fs/jffs2/acl.h b/fs/jffs2/acl.h
index 2e2b5745c3b7..12d0271bdde3 100644
--- a/fs/jffs2/acl.h
+++ b/fs/jffs2/acl.h
@@ -22,6 +22,7 @@ struct jffs2_acl_entry_short {
 
 struct jffs2_acl_header {
 	jint32_t	a_version;
+	struct jffs2_acl_entry	a_entries[];
 };
 
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
-- 
2.17.0
