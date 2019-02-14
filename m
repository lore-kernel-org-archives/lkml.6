Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1492AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88DA21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZJoXraRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438195AbfBNWL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:11:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404953AbfBNWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gwc+mvIl4HoO2YfH2m0A8g4VcbExcOq+aBb16LSf1EI=; b=ZJoXraRwEzPwCjFopYp0D/SBf
        oExrdMzVb4bcoedsPJXTMRiM0f6llqjnv/ND3gdcr+NN16Gq1xGdvVTqEgNNZX38lB+ajiti5MA5t
        QoqGD5j8TSkMmRlf164otrER2pPPxdHs7/xFdtYUKvWe1CM2uv2056tV38vrfj980Q8nYSb4qeZPD
        dF/qOaxvuArkL9sJ76rWgnG0MEcIhoYJk5GtmpFDkCWtXadhb69achm2/Zaps8K9G7VAoZf41Fdk1
        x8bAHEI2bXJ9uISExFkUX+h1zUPiovdWqDjpf2mzLfIBkzHpWLKB8hsFRfWmPNqnMb2owjs0KHqog
        z1ps54Vxg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guPEc-0006Mt-7X; Thu, 14 Feb 2019 22:11:58 +0000
Date:   Thu, 14 Feb 2019 14:11:58 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190214221158.GF12668@bombadil.infradead.org>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
 <20190214211757.GE12668@bombadil.infradead.org>
 <20190214220810.cs2ecomtrqc6m2ap@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214220810.cs2ecomtrqc6m2ap@kshutemo-mobl1>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:08:10AM +0300, Kirill A. Shutemov wrote:
> On Thu, Feb 14, 2019 at 01:17:57PM -0800, Matthew Wilcox wrote:
> > On Thu, Feb 14, 2019 at 04:30:04PM +0300, Kirill A. Shutemov wrote:
> > >  - migrate_page_move_mapping() has to be converted too.
> > 
> > I think that's as simple as:
> > 
> > +++ b/mm/migrate.c
> > @@ -465,7 +465,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
> >  
> >                 for (i = 1; i < HPAGE_PMD_NR; i++) {
> >                         xas_next(&xas);
> > -                       xas_store(&xas, newpage + i);
> > +                       xas_store(&xas, newpage);
> >                 }
> >         }
> >  
> > 
> > or do you see something else I missed?
> 
> Looks right to me.
> 
> BTW, maybe some add syntax sugar from XArray side?
> 
> Replace the loop and xas_store() before it with:
> 
> 		xas_fill(&xas, newpage, 1UL << compound_order(newpage));
> 
> or something similar?

If we were keeping this code longterm, then yes, something like that
would be great.  I'm hoping this code is a mere stepping stone towards
using multi-slot entries for the page cache.
