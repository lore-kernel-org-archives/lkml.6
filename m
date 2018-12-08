Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1EEC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ED62082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ED62082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLHRrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:47:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeLHRrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:47:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BFB6394D58;
        Sat,  8 Dec 2018 17:47:35 +0000 (UTC)
Received: from redhat.com (ovpn-120-239.rdu2.redhat.com [10.10.120.239])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F80D60BE8;
        Sat,  8 Dec 2018 17:47:32 +0000 (UTC)
Date:   Sat, 8 Dec 2018 12:47:30 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181208174730.GB2952@redhat.com>
References: <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
 <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <CAPcyv4hwtMA+4qc6500ucn5vf6fRrNdfyMHru_Jhzx86=1Wwww@mail.gmail.com>
 <20181208163353.GA2952@redhat.com>
 <20181208164825.GA26154@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181208164825.GA26154@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 08 Dec 2018 17:47:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 08:48:25AM -0800, Christoph Hellwig wrote:
> On Sat, Dec 08, 2018 at 11:33:53AM -0500, Jerome Glisse wrote:
> > Patchset to use HMM inside nouveau have already been posted, some
> > of the bits have already made upstream and more are line up for
> > next merge window.
> 
> Even with that it is a relative fringe feature compared to making
> something like get_user_pages() that is literally used every to actually
> work properly.
> 
> So I think we need to kick out HMM here and just find another place for
> it to store data.
> 
> And just to make clear that I'm not picking just on this - the same is
> true to a just a little smaller extent for the pgmap..

Most of the user of GUP are well behave (everything under driver/gpu and
so is mellanox driver and many other) ie they abide by mmu notifier
invalidation call backs. They are a handfull of device driver that thought
they could just do GUP and ignore the mmu notifier part and those are the
one being problematic. So to me it feels like bystander are be shot for no
good reasons.

I proposed an alternative solution to this GUP thing and i don't think it
is a crazy one and thinking about it we only need to do that for file back
page so we can leave untouch the anonymous page case. This would put a
small burden on the user of GUP (by the way i am working on removing GUP
from drivers/gpu and other well behave driver, patch posted on dri-devel
for some of the GPU already).

So why not explore my idea and see if they are any roadblock on it.

Cheers,
Jérôme
