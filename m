Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E57EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C582184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfA2QHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:07:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:4912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfA2QHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:07:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06EFD4E916;
        Tue, 29 Jan 2019 16:07:50 +0000 (UTC)
Received: from redhat.com (ovpn-123-79.rdu2.redhat.com [10.10.123.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id C9CC35D97A;
        Tue, 29 Jan 2019 16:07:47 +0000 (UTC)
Date:   Tue, 29 Jan 2019 11:07:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Subject: Re: [PATCH] virtio_net: Introduce extended RSC feature
Message-ID: <20190129110636-mutt-send-email-mst@kernel.org>
References: <20190129125236.12165-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129125236.12165-1-yuri.benditovich@daynix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 29 Jan 2019 16:07:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:52:36PM +0200, Yuri Benditovich wrote:
> VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> is able to provide extended RSC information. When the feature
> is active and 'gso_type' field in received packet is not GSO_NONE,
> the device reports number of coalesced packets in 'csum_start'
> field and number of duplicated acks in 'csum_offset' field
> and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index a3715a3224c1..93c71d714475 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,7 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> -
> +#define VIRTIO_NET_F_RSC_EXT	  61	/* Provides extended RSC info */
>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
>  					 * with the same MAC.
>  					 */
> @@ -104,6 +104,7 @@ struct virtio_net_config {
>  struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
>  #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
> +#define VIRTIO_NET_HDR_F_RSC_INFO	4   /* rsc_ext data in csum_ fields */
>  	__u8 flags;
>  #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
>  #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
> @@ -140,6 +141,18 @@ struct virtio_net_hdr_mrg_rxbuf {
>  	struct virtio_net_hdr hdr;
>  	__virtio16 num_buffers;	/* Number of merged rx buffers */
>  };
> +
> +static inline __virtio16 *virtio_net_rsc_ext_num_packets(
> +	struct virtio_net_hdr *hdr)
> +{
> +	return &hdr->csum_start;
> +}
> +
> +static inline __virtio16 *virtio_net_rsc_ext_num_dupacks(
> +	struct virtio_net_hdr *hdr)
> +{
> +	return &hdr->csum_offset;
> +}
>  #endif /* ...VIRTIO_NET_NO_LEGACY */

Coding style is off here. But really I don't think these inlines are
needed here. Put them in qemu or something.

>  /*
> -- 
> 2.17.1
