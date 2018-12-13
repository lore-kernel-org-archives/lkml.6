Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4E2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953FA20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953FA20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeLMQCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:02:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbeLMQCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:02:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDF0DC058CB1;
        Thu, 13 Dec 2018 16:02:07 +0000 (UTC)
Received: from redhat.com (ovpn-121-185.rdu2.redhat.com [10.10.121.185])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70DA7648AB;
        Thu, 13 Dec 2018 16:02:05 +0000 (UTC)
Date:   Thu, 13 Dec 2018 11:02:03 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
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
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181213160203.GD3186@redhat.com>
References: <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
 <20181212215931.GG5037@redhat.com>
 <20181213005119.GD29416@dastard>
 <20181213020229.GN5037@redhat.com>
 <01000167a8483bd2-16ae0d3e-d217-4993-a80a-25d221c677e4-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01000167a8483bd2-16ae0d3e-d217-4993-a80a-25d221c677e4-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 13 Dec 2018 16:02:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 03:56:05PM +0000, Christopher Lameter wrote:
> On Wed, 12 Dec 2018, Jerome Glisse wrote:
> 
> > On Thu, Dec 13, 2018 at 11:51:19AM +1100, Dave Chinner wrote:
> > > > > >     [O1] Avoid write back from a page still being written by either a
> > > > > >          device or some direct I/O or any other existing user of GUP.
> > >
> > > IOWs, you need to mark pages being written to by a GUP as
> > > PageWriteback, so all attempts to write the page will block on
> > > wait_on_page_writeback() before trying to write the dirty page.
> >
> > No you don't and you can't for the simple reasons is that the GUP
> > of some device driver can last days, weeks, months, years ... so
> > it is not something you want to do. Here is what happens today:
> 
> I think it would be better to use the established way to block access that
> Dave suggests. Maybe deal with the issue of threads being blocked for
> a long time instead? Introduce a way to abort these attempts in a
> controlled fashion that also allows easy debugging of these conflicts?

GUP does not have the information on how long the GUP will last,
the GUP caller might not know either. What is worse is that the
GUP user provide API today to userspace to do this and thus any
attempt to block this from happening can be interpreted (from
some point of view) as a regression ie worked in linux X.Y does
not work in linux X.Y+1.

I am not against doing that, in fact i advocated at last LSF that
any user of GUP that does not abide to mmu notifier should be
denied GUP (direct IO, kvm and couple other like that being the
exception because they are case we can properly fix).

Anyone that abide to mmu notifier will drop the page reference on
any event like truncate, split, mremap, munmap, write back ... so
anyone with mmu notifier is fine.

Cheers,
Jérôme
