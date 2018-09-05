Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E10CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E4720857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NVpaiFsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E4720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeIESTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:19:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeIESTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nq3whnuyc/5ddYT5jnRz2IJm5G9gTDF2Hs9MFMBcZWM=; b=NVpaiFslpmIqpgc+j4BiDaqV3
        NJ0Am+qORGcM9d/RDIa36otu2ykpPa4bDNDvRLC30sgAXq89Bgruw4/UOsa7jhd+Hz2s0RmmWeeAl
        5xlyAznwNwZaFnYqTvRBAWp0zZJ1Taxbq1lbsYCrcEUDLjIyWHXlo5UHb3QgDt5OHwIvbgPDfUeHP
        eKAlqCIAD/TZBH3jnakVB5ebGLU9SAPcJKq86rnw4MPtIbLlznzYE6IqyNBu91H1Etc2FnPBgc17D
        oixfaWHPWTpqk/Jr1qW0b94gYQoCxbCo0buwkqWaGda3N9gp8eU3lf8pdnmrhAR1uAM7HXbf0AC8y
        FpiGwmSfw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxYAr-0007WU-A3; Wed, 05 Sep 2018 13:48:49 +0000
Date:   Wed, 5 Sep 2018 06:48:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/hugetlb: make hugetlb_lock irq safe
Message-ID: <20180905134848.GB3729@bombadil.infradead.org>
References: <20180905112341.21355-1-aneesh.kumar@linux.ibm.com>
 <20180905130440.GA3729@bombadil.infradead.org>
 <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 06:56:19PM +0530, Aneesh Kumar K.V wrote:
> On 09/05/2018 06:34 PM, Matthew Wilcox wrote:
> > On Wed, Sep 05, 2018 at 04:53:41PM +0530, Aneesh Kumar K.V wrote:
> > >   inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > 
> > How do you go from "can be taken in softirq context" problem report to
> > "must disable hard interrupts" solution?  Please explain why spin_lock_bh()
> > is not a sufficient fix.
> > 
> > >   swapper/68/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> > >   0000000052a030a7 (hugetlb_lock){+.?.}, at: free_huge_page+0x9c/0x340
> > >   {SOFTIRQ-ON-W} state was registered at:
> > >     lock_acquire+0xd4/0x230
> > >     _raw_spin_lock+0x44/0x70
> > >     set_max_huge_pages+0x4c/0x360
> > >     hugetlb_sysctl_handler_common+0x108/0x160
> > >     proc_sys_call_handler+0x134/0x190
> > >     __vfs_write+0x3c/0x1f0
> > >     vfs_write+0xd8/0x220
> > 
> > Also, this only seems to trigger here.  Is it possible we _already_
> > have softirqs disabled through every other code path, and it's just this
> > one sysctl handler that needs to disable softirqs?  Rather than every
> > lock access?
> 
> Are you asking whether I looked at moving that put_page to a worker thread?

No.  I'm asking "why not disable softirqs in the sysctl handler".  Or
perhaps equivalently, just replace spin_lock() with spin_lock_bh() in
set_max_huge_pages().

> I didn't. The reason I looked at current patch is to enable the usage of
> put_page() from irq context. We do allow that for non hugetlb pages. So was
> not sure adding that additional restriction for hugetlb
> is really needed. Further the conversion to irqsave/irqrestore was
> straightforward.

straightforward, sure.  but is it the right thing to do?  do we want to
be able to put_page() a hugetlb page from hardirq context?

