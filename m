Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180D8C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49FA24B77
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49FA24B77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeFWODs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 10:03:48 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:52500 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbeFWODr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 10:03:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id BD4AD2018D;
        Sat, 23 Jun 2018 16:03:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c-fOrj5OkzkL; Sat, 23 Jun 2018 16:03:45 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 3590520084;
        Sat, 23 Jun 2018 16:03:45 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Sat, 23 Jun 2018
 16:03:44 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id B87A43182354;
 Sat, 23 Jun 2018 16:03:44 +0200 (CEST)
Date:   Sat, 23 Jun 2018 16:03:44 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
CC:     <netdev@vger.kernel.org>, huaibin Wang <huaibin.wang@6wind.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: fix missing dst_release() after policy
 blocking lbcast and multicast
Message-ID: <20180623140344.xplih5tva7zii6xg@gauss3.secunet.de>
References: <20180621063048.13847-1-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180621063048.13847-1-tommi.t.rantala@nokia.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 0F940785-078D-4A46-AC60-E149D26AC067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 09:30:47AM +0300, Tommi Rantala wrote:
> Fix missing dst_release() when local broadcast or multicast traffic is
> xfrm policy blocked.
> 
> For IPv4 this results to dst leak: ip_route_output_flow() allocates
> dst_entry via __ip_route_output_key() and passes it to
> xfrm_lookup_route(). xfrm_lookup returns ERR_PTR(-EPERM) that is
> propagated. The dst that was allocated is never released.
> 
> IPv4 local broadcast testcase:
>  ping -b 192.168.1.255 &
>  sleep 1
>  ip xfrm policy add src 0.0.0.0/0 dst 192.168.1.255/32 dir out action block
> 
> IPv4 multicast testcase:
>  ping 224.0.0.1 &
>  sleep 1
>  ip xfrm policy add src 0.0.0.0/0 dst 224.0.0.1/32 dir out action block
> 
> For IPv6 the missing dst_release() causes trouble e.g. when used in netns:
>  ip netns add TEST
>  ip netns exec TEST ip link set lo up
>  ip link add dummy0 type dummy
>  ip link set dev dummy0 netns TEST
>  ip netns exec TEST ip addr add fd00::1111 dev dummy0
>  ip netns exec TEST ip link set dummy0 up
>  ip netns exec TEST ping -6 -c 5 ff02::1%dummy0 &
>  sleep 1
>  ip netns exec TEST ip xfrm policy add src ::/0 dst ff02::1 dir out action block
>  wait
>  ip netns del TEST
> 
> After netns deletion we see:
> [  258.239097] unregister_netdevice: waiting for lo to become free. Usage count = 2
> [  268.279061] unregister_netdevice: waiting for lo to become free. Usage count = 2
> [  278.367018] unregister_netdevice: waiting for lo to become free. Usage count = 2
> [  288.375259] unregister_netdevice: waiting for lo to become free. Usage count = 2
> 
> Fixes: ac37e2515c1a ("xfrm: release dst_orig in case of error in xfrm_lookup()")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Patch applied, thanks a lot!
