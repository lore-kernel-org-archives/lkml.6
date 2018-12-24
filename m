Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA8CC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9576521736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbeLXSK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:10:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbeLXSK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:10:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A90E087621;
        Mon, 24 Dec 2018 18:10:27 +0000 (UTC)
Received: from redhat.com (ovpn-120-80.rdu2.redhat.com [10.10.120.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3BA65C21A;
        Mon, 24 Dec 2018 18:10:26 +0000 (UTC)
Date:   Mon, 24 Dec 2018 13:10:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20181224125237-mutt-send-email-mst@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213101022.12475-4-jasowang@redhat.com>
 <20181213102713-mutt-send-email-mst@kernel.org>
 <d70c5ac1-c805-cefd-ace1-643a2e271ba0@redhat.com>
 <20181214073332-mutt-send-email-mst@kernel.org>
 <2ea274df-a79a-250f-648f-12927529d78a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ea274df-a79a-250f-648f-12927529d78a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 24 Dec 2018 18:10:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 03:53:16PM +0800, Jason Wang wrote:
> 
> On 2018/12/14 下午8:36, Michael S. Tsirkin wrote:
> > On Fri, Dec 14, 2018 at 11:57:35AM +0800, Jason Wang wrote:
> > > On 2018/12/13 下午11:44, Michael S. Tsirkin wrote:
> > > > On Thu, Dec 13, 2018 at 06:10:22PM +0800, Jason Wang wrote:
> > > > > It was noticed that the copy_user() friends that was used to access
> > > > > virtqueue metdata tends to be very expensive for dataplane
> > > > > implementation like vhost since it involves lots of software check,
> > > > > speculation barrier, hardware feature toggling (e.g SMAP). The
> > > > > extra cost will be more obvious when transferring small packets.
> > > > > 
> > > > > This patch tries to eliminate those overhead by pin vq metadata pages
> > > > > and access them through vmap(). During SET_VRING_ADDR, we will setup
> > > > > those mappings and memory accessors are modified to use pointers to
> > > > > access the metadata directly.
> > > > > 
> > > > > Note, this was only done when device IOTLB is not enabled. We could
> > > > > use similar method to optimize it in the future.
> > > > > 
> > > > > Tests shows about ~24% improvement on TX PPS when using virtio-user +
> > > > > vhost_net + xdp1 on TAP (CONFIG_HARDENED_USERCOPY is not enabled):
> > > > > 
> > > > > Before: ~5.0Mpps
> > > > > After:  ~6.1Mpps
> > > > > 
> > > > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > > > > ---
> > > > >    drivers/vhost/vhost.c | 178 ++++++++++++++++++++++++++++++++++++++++++
> > > > >    drivers/vhost/vhost.h |  11 +++
> > > > >    2 files changed, 189 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > index bafe39d2e637..1bd24203afb6 100644
> > > > > --- a/drivers/vhost/vhost.c
> > > > > +++ b/drivers/vhost/vhost.c
> > > > > @@ -443,6 +443,9 @@ void vhost_dev_init(struct vhost_dev *dev,
> > > > >    		vq->indirect = NULL;
> > > > >    		vq->heads = NULL;
> > > > >    		vq->dev = dev;
> > > > > +		memset(&vq->avail_ring, 0, sizeof(vq->avail_ring));
> > > > > +		memset(&vq->used_ring, 0, sizeof(vq->used_ring));
> > > > > +		memset(&vq->desc_ring, 0, sizeof(vq->desc_ring));
> > > > >    		mutex_init(&vq->mutex);
> > > > >    		vhost_vq_reset(dev, vq);
> > > > >    		if (vq->handle_kick)
> > > > > @@ -614,6 +617,102 @@ static void vhost_clear_msg(struct vhost_dev *dev)
> > > > >    	spin_unlock(&dev->iotlb_lock);
> > > > >    }
> > > > > +static int vhost_init_vmap(struct vhost_vmap *map, unsigned long uaddr,
> > > > > +			   size_t size, int write)
> > > > > +{
> > > > > +	struct page **pages;
> > > > > +	int npages = DIV_ROUND_UP(size, PAGE_SIZE);
> > > > > +	int npinned;
> > > > > +	void *vaddr;
> > > > > +
> > > > > +	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
> > > > > +	if (!pages)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	npinned = get_user_pages_fast(uaddr, npages, write, pages);
> > > > > +	if (npinned != npages)
> > > > > +		goto err;
> > > > > +
> > > > As I said I have doubts about the whole approach, but this
> > > > implementation in particular isn't a good idea
> > > > as it keeps the page around forever.
> 
> 
> The pages wil be released during set features.
> 
> 
> > > > So no THP, no NUMA rebalancing,
> 
> 
> For THP, we will probably miss 2 or 4 pages, but does this really matter
> consider the gain we have?

We as in vhost? networking isn't the only thing guest does.
We don't even know if this guest does a lot of networking.
You don't
know what else is in this huge page. Can be something very important
that guest touches all the time.

> For NUMA rebalancing, I'm even not quite sure if
> it can helps for the case of IPC (vhost). It looks to me the worst case it
> may cause page to be thrash between nodes if vhost and userspace are running
> in two nodes.


So again it's a gain for vhost but has a completely unpredictable effect on
other functionality of the guest.

That's what bothers me with this approach.




> 
> > > 
> > > This is the price of all GUP users not only vhost itself.
> > Yes. GUP is just not a great interface for vhost to use.
> 
> 
> Zerocopy codes (enabled by defualt) use them for years.

But only for TX and temporarily. We pin, read, unpin.

Your patch is different

- it writes into memory and GUP has known issues with file
  backed memory
- it keeps pages pinned forever



> 
> > 
> > > What's more
> > > important, the goal is not to be left too much behind for other backends
> > > like DPDK or AF_XDP (all of which are using GUP).
> > 
> > So these guys assume userspace knows what it's doing.
> > We can't assume that.
> 
> 
> What kind of assumption do you they have?
> 
> 
> > 
> > > > userspace-controlled
> > > > amount of memory locked up and not accounted for.
> > > 
> > > It's pretty easy to add this since the slow path was still kept. If we
> > > exceeds the limitation, we can switch back to slow path.
> > > 
> > > > Don't get me wrong it's a great patch in an ideal world.
> > > > But then in an ideal world no barriers smap etc are necessary at all.
> > > 
> > > Again, this is only for metadata accessing not the data which has been used
> > > for years for real use cases.
> > > 
> > > For SMAP, it makes senses for the address that kernel can not forcast. But
> > > it's not the case for the vhost metadata since we know the address will be
> > > accessed very frequently. For speculation barrier, it helps nothing for the
> > > data path of vhost which is a kthread.
> > I don't see how a kthread makes any difference. We do have a validation
> > step which makes some difference.
> 
> 
> The problem is not kthread but the address of userspace address. The
> addresses of vq metadata tends to be consistent for a while, and vhost knows
> they will be frequently. SMAP doesn't help too much in this case.
> 
> Thanks.

It's true for a real life applications but a malicious one
can call the setup ioctls any number of times. And SMAP is
all about malcious applications.

> 
> > 
> > > Packet or AF_XDP benefit from
> > > accessing metadata directly, we should do it as well.
> > > 
> > > Thanks
