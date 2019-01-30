Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEB4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A132087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfA3Q2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:28:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbfA3Q2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:28:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C2268831F;
        Wed, 30 Jan 2019 16:28:10 +0000 (UTC)
Received: from redhat.com (ovpn-122-6.rdu2.redhat.com [10.10.122.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB13F5F9BB;
        Wed, 30 Jan 2019 16:28:09 +0000 (UTC)
Date:   Wed, 30 Jan 2019 11:28:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>
Subject: Re: [PATCH] virtio_net: Introduce extended RSC feature
Message-ID: <20190130101618-mutt-send-email-mst@kernel.org>
References: <20190129125236.12165-1-yuri.benditovich@daynix.com>
 <20190129110636-mutt-send-email-mst@kernel.org>
 <CAOEp5OfBWVcSnVEm2S3VhOYH3uv+vdUvT5z2yss9v8wvriiKtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOEp5OfBWVcSnVEm2S3VhOYH3uv+vdUvT5z2yss9v8wvriiKtA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 30 Jan 2019 16:28:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 09:42:07AM +0200, Yuri Benditovich wrote:
> 
> 
> On Tue, Jan 29, 2019 at 6:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Tue, Jan 29, 2019 at 02:52:36PM +0200, Yuri Benditovich wrote:
>     > VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
>     > is able to provide extended RSC information. When the feature
>     > is active and 'gso_type' field in received packet is not GSO_NONE,
>     > the device reports number of coalesced packets in 'csum_start'
>     > field and number of duplicated acks in 'csum_offset' field
>     > and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
>     >
>     > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>     > ---
>     >  include/uapi/linux/virtio_net.h | 15 ++++++++++++++-
>     >  1 file changed, 14 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/
>     virtio_net.h
>     > index a3715a3224c1..93c71d714475 100644
>     > --- a/include/uapi/linux/virtio_net.h
>     > +++ b/include/uapi/linux/virtio_net.h
>     > @@ -56,7 +56,7 @@
>     >  #define VIRTIO_NET_F_MQ      22      /* Device supports Receive Flow
>     >                                        * Steering */
>     >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
>     > -
>     > +#define VIRTIO_NET_F_RSC_EXT   61    /* Provides extended RSC info */
>     >  #define VIRTIO_NET_F_STANDBY   62    /* Act as standby for another
>     device
>     >                                        * with the same MAC.
>     >                                        */
>     > @@ -104,6 +104,7 @@ struct virtio_net_config {
>     >  struct virtio_net_hdr_v1 {
>     >  #define VIRTIO_NET_HDR_F_NEEDS_CSUM  1       /* Use csum_start,
>     csum_offset */
>     >  #define VIRTIO_NET_HDR_F_DATA_VALID  2       /* Csum is valid */
>     > +#define VIRTIO_NET_HDR_F_RSC_INFO    4   /* rsc_ext data in csum_ fields
>     */
>     >       __u8 flags;
>     >  #define VIRTIO_NET_HDR_GSO_NONE              0       /* Not a GSO frame
>     */
>     >  #define VIRTIO_NET_HDR_GSO_TCPV4     1       /* GSO frame, IPv4 TCP
>     (TSO) */
>     > @@ -140,6 +141,18 @@ struct virtio_net_hdr_mrg_rxbuf {
>     >       struct virtio_net_hdr hdr;
>     >       __virtio16 num_buffers; /* Number of merged rx buffers */
>     >  };
>     > +
>     > +static inline __virtio16 *virtio_net_rsc_ext_num_packets(
>     > +     struct virtio_net_hdr *hdr)
>     > +{
>     > +     return &hdr->csum_start;
>     > +}
>     > +
>     > +static inline __virtio16 *virtio_net_rsc_ext_num_dupacks(
>     > +     struct virtio_net_hdr *hdr)
>     > +{
>     > +     return &hdr->csum_offset;
>     > +}
>     >  #endif /* ...VIRTIO_NET_NO_LEGACY */

I also wonder why do we want to put this code in the legacy section
and use the legacy virtio_net_hdr as opposed to the new virtio_net_hdr_v1.

> 
>     Coding style is off here. But really I don't think these inlines are
>     needed here. Put them in qemu or something.
> 
> 
> 
> The are copied from qemu as is (what exactly is wrong?).


coding style says:

	Descendants are always substantially shorter than the parent and
	are placed substantially to the right.

placing a line to the left of ( doesn't count as substantially to the
right :)
Maybe start a new line at virtio_net_rsc_ext_num_dupacks.

Lack of documentation is also a problem.

> The reason I place these inlines here is following:
> We pull this include sometimes to virtio-win repo exactly as qemu do.
> If I place them into qemu, then we'll have these inlines in virtio-win and in
> qemu and they are not synchronized.
> 
> So, I suggest to keep them in one common header and fix style problems, if they
> present. 
> Please respond if you still disagree.

Okay but this assumes specific usage. E.g. someone might want
an offset and not a pointer. Or have a struct instance on stack.

Given all above issues (and also header version issues
described above) I'm inclined to say macros are better:


#define virtio_net_rsc_ext_num_packets csum_start
#define virtio_net_rsc_ext_num_dupacks csum_offset


But please in any case also add documentation same as we have for
fields.

> 
>     >  /*
>     > --
>     > 2.17.1
> 
