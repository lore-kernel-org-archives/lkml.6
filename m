Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5766FC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0D12147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550749311;
	bh=VTDOwXJ2kLPP0Te3j8Gd3ixIb/fPPP0CvEQYhm0Gn88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UN920zLTziWGt6MWQelAJzcEfY2GBkJA3UtpDfmkt4mkpT0xD1wlqg94lpIfHWscT
	 lnA1hWc9eXSsnmwp6Kx5boJ/rDpcERbm8AfeJa57T3enfHIgGUrOLnp0w3zxrR8and
	 /RXJyYAemZaQeQffleHY7WSghoVvMbKxMmD/b91k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBULlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfBULlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:41:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2222086C;
        Thu, 21 Feb 2019 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550749308;
        bh=VTDOwXJ2kLPP0Te3j8Gd3ixIb/fPPP0CvEQYhm0Gn88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWW6hC911Ad2Vx2lJUxFaWT2PKEafaaM0EciVMoRNedOIW6KSMnkm+bhQAY7RwCSQ
         foPiEcJGf7gutObUggFhuRoR0Ib41iaaa1pilweY/4HsEWpemWPqS+fnxxQdDeSGw3
         n5HsoJJ+PKylCcfrDptb/NAUNpLsbMXnQoWYaKsk=
Date:   Thu, 21 Feb 2019 12:41:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ying Xu <yinxu@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.19 01/24] bridge: do not add port to router list when
 receives query with source 0.0.0.0
Message-ID: <20190221114145.GC10737@kroah.com>
References: <20181102182839.725385066@linuxfoundation.org>
 <20181102182839.913422845@linuxfoundation.org>
 <07d315a2-d735-3d8b-686c-9c52acf91bf1@newmedia-net.de>
 <20190217164809.GA24091@kroah.com>
 <7978727a-eacc-779c-771f-f4c3013237f3@newmedia-net.de>
 <0425449f-f6d9-c492-d7c8-ba202db88d26@newmedia-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0425449f-f6d9-c492-d7c8-ba202db88d26@newmedia-net.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 01:48:47PM +0100, Sebastian Gottschall wrote:
> *reminder*
> 
> Am 18.02.2019 um 11:18 schrieb Sebastian Gottschall:
> > 
> > Am 17.02.2019 um 17:48 schrieb Greg Kroah-Hartman:
> > > On Sun, Feb 17, 2019 at 03:29:22PM +0100, Sebastian Gottschall wrote:
> > > > according to user reports this patch will cause a serious
> > > > regression. igmp
> > > > snooping is not working anymore with this patch
> > > > 
> > > > Am 02.11.2018 um 19:34 schrieb Greg Kroah-Hartman:
> > > > > 4.19-stable review patch.  If anyone has any objections,
> > > > > please let me know.
> > > > > 
> > > > > ------------------
> > > > > 
> > > > > From: Hangbin Liu <liuhangbin@gmail.com>
> > > > > 
> > > > > [ Upstream commit 5a2de63fd1a59c30c02526d427bc014b98adf508 ]
> > > > > 
> > > > > Based on RFC 4541, 2.1.1.  IGMP Forwarding Rules
> > > > > 
> > > > >     The switch supporting IGMP snooping must maintain a list of
> > > > >     multicast routers and the ports on which they are attached.  This
> > > > >     list can be constructed in any combination of the following ways:
> > > > > 
> > > > >     a) This list should be built by the snooping switch sending
> > > > >        Multicast Router Solicitation messages as described in IGMP
> > > > >        Multicast Router Discovery [MRDISC].  It may also snoop
> > > > >        Multicast Router Advertisement messages sent by and to other
> > > > >        nodes.
> > > > > 
> > > > >     b) The arrival port for IGMP Queries (sent by multicast routers)
> > > > >        where the source address is not 0.0.0.0.
> > > > > 
> > > > > We should not add the port to router list when receives
> > > > > query with source
> > > > > 0.0.0.0.
> > > > > 
> > > > > Reported-by: Ying Xu <yinxu@redhat.com>
> > > > > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > > > > Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> > > > > Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>
> > > > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > ---
> > > > >    net/bridge/br_multicast.c |   10 +++++++++-
> > > > >    1 file changed, 9 insertions(+), 1 deletion(-)
> > > > > 
> > > > > --- a/net/bridge/br_multicast.c
> > > > > +++ b/net/bridge/br_multicast.c
> > > > > @@ -1420,7 +1420,15 @@ static void br_multicast_query_received(
> > > > >            return;
> > > > >        br_multicast_update_query_timer(br, query, max_delay);
> > > > > -    br_multicast_mark_router(br, port);
> > > > > +
> > > > > +    /* Based on RFC4541, section 2.1.1 IGMP Forwarding Rules,
> > > > > +     * the arrival port for IGMP Queries where the source address
> > > > > +     * is 0.0.0.0 should not be added to router port list.
> > > > > +     */
> > > > > +    if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
> > > > > +        (saddr->proto == htons(ETH_P_IPV6) &&
> > > > > +         !ipv6_addr_any(&saddr->u.ip6)))
> > > > > +        br_multicast_mark_router(br, port);
> > > > >    }
> > > > >    static void br_ip4_multicast_query(struct net_bridge *br,
> > > Is this also a problem in 4.20?  This patch went into 4.20-rc1, so it
> > > has been around for a while with no reported issues that I can find.
> > > Any pointers to the reports?
> > 
> > i need to check this. i found this patch in 4.9, 4.14 and 4.4
> > the rest was picked up from the mailinglist. according to the git
> > sources of 4.20 and 5.0 the same code is in there as well
> > 
> > i just got the report from users today and was able to reproduce it with
> > iptv streams. just by disabling the code it was working again.

Reminder of what?

If this is still an issue in 4.20, and 5.0-rc, there's nothing I can do.
Please work with the networking developers to resolve the issue and get
the fix merged into Linus's tree and then I will be glad to take the fix
into the stable trees.

If this is _not_ an issue with 4.20 and 5.0-rc, I need to know that as
well.

thanks,

greg k-h
