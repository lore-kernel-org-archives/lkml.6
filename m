Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0636C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77827278B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sGZdR9B6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77827278B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933300AbeF2F6A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 01:58:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933168AbeF2F57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 01:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tVTMmjz2wHyLF/1YA+ptcKs0CD4fMHdPTnKdfchz2Ak=; b=sGZdR9B6QojDDj1bKU5lVWgdz
        xOuowUR0VsAogpAy1gJuTig1YTKBCxbH6860anp/T/8ZpadvnlJVTLRv+7uIZLBATOBcmGdSMOtJA
        klxEU0cqCIydSkJw28DE2kOzNQLumYDKU+XvWjljEiN9RBR/bjI9xyfGCDGueFXMOBr4iTVIGBLxQ
        ri12VytHVX4XcHx36H9jPpgh6TJuiT5QwdZzF4vEHFS182fJea1r7fDfmSeFfTwsDKw4UAvfR11rg
        cVCYGIMazaO3r5vYjnsut6jlDNtqko7dv36xinjPnFcGkYed88mCUnF23Aep8p7ykPdhd+VGuK+lD
        xGKyZtKRw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYmPq-0004x5-K2; Fri, 29 Jun 2018 05:57:54 +0000
Date:   Thu, 28 Jun 2018 22:57:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 00/21] mm, THP, swap: Swapout/swapin THP in one
 piece
Message-ID: <20180629055754.GH7646@bombadil.infradead.org>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
 <87r2krfpi2.fsf@yhuang-dev.intel.com>
 <20180627223118.dd2f52d87f53e7e002ed0153@linux-foundation.org>
 <87muvffp7w.fsf@yhuang-dev.intel.com>
 <20180627231839.e5ac2f38e0397979d3db7765@linux-foundation.org>
 <20180628090301.GC7646@bombadil.infradead.org>
 <87woui9ysj.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woui9ysj.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 09:17:16AM +0800, Huang, Ying wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > I'll take a look.  Honestly, my biggest problem with this patch set is
> > overuse of tagging:
> >
> > 59832     Jun 22 Huang, Ying     ( 131) [PATCH -mm -v4 00/21] mm, THP, swap: Swa
> > There's literally zero useful information displayed in the patch subjects.
> 
> Thanks!  What's your suggestion on tagging?  Only keep "mm" or "swap"?

Subject: [PATCH v14 10/74] xarray: Add XArray tags

I'm not sure where the extra '-' in front of '-v4' comes from.  I also
wouldn't put the '-mm' in front of it -- that information can live in
the cover letter's body rather than any patch's subject.

I think 'swap:' implies "mm:", so yeah I'd just go with that.

Subject: [PATCH v4 00/21] swap: Useful information here

I'd see that as:

59832     Jun 22 Huang, Ying     ( 131) [PATCH v4 00/21] swap: Useful informatio

I had a quick look at your patches.  I think only two are affected by
the XArray, and I'll make some general comments about them soon.
