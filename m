Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83ACC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81355249C1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PPY5TrI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81355249C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934410AbeGCRsQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:48:16 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:35332 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934194AbeGCRsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1530640093;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=aXbYaSd3EQ3yZCupU/c+djTDBfDgvkfq9r7D/H9Z44M=;
        b=PPY5TrI7v1CmLCdVsJELPVPYBud7VqDslZc/l9Mab3FTJb/mtDXNAqQJR9JYRwpm
        5vlEilrMqHUuel0sOof6jDV33DuqINBPQnoxeQsReFJ2onAvTyHzAW7rqnpk4fpvkpc
        B1Wb/mGQUlgOgzSBz4lEBQXPT7lT9rJTQYZedZks=
Date:   Tue, 3 Jul 2018 17:48:13 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     John Hubbard <jhubbard@nvidia.com>
cc:     Jan Kara <jack@suse.cz>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mm: track gup pages with page->dma_pinned_*
 fields
In-Reply-To: <3c71556f-1d71-873a-6f74-121865568bf7@nvidia.com>
Message-ID: <0100016461425062-724aa9d3-d7c1-4fa2-a87b-dc59cc5f7800-000000@email.amazonses.com>
References: <20180702005654.20369-1-jhubbard@nvidia.com> <20180702005654.20369-6-jhubbard@nvidia.com> <20180702095331.n5zfz35d3invl5al@quack2.suse.cz> <bb798475-ebf3-7b02-409f-8c4347fa6674@nvidia.com> <010001645d77ee2c-de7fedbd-f52d-4b74-9388-e6435973792b-000000@email.amazonses.com>
 <f01666d5-8da1-7bea-adfb-c3571a54587a@nvidia.com> <01000164611dacae-5ac25e48-b845-43ef-9992-fc1047d8e0a0-000000@email.amazonses.com> <3c71556f-1d71-873a-6f74-121865568bf7@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.07.03-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, John Hubbard wrote:

> The page->_refcount field is used normally, in addition to the dma_pinned_count.
> But the problem is that, unless the caller knows what kind of page it is,
> the page->dma_pinned_count cannot be looked at, because it is unioned with
> page->lru.prev.  page->dma_pinned_flags, at least starting at bit 1, are
> safe to look at due to pointer alignment, but now you cannot atomically
> count...
>
> So this seems unsolvable without having the caller specify that it knows the
> page type, and that it is therefore safe to decrement page->dma_pinned_count.
> I was hoping I'd found a way, but clearly I haven't. :)

Try to find some way to indicate that the page is pinned by using some of
the existing page flags? There is already an MLOCK flag. Maybe some
creativity with that can lead to something (but then the MLOCKed pages are
on the unevictable LRU....). cgroups used to have something called struct
page_ext. Oh its there in linux/mm/page_ext.c.




