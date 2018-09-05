Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEA9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076442077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076442077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeIFAab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:30:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeIFAaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:30:30 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78B1BDC2;
        Wed,  5 Sep 2018 19:58:47 +0000 (UTC)
Date:   Wed, 5 Sep 2018 12:58:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/hugetlb: make hugetlb_lock irq safe
Message-Id: <20180905125846.eb0a9ed907b293c1b4c23c23@linux-foundation.org>
In-Reply-To: <20180905134848.GB3729@bombadil.infradead.org>
References: <20180905112341.21355-1-aneesh.kumar@linux.ibm.com>
        <20180905130440.GA3729@bombadil.infradead.org>
        <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
        <20180905134848.GB3729@bombadil.infradead.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 06:48:48 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> > I didn't. The reason I looked at current patch is to enable the usage of
> > put_page() from irq context. We do allow that for non hugetlb pages. So was
> > not sure adding that additional restriction for hugetlb
> > is really needed. Further the conversion to irqsave/irqrestore was
> > straightforward.
> 
> straightforward, sure.  but is it the right thing to do?  do we want to
> be able to put_page() a hugetlb page from hardirq context?

Calling put_page() against a huge page from hardirq seems like the
right thing to do - even if it's rare now, it will presumably become
more common as the hugepage virus spreads further across the kernel. 
And the present asymmetry is quite a wart.

That being said, arch/powerpc/mm/mmu_context_iommu.c:mm_iommu_free() is
the only known site which does this (yes?) so perhaps we could put some
stopgap workaround into that site and add a runtime warning into the
put_page() code somewhere to detect puttage of huge pages from hardirq
and softirq contexts.

And attention will need to be paid to -stable backporting.  How long
has mm_iommu_free() existed, and been doing this?
