Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A06EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63C520855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="L9qVsApf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfBLQjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:39:44 -0500
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:53352 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729633AbfBLQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549989583;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=QONQxq6NqJ1WQyN3EWBcAnyyjiKu2fZbxNpfP8BUfQw=;
        b=L9qVsApfysCu2oX2ycOKEAIsoSsfsL401tm3A5JhTNcfPRycrN/SU3q03Yg8CacL
        iUWr90rd4XwT+bw/1d13ahfJRucia0Sc1lYrTbPfbF243/9D/sIIqLWAb7mYBFB4+aK
        Iz4Mws7VxD3GCLqKnJO1/FdcgEhND4r84guKpcFE=
Date:   Tue, 12 Feb 2019 16:39:43 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     John Hubbard <jhubbard@nvidia.com>
cc:     Jason Gunthorpe <jgg@ziepe.ca>, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving longterm-GUP
 usage by RDMA
In-Reply-To: <018c1a05-5fd8-886a-573b-42649949bba8@nvidia.com>
Message-ID: <01000168e29418ba-81301f56-9370-4555-b70c-3ad51be84543-000000@email.amazonses.com>
References: <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com> <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com> <20190208044302.GA20493@dastard> <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com> <20190211102402.GF19029@quack2.suse.cz> <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com> <20190211180654.GB24692@ziepe.ca> <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
 <fb507b56-7f8f-cf2c-285c-bae3b2d72c4f@nvidia.com> <20190211221247.GI24692@ziepe.ca> <018c1a05-5fd8-886a-573b-42649949bba8@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.12-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, John Hubbard wrote:

> But anyway, Jan's proposal a bit earlier today [1] is finally sinking into
> my head--if we actually go that way, and prevent the caller from setting up
> a problematic gup pin in the first place, then that may make this point sort
> of moot.

Ok well can be document how we think it would work somewhere? Long term
mapping a page cache page could a problem and we need to explain that
somewhere.

> > ie indicate to the FS that is should not attempt to remap physical
> > memory addresses backing this VMA. If the FS can't do that it must
> > fail.
> >
>
> Yes. Duration is probably less important than the fact that the page
> is specially treated.

Yup.

