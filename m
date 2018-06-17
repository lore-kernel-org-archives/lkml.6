Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C047C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FB420891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BmOj2Qil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FB420891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753766AbeFQWuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 18:50:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeFQWut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 18:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HuQ/rOQfuykGNRh7B1gAYf/iZ8DQ+lM7rwBaMHv5eGA=; b=BmOj2QilFr62G/Xrs5tSbj+nA
        EzkRcLR+0LCWB/+mFvcj0zsn4+UlDyTFBKqKzopaf8b5198vuInF10hsaoirMQJlRmvvK0tU2sFan
        k5LC4RHFZpYDZHxDmGUUZHl0AEUi4n/OZoNQGmW5zJMkUoqeVYJZsXFjdgzYxJ9RlkPhXB5sxBs6M
        wbW7VtEH5wGpkGhvlWsxEeDQQqCvY93ldueFOrylWRIYY93b2yE5Onrn3IOokbeCsH9B+AlCBDr9k
        /sm4TgAI8+8T6N60zvldZoBbGSoEjtZ9UpfTfpZWOJNENml9PF8MaWGOFTccpHUjXhU024AO/LAOG
        fiJTODvlg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUgVS-0002WV-B2; Sun, 17 Jun 2018 22:50:46 +0000
Date:   Sun, 17 Jun 2018 15:50:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: Call destructor during __pte_free_tlb
Message-ID: <20180617225046.GB21805@bombadil.infradead.org>
References: <20180617221243.10126-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617221243.10126-1-shorne@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 07:12:42AM +0900, Stafford Horne wrote:
> During the __pte_free_tlb path openrisc fails to call the page
> destructor which would clear the new bits that were introduced.
> To fix this we are calling the destructor.
> 
> It seem openrisc was the only architecture missing this,  all other
> architectures either call the destructor like we are doing here or use
> pte_free.

It may be worth noting that failing to call the destructor was also
messing up the zone stats (and would be causing other problems if
you were using SPLIT_PTE_PTLOCKS).

At any rate, Acked-by: Matthew Wilcox <willy@infradead.org>
