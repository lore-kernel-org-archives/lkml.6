Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CDDC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294DE218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZXEgHwlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfAYTaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:30:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfAYTaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ww5Iu1QbHYxludV75gZhSQ1cVEB4MwtTUBxCvKbV0Ns=; b=ZXEgHwlKvOWKrx9g0SlEIbYLw
        TadyUIABncSF685kG7JRSlFsswQbGTUv92YWPb1ggkkkz7605W1p4x2vwEbffXHgJ72YfdJUmPs3k
        5ZTDQanfHFYbrFj0bytN7hN+WJB+nVn612lYPk9hEt6o8kHfjA0l/+w17h65NyWWKrvej4lgosUyd
        1FP/BbsIgoHLcnLLlilzSr90rHCA8sdIMmvoPyfTrP12YP7MIiQU5aPrPWM/5IHhv3U/laqLV1eKj
        6Fpcc7jrbwCp602NukzUdUMUhUZ7COB40/Hqg5QIjusLWI5gP42LCW6yIlk/qZnzZlI0LS4XHT3to
        PfuRFIQnQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gn7Ay-0007es-Su; Fri, 25 Jan 2019 19:30:04 +0000
Date:   Fri, 25 Jan 2019 11:30:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] mm: Prevent mapping slab pages to userspace
Message-ID: <20190125193004.GA21155@bombadil.infradead.org>
References: <20190125173827.2658-1-willy@infradead.org>
 <CAGXu5jJ=yHXC_S_o6V4QQ+DCV4w2T-tw_BiUXDAW2a8rZDhZJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ=yHXC_S_o6V4QQ+DCV4w2T-tw_BiUXDAW2a8rZDhZJg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 07:44:40AM +1300, Kees Cook wrote:
> > -       if (PageAnon(page))
> > +       if (PageAnon(page) || PageSlab(page))
> 
> Are there other types that should not get mapped? (Or better yet, is
> there a whitelist of those that are okay to be mapped?)

Funny you should ask; I think the next patch in this series looks like this:

-       if (PageAnon(page) || PageSlab(page))
+       if (PageAnon(page) || PageSlab(page) || page_has_type(page))

but let's see if there's something I've overlooked with this patch.
