Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDEAad convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:30:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:37688 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752591AbeDEAab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:30:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,409,1517904000";
   d="scan'208";a="43543274"
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
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
Subject: RE: [PATCH v30 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Thread-Topic: [PATCH v30 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Thread-Index: AQHTyyXXTsdlmy3QmUiflW8thGbyQqPu3AAAgAB7EICAAMkagIABH5Eg
Date: Thu, 5 Apr 2018 00:30:27 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7394A6E96@shsmsx102.ccr.corp.intel.com>
References: <1522771805-78927-1-git-send-email-wei.w.wang@intel.com>
 <1522771805-78927-3-git-send-email-wei.w.wang@intel.com>
 <20180403214147-mutt-send-email-mst@kernel.org> <5AC43377.2070607@intel.com>
 <20180404155907-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180404155907-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjQzMzUyMGUtNWE2Zi00ZmMwLWI4MDItNDgwODJjYTdiOTU5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IlwvQ09ZaWFCa3JheVdkNVFGNktIMjlTUzFIZHJaTHBCU0FnQk11WXM4S2U4PSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 4, 2018 10:08 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 04, 2018 at 10:07:51AM +0800, Wei Wang wrote:
> > On 04/04/2018 02:47 AM, Michael S. Tsirkin wrote:
> > > On Wed, Apr 04, 2018 at 12:10:03AM +0800, Wei Wang wrote:
> > > > +static int add_one_sg(struct virtqueue *vq, unsigned long pfn,
> > > > +uint32_t len) {
> > > > +	struct scatterlist sg;
> > > > +	unsigned int unused;
> > > > +
> > > > +	sg_init_table(&sg, 1);
> > > > +	sg_set_page(&sg, pfn_to_page(pfn), len, 0);
> > > > +
> > > > +	/* Detach all the used buffers from the vq */
> > > > +	while (virtqueue_get_buf(vq, &unused))
> > > > +		;
> > > > +
> > > > +	/*
> > > > +	 * Since this is an optimization feature, losing a couple of free
> > > > +	 * pages to report isn't important. We simply return without adding
> > > > +	 * the page hint if the vq is full.
> > > why not stop scanning of following pages though?
> >
> > Because continuing to send hints is a way to deliver the maximum
> > possible hints to host. For example, host may have a delay in taking
> > hints at some point, and then it resumes to take hints soon. If the
> > driver does not stop when the vq is full, it will be able to put more
> > hints to the vq once the vq has available entries to add.
> 
> What this appears to be is just lack of coordination between host and guest.
> 
> But meanwhile you are spending cycles walking the list uselessly.
> Instead of trying nilly-willy, the standard thing to do is to wait for host to
> consume an entry and proceed.
> 
> Coding it up might be tricky, so it's probably acceptable as is for now, but
> please replace the justification about with a TODO entry that we should
> synchronize with the host.

Thanks. I plan to add

TODO: The current implementation could be further improved by stopping the reporting when the vq is full and continuing the reporting when host notifies that there are available entries for the driver to add.


> 
> 
> >
> > >
> > > > +	 * We are adding one entry each time, which essentially results in no
> > > > +	 * memory allocation, so the GFP_KERNEL flag below can be ignored.
> > > > +	 * Host works by polling the free page vq for hints after sending the
> > > > +	 * starting cmd id, so the driver doesn't need to kick after filling
> > > > +	 * the vq.
> > > > +	 * Lastly, there is always one entry reserved for the cmd id to use.
> > > > +	 */
> > > > +	if (vq->num_free > 1)
> > > > +		return virtqueue_add_inbuf(vq, &sg, 1, vq, GFP_KERNEL);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int virtio_balloon_send_free_pages(void *opaque, unsigned long
> pfn,
> > > > +					   unsigned long nr_pages)
> > > > +{
> > > > +	struct virtio_balloon *vb = (struct virtio_balloon *)opaque;
> > > > +	uint32_t len = nr_pages << PAGE_SHIFT;
> > > > +
> > > > +	/*
> > > > +	 * If a stop id or a new cmd id was just received from host, stop
> > > > +	 * the reporting, and return 1 to indicate an active stop.
> > > > +	 */
> > > > +	if (virtio32_to_cpu(vb->vdev, vb->cmd_id_use) != vb-
> >cmd_id_received)
> > > > +		return 1;
> 
> functions returning int should return 0 or -errno on failure, positive return
> code should indicate progress.
> 
> If you want a boolean, use bool pls.

OK. I plan to change 1  to -EBUSY to indicate the case that host actively asks the driver to stop reporting (This makes the callback return value type consistent with walk_free_mem_block). 



> 
> 
> > > > +
> > > this access to cmd_id_use and cmd_id_received without locks bothers
> > > me. Pls document why it's safe.
> >
> > OK. Probably we could add below to the above comments:
> >
> > cmd_id_use and cmd_id_received don't need to be accessed under locks
> > because the reporting does not have to stop immediately before
> > cmd_id_received is changed (i.e. when host requests to stop). That is,
> > reporting more hints after host requests to stop isn't an issue for
> > this optimization feature, because host will simply drop the stale
> > hints next time when it needs a new reporting.
> 
> What about the other direction? Can this observe a stale value and exit
> erroneously?

I'm afraid the driver couldn't be aware if the added hints are stale or not, because host and guest actions happen asynchronously. That is, host side iothread stops taking hints as soon as the migration thread asks to stop, it doesn't wait for any ACK from the driver to stop (as we discussed before, host couldn't always assume that the driver is in a responsive state).

Btw, we also don't need to worry about any memory left in the vq, since only addresses are added to the vq, there is no real memory allocations.

Best,
Wei
