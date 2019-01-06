Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37906C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 00:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0319320830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 00:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfAFAcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 19:32:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfAFAcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 19:32:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7174C04AC54;
        Sun,  6 Jan 2019 00:32:03 +0000 (UTC)
Received: from redhat.com (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with SMTP id D1FC160BF6;
        Sun,  6 Jan 2019 00:31:59 +0000 (UTC)
Date:   Sat, 5 Jan 2019 19:31:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 1/2] virtio-balloon: tweak config_changed
 implementation
Message-ID: <20190105192858-mutt-send-email-mst@kernel.org>
References: <1546585913-34804-1-git-send-email-wei.w.wang@intel.com>
 <1546585913-34804-2-git-send-email-wei.w.wang@intel.com>
 <20190104103213-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F73DEF57A3@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73DEF57A3@shsmsx102.ccr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 06 Jan 2019 00:32:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 03:32:44AM +0000, Wang, Wei W wrote:
> On Friday, January 4, 2019 11:45 PM, Michael S. Tsirkin wrote:
> > >  struct virtio_balloon {
> > >  	struct virtio_device *vdev;
> > >  	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
> > > @@ -77,6 +81,8 @@ struct virtio_balloon {
> > >  	/* Prevent updating balloon when it is being canceled. */
> > >  	spinlock_t stop_update_lock;
> > >  	bool stop_update;
> > > +	/* Bitmap to indicate if reading the related config fields are needed
> > */
> > > +	unsigned long config_read_bitmap;
> > >
> > >  	/* The list of allocated free pages, waiting to be given back to mm */
> > >  	struct list_head free_page_list;
> > 
> > It seems that you never initialize this bitmap. Probably harmless here but
> > generally using uninitialized memory isn't good.
> 
> We've used kzalloc to allocate the vb struct, so it's already 0-initialized :)

Ah ok. We do explicitly init other fields like stop_update so
it seems cleaner to init this one too though.

> > > +
> > >  static int send_free_pages(struct virtio_balloon *vb)  {
> > >  	int err;
> > > @@ -620,6 +630,7 @@ static int send_free_pages(struct virtio_balloon *vb)
> > >  		 * stop the reporting.
> > >  		 */
> > >  		cmd_id_active = virtio32_to_cpu(vb->vdev, vb-
> > >cmd_id_active);
> > > +		virtio_balloon_read_cmd_id_received(vb);
>  
> 
> [1]
> 
> 
> > >  		if (cmd_id_active != vb->cmd_id_received)
> > >  			break;
> > >
> > > @@ -637,11 +648,9 @@ static int send_free_pages(struct virtio_balloon
> > *vb)
> > >  	return 0;
> > >  }
> > >
> > > -static void report_free_page_func(struct work_struct *work)
> > > +static void virtio_balloon_report_free_page(struct virtio_balloon
> > > +*vb)
> > >  {
> > >  	int err;
> > > -	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> > > -						 report_free_page_work);
> > >  	struct device *dev = &vb->vdev->dev;
> > >
> > >  	/* Start by sending the received cmd id to host with an outbuf. */
> > > @@ -659,6 +668,22 @@ static void report_free_page_func(struct
> > work_struct *work)
> > >  		dev_err(dev, "Failed to send a stop id, err = %d\n", err);  }
> > >
> > > +static void report_free_page_func(struct work_struct *work) {
> > > +	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> > > +						 report_free_page_work);
> > > +
> > > +	virtio_balloon_read_cmd_id_received(vb);
> > 
> > This will not achieve what you are trying to do, which is cancel reporting if it's
> > in progress.
> > 
> > You need to re-read each time you compare to cmd_id_active.
> 
> Yes, already did, please see [1] above

Oh right. Sorry.

> 
> > An API similar to
> > 	u32 virtio_balloon_cmd_id_received(vb)
> > seems to be called for, and I would rename cmd_id_received to
> > cmd_id_received_cache to make sure we caught all users.
> > 
> 
> I'm not sure about adding "cache" here, cmd_id_received refers to the cmd id
> that the driver just received from the device. There is one called "cmd_id_active" which
> is the one that the driver is actively using. 
> So cmd_id_received is already a "cache" to " cmd_id_active " in some sense.
> 
> Best,
> Wei

The point is that any access to cmd_id_received should first call
virtio_balloon_read_cmd_id_received. So a better API is
to have virtio_balloon_read_cmd_id_received return the value
instead of poking at cmd_id_received afterwards.
Renaming cmd_id_received will help make sure all no
call sites were missed and help stress it's never used directly.


