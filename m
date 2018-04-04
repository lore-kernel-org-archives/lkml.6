Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDDOHx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:07:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751231AbeDDOHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:07:40 -0400
Date: Wed, 4 Apr 2018 17:07:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, huangzhichao@huawei.com
Subject: Re: [PATCH v30 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Message-ID: <20180404155907-mutt-send-email-mst@kernel.org>
References: <1522771805-78927-1-git-send-email-wei.w.wang@intel.com>
 <1522771805-78927-3-git-send-email-wei.w.wang@intel.com>
 <20180403214147-mutt-send-email-mst@kernel.org>
 <5AC43377.2070607@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AC43377.2070607@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:07:51AM +0800, Wei Wang wrote:
> On 04/04/2018 02:47 AM, Michael S. Tsirkin wrote:
> > On Wed, Apr 04, 2018 at 12:10:03AM +0800, Wei Wang wrote:
> > > +static int add_one_sg(struct virtqueue *vq, unsigned long pfn, uint32_t len)
> > > +{
> > > +	struct scatterlist sg;
> > > +	unsigned int unused;
> > > +
> > > +	sg_init_table(&sg, 1);
> > > +	sg_set_page(&sg, pfn_to_page(pfn), len, 0);
> > > +
> > > +	/* Detach all the used buffers from the vq */
> > > +	while (virtqueue_get_buf(vq, &unused))
> > > +		;
> > > +
> > > +	/*
> > > +	 * Since this is an optimization feature, losing a couple of free
> > > +	 * pages to report isn't important. We simply return without adding
> > > +	 * the page hint if the vq is full.
> > why not stop scanning of following pages though?
> 
> Because continuing to send hints is a way to deliver the maximum possible
> hints to host. For example, host may have a delay in taking hints at some
> point, and then it resumes to take hints soon. If the driver does not stop
> when the vq is full, it will be able to put more hints to the vq once the vq
> has available entries to add.

What this appears to be is just lack of coordination between
host and guest.

But meanwhile you are spending cycles walking the list uselessly.
Instead of trying nilly-willy, the standard thing to do
is to wait for host to consume an entry and proceed.

Coding it up might be tricky, so it's probably acceptable as is
for now, but please replace the justification about with
a TODO entry that we should synchronize with the host.


> 
> > 
> > > +	 * We are adding one entry each time, which essentially results in no
> > > +	 * memory allocation, so the GFP_KERNEL flag below can be ignored.
> > > +	 * Host works by polling the free page vq for hints after sending the
> > > +	 * starting cmd id, so the driver doesn't need to kick after filling
> > > +	 * the vq.
> > > +	 * Lastly, there is always one entry reserved for the cmd id to use.
> > > +	 */
> > > +	if (vq->num_free > 1)
> > > +		return virtqueue_add_inbuf(vq, &sg, 1, vq, GFP_KERNEL);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int virtio_balloon_send_free_pages(void *opaque, unsigned long pfn,
> > > +					   unsigned long nr_pages)
> > > +{
> > > +	struct virtio_balloon *vb = (struct virtio_balloon *)opaque;
> > > +	uint32_t len = nr_pages << PAGE_SHIFT;
> > > +
> > > +	/*
> > > +	 * If a stop id or a new cmd id was just received from host, stop
> > > +	 * the reporting, and return 1 to indicate an active stop.
> > > +	 */
> > > +	if (virtio32_to_cpu(vb->vdev, vb->cmd_id_use) != vb->cmd_id_received)
> > > +		return 1;

functions returning int should return 0 or -errno on failure,
positive return code should indicate progress.

If you want a boolean, use bool pls.


> > > +
> > this access to cmd_id_use and cmd_id_received without locks
> > bothers me. Pls document why it's safe.
> 
> OK. Probably we could add below to the above comments:
> 
> cmd_id_use and cmd_id_received don't need to be accessed under locks because
> the reporting does not have to stop immediately before cmd_id_received is
> changed (i.e. when host requests to stop). That is, reporting more hints
> after host requests to stop isn't an issue for this optimization feature,
> because host will simply drop the stale hints next time when it needs a new
> reporting.

What about the other direction? Can this observe a stale value and
exit erroneously?

> 
> 
> 
> > 
> > > +	return add_one_sg(vb->free_page_vq, pfn, len);
> > > +}
> > > +
> > > +static int send_start_cmd_id(struct virtio_balloon *vb, uint32_t cmd_id)
> > > +{
> > > +	struct scatterlist sg;
> > > +	struct virtqueue *vq = vb->free_page_vq;
> > > +
> > > +	vb->cmd_id_use = cpu_to_virtio32(vb->vdev, cmd_id);
> > > +	sg_init_one(&sg, &vb->cmd_id_use, sizeof(vb->cmd_id_use));
> > > +	return virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> > > +}
> > > +
> > > +static int send_stop_cmd_id(struct virtio_balloon *vb)
> > > +{
> > > +	struct scatterlist sg;
> > > +	struct virtqueue *vq = vb->free_page_vq;
> > > +
> > > +	sg_init_one(&sg, &vb->stop_cmd_id, sizeof(vb->cmd_id_use));
> > why the inconsistency?
> 
> Thanks, will make it consistent.
> 
> Best,
> Wei
