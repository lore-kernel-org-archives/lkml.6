Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BB7C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731812086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="B47/aMZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfBGSRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:17:48 -0500
Received: from a9-36.smtp-out.amazonses.com ([54.240.9.36]:38788 "EHLO
        a9-36.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbfBGSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549563466;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=0VffAsrUHZUiZ63MsIfnIIlVBW7/RgvsuDezdKupRM8=;
        b=B47/aMZwpGCuvge66yAeFJ1YIM+i7xuALx1AU+6y+BctQkRsA7s32uTkotT6ixxR
        vRbR+yOqW3PfCcHyIw/t1tgS5858WaLW0Xvd8Cy13zvdjhKQdEvTXRV4aC+QXAUOURh
        MjDzJiPT3clgimtKm27lFmPphToHGq2F8d0JBoLA=
Date:   Thu, 7 Feb 2019 18:17:46 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Ira Weiny <ira.weiny@intel.com>
cc:     Doug Ledford <dledford@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving longterm-GUP
 usage by RDMA
In-Reply-To: <20190207173504.GD29531@iweiny-DESK2.sc.intel.com>
Message-ID: <01000168c92e1220-36386b5d-66f7-4ba5-ba0e-d314b1d26cf8-000000@email.amazonses.com>
References: <20190206173114.GB12227@ziepe.ca> <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com> <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com> <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca> <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com> <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com> <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com> <20190207173504.GD29531@iweiny-DESK2.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.07-54.240.9.36
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019, Ira Weiny wrote:

> On Thu, Feb 07, 2019 at 04:55:37PM +0000, Christopher Lameter wrote:
> > One approach that may be a clean way to solve this:
> >
> > 1. Long term GUP usage requires the virtual mapping to the pages be fixed
> >    for the duration of the GUP Map. There never has been a way to break
> >    the pinnning and thus this needs to be preserved.
>
> How does this fit in with the changes John is making?
>
> >
> > 2. Page Cache Long term pins are not allowed since regular filesystems
> >    depend on COW and other tricks which are incompatible with a long term
> >    pin.
>
> Unless the hardware supports ODP or equivalent functionality.  Right?

Ok we could make an exception there. But that is not required as a first
step and only some hardware would support it.

> > 3. Filesystems that allow bypass of the page cache (like XFS / DAX) will
> >    provide the virtual mapping when the PIN is done and DO NO OPERATIONS
> >    on the longterm pinned range until the long term pin is removed.
> >    Hardware may do its job (like for persistent memory) but no data
> >    consistency on the NVDIMM medium is guaranteed until the long term pin
> >    is removed  and the filesystems regains control over the area.
>
> I believe Dan attempted something like this and it became pretty difficult.

What is difficult about leaving things alone that are pinned? We already
have to do that currently because the refcount is elevated.

