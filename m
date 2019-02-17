Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53630C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2378F21929
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=newmedia-net.de header.i=@newmedia-net.de header.b="L4kyQD4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfBQOpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 09:45:01 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:43349 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfBQOpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 09:45:01 -0500
X-Greylist: delayed 930 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Feb 2019 09:44:59 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=BCoHtEvbPNkmj25tdc1uluIH6vnbWeFVIPAzSdkUxTE=;
        b=L4kyQD4MMgZVAs9aLL01E7y08Jeay60mO9vo4REPpg/AdxCvwJSmSDFlFNf0WYllj43p5LfqtZ7B99CzPXBMzlDm2WhJ7GVPOBXqnblJx+Qbc/IKNQbxW/m4X5U9Ngn0DUuKIOjuqVLH+6TVWxPmt4lnDA/3nt85S72LVzsSY40=;
Subject: Re: [PATCH 4.19 01/24] bridge: do not add port to router list when
 receives query with source 0.0.0.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181102182839.725385066@linuxfoundation.org>
 <20181102182839.913422845@linuxfoundation.org>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <07d315a2-d735-3d8b-686c-9c52acf91bf1@newmedia-net.de>
Date:   Sun, 17 Feb 2019 15:29:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20181102182839.913422845@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f02:2400:a93f:22bc:252b:7e28]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1gvNRh-0007b7-8v; Sun, 17 Feb 2019 15:29:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

according to user reports this patch will cause a serious regression. 
igmp snooping is not working anymore with this patch

Am 02.11.2018 um 19:34 schrieb Greg Kroah-Hartman:
> 4.19-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Hangbin Liu <liuhangbin@gmail.com>
>
> [ Upstream commit 5a2de63fd1a59c30c02526d427bc014b98adf508 ]
>
> Based on RFC 4541, 2.1.1.  IGMP Forwarding Rules
>
>    The switch supporting IGMP snooping must maintain a list of
>    multicast routers and the ports on which they are attached.  This
>    list can be constructed in any combination of the following ways:
>
>    a) This list should be built by the snooping switch sending
>       Multicast Router Solicitation messages as described in IGMP
>       Multicast Router Discovery [MRDISC].  It may also snoop
>       Multicast Router Advertisement messages sent by and to other
>       nodes.
>
>    b) The arrival port for IGMP Queries (sent by multicast routers)
>       where the source address is not 0.0.0.0.
>
> We should not add the port to router list when receives query with source
> 0.0.0.0.
>
> Reported-by: Ying Xu <yinxu@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   net/bridge/br_multicast.c |   10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1420,7 +1420,15 @@ static void br_multicast_query_received(
>   		return;
>   
>   	br_multicast_update_query_timer(br, query, max_delay);
> -	br_multicast_mark_router(br, port);
> +
> +	/* Based on RFC4541, section 2.1.1 IGMP Forwarding Rules,
> +	 * the arrival port for IGMP Queries where the source address
> +	 * is 0.0.0.0 should not be added to router port list.
> +	 */
> +	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
> +	    (saddr->proto == htons(ETH_P_IPV6) &&
> +	     !ipv6_addr_any(&saddr->u.ip6)))
> +		br_multicast_mark_router(br, port);
>   }
>   
>   static void br_ip4_multicast_query(struct net_bridge *br,
>
>
>
