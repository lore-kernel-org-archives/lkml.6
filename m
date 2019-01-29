Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000ACC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6A920844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfA2Suf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:50:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:7114 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbfA2Suf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:50:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 10:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="295436405"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 29 Jan 2019 10:50:34 -0800
Date:   Tue, 29 Jan 2019 10:50:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org,
        dledford@redhat.com, jack@suse.de, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/6] drivers/IB,qib: do not use mmap_sem
Message-ID: <20190129185005.GC10129@iweiny-DESK2.sc.intel.com>
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-4-dave@stgolabs.net>
 <20190128233140.GA12530@ziepe.ca>
 <20190129044607.GL25106@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129044607.GL25106@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 09:46:07PM -0700, Jason Gunthorpe wrote:
> On Mon, Jan 28, 2019 at 04:31:40PM -0700, Jason Gunthorpe wrote:
> > On Mon, Jan 21, 2019 at 09:42:17AM -0800, Davidlohr Bueso wrote:
> > > The driver uses mmap_sem for both pinned_vm accounting and
> > > get_user_pages(). By using gup_fast() and letting the mm handle
> > > the lock if needed, we can no longer rely on the semaphore and
> > > simplify the whole thing as the pinning is decoupled from the lock.
> > > 
> > > This also fixes a bug that __qib_get_user_pages was not taking into
> > > account the current value of pinned_vm.
> > > 
> > > Cc: dennis.dalessandro@intel.com
> > > Cc: mike.marciniszyn@intel.com
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> > >  drivers/infiniband/hw/qib/qib_user_pages.c | 67 ++++++++++--------------------
> > >  1 file changed, 22 insertions(+), 45 deletions(-)
> > 
> > I need you to respin this patch/series against the latest rdma tree:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> > 
> > branch for-next
> > 
> > > diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
> > > -static int __qib_get_user_pages(unsigned long start_page, size_t num_pages,
> > > -				struct page **p)
> > > -{
> > > -	unsigned long lock_limit;
> > > -	size_t got;
> > > -	int ret;
> > > -
> > > -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > -
> > > -	if (num_pages > lock_limit && !capable(CAP_IPC_LOCK)) {
> > > -		ret = -ENOMEM;
> > > -		goto bail;
> > > -	}
> > > -
> > > -	for (got = 0; got < num_pages; got += ret) {
> > > -		ret = get_user_pages(start_page + got * PAGE_SIZE,
> > > -				     num_pages - got,
> > > -				     FOLL_WRITE | FOLL_FORCE,
> > > -				     p + got, NULL);
> > 
> > As this has been rightly changed to get_user_pages_longterm, and I
> > think the right answer to solve the conflict is to discard some of
> > this patch?
> 
> .. and I'm looking at some of the other conversions here.. *most
> likely* any caller that is manipulating rlimit for get_user_pages
> should really be calling get_user_pages_longterm, so they should not
> be converted to use _fast?

Is this a question?  I'm not sure I understand the meaning here?

Ira

> 
> Jason
