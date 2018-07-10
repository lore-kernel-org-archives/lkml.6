Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66229C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B8220881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B8220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeGJFvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:51:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751042AbeGJFv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:51:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1B5740122D4;
        Tue, 10 Jul 2018 05:51:27 +0000 (UTC)
Received: from [10.72.12.151] (ovpn-12-151.pek2.redhat.com [10.72.12.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C895A2026D6B;
        Tue, 10 Jul 2018 05:51:23 +0000 (UTC)
Subject: Re: [PATCH net-next v1 5/5] virtio_ring: enable packed ring
To:     Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com
References: <20180709072241.8886-1-tiwei.bie@intel.com>
 <20180709072241.8886-6-tiwei.bie@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <27ae72ad-247b-e8f0-aa37-a75a719e0e01@redhat.com>
Date:   Tue, 10 Jul 2018 13:51:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709072241.8886-6-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 05:51:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 05:51:27 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月09日 15:22, Tiwei Bie wrote:
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>   drivers/s390/virtio/virtio_ccw.c | 8 ++++++++
>   drivers/virtio/virtio_ring.c     | 2 ++
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 8f5c1d7f751a..ff5b85736d8d 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -765,6 +765,11 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
>   	return rc;
>   }
>   
> +static void ccw_transport_features(struct virtio_device *vdev)
> +{
> +	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
> +}

I think we need a better comment to explain why it was disabled here.

Thanks

> +
>   static int virtio_ccw_finalize_features(struct virtio_device *vdev)
>   {
>   	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> @@ -791,6 +796,9 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
>   	/* Give virtio_ring a chance to accept features. */
>   	vring_transport_features(vdev);
>   
> +	/* Give virtio_ccw a chance to accept features. */
> +	ccw_transport_features(vdev);
> +
>   	features->index = 0;
>   	features->features = cpu_to_le32((u32)vdev->features);
>   	/* Write the first half of the feature bits to the host. */
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4b3f9e1a3cab..64f20023f088 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1968,6 +1968,8 @@ void vring_transport_features(struct virtio_device *vdev)
>   			break;
>   		case VIRTIO_F_IOMMU_PLATFORM:
>   			break;
> +		case VIRTIO_F_RING_PACKED:
> +			break;
>   		default:
>   			/* We don't understand this bit. */
>   			__virtio_clear_bit(vdev, i);

