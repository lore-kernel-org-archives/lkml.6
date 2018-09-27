Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B842B2156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B842B2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeI0POX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:14:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbeI0POX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:14:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2DE3792C0;
        Thu, 27 Sep 2018 08:57:12 +0000 (UTC)
Received: from ovpn-112-72.ams2.redhat.com (ovpn-112-72.ams2.redhat.com [10.36.112.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EEF160D62;
        Thu, 27 Sep 2018 08:57:06 +0000 (UTC)
Message-ID: <1538038625.19334.2.camel@redhat.com>
Subject: Re: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
From:   Mohammed Gamal <mgamal@redhat.com>
Reply-To: mgamal@redhat.com
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     KY Srinivasan <kys@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        "otubo@redhat.com" <otubo@redhat.com>, cavery <cavery@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Date:   Thu, 27 Sep 2018 10:57:05 +0200
In-Reply-To: <BN6PR21MB01612C60B5421AF2BB09742CCA150@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <1537979659-26979-1-git-send-email-mgamal@redhat.com>
         <BN6PR21MB01612C60B5421AF2BB09742CCA150@BN6PR21MB0161.namprd21.prod.outlook.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 27 Sep 2018 08:57:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-26 at 17:13 +0000, Haiyang Zhang wrote:
> > -----Original Message-----
> > From: Mohammed Gamal <mgamal@redhat.com>
> > Sent: Wednesday, September 26, 2018 12:34 PM
> > To: Stephen Hemminger <sthemmin@microsoft.com>; netdev@vger.kernel.
> > org
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; vkuznets <vkuznets@redhat.com>;
> > otubo@redhat.com; cavery <cavery@redhat.com>; linux-
> > kernel@vger.kernel.org; devel@linuxdriverproject.org; Mohammed
> > Gamal
> > <mgamal@redhat.com>
> > Subject: [PATCH] hv_netvsc: Make sure out channel is fully opened
> > on send
> > 
> > Dring high network traffic changes to network interface parameters
> > such as
> > number of channels or MTU can cause a kernel panic with a NULL
> > pointer
> > dereference. This is due to netvsc_device_remove() being called and
> > deallocating the channel ring buffers, which can then be accessed
> > by
> > netvsc_send_pkt() before they're allocated on calling
> > netvsc_device_add()
> > 
> > The patch fixes this problem by checking the channel state and
> > returning
> > ENODEV if not yet opened. We also move the call to
> > hv_ringbuf_avail_percent()
> > which may access the uninitialized ring buffer.
> > 
> > Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> > ---
> >  drivers/net/hyperv/netvsc.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/hyperv/netvsc.c
> > b/drivers/net/hyperv/netvsc.c index
> > fe01e14..75f1b31 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -825,7 +825,12 @@ static inline int netvsc_send_pkt(
> >  	struct netdev_queue *txq = netdev_get_tx_queue(ndev,
> > packet->q_idx);
> >  	u64 req_id;
> >  	int ret;
> > -	u32 ring_avail =
> > hv_get_avail_to_write_percent(&out_channel-
> > > outbound);
> > 
> > +	u32 ring_avail;
> > +
> > +	if (out_channel->state != CHANNEL_OPENED_STATE)
> > +		return -ENODEV;
> > +
> > +	ring_avail = hv_get_avail_to_write_percent(&out_channel-
> > >outbound);
> 
> When you reproducing the NULL ptr panic, does your kernel include the
> following patch?
> hv_netvsc: common detach logic
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c
> ommit/?id=7b2ee50c0cd513a176a26a71f2989facdd75bfea
> 
Yes it is included. And the commit did reduce the occurrence of this
race condition, but it still nevertheless occurs albeit rarely.

> We call netif_tx_disable(ndev) and netif_device_detach(ndev) before
> doing the changes 
> on MTU or #channels. So there should be no call to start_xmit() when
> channel is not ready.
> 
> If you see the check for CHANNEL_OPENED_STATE is still necessary on
> upstream kernel (including 
> the patch " common detach logic "), we should debug further on the
> code and find out the 
> root cause.
> 
> Thanks,
> - Haiyang
> 
