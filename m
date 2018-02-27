Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeB0JE5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:04:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:16376 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752336AbeB0JEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:04:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,400,1515484800";
   d="scan'208";a="207373257"
Date: Tue, 27 Feb 2018 17:03:20 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH RFC 2/2] vhost: packed ring support
Message-ID: <20180227090319.h7hxmxp5rpozrb5s@debian>
References: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
 <1518575829-1431-3-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518575829-1431-3-git-send-email-jasowang@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:37:09AM +0800, Jason Wang wrote:
[...]
> +static void set_desc_used(struct vhost_virtqueue *vq,
> +			  struct vring_desc_packed *desc, bool wrap_counter)
> +{
> +	__virtio16 flags = desc->flags;
> +
> +	if (wrap_counter) {
> +		desc->flags |= cpu_to_vhost16(vq, DESC_AVAIL);
> +		desc->flags |= cpu_to_vhost16(vq, DESC_USED);
> +	} else {
> +		desc->flags &= ~cpu_to_vhost16(vq, DESC_AVAIL);
> +		desc->flags &= ~cpu_to_vhost16(vq, DESC_USED);
> +	}
> +
> +	desc->flags = flags;

The `desc->flags` is restored after the change.

> +}
> +
> +static int vhost_get_vq_desc_packed(struct vhost_virtqueue *vq,
> +				    struct iovec iov[], unsigned int iov_size,
> +				    unsigned int *out_num, unsigned int *in_num,
> +				    struct vhost_log *log,
> +				    unsigned int *log_num)
> +{
> +	struct vring_desc_packed desc;
> +	int ret, access, i;
> +	u16 avail_idx = vq->last_avail_idx;
> +
> +	/* When we start there are none of either input nor output. */
> +	*out_num = *in_num = 0;
> +	if (unlikely(log))
> +		*log_num = 0;
> +
> +	do {
> +		unsigned int iov_count = *in_num + *out_num;
> +
> +		i = vq->last_avail_idx & (vq->num - 1);

The queue size may not be a power of 2 in packed ring.

Best regards,
Tiwei Bie
