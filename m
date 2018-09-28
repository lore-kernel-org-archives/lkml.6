Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C65EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1DF20833
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1DF20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeI1Vy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:54:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbeI1Vy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:54:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5765F1B96;
        Fri, 28 Sep 2018 15:30:10 +0000 (UTC)
Received: from redhat.com (ovpn-121-210.rdu2.redhat.com [10.10.121.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 663B85D791;
        Fri, 28 Sep 2018 15:30:03 +0000 (UTC)
Date:   Fri, 28 Sep 2018 11:29:59 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 0/4] get_user_pages*() and RDMA: first steps
Message-ID: <20180928152958.GA3321@redhat.com>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180928053949.5381-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 28 Sep 2018 15:30:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:39:45PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Hi,
> 
> This short series prepares for eventually fixing the problem described
> in [1], and is following a plan listed in [2].
> 
> I'd like to get the first two patches into the -mm tree.
> 
> Patch 1, although not technically critical to do now, is still nice to have,
> because it's already been reviewed by Jan, and it's just one more thing on the
> long TODO list here, that is ready to be checked off.
> 
> Patch 2 is required in order to allow me (and others, if I'm lucky) to start
> submitting changes to convert all of the callsites of get_user_pages*() and
> put_page().  I think this will work a lot better than trying to maintain a
> massive patchset and submitting all at once.
> 
> Patch 3 converts infiniband drivers: put_page() --> put_user_page(). I picked
> a fairly small and easy example.
> 
> Patch 4 converts a small driver from put_page() --> release_user_pages(). This
> could just as easily have been done as a change from put_page() to
> put_user_page(). The reason I did it this way is that this provides a small and
> simple caller of the new release_user_pages() routine. I wanted both of the
> new routines, even though just placeholders, to have callers.
> 
> Once these are all in, then the floodgates can open up to convert the large
> number of get_user_pages*() callsites.
> 
> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> 
> [2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
>     Proposed steps for fixing get_user_pages() + DMA problems.
> 

So the solution is to wait (possibly for days, months, years) that the
RDMA or GPU which did GUP and do not have mmu notifier, release the page
(or put_user_page()) ?

This sounds bads. Like i said during LSF/MM there is no way to properly
fix hardware that can not be preempted/invalidated ... most GPU are fine.
Few RDMA are fine, most can not ...

If it is just about fixing the set_page_dirty() bug then just looking at
refcount versus mapcount should already tell you if you can remove the
buffer head from the page or not. Which would fix the bug without complex
changes (i still like the put_user_page just for symetry with GUP).

Cheers,
Jérôme
