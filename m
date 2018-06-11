Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id G8woO7XnHVszBwAAmS7hNA
	; Mon, 11 Jun 2018 03:08:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0B446607E4; Mon, 11 Jun 2018 03:08:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F3340604D4;
	Mon, 11 Jun 2018 03:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3340604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753922AbeFKDIg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:08:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753884AbeFKDIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:08:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5C8879D36;
        Mon, 11 Jun 2018 03:08:34 +0000 (UTC)
Received: from redhat.com (ovpn-120-77.rdu2.redhat.com [10.10.120.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60C5B63F32;
        Mon, 11 Jun 2018 03:08:34 +0000 (UTC)
Date: Mon, 11 Jun 2018 06:08:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost_net: remove VHOST_NET_F_VIRTIO_NET_HDR support
Message-ID: <20180611060759-mutt-send-email-mst@kernel.org>
References: <1528429842-22835-1-git-send-email-jasowang@redhat.com>
 <20180608074115-mutt-send-email-mst@kernel.org>
 <23efe110-f61a-5aee-c0b4-bd3dc5426438@redhat.com>
 <20180611050741-mutt-send-email-mst@kernel.org>
 <90e9b3ea-e9d2-d60d-8355-42d447c67452@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90e9b3ea-e9d2-d60d-8355-42d447c67452@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 11 Jun 2018 03:08:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 11 Jun 2018 03:08:34 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:29:36AM +0800, Jason Wang wrote:
> 
> 
> On 2018年06月11日 10:12, Michael S. Tsirkin wrote:
> > On Fri, Jun 08, 2018 at 01:07:09PM +0800, Jason Wang wrote:
> > > 
> > > On 2018年06月08日 12:46, Michael S. Tsirkin wrote:
> > > > On Fri, Jun 08, 2018 at 11:50:42AM +0800, Jason Wang wrote:
> > > > > This feature bit is duplicated with VIRTIO_F_ANY_LAYOUT, this means if
> > > > > a userpsace want to enable VRITIO_F_ANY_LAYOUT,
> > > > > VHOST_NET_F_VIRTIO_NET_HDR will be implied too. This is wrong and will
> > > > > break networking.
> > > > What breaks networking exactly? VHOST_NET supported ANY_LAYOUT
> > > > from day one. For this reason it does not need to know about
> > > > VRITIO_F_ANY_LAYOUT and we reused the bit for other purposes.
> > > It's the knowledge of vhost_net code it self but not userspace. For
> > > userspace, it should depends on the value of returned by VHOST_GET_FEATURES.
> > > So when userspace can set_features with ANY_LAYOUT, vhost may think it wants
> > > VHOST_NET_F_VIRTIO_NET_HDR.
> > Yes but that's the admittedly ugly API that we have now.
> > userspace is supposed to know VRITIO_F_ANY_LAYOUT does
> > not make sense for vhost.
> 
> Ok.
> 
> > 
> > 
> > 
> > > > 
> > > > 
> > > > > Fixing this by safely removing
> > > > > VHOST_NET_F_VIRTIO_NET_HDR support. There should be very few or even
> > > > > no userspace can use this.
> > > > Quite possibly, but it is hard to be sure. It seems safer to
> > > > maintain it unless there's an actual reason something's broken.
> > > I think not since the feature is negotiated not mandatory?
> > That doesn't mean much.
> > 
> > > > > Further cleanups could be done for
> > > > > -net-next for safety.
> > > > > 
> > > > > In the future, we need a vhost dedicated feature set/get ioctl()
> > > > > instead of reusing virtio ones.
> > > > Not just in the future, we might want to switch iommu
> > > > to a sane structure without the 64 bit padding bug
> > > > right now.
> > > Yes, I hit this bug when introducing V2 of msg IOTLB message.
> > Sounds good, so if you like, reserve a bit for
> > VHOST_NET_F_VIRTIO_NET_HDR in the new ioctl mask and
> > do not enable it there.
> 
> Ok, and maybe VHOST_F_LOG_ALL.
> 
> > 
> > > > > Fixes: 4e9fa50c6ccbe ("vhost: move features to core")
> > > > This tag makes no sense here IMHO. Looks like people are using some tool
> > > > that just looks at the earliest version where patch won't apply. The
> > > > commit in question just moved some code around.
> > > Looks not, before this commit, vhost_net won't return ANY_LAYOUT.
> > > 
> > > Thanks
> > Well ANY_LAYOUT just happens to be same as VHOST_NET_F_VIRTIO_NET_HDR
> > and that has been set since forever.
> 
> So do you still want this patch? If not we need to document that ANY_LAYOUT
> could not be passed through SET_FEATURES somewhere.
> 
> Thanks

Let's document this, yes. I don't think we should drop
VHOST_NET_F_VIRTIO_NET_HDR now.

> > 
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >    drivers/vhost/net.c | 15 +++++----------
> > > > >    1 file changed, 5 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > > > index 986058a..83eef52 100644
> > > > > --- a/drivers/vhost/net.c
> > > > > +++ b/drivers/vhost/net.c
> > > > > @@ -69,7 +69,6 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
> > > > >    enum {
> > > > >    	VHOST_NET_FEATURES = VHOST_FEATURES |
> > > > > -			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> > > > >    			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> > > > >    			 (1ULL << VIRTIO_F_IOMMU_PLATFORM)
> > > > >    };
> > > > > @@ -1255,15 +1254,11 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
> > > > >    			       (1ULL << VIRTIO_F_VERSION_1))) ?
> > > > >    			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
> > > > >    			sizeof(struct virtio_net_hdr);
> > > > > -	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
> > > > > -		/* vhost provides vnet_hdr */
> > > > > -		vhost_hlen = hdr_len;
> > > > > -		sock_hlen = 0;
> > > > > -	} else {
> > > > > -		/* socket provides vnet_hdr */
> > > > > -		vhost_hlen = 0;
> > > > > -		sock_hlen = hdr_len;
> > > > > -	}
> > > > > +
> > > > > +        /* socket provides vnet_hdr */
> > > > > +	vhost_hlen = 0;
> > > > > +	sock_hlen = hdr_len;
> > > > > +
> > > > >    	mutex_lock(&n->dev.mutex);
> > > > >    	if ((features & (1 << VHOST_F_LOG_ALL)) &&
> > > > >    	    !vhost_log_access_ok(&n->dev))
> > > > > -- 
> > > > > 2.7.4
