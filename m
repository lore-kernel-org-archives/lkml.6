Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EDBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433BD2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="Rvpcn8sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBGWjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:39:24 -0500
Received: from server.eikelenboom.it ([91.121.65.215]:60950 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGWjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:39:23 -0500
X-Greylist: delayed 1505 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2019 17:39:22 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kFEpf5w44ybqCRJ0hp7WnrAaT8XA3YBS6zPD+17pLs0=; b=Rvpcn8sDRXVPQIOKxIA+9tfRcB
        ug+i2FAUFwcWRaBaGu6R4M5pBZDpESLxuDqh6+ilpk/aiu6Ioz56sDuIIrl9WTvRvp7KglJCdSN92
        n6ROqqaal/UPCfu8ZkAyvz4LUhhUhC70sKgkNPqmWsG50yfReCUGqfZ5AqYsrvEJR/RU=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:43398 helo=[172.16.1.50])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1grrw9-0001sV-FY; Thu, 07 Feb 2019 23:14:25 +0100
From:   Sander Eikelenboom <linux@eikelenboom.it>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Kernel 5.0-rc5 regression with NAT, bisected to: netfilter: nat:
 remove l4proto->manip_pkt
Message-ID: <40b70892-daf5-28d7-28b5-869911faf2bb@eikelenboom.it>
Date:   Thu, 7 Feb 2019 23:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L.S.,

While trying out a 5.0-RC5 kernel I seem to have stumbled over a regression with NAT.
(using an nftables firewall with NAT and connection tracking).

Unfortunately it isn't too obvious since no errors are logged, but on clients it
causes symptoms like firefox intermittently not being able to load pages with:
    Network Protocol Error
    An error occurred during a connection to www.example.com
    The page you are trying to view cannot be shown because an error in the network protocol was detected.
    Please contact the website owners to inform them of this problem.

But it's only intermittently, so i can still visit some webpages with clients, 
could be that packet size and or fragments are at play ?

So I tried testing with git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git with 
e8c32c32b48c2e889704d8ca0872f92eb027838e as last commit, to be sure to have the latest netdev has to offer,
but to no avail. 

After that I tried to git bisect and ended up with:

faec18dbb0405c7d4dda025054511dc3a6696918 is the first bad commit
commit faec18dbb0405c7d4dda025054511dc3a6696918
Author: Florian Westphal <fw@strlen.de>
Date:   Thu Dec 13 16:01:33 2018 +0100

    netfilter: nat: remove l4proto->manip_pkt
    
    This removes the last l4proto indirection, the two callers, the l3proto
    packet mangling helpers for ipv4 and ipv6, now call the
    nf_nat_l4proto_manip_pkt() helper.
    
    nf_nat_proto_{dccp,tcp,sctp,gre,icmp,icmpv6} are left behind, even though
    they contain no functionality anymore to not clutter this patch.
    
    Next patch will remove the empty files and the nf_nat_l4proto
    struct.
    
    nf_nat_proto_udp.c is renamed to nf_nat_proto.c, as it now contains the
    other nat manip functionality as well, not just udp and udplite.
    
    Signed-off-by: Florian Westphal <fw@strlen.de>
    Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

:040000 040000 22d8706921e03cbd6d78a6ebcc5f253ccfd2bf0c b6f8ab2779215b4495dfe641f50e798da73859ac M  include
:040000 040000 af212a756f1acf00cbe45c3be5b71f38f01f1d34 165c440f9e6f2e05738628a19b51f7603f95752a M  net

Any ideas or debugging hints ?

--
Sander
