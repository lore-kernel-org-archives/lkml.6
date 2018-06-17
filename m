Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8B4C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F397208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JEsLqsKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F397208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeFQVyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 17:54:33 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:48590 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752699AbeFQVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 17:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1529272471;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=wYY+h80vAnUTTrDsL0DASx7v1lZSPozQM7VnO5xZ5Mk=;
        b=JEsLqsKxtMZahXr5XChj8ODlgSgjjE/NTWWHeGgFyyDt/NgWbmaLii9wKsVUvBAf
        HFkW7WyTPn+Bt5Jv07AMlSgJSid6LGFNKcyCVbXB1A/fI0OhODpHLVRGkrtgDY6eq3x
        rTQYEuLHtlJSI9K7Y78NCkh2pVFY6KEjiLNW49TQ=
Date:   Sun, 17 Jun 2018 21:54:31 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     john.hubbard@gmail.com
cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/2] mm: gup: don't unmap or drop filesystem buffers
In-Reply-To: <20180617012510.20139-1-jhubbard@nvidia.com>
Message-ID: <010001640fbe0dd8-f999e7f6-7b6e-4deb-b073-0c572006727d-000000@email.amazonses.com>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.06.17-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2018, john.hubbard@gmail.com wrote:

> I've come up with what I claim is a simple, robust fix, but...I'm
> presuming to burn a struct page flag, and limit it to 64-bit arches, in
> order to get there. Given that the problem is old (Jason Gunthorpe noted
> that RDMA has been living with this problem since 2005), I think it's
> worth it.
>
> Leaving the new page flag set "nearly forever" is not great, but on the
> other hand, once the page is actually freed, the flag does get cleared.
> It seems like an acceptable tradeoff, given that we only get one bit
> (and are lucky to even have that).

This is not robust. Multiple processes may register a page with the RDMA
subsystem. How do you decide when to clear the flag? I think you would
need an additional refcount for the number of times the page was
registered.

I still think the cleanest solution here is to require mmu notifier
callbacks and to not pin the page in the first place. If a NIC does not
support a hardware mmu then it can still simulate it in software by
holding off the ummapping the mmu notifier callback until any pending
operation is complete and then invalidate the mapping so that future
operations require a remapping (or refaulting).



