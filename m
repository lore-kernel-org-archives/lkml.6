Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FF4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA0720879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="QHf/o7fZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA0720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeLMP4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:56:07 -0500
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:43172 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727707AbeLMP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1544716565;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=NZabmP3XK9/5WAKKWC7R595/zGK/oTVP2WOhqXoEXqg=;
        b=QHf/o7fZT9OJhhJg0RiOZNIi1yEGSh+sOyZp8rZgM1JekqaNoGoZSvpLHkw3OvJj
        lQZwiM31jeFJTqYMBRSmMMff0XR/AlcyAibWiNbD68JjdPgOKCvcP6cuvQuqsrBo+Pe
        HyW2PcOPBsR2AXeE4WjYHRMC1+/efbtvRSoSUXDg=
Date:   Thu, 13 Dec 2018 15:56:05 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Jerome Glisse <jglisse@redhat.com>
cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder
 versions
In-Reply-To: <20181213020229.GN5037@redhat.com>
Message-ID: <01000167a8483bd2-16ae0d3e-d217-4993-a80a-25d221c677e4-000000@email.amazonses.com>
References: <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com> <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com> <20181207191620.GD3293@redhat.com> <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com> <20181208022445.GA7024@redhat.com> <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com> <20181212214641.GB29416@dastard> <20181212215931.GG5037@redhat.com> <20181213005119.GD29416@dastard> <20181213020229.GN5037@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.12.13-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Jerome Glisse wrote:

> On Thu, Dec 13, 2018 at 11:51:19AM +1100, Dave Chinner wrote:
> > > > >     [O1] Avoid write back from a page still being written by either a
> > > > >          device or some direct I/O or any other existing user of GUP.
> >
> > IOWs, you need to mark pages being written to by a GUP as
> > PageWriteback, so all attempts to write the page will block on
> > wait_on_page_writeback() before trying to write the dirty page.
>
> No you don't and you can't for the simple reasons is that the GUP
> of some device driver can last days, weeks, months, years ... so
> it is not something you want to do. Here is what happens today:

I think it would be better to use the established way to block access that
Dave suggests. Maybe deal with the issue of threads being blocked for
a long time instead? Introduce a way to abort these attempts in a
controlled fashion that also allows easy debugging of these conflicts?

