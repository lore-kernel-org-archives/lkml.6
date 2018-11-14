Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8B022513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="du9FHmqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8B022513
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbeKOI22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:28:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbeKOI21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HZ9FoT/Yy3OX8C0H4qzEvYCUztlDQL9Afu/eqdCHPIU=; b=du9FHmqJIFno6bdq2AWaNBqtB
        q9G5S07pYfFUoBX6rUJlRGhD+Ggnu7bn0V2NmFfhXVu8PFulCAVmSvxDs0TavDbD4ApJYN3lRgZ0V
        ZlWGBgkro3pzJ0HRwVJWmR1Gs43gASfN1yv9csU5NIl0gjDkjNDLgwEQc6cCsJ7yDrgmV26JIWW49
        r4BR52qzvTZXmaqJf9CeWtFdnwYblbPpYACYw7pEhPy6Z49PsKlypZ68tCMD4cO2d3kvDZTbxgM/5
        FttHCvpncqygVXjrC5SYPJUa12r9hCJwXIjJjP3r9D4d8ShA3rwNPW3H/7/RrnojeJ3PoOHluVe1T
        8qNIkPKpA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gN3ZB-0001Va-DA; Wed, 14 Nov 2018 22:23:21 +0000
Date:   Wed, 14 Nov 2018 14:23:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devel@linuxdriverproject.org,
        linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
        xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Hansen <chansen3@cisco.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Miles Chen <miles.chen@mediatek.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH RFC 2/6] mm: convert PG_balloon to PG_offline
Message-ID: <20181114222321.GB1784@bombadil.infradead.org>
References: <20181114211704.6381-1-david@redhat.com>
 <20181114211704.6381-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114211704.6381-3-david@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 10:17:00PM +0100, David Hildenbrand wrote:
> Rename PG_balloon to PG_offline. This is an indicator that the page is
> logically offline, the content stale and that it should not be touched
> (e.g. a hypervisor would have to allocate backing storage in order for the
> guest to dump an unused page).  We can then e.g. exclude such pages from
> dumps.
> 
> In following patches, we will make use of this bit also in other balloon
> drivers.  While at it, document PGTABLE.

Thank you for documenting PGTABLE.  I didn't realise I also had this
document to update when I added PGTABLE.

> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -78,6 +78,8 @@ number of times a page is mapped.
>      23. BALLOON
>      24. ZERO_PAGE
>      25. IDLE
> +    26. PGTABLE
> +    27. OFFLINE

So the offline *user* bit is new ... even though the *kernel* bit
just renames the balloon bit.  I'm not sure how I feel about this.
I'm going to think about it some more.  Could you share your decision
process with us?

I have no objection to renaming the balloon bit inside the kernel; I
think that's a wise idea.  I'm just not sure whether we should rename
the user balloon bit rather than adding a new bit.
