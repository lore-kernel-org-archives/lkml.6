Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9971C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C68320869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C68320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeIDHeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:34:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbeIDHeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:34:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B59FA87927;
        Tue,  4 Sep 2018 03:11:11 +0000 (UTC)
Received: from redhat.com (ovpn-123-241.rdu2.redhat.com [10.10.123.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5485A1134CA7;
        Tue,  4 Sep 2018 03:11:11 +0000 (UTC)
Date:   Mon, 3 Sep 2018 23:11:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: fix VHOST_GET_BACKEND_FEATURES ioctl request
 definition
Message-ID: <20180903231102-mutt-send-email-mst@kernel.org>
References: <20180903175906.GA11529@glebfm.cloud.tilaa.com>
 <20180903222127-mutt-send-email-mst@kernel.org>
 <a9ea89ac-4816-96a1-7de4-caf9884da876@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9ea89ac-4816-96a1-7de4-caf9884da876@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 04 Sep 2018 03:11:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 04 Sep 2018 03:11:11 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:08:40AM +0800, Jason Wang wrote:
> 
> 
> On 2018年09月04日 10:22, Michael S. Tsirkin wrote:
> > On Mon, Sep 03, 2018 at 08:59:13PM +0300, Gleb Fotengauer-Malinovskiy wrote:
> > > The _IOC_READ flag fits this ioctl request more because this request
> > > actually only writes to, but doesn't read from userspace.
> > > See NOTEs in include/uapi/asm-generic/ioctl.h for more information.
> > > 
> > > Fixes: 429711aec282 ("vhost: switch to use new message format")
> > > Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> > Hmm it does make sense, and it's not too late to fix this up.
> > Jason, what's your take on this? Was _IOW intentional?
> 
> My bad, not intentional. And I agree that fixing this is not too late.
> 
> So
> 
> Acked-by: Jason Wang <jasowang@redhat.com>


OK then

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> > 
> > > ---
> > >   include/uapi/linux/vhost.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > index b1e22c40c4b6..84c3de89696a 100644
> > > --- a/include/uapi/linux/vhost.h
> > > +++ b/include/uapi/linux/vhost.h
> > > @@ -176,7 +176,7 @@ struct vhost_memory {
> > >   #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
> > >   #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
> > > -#define VHOST_GET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x26, __u64)
> > > +#define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
> > >   /* VHOST_NET specific defines */
> > > 
> > > -- 
> > > glebfm
