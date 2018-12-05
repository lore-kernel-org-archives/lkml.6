Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCABC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEBB20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OOSQpjgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEBB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeLEToP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:44:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLEToM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mmbNXnLboc/4gvLXKLRKyRNNeEVA9d2POSwwCYCDKPI=; b=OOSQpjgGLwHg8uxTF2p4rofAqC
        M3LbucbBrPXovWBCQQ5UzMNAHvCz26X0trUfqIzytCn5xklM8al9mS6IC5kvaSQYZYX8J6fu6GeKb
        414qviafBAAPV7S+kjG2JNfWVQbVZ3763/nqC7hHbag+1+eE5TiA0QpqNXJO7Hn/nxMS4ZgXkGZ+N
        BH9l02ouN1I04DY8LdQhzN10HRTmy2RmpsCAFJJ4gBk4uJBnoWKkxi7t1HfrsCN6usCxQt53aIjxT
        HvvANywQUQPVESvfquBAWQPLM40Vrg6VdqOWowAeC5FPbFRmOKxhs/lPW9rD+iVtDDv8VjHQL5la1
        +aVQCdDg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUd5d-0005m0-HJ; Wed, 05 Dec 2018 19:44:09 +0000
Date:   Wed, 5 Dec 2018 11:44:09 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        adobriyan@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        sfr@canb.auug.org.au, kirill.shutemov@linux.intel.com,
        rppt@linux.vnet.ibm.com, mhocko@suse.com,
        alexander.h.duyck@linux.intel.com, hannes@cmpxchg.org,
        miles.chen@mediatek.com, n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH] /proc/kpagecount: return 0 for special pages that are
 never mapped
Message-ID: <20181205194409.GB11646@bombadil.infradead.org>
References: <1543963526-27917-1-git-send-email-anthony.yznaga@oracle.com>
 <20181205004836.GU10377@bombadil.infradead.org>
 <fa5b667d-ccfb-b11a-2aeb-b1007651f9ec@oracle.com>
 <20181205012534.GW10377@bombadil.infradead.org>
 <540f7690-5fcd-04d6-edb3-a44ebd09e70c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <540f7690-5fcd-04d6-edb3-a44ebd09e70c@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:40:51AM -0800, Anthony Yznaga wrote:
> On 12/04/2018 05:25 PM, Matthew Wilcox wrote:
> > On Tue, Dec 04, 2018 at 05:18:32PM -0800, anthony.yznaga@oracle.com wrote:
> >> On 12/04/2018 04:48 PM, Matthew Wilcox wrote:
> >>> On Tue, Dec 04, 2018 at 02:45:26PM -0800, Anthony Yznaga wrote:
> >>>> +static inline int page_has_type(struct page *page)
> >>>> +{
> >>>> +	return (PageType(page, 0) &&
> >>>> +	       ((page->page_type & PAGE_TYPE_ALL) != PAGE_TYPE_ALL));
> >>>> +}
> >>>> +
> >>> I think this is a bit complex, and a bit of a pain to update as we add
> >>> new page types.  How about this?
> >>>
> >>> 	return (int)page_type < -128;
> >>>
> >>> (I'm open to appropriate #defines to make this more obvious that it's ~0x7F)
> >> I thought about having this:
> >>
> >> #define PAGE_TYPE_END    0xffffff80
> >>
> >> static int inline page_has_type(struct page *page)
> >> {
> >>     return page->page_type > PAGE_TYPE_BASE &&
> >>            page->page_type < PAGE_TYPE_END;
> >> }
> >>
> >> But I opted for the additional complexity to avoid more false-positives from
> >> possibly corrupted values.  I'm certainly fine with a simple approach, though.
> > The way I'm thinking about this field is that usually it's _mapcount
> > which is 0xffffffff to represent 0.  We allow a certain small amount
> > of underflow and still treat it as a mapcount.  We also allow for some
> > amount of overflow.  So to be utterly precise, what you had there would
> > have been fine, but for simplicity, I'd rather just do a signed compare
> > against -128.
> The signed compare does not allow for mapcount overflow.  Is that acceptable?
> False-positives would be benign for /proc/kpagecount though from a debug
> perspective it could be helpful to see overflowed mapcounts.  Some future
> caller would need separate consideration.

Nobody seems terribly interested in mapcount overflows.  I got no response
to https://lkml.org/lkml/2018/3/2/991
