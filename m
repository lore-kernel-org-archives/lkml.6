Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B04AC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7068214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPQj6opL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7068214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeIRQKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:10:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeIRQKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hxWds5RXGJieoZJQYObH4lNQuNMJfiW+ZNdTQ3kHtgU=; b=gPQj6opLQGM7EKcWbNEpuqH+g
        VLG1qADxAImRg7g4IlFbami9kip8n4wtSIqkCH9ovR5+rl5P4Z5SfGaQLENx+rGVqMUmdugfRlyyF
        n4+BOKzFDjrksLRs6hHAOrXIMxbGmsg67WDc7wNHeFp0+sJr+B27J+TOWItmr1Oe9p+AclJZL1yLX
        0AeGzMtOjE2xTuOt/C4RiPjQjep9GMIiunof5ZibabHg3HlWNxmOzGgawJJR/UkEmgTB8JnoYJ3ZP
        zW4/OqYPQim/2JkVLBvs0Hn6nik9SlWMi6BmioLtJWd/j43bLNwZSx3UkZybJECYlOWN9XRU1JmqQ
        9UlYu/Fow==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2DOH-000207-BG; Tue, 18 Sep 2018 10:37:57 +0000
Date:   Tue, 18 Sep 2018 03:37:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        kirill@shutemov.name, akpm@linux-foundation.org,
        dave.hansen@intel.com, oleg@redhat.com, srikar@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v10 PATCH 0/3] mm: zap pages with read mmap_sem in munmap
 for large mapping
Message-ID: <20180918103757.GA17108@bombadil.infradead.org>
References: <1536957299-43536-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180915101042.GD31572@bombadil.infradead.org>
 <d00aea15-cf08-1980-dcdf-bf24334e6848@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00aea15-cf08-1980-dcdf-bf24334e6848@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 01:00:58PM -0700, Yang Shi wrote:
> On 9/15/18 3:10 AM, Matthew Wilcox wrote:
> > Something I've been wondering about for a while is whether we should "sort"
> > the readers together.  ie if the acquirers look like this:
> > 
> > A write
> > B read
> > C read
> > D write
> > E read
> > F read
> > G write
> > 
> > then we should grant the lock to A, BCEF, D, G rather than A, BC, D, EF, G.
> 
> I'm not sure how much this can help to the real world workload.
> 
> Typically, there are multi threads to contend for one mmap_sem. So, they are
> trying to read/write the same address space. There might be dependency or
> synchronization among them. Sorting read together might break the
> dependency?

I don't think that's true for the mmap_sem.  If one thread is trying to
get the sem for read then it's a page fault.  Another thread trying to
get the sem for write is trying to modify the address space.  If an
application depends on the ordering of an mmap vs a page fault, it has
to have its own synchronisation.
