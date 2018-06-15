Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 171B9C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB9720896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB9720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965885AbeFOO3U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:29:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965737AbeFOO3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8EA2401CB89;
        Fri, 15 Jun 2018 14:29:18 +0000 (UTC)
Received: from redhat.com (ovpn-120-46.rdu2.redhat.com [10.10.120.46])
        by smtp.corp.redhat.com (Postfix) with SMTP id B962B215672D;
        Fri, 15 Jun 2018 14:29:16 +0000 (UTC)
Date:   Fri, 15 Jun 2018 17:29:16 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v33 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Message-ID: <20180615171635-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-3-git-send-email-wei.w.wang@intel.com>
 <20180615144000-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A3D04@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7396A3D04@shsmsx102.ccr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 15 Jun 2018 14:29:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 15 Jun 2018 14:29:18 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 02:11:23PM +0000, Wang, Wei W wrote:
> On Friday, June 15, 2018 7:42 PM, Michael S. Tsirkin wrote:
> > On Fri, Jun 15, 2018 at 12:43:11PM +0800, Wei Wang wrote:
> > > Negotiation of the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature indicates
> > > the support of reporting hints of guest free pages to host via virtio-balloon.
> > >
> > > Host requests the guest to report free page hints by sending a command
> > > to the guest via setting the
> > VIRTIO_BALLOON_HOST_CMD_FREE_PAGE_HINT
> > > bit of the host_cmd config register.
> > >
> > > As the first step here, virtio-balloon only reports free page hints
> > > from the max order (10) free page list to host. This has generated
> > > similar good results as reporting all free page hints during our tests.
> > >
> > > TODO:
> > > - support reporting free page hints from smaller order free page lists
> > >   when there is a need/request from users.
> > >
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > >  drivers/virtio/virtio_balloon.c     | 187 +++++++++++++++++++++++++++++--
> > -----
> > >  include/uapi/linux/virtio_balloon.h |  13 +++
> > >  2 files changed, 163 insertions(+), 37 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_balloon.c
> > > b/drivers/virtio/virtio_balloon.c index 6b237e3..582a03b 100644
> > > --- a/drivers/virtio/virtio_balloon.c
> > > +++ b/drivers/virtio/virtio_balloon.c
> > > @@ -43,6 +43,9 @@
> > >  #define OOM_VBALLOON_DEFAULT_PAGES 256  #define
> > > VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
> > >
> > > +/* The size of memory in bytes allocated for reporting free page
> > > +hints */ #define FREE_PAGE_HINT_MEM_SIZE (PAGE_SIZE * 16)
> > > +
> > >  static int oom_pages = OOM_VBALLOON_DEFAULT_PAGES;
> > > module_param(oom_pages, int, S_IRUSR | S_IWUSR);
> > > MODULE_PARM_DESC(oom_pages, "pages to free on OOM");
> > 
> > Doesn't this limit memory size of the guest we can report?
> > Apparently to several gigabytes ...
> > OTOH huge guests with lots of free memory is exactly where we would gain
> > the most ...
> 
> Yes, the 16-page array can report up to 32GB (each page can hold 512 addresses of 4MB free page blocks, i.e. 2GB free memory per page) free memory to host. It is not flexible.
> 
> How about allocating the buffer according to the guest memory size (proportional)? That is,
> 
> /* Calculates the maximum number of 4MB (equals to 1024 pages) free pages blocks that the system can have */
> 4m_page_blocks = totalram_pages / 1024;
> 
> /* Allocating one page can hold 512 free page blocks, so calculates the number of pages that can hold those 4MB blocks. And this allocation should not exceed 1024 pages */
> pages_to_allocate = min(4m_page_blocks / 512, 1024);
> 
> For a 2TB guests, which has 2^19 page blocks (4MB each), we will allocate 1024 pages as the buffer.
> 
> When the guest has large memory, it should be easier to succeed in allocation of large buffer. If that allocation fails, that implies that nothing would be got from the 4MB free page list.
> 
> I think the proportional allocation is simpler compared to other approaches like 
> - scattered buffer, which will complicate the get_from_free_page_list implementation;
> - one buffer to call get_from_free_page_list multiple times, which needs get_from_free_page_list to maintain states.. also too complicated.
> 
> Best,
> Wei
> 

That's more reasonable, but question remains what to do if that value
exceeds MAX_ORDER. I'd say maybe tell host we can't report it.

Also allocating it with GFP_KERNEL is out. You only want to take
it off the free list. So I guess __GFP_NOMEMALLOC and __GFP_ATOMIC.

Also you can't allocate this on device start. First totalram_pages can
change. Second that's too much memory to tie up forever.

-- 
MST
