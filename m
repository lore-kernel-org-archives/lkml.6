Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB45EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52ADE2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52ADE2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIFCcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:32:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59998 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeIFCcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:32:19 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ABB8910D3;
        Wed,  5 Sep 2018 22:00:09 +0000 (UTC)
Date:   Wed, 5 Sep 2018 15:00:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/hugetlb: make hugetlb_lock irq safe
Message-Id: <20180905150008.59d477c1f78f966a8f9c3cc8@linux-foundation.org>
In-Reply-To: <78b08258-14c8-0e90-97c7-d647a11acb30@oracle.com>
References: <20180905112341.21355-1-aneesh.kumar@linux.ibm.com>
        <20180905130440.GA3729@bombadil.infradead.org>
        <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
        <20180905134848.GB3729@bombadil.infradead.org>
        <20180905125846.eb0a9ed907b293c1b4c23c23@linux-foundation.org>
        <78b08258-14c8-0e90-97c7-d647a11acb30@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 14:35:11 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> >                                            so perhaps we could put some
> > stopgap workaround into that site and add a runtime warning into the
> > put_page() code somewhere to detect puttage of huge pages from hardirq
> > and softirq contexts.
> 
> I think we would add the warning/etc at free_huge_page.  The issue would
> only apply to hugetlb pages, not THP.
> 
> But, the more I think about it the more I think Aneesh's patch to do
> spin_lock/unlock_irqsave is the right way to go.  Currently, we only
> know of one place where a put_page of hugetlb pages is done from softirq
> context.  So, we could take the spin_lock/unlock_bh as Matthew suggested.
> When the powerpc iommu code was added, I doubt this was taken into account.
> I would be afraid of someone adding put_page from hardirq context.

Me too.  If we're going to do this, surely we should make hugepages
behave in the same fashion as PAGE_SIZE pages.
