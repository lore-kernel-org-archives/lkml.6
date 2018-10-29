Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78AFC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F65E2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qoUpw6Jl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F65E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeJ2LRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:17:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbeJ2LRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HgVFgci+gjDF7DF5bd6K2ongmaAjKrHaNK3ZkD4uZPQ=; b=qoUpw6JlTu2E46hzop7Msu8Sh
        UtVNFkbZ8aA92MtV4P6RKqq9F/JlYOPmHPzmkRflNhXX3MwkdBtJO6f25LpaMSqWVBvyVWYv2TZbC
        I6vbWI91pdjJalWv/Fe+N7pkquXDl3JZpZMeSrtVa2oAxSmm613tUtHny6UOQa/hsnkNYX9kyPVgA
        Hs6wo/cHOsfZwJi1wynKE0tYVXPwHxDJjWfbOx8LC7Vs/IHS2oVfb16DvmBc1H2RVsFl6nU2ITlez
        mAi9zO4RWwGZqntB9qMFAShH56uVVgfXyNkr0ZC0nk+052In7q7n9ayuhoxKDwceGpBIHVz8M38o0
        hVTcecWiA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGxJz-0002ef-1T; Mon, 29 Oct 2018 02:30:27 +0000
Date:   Sun, 28 Oct 2018 19:30:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     miles.chen@mediatek.com
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCHv2] mm/page_owner: use kvmalloc instead of kmalloc
Message-ID: <20181029023026.GC28520@bombadil.infradead.org>
References: <1540779403-27622-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540779403-27622-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:16:43AM +0800, miles.chen@mediatek.com wrote:
> The kbuf used by page owner is allocated by kmalloc(), which means it
> can use only normal memory and there might be a "out of memory"
> issue when we're out of normal memory.
> 
> Use kvmalloc() so we can also allocate kbuf from
> normal/hihghmem on 32bit kernel.

That's a misconception:

        ret = kmalloc_node(size, kmalloc_flags, node);

        /*
         * It doesn't really make sense to fallback to vmalloc for sub page
         * requests
         */
        if (ret || size <= PAGE_SIZE)
                return ret;

Now, maybe this is an opportunity for us to improve kvmalloc.  Maybe like
this ...

diff --git a/mm/util.c b/mm/util.c
index 8bf08b5b5760..fdf5b34d2c28 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -416,10 +416,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	ret = kmalloc_node(size, kmalloc_flags, node);
 
 	/*
-	 * It doesn't really make sense to fallback to vmalloc for sub page
-	 * requests
+	 * It only makes sense to fallback to vmalloc for sub page
+	 * requests if we might be able to allocate highmem pages.
 	 */
-	if (ret || size <= PAGE_SIZE)
+	if (ret || (!IS_ENABLED(CONFIG_HIGHMEM) && size <= PAGE_SIZE))
 		return ret;
 
 	return __vmalloc_node_flags_caller(size, node, flags,
