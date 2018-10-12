Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461FDC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A0F21470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A0F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeJMA5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:57:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeJMA5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:57:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CC4940F2B;
        Fri, 12 Oct 2018 17:23:53 +0000 (UTC)
Received: from redhat.com (ovpn-124-120.rdu2.redhat.com [10.10.124.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7ECAC60CD3;
        Fri, 12 Oct 2018 17:23:47 +0000 (UTC)
Date:   Fri, 12 Oct 2018 13:23:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [PATCH net-next V2 6/8] vhost: packed ring support
Message-ID: <20181012131812-mutt-send-email-mst@kernel.org>
References: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
 <1531711691-6769-7-git-send-email-jasowang@redhat.com>
 <20181012143244.GA28400@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012143244.GA28400@debian>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 12 Oct 2018 17:23:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:32:44PM +0800, Tiwei Bie wrote:
> On Mon, Jul 16, 2018 at 11:28:09AM +0800, Jason Wang wrote:
> [...]
> > @@ -1367,10 +1397,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> >  		vq->last_avail_idx = s.num;
> >  		/* Forget the cached index value. */
> >  		vq->avail_idx = vq->last_avail_idx;
> > +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> > +			vq->last_avail_wrap_counter = wrap_counter;
> > +			vq->avail_wrap_counter = vq->last_avail_wrap_counter;
> > +		}
> >  		break;
> >  	case VHOST_GET_VRING_BASE:
> >  		s.index = idx;
> >  		s.num = vq->last_avail_idx;
> > +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> > +			s.num |= vq->last_avail_wrap_counter << 31;
> > +		if (copy_to_user(argp, &s, sizeof(s)))
> > +			r = -EFAULT;
> > +		break;
> > +	case VHOST_SET_VRING_USED_BASE:
> > +		/* Moving base with an active backend?
> > +		 * You don't want to do that.
> > +		 */
> > +		if (vq->private_data) {
> > +			r = -EBUSY;
> > +			break;
> > +		}
> > +		if (copy_from_user(&s, argp, sizeof(s))) {
> > +			r = -EFAULT;
> > +			break;
> > +		}
> > +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> > +			wrap_counter = s.num >> 31;
> > +			s.num &= ~(1 << 31);
> > +		}
> > +		if (s.num > 0xffff) {
> > +			r = -EINVAL;
> > +			break;
> > +		}
> 
> Do we want to put wrap_counter at bit 15?

I think I second that - seems to be consistent with
e.g. event suppression structure and the proposed
extension to driver notifications.


> If put wrap_counter at bit 31, the check (s.num > 0xffff)
> won't be able to catch the illegal index 0x8000~0xffff for
> packed ring.
> 
> > +		vq->last_used_idx = s.num;
> > +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> > +			vq->last_used_wrap_counter = wrap_counter;
> > +		break;
> > +	case VHOST_GET_VRING_USED_BASE:
> 
> Do we need the new VHOST_GET_VRING_USED_BASE and
> VHOST_SET_VRING_USED_BASE ops?
> 
> We are going to merge below series in DPDK:
> 
> http://patches.dpdk.org/patch/45874/
> 
> We may need to reach an agreement first.
> 
> 
> > +		s.index = idx;
> > +		s.num = vq->last_used_idx;
> > +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> > +			s.num |= vq->last_used_wrap_counter << 31;
> >  		if (copy_to_user(argp, &s, sizeof s))
> >  			r = -EFAULT;
> >  		break;
> [...]
