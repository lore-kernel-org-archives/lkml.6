Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003ACC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD1220645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MUc60ZUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD1220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeIFDkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 23:40:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeIFDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 23:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LYBrlr9EnVM+RkR6YOBymLMDpV50ZGXFiXT7SxrbHBs=; b=MUc60ZUMRuZe0z6mtGwJhONYH
        3scrqcH5SvZsE33fzjU9dehkaqfr391iqjFGFXVnlKnVvVo0BLJFQmaDtdw4/wVWKHfZuG4MTWCvi
        0GEkKFFGNv/2lQBLLO81mYOBklfaZtvHmPaD5Jgp6Gl4JXsl8oKNwxStt4WMUFvXFw3cVaf7ODHUi
        wnSWozv9OB/ncaSridRYZXoHEvrXMHrPV/2mi2g8dVBpUdGDcRLnUFKHYsBZHglAJWSQgwA53TxXs
        rQdcAOJzR+LuPzUbmKwJbFq4kQ9StCXgvmR28GtZd/8olXbl6j14ePzmJtiUcGDS2NQATG6jnApRu
        Z1+g10H8w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxgtd-0003z6-Rw; Wed, 05 Sep 2018 23:07:37 +0000
Date:   Wed, 5 Sep 2018 16:07:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/hugetlb: make hugetlb_lock irq safe
Message-ID: <20180905230737.GA14977@bombadil.infradead.org>
References: <20180905112341.21355-1-aneesh.kumar@linux.ibm.com>
 <20180905130440.GA3729@bombadil.infradead.org>
 <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
 <20180905134848.GB3729@bombadil.infradead.org>
 <20180905125846.eb0a9ed907b293c1b4c23c23@linux-foundation.org>
 <78b08258-14c8-0e90-97c7-d647a11acb30@oracle.com>
 <20180905150008.59d477c1f78f966a8f9c3cc8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905150008.59d477c1f78f966a8f9c3cc8@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 03:00:08PM -0700, Andrew Morton wrote:
> On Wed, 5 Sep 2018 14:35:11 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > >                                            so perhaps we could put some
> > > stopgap workaround into that site and add a runtime warning into the
> > > put_page() code somewhere to detect puttage of huge pages from hardirq
> > > and softirq contexts.
> > 
> > I think we would add the warning/etc at free_huge_page.  The issue would
> > only apply to hugetlb pages, not THP.
> > 
> > But, the more I think about it the more I think Aneesh's patch to do
> > spin_lock/unlock_irqsave is the right way to go.  Currently, we only
> > know of one place where a put_page of hugetlb pages is done from softirq
> > context.  So, we could take the spin_lock/unlock_bh as Matthew suggested.
> > When the powerpc iommu code was added, I doubt this was taken into account.
> > I would be afraid of someone adding put_page from hardirq context.
> 
> Me too.  If we're going to do this, surely we should make hugepages
> behave in the same fashion as PAGE_SIZE pages.

But these aren't vanilla hugepages, they're specifically hugetlbfs pages.
I don't believe there's any problem with calling put_page() on a normally
allocated huge page or THP.
