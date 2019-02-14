Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E12621B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cEctZLfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438295AbfBNTId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:08:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbfBNTIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z/guOjnPcwW8qHKWLH6ei2fgh2Qlw1Lh/RZ/6h84/Co=; b=cEctZLfPAGyPtiErBt/B7+YbC
        FeY0fEvhO8Ygf80DDHtmxGTehgHHi0sskUBDjyZAG4N8ijgXeDUcY2/jW79FOvaQrJyoYLT0AYg0x
        yb4GtkElgIVSF2LyFauA27vzP1D8LHzPLHaNnLudneFG4X2cG1LyUcMR4ja1CdksGBKeEO8tsicQK
        iRMJW8pNONeP0aUmXyuGEbtCaNwUKfpRrBhkQDjQ29HOdkXHkZeIhwQRMsb6UgN5visI12myCUf/p
        QVjnV+bDarRTCC4lqWPcnD1kk1jKf+w8aj8gpZUJUrPKXh5W8WWyc3AuyNJVr7deMrBpqCQfYkCko
        ZNwcj2KFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guMMg-0003Hu-An; Thu, 14 Feb 2019 19:08:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD3D020268335; Thu, 14 Feb 2019 20:08:03 +0100 (CET)
Date:   Thu, 14 Feb 2019 20:08:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, jsteckli@amazon.de, tycho@tycho.ws,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
        konrad.wilk@oracle.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        oao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, labbott@redhat.com, luto@kernel.org,
        dave.hansen@intel.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@docker.com>,
        Marco Benatto <marco.antonio.780@gmail.com>
Subject: Re: [RFC PATCH v8 03/14] mm, x86: Add support for eXclusive Page
 Frame Ownership (XPFO)
Message-ID: <20190214190803.GQ32477@hirez.programming.kicks-ass.net>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <8275de2a7e6b72d19b1cd2ec5d71a42c2c7dd6c5.1550088114.git.khalid.aziz@oracle.com>
 <20190214105631.GJ32494@hirez.programming.kicks-ass.net>
 <e157e274-1bdf-0987-bfe9-21c9301578ab@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e157e274-1bdf-0987-bfe9-21c9301578ab@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:13:54AM -0700, Khalid Aziz wrote:

> Patch 11 ("xpfo, mm: remove dependency on CONFIG_PAGE_EXTENSION") cleans
> all this up. If the original authors of these two patches, Juerg
> Haefliger and Julian Stecklina, are ok with it, I would like to combine
> the two patches in one.

Don't preserve broken patches because of different authorship or
whatever.

If you care you can say things like:

 Based-on-code-from:
 Co-developed-by:
 Originally-from:

or whatever other things there are. But individual patches should be
correct and complete.
