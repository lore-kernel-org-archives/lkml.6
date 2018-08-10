Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7407C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 05:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430ED223DB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 05:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430ED223DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeHJIEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 04:04:23 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:43748 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbeHJIEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 04:04:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 28F06201D7;
        Fri, 10 Aug 2018 09:35:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eFClQKpqpyZa; Fri, 10 Aug 2018 09:35:49 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id C5B19201AA;
        Fri, 10 Aug 2018 09:35:49 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Fri, 10 Aug 2018
 07:36:04 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 437F031817D3;
 Fri, 10 Aug 2018 07:36:04 +0200 (CEST)
Date:   Fri, 10 Aug 2018 07:36:04 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     bai <baijiaju1990@gmail.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] net: xfrm: Two possible sleep-in-atomic-context bugs
Message-ID: <20180810053604.uopy5ziikf736p5o@gauss3.secunet.de>
References: <b74ebf58-16c0-4a51-a004-7ce9e6abde7a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b74ebf58-16c0-4a51-a004-7ce9e6abde7a@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: F1D279C4-A6D5-42DD-9F12-AC259DE0B0DA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 10:02:42AM +0800, bai wrote:
> The code may sleep in interrupt handler.
> xfrm_trans_reinject() is an interrupt handler set in tasklet_init().
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] schedule_timeout
> net/core/sock.c, 2044: schedule_timeout in sock_wait_for_wmem
> net/core/sock.c, 2083: sock_wait_for_wmem in sock_alloc_send_pskb
> net/core/sock.c, 2102: sock_alloc_send_pskb in sock_alloc_send_skb
> net/ipv6/mcast.c, 1989: sock_alloc_send_skb in igmp6_send

igmp6_send calls sock_alloc_send_skb with 'noblock = 1',
this means that sock_wait_for_wmem is not executed in
sock_alloc_send_pskb.

> net/ipv6/mcast.c, 2391: igmp6_send in igmp6_join_group
> net/ipv6/mcast.c, 670: igmp6_join_group in igmp6_group_added
> net/ipv6/mcast.c, 914: igmp6_group_added in ipv6_dev_mc_inc
> net/ipv6/ndisc.c, 379: ipv6_dev_mc_inc in pndisc_constructor
> net/core/neighbour.c, 640: [FUNC_PTR]pndisc_constructor in pneigh_lookup
> net/ipv6/ip6_output.c, 483: pneigh_lookup in ip6_forward
> ./include/net/dst.h, 449: [FUNC_PTR]ip6_forward in dst_input
> net/ipv6/ip6_input.c, 71: dst_input in ip6_rcv_finish
> net/xfrm/xfrm_input.c, 511: [FUNC_PTR]ip6_rcv_finish in xfrm_trans_reinject
> 
> [FUNC] kmalloc(GFP_KERNEL)
> net/core/neighbour.c, 630: kmalloc in pneigh_lookup
> net/ipv6/ip6_output.c, 483: pneigh_lookup in ip6_forward

ip6_forward calls pneigh_lookup with 'creat = 0',
this means that pneigh_lookup does not do the kmalloc.

> ./include/net/dst.h, 449: [FUNC_PTR]ip6_forward in dst_input
> net/ipv6/ip6_input.c, 71: dst_input in ip6_rcv_finish
> net/xfrm/xfrm_input.c, 511: [FUNC_PTR]ip6_rcv_finish in xfrm_trans_reinject
> 
> Note that [FUNC_PTR] means a function pointer call is used.
> 
> I do not find a good way to fix them, so I only report.
> These possible bugs are found by my static analysis tool (DSAC) and checked
> by my code review.

Both codepaths are ok, maybe you should fix your tool ;-)
