Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C279C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3A120672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3A120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeLIOdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:33:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeLIOds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:33:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CD57C028345;
        Sun,  9 Dec 2018 14:33:48 +0000 (UTC)
Received: from redhat.com (ovpn-120-192.rdu2.redhat.com [10.10.120.192])
        by smtp.corp.redhat.com (Postfix) with SMTP id EFE711019635;
        Sun,  9 Dec 2018 14:33:42 +0000 (UTC)
Date:   Sun, 9 Dec 2018 09:33:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [RFC 3/3] virtio_ring: use new vring flags
Message-ID: <20181209093222-mutt-send-email-mst@kernel.org>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
 <20181207084842.13133-4-tiwei.bie@intel.com>
 <20181207130822-mutt-send-email-mst@kernel.org>
 <20181208134728.GC29772@dpdk-tbie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208134728.GC29772@dpdk-tbie>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 09 Dec 2018 14:33:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 09:47:29PM +0800, Tiwei Bie wrote:
> On Fri, Dec 07, 2018 at 01:10:48PM -0500, Michael S. Tsirkin wrote:
> > On Fri, Dec 07, 2018 at 04:48:42PM +0800, Tiwei Bie wrote:
> > > Switch to using the _SPLIT_ and _PACKED_ variants of vring flags
> > > in split ring and packed ring respectively.
> > > 
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > ---
> > > @@ -502,7 +505,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >  		}
> > >  	}
> > >  	/* Last one doesn't continue. */
> > > -	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > +	desc[prev].flags &= cpu_to_virtio16(_vq->vdev,
> > > +				(u16)~BIT(VRING_SPLIT_DESC_F_NEXT));
> > >  
> > >  	if (indirect) {
> > >  		/* Now that the indirect table is filled in, map it. */
> > 
> > I kind of dislike it that this forces use of a cast here.
> > Kind of makes it more fragile. Let's use a temporary instead?
> 
> I tried something like this:
> 
> u16 mask = ~BIT(VRING_SPLIT_DESC_F_NEXT);
> 
> And it will still cause the warning:
> 
> warning: large integer implicitly truncated to unsigned type [-Woverflow]
>   u16 mask = ~BIT(VRING_SPLIT_DESC_F_NEXT);
> 
> If the cast isn't wanted, maybe use ~(1 << VRING_SPLIT_DESC_F_NEXT)
> directly?

What I'd like to see is a macro that warns/errors out if the shift is
too large. I'll think it over on the weekend.


> 
> > 
> > > -- 
> > > 2.17.1
