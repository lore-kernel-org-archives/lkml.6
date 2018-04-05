Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeDESaU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 14:30:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751415AbeDESaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 14:30:19 -0400
Date: Thu, 5 Apr 2018 21:30:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "huangzhichao@huawei.com" <huangzhichao@huawei.com>
Subject: Re: [PATCH v30 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Message-ID: <20180405212850-mutt-send-email-mst@kernel.org>
References: <1522771805-78927-1-git-send-email-wei.w.wang@intel.com>
 <1522771805-78927-3-git-send-email-wei.w.wang@intel.com>
 <20180403214147-mutt-send-email-mst@kernel.org>
 <5AC43377.2070607@intel.com>
 <20180404155907-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7394A6E96@shsmsx102.ccr.corp.intel.com>
 <20180405040900-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7394A7F3B@shsmsx102.ccr.corp.intel.com>
 <20180405170248-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7394A889E@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7394A889E@shsmsx102.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 03:47:28PM +0000, Wang, Wei W wrote:
> On Thursday, April 5, 2018 10:04 PM, Michael S. Tsirkin wrote:
> > On Thu, Apr 05, 2018 at 02:05:03AM +0000, Wang, Wei W wrote:
> > > On Thursday, April 5, 2018 9:12 AM, Michael S. Tsirkin wrote:
> > > > On Thu, Apr 05, 2018 at 12:30:27AM +0000, Wang, Wei W wrote:
> > > > > On Wednesday, April 4, 2018 10:08 PM, Michael S. Tsirkin wrote:
> > > > > > On Wed, Apr 04, 2018 at 10:07:51AM +0800, Wei Wang wrote:
> > > > > > > On 04/04/2018 02:47 AM, Michael S. Tsirkin wrote:
> > > > > > > > On Wed, Apr 04, 2018 at 12:10:03AM +0800, Wei Wang wrote:
> > > > > I'm afraid the driver couldn't be aware if the added hints are
> > > > > stale or not,
> > > >
> > > >
> > > > No - I mean that driver has code that compares two values and stops
> > > > reporting. Can one of the values be stale?
> > >
> > > The driver compares "vb->cmd_id_use != vb->cmd_id_received" to decide
> > > if it needs to stop reporting hints, and cmd_id_received is what the
> > > driver reads from host (host notifies the driver to read for the
> > > latest value). If host sends a new cmd id, it will notify the guest to
> > > read again. I'm not sure how that could be a stale cmd id (or maybe I
> > > misunderstood your point here?)
> > >
> > > Best,
> > > Wei
> > 
> > The comparison is done in one thread, the update in another one.
> 
> I think this isn't something that could be solved by adding a lock,
> unless host waits for the driver's ACK about finishing the update
> (this is not agreed in the QEMU part discussion).
> 
> Actually virtio_balloon has F_IOMMU_PLATFORM disabled, maybe we don't
> need to worry about that using DMA api case (we only have gpa added to
> the vq, and having some entries stay in the vq seems fine). For this
> feature, I think it would not work with F_IOMMU enabled either.

Adding a code comment explaining all this might be a good idea.

> If there is any further need (I couldn't think of a need so far), I
> think we could consider to let host inject a vq interrupt at some
> point, and then the driver handler can do the virtqueue_get_buf work.
> 
> Best,
> Wei
