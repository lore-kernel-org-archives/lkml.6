Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBE8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3B6222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C+BUwJtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbfBMNGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:06:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733281AbfBMNGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v/SUZ32bLKbB19QVGv5xAUSeQGwbhzkwhCTSONn+E+M=; b=C+BUwJtTvwgYa5sRRkKMYNVqZ
        ak/NcpoOoVcJZ4tdr+3q/lIQOpBkN4DGqFIwj/mLp3NZc7Kz2JHDl2ou46v77pWFfvw9vCVWN/8Iz
        nMRJOWeUpm06CpdcFAf7YrzdjMK5aMOtiqArK7ZxB4YNDQ+PlhjDMuSH7GGwweP3gAM9w3fgQW1G7
        GZHs5cheOfonHKGxrN7FPkAbpA9bZssfg0flQaXgqvEnqAex1nFQvVMeXGDYE8L/TdG4nuiCVK7GK
        xYLPO+p8P+v8IvdyFzBtyRShxLmqU9kHvBC34xX7yPb7nxxt2NSj+7teE0Yd6I/qy7yvJyvPuXW2I
        HgvS/hHfQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtuFT-0001z6-Av; Wed, 13 Feb 2019 13:06:47 +0000
Date:   Wed, 13 Feb 2019 05:06:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        lsf-pc@lists.linux-foundation.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LSF/MM TOPIC] Non standard size THP
Message-ID: <20190213130647.GQ12668@bombadil.infradead.org>
References: <dcb0b2cf-ba5c-e6ef-0b05-c6006227b6a9@arm.com>
 <20190212083331.dtch7xubjxlmz5tf@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212083331.dtch7xubjxlmz5tf@kshutemo-mobl1>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:33:31AM +0300, Kirill A. Shutemov wrote:
> To consider it seriously we need to understand what it means for
> split_huge_p?d()/split_huge_page()? How khugepaged will deal with this?
> 
> In particular, I'm worry to expose (to user or CPU) page table state in
> the middle of conversion (huge->small or small->huge). Handling this on
> page table level provides a level atomicity that you will not have.

We could do an RCU-style trick where (eg) for merging 16 consecutive
entries together, we allocate a new PTE leaf, take the mmap_sem for write,
copy the page table over, update the new entries, then put the new leaf
into the PMD level.  Then iterate over the old PTE leaf again, and set
any dirty bits in the new leaf which were set during the race window.

Does that cover all the problems?

> Honestly, I'm very skeptical about the idea. It took a lot of time to
> stabilize THP for singe page size, equal to PMD page table, but this looks
> like a new can of worms. :P

It's definitely a lot of work, and it has a lot of prerequisites.
