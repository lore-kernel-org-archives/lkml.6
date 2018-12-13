Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2991FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAC22145D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAC22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeLMMnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:43:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbeLMMnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:43:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E238330832C4;
        Thu, 13 Dec 2018 12:43:29 +0000 (UTC)
Received: from redhat.com (ovpn-121-185.rdu2.redhat.com [10.10.121.185])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58FCC648B4;
        Thu, 13 Dec 2018 12:43:27 +0000 (UTC)
Date:   Thu, 13 Dec 2018 07:43:25 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181213124325.GA3186@redhat.com>
References: <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212213005.GE5037@redhat.com>
 <CAPcyv4gJHeFjEgna1S-2uE4KxkSUgkc=e=2E5oqfoirec84C-w@mail.gmail.com>
 <20181212215348.GF5037@redhat.com>
 <20181212233703.GB2947@ziepe.ca>
 <20181213000109.GK5037@redhat.com>
 <20181213032043.GA3204@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181213032043.GA3204@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 13 Dec 2018 12:43:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 08:20:43PM -0700, Jason Gunthorpe wrote:
> On Wed, Dec 12, 2018 at 07:01:09PM -0500, Jerome Glisse wrote:
> > On Wed, Dec 12, 2018 at 04:37:03PM -0700, Jason Gunthorpe wrote:
> > > On Wed, Dec 12, 2018 at 04:53:49PM -0500, Jerome Glisse wrote:
> > > > > Almost, we need some safety around assuming that DMA is complete the
> > > > > page, so the notification would need to go all to way to userspace
> > > > > with something like a file lease notification. It would also need to
> > > > > be backstopped by an IOMMU in the case where the hardware does not /
> > > > > can not stop in-flight DMA.
> > > > 
> > > > You can always reprogram the hardware right away it will redirect
> > > > any dma to the crappy page.
> > > 
> > > That causes silent data corruption for RDMA users - we can't do that.
> > > 
> > > The only way out for current hardware is to forcibly terminate the
> > > RDMA activity somehow (and I'm not even sure this is possible, at
> > > least it would be driver specific)
> > > 
> > > Even the IOMMU idea probably doesn't work, I doubt all current
> > > hardware can handle a PCI-E error TLP properly. 
> > 
> > What i saying is reprogram hardware to crappy page ie valid page
> > dma map but that just has random content as a last resort to allow
> > filesystem to reuse block. So their should be no PCIE error unless
> > hardware freak out to see its page table reprogram randomly.
> 
> No, that isn't an option. You can't silently provide corrupted data
> for RDMA to transfer out onto the network, or silently discard data
> coming in!! 
> 
> Think of the consequences of that - I have a fileserver process and
> someone does ftruncate and now my clients receive corrupted data??

This is what happens _today_ ie today someone do GUP on page file
and then someone else do truncate the first GUP is effectively
streaming _random_ data to network as the page does not correspond
to anything anymore and once the RDMA MR goes aways and release
the page the page content will be lost. So i am not changing anything
here, what i proposed was to make it explicit to device driver at
least that they were streaming random data. Right now this is all
silent but this is what is happening wether you like it or not :)

Note that  i am saying do that only for truncate to allow to be
nice to fs. But again i am fine with whatever solution but you can
not please everyone here. Either block truncate and fs folks will
hate you or make it clear to device driver that you are streaming
random things and RDMA people hates you.


> The only option is to prevent the RDMA transfer from ever happening,
> and we just don't have hardware support (beyond destroy everything) to
> do that.
> 
> > The question is who do you want to punish ? RDMA user that pin stuff
> > and expect thing to work forever without worrying for other fs
> > activities ? Or filesystem to pin block forever :) 
> 
> I don't want to punish everyone, I want both sides to have complete
> data integrity as the USER has deliberately decided to combine DAX and
> RDMA. So either stop it at the front end (ie get_user_pages_longterm)
> or make it work in a way that guarantees integrity for both.
> 
> >     S2: notify userspace program through device/sub-system
> >         specific API and delay ftruncate. After a while if there
> >         is no answer just be mean and force hardware to use
> >         crappy page as anyway this is what happens today
> 
> I don't think this happens today (outside of DAX).. Does it?

It does it is just silent, i don't remember anything in the code
that would stop a truncate to happen because of elevated refcount.
This does not happen with ODP mlx5 as it does abide by _all_ mmu
notifier. This is for anything that does ODP without support for
mmu notifier.

> .. and the remedy here is to kill the process, not provide corrupt
> data. Kill the process is likely to not go over well with any real
> users that want this combination.
> 
> Think Samba serving files over RDMA - you can't have random unpriv
> users calling ftruncate and causing smbd to be killed or serve corrupt
> data.

So what i am saying is there is a choice and it would be better to
decide something than let the existing status quo where we just keep
streaming random data after truncate to a GUPed page.

Cheers,
Jérôme
