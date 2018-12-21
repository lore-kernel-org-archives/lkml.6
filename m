Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E357CC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A034F2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/b59+yF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390427AbeLUTpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:45:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbeLUTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Dp90EFvnmLmkfb4kRJucTqBYIXFRsXHuSAR/QtUaRI=; b=c/b59+yFxIzcrLU/82hrWB16K
        jiDWa2iIShlXNooddv1peYIvR60T1gmDG1jcIXFjUvwbNP7lJ0il8CUvZy6e1HhcpL3IrDW/J0vdp
        +8VE3Cyj95Jyaealc02YTbhrY/0J8vGZ2Kys1WOo+3bPppQh2j3Xdp8wLRDBxxwZGmg4HcaR7lxEe
        RcMAvfeMKWHDMM2YDldw4OobYkdVs8Huq/LRLiVH4JPJxRv+/txQG/d/Co52DKsezgDwCrJGo04nm
        9mLUkIlk6epM/0JMmQx16xXe5MQK2QRlZAXthaXI2IO0FYXcc6vGmYQVQFRl1FTpK4RhzPYl6DAfJ
        EfYkS7j3w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaQjz-0002DE-VJ; Fri, 21 Dec 2018 19:45:47 +0000
Date:   Fri, 21 Dec 2018 11:45:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, igor.stoppa@huawei.com,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] __wr_after_init: generic header
Message-ID: <20181221194547.GI10600@bombadil.infradead.org>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-4-igor.stoppa@huawei.com>
 <8474D7CA-E5FF-40B1-9428-855854CDDB5F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8474D7CA-E5FF-40B1-9428-855854CDDB5F@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:38:16AM -0800, Nadav Amit wrote:
> > On Dec 19, 2018, at 1:33 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
> > 
> > +static inline void *wr_memset(void *p, int c, __kernel_size_t len)
> > +{
> > +	return __wr_op((unsigned long)p, (unsigned long)c, len, WR_MEMSET);
> > +}
> 
> What do you think about doing something like:
> 
> #define __wr          __attribute__((address_space(5)))
> 
> And then make all the pointers to write-rarely memory to use this attribute?
> It might require more changes to the code, but can prevent bugs.

I like this idea.  It was something I was considering suggesting.
