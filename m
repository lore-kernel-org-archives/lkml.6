Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40965C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC96E24141
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="MXYx+ZNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC96E24141
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934299AbeGCRIR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:08:17 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:58602 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933860AbeGCRIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1530637692;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=PlNvGt4Niu1GplK8wDH7AqVGgfaOe8vRNAjVsCWVWIY=;
        b=MXYx+ZNhw/Fq5P0Dsgku8oNfTWT2I6kLWXiAWkILf30UmrxjIhOyNEFSuoLTV75F
        G9yEos2Ps3bbsAHRH4r+6NJH77rP7qWmyQQcICVxOZxpK0fhuB9FiOPbLtxRmLHZXnZ
        +NuftoYn591eC9HTlCW13P63ZY7gimFZAZmuaGuc=
Date:   Tue, 3 Jul 2018 17:08:12 +0000
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
In-Reply-To: <f01666d5-8da1-7bea-adfb-c3571a54587a@nvidia.com>
Message-ID: <01000164611dacae-5ac25e48-b845-43ef-9992-fc1047d8e0a0-000000@email.amazonses.com>
References: <20180702005654.20369-1-jhubbard@nvidia.com> <20180702005654.20369-6-jhubbard@nvidia.com> <20180702095331.n5zfz35d3invl5al@quack2.suse.cz> <bb798475-ebf3-7b02-409f-8c4347fa6674@nvidia.com> <010001645d77ee2c-de7fedbd-f52d-4b74-9388-e6435973792b-000000@email.amazonses.com>
 <f01666d5-8da1-7bea-adfb-c3571a54587a@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.07.03-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018, John Hubbard wrote:

> > If you establish a reference to a page then increase the page count. If
> > the reference is a dma pin action also then increase the pinned count.
> >
> > That way you know how many of the references to the page are dma
> > pins and you can correctly manage the state of the page if the dma pins go
> > away.
> >
>
> I think this sounds like what this patch already does, right? See:
> __put_page_for_pinned_dma(), __get_page_for_pinned_dma(), and
> pin_page_for_dma(). The locking seems correct to me, but I suspect it's
> too heavyweight for such a hot path. But without adding a new put_user_page()
> call, that was the best I could come up with.

When I saw the patch it looked like you were avoiding to increment the
page->count field.

> What I'm hearing now from Jan and Michal is that the desired end result is
> a separate API call, put_user_pages(), so that we can explicitly manage
> these pinned pages.

Certainly a good approach.
