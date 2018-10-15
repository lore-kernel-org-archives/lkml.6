Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFACCC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6C92064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6C92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeJOSJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:09:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOSJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:09:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34A683082A46;
        Mon, 15 Oct 2018 10:25:16 +0000 (UTC)
Received: from redhat.com (ovpn-120-81.rdu2.redhat.com [10.10.120.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37D131726D;
        Mon, 15 Oct 2018 10:25:09 +0000 (UTC)
Date:   Mon, 15 Oct 2018 06:25:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [PATCH net-next V2 6/8] vhost: packed ring support
Message-ID: <20181015062241-mutt-send-email-mst@kernel.org>
References: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
 <1531711691-6769-7-git-send-email-jasowang@redhat.com>
 <20181012143244.GA28400@debian>
 <20181012131812-mutt-send-email-mst@kernel.org>
 <447f47fa-32dd-a408-dd81-13a9839e0748@redhat.com>
 <20181014224208-mutt-send-email-mst@kernel.org>
 <ee3785be-b309-c4ae-e959-737018c21464@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee3785be-b309-c4ae-e959-737018c21464@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 15 Oct 2018 10:25:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:51:06AM +0800, Jason Wang wrote:
> 
> 
> On 2018年10月15日 10:43, Michael S. Tsirkin wrote:
> > On Mon, Oct 15, 2018 at 10:22:33AM +0800, Jason Wang wrote:
> > > 
> > > On 2018年10月13日 01:23, Michael S. Tsirkin wrote:
> > > > On Fri, Oct 12, 2018 at 10:32:44PM +0800, Tiwei Bie wrote:
> > > > > On Mon, Jul 16, 2018 at 11:28:09AM +0800, Jason Wang wrote:
> > > > > [...]
> > > > > > @@ -1367,10 +1397,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> > > > > >    		vq->last_avail_idx = s.num;
> > > > > >    		/* Forget the cached index value. */
> > > > > >    		vq->avail_idx = vq->last_avail_idx;
> > > > > > +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> > > > > > +			vq->last_avail_wrap_counter = wrap_counter;
> > > > > > +			vq->avail_wrap_counter = vq->last_avail_wrap_counter;
> > > > > > +		}
> > > > > >    		break;
> > > > > >    	case VHOST_GET_VRING_BASE:
> > > > > >    		s.index = idx;
> > > > > >    		s.num = vq->last_avail_idx;
> > > > > > +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> > > > > > +			s.num |= vq->last_avail_wrap_counter << 31;
> > > > > > +		if (copy_to_user(argp, &s, sizeof(s)))
> > > > > > +			r = -EFAULT;
> > > > > > +		break;
> > > > > > +	case VHOST_SET_VRING_USED_BASE:
> > > > > > +		/* Moving base with an active backend?
> > > > > > +		 * You don't want to do that.
> > > > > > +		 */
> > > > > > +		if (vq->private_data) {
> > > > > > +			r = -EBUSY;
> > > > > > +			break;
> > > > > > +		}
> > > > > > +		if (copy_from_user(&s, argp, sizeof(s))) {
> > > > > > +			r = -EFAULT;
> > > > > > +			break;
> > > > > > +		}
> > > > > > +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> > > > > > +			wrap_counter = s.num >> 31;
> > > > > > +			s.num &= ~(1 << 31);
> > > > > > +		}
> > > > > > +		if (s.num > 0xffff) {
> > > > > > +			r = -EINVAL;
> > > > > > +			break;
> > > > > > +		}
> > > > > Do we want to put wrap_counter at bit 15?
> > > > I think I second that - seems to be consistent with
> > > > e.g. event suppression structure and the proposed
> > > > extension to driver notifications.
> > > Ok, I assumes packed virtqueue support 64K but looks not. I can change it to
> > > bit 15 and GET_VRING_BASE need to be changed as well.
> > > 
> > > > 
> > > > > If put wrap_counter at bit 31, the check (s.num > 0xffff)
> > > > > won't be able to catch the illegal index 0x8000~0xffff for
> > > > > packed ring.
> > > > > 
> > > Do we need to clarify this in the spec?
> > Isn't this all internal vhost stuff?
> 
> I meant the illegal index 0x8000-0xffff.

It does say packed virtqueues support up to 2 15 entries each.

But yes we can add a requirement that devices do not expose
larger rings. Split does not support 2**16 either, right?
With 2**16 enties avail index becomes 0 and ring looks empty.

> 
> > 
> > > > > > +		vq->last_used_idx = s.num;
> > > > > > +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> > > > > > +			vq->last_used_wrap_counter = wrap_counter;
> > > > > > +		break;
> > > > > > +	case VHOST_GET_VRING_USED_BASE:
> > > > > Do we need the new VHOST_GET_VRING_USED_BASE and
> > > > > VHOST_SET_VRING_USED_BASE ops?
> > > > > 
> > > > > We are going to merge below series in DPDK:
> > > > > 
> > > > > http://patches.dpdk.org/patch/45874/
> > > > > 
> > > > > We may need to reach an agreement first.
> > > If we agree that 64K virtqueue won't be supported, I'm ok with either.
> > Well the spec says right at the beginning:
> > 
> > Packed virtqueues support up to 2 15 entries each.
> 
> Ok. I get it.
> 
> Then I can change vhost to match what dpdk did.
> 
> Thanks
> 
> > 
> > 
> > > Btw the code assumes used_wrap_counter is equal to avail_wrap_counter which
> > > looks wrong?
> > > 
> > > Thanks
> > > 
> > > > > > +		s.index = idx;
> > > > > > +		s.num = vq->last_used_idx;
> > > > > > +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> > > > > > +			s.num |= vq->last_used_wrap_counter << 31;
> > > > > >    		if (copy_to_user(argp, &s, sizeof s))
> > > > > >    			r = -EFAULT;
> > > > > >    		break;
> > > > > [...]
