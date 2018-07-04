Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7E7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66422469C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66422469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeGDEs1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:48:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:37948 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751768AbeGDEsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:48:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 21:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="54969094"
Received: from debian.sh.intel.com (HELO debian) ([10.67.104.228])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2018 21:48:22 -0700
Date:   Wed, 4 Jul 2018 12:48:23 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wexu@redhat.com,
        maxime.coquelin@redhat.com, jfreimann@redhat.com
Subject: Re: [PATCH net-next 6/8] virtio: introduce packed ring defines
Message-ID: <20180704044823.GA22808@debian>
References: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
 <1530596284-4101-7-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1530596284-4101-7-git-send-email-jasowang@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:38:02PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/uapi/linux/virtio_config.h |  2 ++
>  include/uapi/linux/virtio_ring.h   | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 449132c..947f6a3 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -75,6 +75,8 @@
>   */
>  #define VIRTIO_F_IOMMU_PLATFORM		33
>  
> +#define VIRTIO_F_RING_PACKED		34

It's better to add some comments for this macro.

> +
>  /*
>   * Does the device support Single Root I/O Virtualization?
>   */
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 6d5d5fa..71c7a46 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -43,6 +43,8 @@
>  #define VRING_DESC_F_WRITE	2
>  /* This means the buffer contains a list of buffer descriptors. */
>  #define VRING_DESC_F_INDIRECT	4
> +#define VRING_DESC_F_AVAIL      7

It's better to use tab between VRING_DESC_F_AVAIL and 7.

> +#define VRING_DESC_F_USED	15

Maybe it's better to define VRING_DESC_F_AVAIL and
VRING_DESC_F_USED as (1 << 7) and (1 << 15) or something
similar to make them consistent with VRING_DESC_F_NEXT
(1 << 0), VRING_DESC_F_WRITE (1 << 1) and
VRING_DESC_F_INDIRECT (1 << 2).

I plan to define below macros in virtio_ring.c:

#define _VRING_DESC_F_AVAIL(b)  ((__u16)(b) << 7)
#define _VRING_DESC_F_USED(b)   ((__u16)(b) << 15)

>  
>  /* The Host uses this in used->flags to advise the Guest: don't kick me when
>   * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
> @@ -62,6 +64,36 @@
>   * at the end of the used ring. Guest should ignore the used->flags field. */
>  #define VIRTIO_RING_F_EVENT_IDX		29
>  
> +struct vring_desc_packed {

We may have other related types named as:

struct vring_packed;
struct vring_packed_desc_event;

So maybe it's better to name this type as:

struct vring_packed_desc;

> +	/* Buffer Address. */
> +	__virtio64 addr;
> +	/* Buffer Length. */
> +	__virtio32 len;
> +	/* Buffer ID. */
> +	__virtio16 id;
> +	/* The flags depending on descriptor type. */
> +	__virtio16 flags;
> +};
> +
> +/* Enable events */
> +#define RING_EVENT_FLAGS_ENABLE 0x0
> +/* Disable events */
> +#define RING_EVENT_FLAGS_DISABLE 0x1
> +/*
> + * Enable events for a specific descriptor
> + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> + * Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
> + */
> +#define RING_EVENT_FLAGS_DESC 0x2

For above three macros, maybe it's better to name
them as:

VRING_EVENT_FLAGS_ENABLE
VRING_EVENT_FLAGS_DISABLE
VRING_EVENT_FLAGS_DESC

or

VRING_EVENT_F_ENABLE
VRING_EVENT_F_DISABLE
VRING_EVENT_F_DESC

VRING_EVENT_F_* will be more consistent with
VIRTIO_F_*, VRING_DESC_F_*, etc

> +/* The value 0x3 is reserved */
> +
> +struct vring_packed_desc_event {
> +	/* Descriptor Ring Change Event Offset and Wrap Counter */
> +	__virtio16 off_wrap;
> +	/* Descriptor Ring Change Event Flags */
> +	__virtio16 flags;
> +};
> +
>  /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
>  struct vring_desc {
>  	/* Address (guest-physical). */
> -- 
> 2.7.4
> 
