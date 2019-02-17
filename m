Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26160C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E902B21924
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550422097;
	bh=HjFIrihBcVZgXoCOgErOCMvaEU7bieYJv1BUuJ2jlJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q8nNdt/tP7GFMTqNHZC0eJTrBgv/yc3gkUngHizCZk31UXVGp2GpNdGW2ZHAaTKma
	 WM4wwTGDks2u4y7Lv6yiTEFjcCpIkcvEd6yeGxQhePV9evo/Vd/W7zMuQPU1Bxa/g2
	 pbdUDCt7lCP5KEnKiqAN4lFBuQ7Q6g9vDDajQ78c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBQQsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfBQQsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:48:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CAF21924;
        Sun, 17 Feb 2019 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550422093;
        bh=HjFIrihBcVZgXoCOgErOCMvaEU7bieYJv1BUuJ2jlJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lt0qqpqgxMpr7qUsMdlBJo7N40b4yaDT4H/w6vMeJ8gljl9lRSeerh9uvlWzgXOwP
         twyi03Qz4VrpkKb+aN4d9jvnKDS+bbuFzBHC2bDCyd96kcaLrGMIDA9gsZrN18ekPC
         P+3IQKzfWaO3ZaRScBI3vkFoouliDOeJTPUGCt9A=
Date:   Sun, 17 Feb 2019 17:48:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ying Xu <yinxu@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.19 01/24] bridge: do not add port to router list when
 receives query with source 0.0.0.0
Message-ID: <20190217164809.GA24091@kroah.com>
References: <20181102182839.725385066@linuxfoundation.org>
 <20181102182839.913422845@linuxfoundation.org>
 <07d315a2-d735-3d8b-686c-9c52acf91bf1@newmedia-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d315a2-d735-3d8b-686c-9c52acf91bf1@newmedia-net.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 03:29:22PM +0100, Sebastian Gottschall wrote:
> according to user reports this patch will cause a serious regression. igmp
> snooping is not working anymore with this patch
> 
> Am 02.11.2018 um 19:34 schrieb Greg Kroah-Hartman:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Hangbin Liu <liuhangbin@gmail.com>
> > 
> > [ Upstream commit 5a2de63fd1a59c30c02526d427bc014b98adf508 ]
> > 
> > Based on RFC 4541, 2.1.1.  IGMP Forwarding Rules
> > 
> >    The switch supporting IGMP snooping must maintain a list of
> >    multicast routers and the ports on which they are attached.  This
> >    list can be constructed in any combination of the following ways:
> > 
> >    a) This list should be built by the snooping switch sending
> >       Multicast Router Solicitation messages as described in IGMP
> >       Multicast Router Discovery [MRDISC].  It may also snoop
> >       Multicast Router Advertisement messages sent by and to other
> >       nodes.
> > 
> >    b) The arrival port for IGMP Queries (sent by multicast routers)
> >       where the source address is not 0.0.0.0.
> > 
> > We should not add the port to router list when receives query with source
> > 0.0.0.0.
> > 
> > Reported-by: Ying Xu <yinxu@redhat.com>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> > Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   net/bridge/br_multicast.c |   10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > --- a/net/bridge/br_multicast.c
> > +++ b/net/bridge/br_multicast.c
> > @@ -1420,7 +1420,15 @@ static void br_multicast_query_received(
> >   		return;
> >   	br_multicast_update_query_timer(br, query, max_delay);
> > -	br_multicast_mark_router(br, port);
> > +
> > +	/* Based on RFC4541, section 2.1.1 IGMP Forwarding Rules,
> > +	 * the arrival port for IGMP Queries where the source address
> > +	 * is 0.0.0.0 should not be added to router port list.
> > +	 */
> > +	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
> > +	    (saddr->proto == htons(ETH_P_IPV6) &&
> > +	     !ipv6_addr_any(&saddr->u.ip6)))
> > +		br_multicast_mark_router(br, port);
> >   }
> >   static void br_ip4_multicast_query(struct net_bridge *br,

Is this also a problem in 4.20?  This patch went into 4.20-rc1, so it
has been around for a while with no reported issues that I can find.
Any pointers to the reports?

thanks,

greg k-h
