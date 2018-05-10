Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756970AbeEJIzc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 04:55:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:4916 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756676AbeEJIza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 04:55:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,384,1520924400";
   d="scan'208";a="57461983"
Date: Thu, 10 May 2018 16:56:01 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com
Subject: Re: [RFC v3 3/5] virtio_ring: add packed ring support
Message-ID: <20180510085601.6mpxf3yvwxnqnk5q@debian>
References: <20180425051550.24342-1-tiwei.bie@intel.com>
 <20180425051550.24342-4-tiwei.bie@intel.com>
 <927f4478-5a81-31d4-ac69-f9ec26248591@redhat.com>
 <5885acac-e9e3-3abf-b6a2-7347f4d55be2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5885acac-e9e3-3abf-b6a2-7347f4d55be2@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 03:34:50PM +0800, Jason Wang wrote:
> On 2018年05月10日 15:32, Jason Wang wrote:
> > On 2018年04月25日 13:15, Tiwei Bie wrote:
> > > +    /* We're using some buffers from the free list. */
> > > +    vq->vq.num_free -= descs_used;
> > > +
> > > +    /* Update free pointer */
> > > +    if (indirect) {
> > > +        n = head + 1;
> > > +        if (n >= vq->vring_packed.num) {
> > > +            n = 0;
> > > +            vq->wrap_counter ^= 1;
> > > +        }
> > > +        vq->next_avail_idx = n;
> > > +    } else
> > > +        vq->next_avail_idx = i;
> > 
> > During testing zerocopy (out of order completion), I found driver may
> > submit two identical buffer id to vhost. So the above code may not work
> > well.
> > 
> > Consider the case that driver adds 3 buffer and virtqueue size is 8.
> > 
> > a) id = 0,count = 2,next_avail = 2
> > 
> > b) id = 2,count = 4,next_avail = 2
> 
> next_avail should be 6 here.
> 
> > 
> > c) id = 4,count = 2,next_avail = 0
> > 
> 
> id should be 6 here.
> 
> Thanks
> 
> > if packet b is done before packet a, driver may think buffer id 0 is
> > available and try to use it if even if the real buffer 0 was not done.
> > 
> > Thanks

Nice catch! Thanks a lot!
I'll implement an ID allocator.

Best regards,
Tiwei Bie
