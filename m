Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A25BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE9820856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE9820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbeGWPOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:14:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388153AbeGWPOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:14:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D47E402346D;
        Mon, 23 Jul 2018 14:13:19 +0000 (UTC)
Received: from redhat.com (ovpn-123-242.rdu2.redhat.com [10.10.123.242])
        by smtp.corp.redhat.com (Postfix) with SMTP id AD13A111DD0B;
        Mon, 23 Jul 2018 14:13:12 +0000 (UTC)
Date:   Mon, 23 Jul 2018 17:13:11 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com
Subject: Re: [PATCH v36 2/5] virtio_balloon: replace oom notifier with
 shrinker
Message-ID: <20180723170826-mutt-send-email-mst@kernel.org>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
 <1532075585-39067-3-git-send-email-wei.w.wang@intel.com>
 <20180722174125-mutt-send-email-mst@kernel.org>
 <5B55AE56.5030404@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B55AE56.5030404@intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 23 Jul 2018 14:13:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 23 Jul 2018 14:13:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 06:30:46PM +0800, Wei Wang wrote:
> On 07/22/2018 10:48 PM, Michael S. Tsirkin wrote:
> > On Fri, Jul 20, 2018 at 04:33:02PM +0800, Wei Wang wrote:
> > > +static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
> > > +						  struct shrink_control *sc)
> > > +{
> > > +	unsigned long pages_to_free = balloon_pages_to_shrink,
> > > +		      pages_freed = 0;
> > > +	struct virtio_balloon *vb = container_of(shrinker,
> > > +					struct virtio_balloon, shrinker);
> > > +
> > > +	/*
> > > +	 * One invocation of leak_balloon can deflate at most
> > > +	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
> > > +	 * multiple times to deflate pages till reaching
> > > +	 * balloon_pages_to_shrink pages.
> > > +	 */
> > > +	while (vb->num_pages && pages_to_free) {
> > > +		pages_to_free = balloon_pages_to_shrink - pages_freed;
> > > +		pages_freed += leak_balloon(vb, pages_to_free);
> > > +	}
> > > +	update_balloon_size(vb);
> > Are you sure that this is never called if count returned 0?
> 
> Yes. Please see do_shrink_slab, it just returns if count is 0.
> 
> > 
> > > +
> > > +	return pages_freed / VIRTIO_BALLOON_PAGES_PER_PAGE;
> > > +}
> > > +
> > > +static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
> > > +						   struct shrink_control *sc)
> > > +{
> > > +	struct virtio_balloon *vb = container_of(shrinker,
> > > +					struct virtio_balloon, shrinker);
> > > +
> > > +	/*
> > > +	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to handle the
> > > +	 * case when shrinker needs to be invoked to relieve memory pressure.
> > > +	 */
> > > +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> > > +		return 0;
> > So why not skip notifier registration when deflate on oom
> > is clear?
> 
> Sounds good, thanks.
> 
> 
> >   	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
> >   #endif
> > +	err = virtio_balloon_register_shrinker(vb);
> > +	if (err)
> > +		goto out_del_vqs;
> > So we can get scans before device is ready. Leak will fail
> > then. Why not register later after device is ready?
> 
> Probably no.
> 
> - it would be better not to set device ready when register_shrinker failed.

That's very rare so I won't be too worried.

> - When the device isn't ready, ballooning won't happen, that is,
> vb->num_pages will be 0, which results in shrinker_count=0 and shrinker_scan
> won't be called.
> 
> So I think it would be better to have shrinker registered before
> device_ready.
> 
> Best,
> Wei
