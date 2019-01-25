Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BDBC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D318218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nf8Bb+7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfAYRiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:38:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5fm7+VQclmc9hs1XdDfzoo0+kGTLRUZeg8UOcg8q+Z4=; b=nf8Bb+7W8x8wxgblLvy6oWMic
        d652mU0FzZk0JJee7uTAu8bH38PuCNnOgXPoWfLnj6NvmVvMVGjnWFKC+RDBigMq35LO4lvc7D7dn
        rkSem+D3vPoXfBabKSOPe+i9kSlzYTl2Lay6bBxCfYHkojLqgj3vawCoDKa9BbKQ4kYWJdGX0iNUC
        HdjdIt518XQF7vHcGAI2CShiycADvgCzYmkWMrvXwq4giB+5GXJPlzdqeL4br4whw8XZp0nVtlG62
        cCL2HclCSzKdzKjbuibSwZTUrnauEnJ7RfLH3cMctor6SHckglSa9UgEI145lPqlCPIHzgqNhDHcz
        EJkl3+VbQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gn5R9-0000hr-Ei; Fri, 25 Jan 2019 17:38:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] mm: Prevent mapping slab pages to userspace
Date:   Fri, 25 Jan 2019 09:38:27 -0800
Message-Id: <20190125173827.2658-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's never appropriate to map a page allocated by SLAB into userspace.
A buggy device driver might try this, or an attacker might be able to
find a way to make it happen.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index e11ca9dd823f..ce8c90b752be 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1451,7 +1451,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	spinlock_t *ptl;
 
 	retval = -EINVAL;
-	if (PageAnon(page))
+	if (PageAnon(page) || PageSlab(page))
 		goto out;
 	retval = -ENOMEM;
 	flush_dcache_page(page);
-- 
2.20.1

