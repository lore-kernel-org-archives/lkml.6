Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA31C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EE524112
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="gurrF9p8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EE524112
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeGEORW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:17:22 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:38118 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753606AbeGEORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1530800239;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=K9PH+/K89pRAdEgmI3fx7ERZ/RnQIWTYCAT/5katZ6Y=;
        b=gurrF9p8EF+ztjS5akguIPvrbpwmJoGltGOvXF05khbLUoV6QKjCo8/CbgFRX3LA
        rLK9+P2t9xeqZs88x7iGjBQ+V+afeAQgDlskNXSXATk/dCWNzOJs0nXT+Tt57SWkDC+
        Y3XQ0UVrPOU1DMY1B1sBMbzjlBOlyRwzsqov2AT8=
Date:   Thu, 5 Jul 2018 14:17:19 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Jan Kara <jack@suse.cz>
cc:     John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mm: track gup pages with page->dma_pinned_*
 fields
In-Reply-To: <20180704104318.f5pnqtnn3unkwauw@quack2.suse.cz>
Message-ID: <010001646acdf1d8-0460be04-cc74-4a2d-be89-a337461bd485-000000@email.amazonses.com>
References: <20180702005654.20369-1-jhubbard@nvidia.com> <20180702005654.20369-6-jhubbard@nvidia.com> <20180702095331.n5zfz35d3invl5al@quack2.suse.cz> <bb798475-ebf3-7b02-409f-8c4347fa6674@nvidia.com> <010001645d77ee2c-de7fedbd-f52d-4b74-9388-e6435973792b-000000@email.amazonses.com>
 <f01666d5-8da1-7bea-adfb-c3571a54587a@nvidia.com> <01000164611dacae-5ac25e48-b845-43ef-9992-fc1047d8e0a0-000000@email.amazonses.com> <3c71556f-1d71-873a-6f74-121865568bf7@nvidia.com> <20180704104318.f5pnqtnn3unkwauw@quack2.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.07.05-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Jan Kara wrote:

> > So this seems unsolvable without having the caller specify that it knows the
> > page type, and that it is therefore safe to decrement page->dma_pinned_count.
> > I was hoping I'd found a way, but clearly I haven't. :)
>
> Well, I think the misconception is that "pinned" is a fundamental property
> of a page. It is not. "pinned" is a property of a page reference (i.e., a
> kind of reference that can be used for DMA access) and page gets into
> "pinned" state if it has any reference of "pinned" type. And when you
> realize this, it is obvious that you just have to have a special api for
> getting and dropping references of this "pinned" type. For getting we
> already have get_user_pages(), for putting we have to create the api...

Maybe we can do something by creating a special "pinned" bit in the pte?
If it is a RDMA reference then set that pinned bit there.

Thus any of the references could cause a pin. Since the page struct does
not contain that information we therefore have to scan through the ptes to
figure out if a page is pinned?

If so then we would not need a special function for dropping the
reference.

References to a page can also be created from devices mmu. Maybe we could
at some point start to manage them in a similar way to the page tables of
the processor? The mmu notifiers are a bit awkward if we need closer mm
integration.

