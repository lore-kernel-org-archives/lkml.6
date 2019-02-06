Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4BEC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D5F20823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ab/ZKKur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfBFUUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:20:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfBFUUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zxiuA+kMki/UhwSsnRN7805PLjtsIi6PGZFOiQ1YwQk=; b=Ab/ZKKurlrlfBf27eXyZXOAoc
        vMRey/USNDaTEnIgHG3mGDD3ZLLM1aisiG7e0shzKeua0xOugZ2EixdhKk8B/pBQs/aw+NSJl72+5
        WMkK95M7MEOG8rcRdlRibITDjzsg7gYTfhH7d/kL6LnJUluCZ+vN+M8uKloKFKAm911wua3K4IyY3
        53oawd2oTBqnpQUtZm7AniaJvkc/6VKZ2z8miEukueTSg6krxGKQwIAjLR9/OjAHNFuYR9jAAjSIv
        YJJS0o8Mt+ikxTAoYusqDbJtLVPBy3+FsI3TMamjD6SZsPHbOoiOqU0ENz7ItusFaSmT4pmdeN7qx
        ME+59Vxyw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grTgD-0003Sc-As; Wed, 06 Feb 2019 20:20:21 +0000
Date:   Wed, 6 Feb 2019 12:20:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Christopher Lameter <cl@linux.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190206202021.GQ21860@bombadil.infradead.org>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz>
 <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206194055.GP21860@bombadil.infradead.org>
 <a9df9be75966f34f55f843a3cd7e1ee7d497c7fa.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9df9be75966f34f55f843a3cd7e1ee7d497c7fa.camel@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 03:16:02PM -0500, Doug Ledford wrote:
> On Wed, 2019-02-06 at 11:40 -0800, Matthew Wilcox wrote:
> > On Wed, Feb 06, 2019 at 07:16:21PM +0000, Christopher Lameter wrote:
> > > 
> > > though? If we only allow this use case then we may not have to worry about
> > > long term GUP because DAX mapped files will stay in the physical location
> > > regardless.
> > 
> > ... except for truncate.  And now that I think about it, there was a
> > desire to support hot-unplug which also needed revoke.
> 
> We already support hot unplug of RDMA devices.  But it is extreme.  How
> does hot unplug deal with a program running from the device (something
> that would have returned ETXTBSY)?

Not hot-unplugging the RDMA device but hot-unplugging an NV-DIMM.

It's straightforward to migrate text pages from one DIMM to another;
you remove the PTEs from the CPU's page tables, copy the data over and
pagefaults put the new PTEs in place.  We don't have a way to do similar
things to an RDMA device, do we?


