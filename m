Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE30C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F9520835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F9520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeJLWGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:06:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:44390 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbeJLWGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:06:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 07:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,372,1534834800"; 
   d="scan'208";a="94673819"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.158])
  by fmsmga002.fm.intel.com with ESMTP; 12 Oct 2018 07:34:01 -0700
Date:   Fri, 12 Oct 2018 22:32:44 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [PATCH net-next V2 6/8] vhost: packed ring support
Message-ID: <20181012143244.GA28400@debian>
References: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
 <1531711691-6769-7-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531711691-6769-7-git-send-email-jasowang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:28:09AM +0800, Jason Wang wrote:
[...]
> @@ -1367,10 +1397,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  		vq->last_avail_idx = s.num;
>  		/* Forget the cached index value. */
>  		vq->avail_idx = vq->last_avail_idx;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> +			vq->last_avail_wrap_counter = wrap_counter;
> +			vq->avail_wrap_counter = vq->last_avail_wrap_counter;
> +		}
>  		break;
>  	case VHOST_GET_VRING_BASE:
>  		s.index = idx;
>  		s.num = vq->last_avail_idx;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +			s.num |= vq->last_avail_wrap_counter << 31;
> +		if (copy_to_user(argp, &s, sizeof(s)))
> +			r = -EFAULT;
> +		break;
> +	case VHOST_SET_VRING_USED_BASE:
> +		/* Moving base with an active backend?
> +		 * You don't want to do that.
> +		 */
> +		if (vq->private_data) {
> +			r = -EBUSY;
> +			break;
> +		}
> +		if (copy_from_user(&s, argp, sizeof(s))) {
> +			r = -EFAULT;
> +			break;
> +		}
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> +			wrap_counter = s.num >> 31;
> +			s.num &= ~(1 << 31);
> +		}
> +		if (s.num > 0xffff) {
> +			r = -EINVAL;
> +			break;
> +		}

Do we want to put wrap_counter at bit 15?

If put wrap_counter at bit 31, the check (s.num > 0xffff)
won't be able to catch the illegal index 0x8000~0xffff for
packed ring.

> +		vq->last_used_idx = s.num;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +			vq->last_used_wrap_counter = wrap_counter;
> +		break;
> +	case VHOST_GET_VRING_USED_BASE:

Do we need the new VHOST_GET_VRING_USED_BASE and
VHOST_SET_VRING_USED_BASE ops?

We are going to merge below series in DPDK:

http://patches.dpdk.org/patch/45874/

We may need to reach an agreement first.


> +		s.index = idx;
> +		s.num = vq->last_used_idx;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +			s.num |= vq->last_used_wrap_counter << 31;
>  		if (copy_to_user(argp, &s, sizeof s))
>  			r = -EFAULT;
>  		break;
[...]
