Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF62CC65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4BF2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4BF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeLGU3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:29:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGU3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:29:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 364853099F9E;
        Fri,  7 Dec 2018 20:29:23 +0000 (UTC)
Received: from ovpn-116-97.ams2.redhat.com (ovpn-116-97.ams2.redhat.com [10.36.116.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3DE9600C4;
        Fri,  7 Dec 2018 20:29:21 +0000 (UTC)
Message-ID: <c8ebc324a2195942f2a8ba2190b7e18f7b5ed0e2.camel@redhat.com>
Subject: Re: [PATCH net-next v2 0/4] net: mitigate retpoline overhead
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Miller <davem@redhat.com>
Cc:     netdev@vger.kernel.org, eric.dumazet@gmail.com, pjt@google.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Dec 2018 21:29:20 +0100
In-Reply-To: <20181206.222855.1688568512001921392.davem@redhat.com>
References: <cover.1544032300.git.pabeni@redhat.com>
         <20181206.222409.551374562843523036.davem@davemloft.net>
         <20181206.222855.1688568512001921392.davem@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 07 Dec 2018 20:29:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2018-12-06 at 22:28 -0800, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Thu, 06 Dec 2018 22:24:09 -0800 (PST)
> 
> > Series applied, thanks!
> 
> Erm... actually reverted.  Please fix these build failures:

oops ...
I'm sorry for the late reply. I'm travelling and I will not able to re-
post soon.

> ld: net/ipv6/ip6_offload.o: in function `ipv6_gro_receive':
> ip6_offload.c:(.text+0xda2): undefined reference to `udp6_gro_receive'
> ld: ip6_offload.c:(.text+0xdb6): undefined reference to `udp6_gro_receive'
> ld: net/ipv6/ip6_offload.o: in function `ipv6_gro_complete':
> ip6_offload.c:(.text+0x1953): undefined reference to `udp6_gro_complete'
> ld: ip6_offload.c:(.text+0x1966): undefined reference to `udp6_gro_complete'
> make: *** [Makefile:1036: vmlinux] Error 1

Are you building with CONFIG_IPV6=m ? I tested vs some common cfg, but
I omitted that in my last iteration (my bad). With such conf ip6
offloads are builtin while udp6 offloads end-up in the ipv6 module, so
I can't use them with the given conf.

I'll try to fix the above in v3.

I'm sorry for this mess,

Paolo

