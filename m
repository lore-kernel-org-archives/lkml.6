Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F715C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C221A2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZmXIHHN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C221A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbeLEBZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:25:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeLEBZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZOYQ6mpshYhus4slzhR7rwm2nNJJHIQCI7kwfvkz5hQ=; b=ZmXIHHN/FuwDWDQ4Seb9nZYhwP
        k9CnCVB8KrEDdAgI1/3LIRmX2OtdXTBCySr09udjSO99oZK/W7WrC/VoiIMf1AwfEeO71+Q94+RV2
        NXtof4P/rrN5GotA7qBE0nStcHCWrDNeZ2mShiHh3hR02WlvLT/Kyv16xa3ISzjqAOGwS/9c8ZSLj
        zDJPxvftUM0/LKQwp4dpyagvVYSM1i4Dcw622QEFCcWBXdAQFZ0UvgGrZwn5xs/uW5CE9dlhsFsPG
        5GmToZH+sJeUhJ16oqrB6GM88+VvaevtTKSWQla/LGrwzKG4UL1S8YCI6GOdhH+pJ0lp4glDHM34M
        jtCX7XBg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gULwV-0007kY-1f; Wed, 05 Dec 2018 01:25:35 +0000
Date:   Tue, 4 Dec 2018 17:25:34 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     anthony.yznaga@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        adobriyan@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        sfr@canb.auug.org.au, kirill.shutemov@linux.intel.com,
        rppt@linux.vnet.ibm.com, mhocko@suse.com,
        alexander.h.duyck@linux.intel.com, hannes@cmpxchg.org,
        miles.chen@mediatek.com, n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH] /proc/kpagecount: return 0 for special pages that are
 never mapped
Message-ID: <20181205012534.GW10377@bombadil.infradead.org>
References: <1543963526-27917-1-git-send-email-anthony.yznaga@oracle.com>
 <20181205004836.GU10377@bombadil.infradead.org>
 <fa5b667d-ccfb-b11a-2aeb-b1007651f9ec@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa5b667d-ccfb-b11a-2aeb-b1007651f9ec@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:18:32PM -0800, anthony.yznaga@oracle.com wrote:
> On 12/04/2018 04:48 PM, Matthew Wilcox wrote:
> > On Tue, Dec 04, 2018 at 02:45:26PM -0800, Anthony Yznaga wrote:
> >> +static inline int page_has_type(struct page *page)
> >> +{
> >> +	return (PageType(page, 0) &&
> >> +	       ((page->page_type & PAGE_TYPE_ALL) != PAGE_TYPE_ALL));
> >> +}
> >> +
> >
> > I think this is a bit complex, and a bit of a pain to update as we add
> > new page types.  How about this?
> >
> > 	return (int)page_type < -128;
> >
> > (I'm open to appropriate #defines to make this more obvious that it's ~0x7F)
> 
> I thought about having this:
> 
> #define PAGE_TYPE_END    0xffffff80
> 
> static int inline page_has_type(struct page *page)
> {
>     return page->page_type > PAGE_TYPE_BASE &&
>            page->page_type < PAGE_TYPE_END;
> }
> 
> But I opted for the additional complexity to avoid more false-positives from
> possibly corrupted values.  I'm certainly fine with a simple approach, though.

The way I'm thinking about this field is that usually it's _mapcount
which is 0xffffffff to represent 0.  We allow a certain small amount
of underflow and still treat it as a mapcount.  We also allow for some
amount of overflow.  So to be utterly precise, what you had there would
have been fine, but for simplicity, I'd rather just do a signed compare
against -128.
