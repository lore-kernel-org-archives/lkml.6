Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2DAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E37E222D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rEIVnWW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391068AbfBOUU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:20:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbfBOUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t4kh6gL7Nt9+3Mr1Ov9ssDsZXZ4VLPAcQPbRxG5XoQE=; b=rEIVnWW2VmDLAFvnYVAJS9d0A
        WYO74VFpVSuuTJjJTmuLb2Pd0os80RVkoZMhJ1+8pMVhnDNhDN2XsYrNcgBIf45rUowaVCLh9uyc7
        qIf0clGtvkiiCE3+56fIKS+l/L+9u+yNjbr7G8/U0n7gjdwtL7ZTaKwfQH0KKImdKB4Rzk1+sIAwG
        r/hYCUPKEXeL+VFFtvEaSKQCHvBT+/8CUCESKqWK4DtMd/75Scf/P6mnDaVy1KD318xj3lea9Vt8j
        l33nVqqjeTYkHev8OLJ+tPdu7Np5wHsWriuXqOouo2l7yDC4ACjZyCVseuMXb4X9G0dQgTdPuOUud
        3nftqlg1w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gujyj-0008Pk-7C; Fri, 15 Feb 2019 20:20:57 +0000
Date:   Fri, 15 Feb 2019 12:20:57 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190215202056.GK12668@bombadil.infradead.org>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
 <20190214224115.4edwl7x72abztajb@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214224115.4edwl7x72abztajb@kshutemo-mobl1>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:41:15AM +0300, Kirill A. Shutemov wrote:
>   - __delete_from_swap_cache() will blow up on
> 
> 	VM_BUG_ON_PAGE(entry != page + i, entry);

Right.

@@ -167,7 +167,7 @@ void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
 
        for (i = 0; i < nr; i++) {
                void *entry = xas_store(&xas, NULL);
-               VM_BUG_ON_PAGE(entry != page + i, entry);
+               VM_BUG_ON_PAGE(entry != page, entry);
                set_page_private(page + i, 0);
                xas_next(&xas);
        }

