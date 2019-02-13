Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ED2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF549222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391843AbfBMLXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:23:13 -0500
Received: from www62.your-server.de ([213.133.104.62]:41586 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfBMLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:23:13 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gtsdC-0006lF-EE; Wed, 13 Feb 2019 12:23:10 +0100
Received: from [2a02:1205:34ea:9e0:5681:e3d2:fbd:7e53] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gtsdC-0002kp-6Q; Wed, 13 Feb 2019 12:23:10 +0100
Subject: Re: [PATCH -next] net: ipvlan_l3s: fix kconfig unmet dependency
 warning
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Mahesh Bandewar <maheshb@google.com>,
        David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>
References: <c2d5e413-01c8-8da4-aa67-9517a9518a68@infradead.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1bc4ec7b-8373-12bc-5f89-3d85415bc5d7@iogearbox.net>
Date:   Wed, 13 Feb 2019 12:23:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <c2d5e413-01c8-8da4-aa67-9517a9518a68@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25359/Wed Feb 13 11:34:31 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2019 03:02 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix the kconfig warning in IPVLAN_L3S when neither INET nor IPV6
> is enabled:
> 
> WARNING: unmet direct dependencies detected for NET_L3_MASTER_DEV
>   Depends on [n]: NET [=y] && (INET [=n] || IPV6 [=n])
>   Selected by [y]:
>   - IPVLAN_L3S [=y] && NETDEVICES [=y] && NET_CORE [=y] && NETFILTER [=y]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mahesh Bandewar <maheshb@google.com>
> ---
> Seen in mmotm but applies to linux-next.
> 
>  drivers/net/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- mmotm-2019-0212-1537.orig/drivers/net/Kconfig
> +++ mmotm-2019-0212-1537/drivers/net/Kconfig
> @@ -147,6 +147,7 @@ config MACVTAP
>  
>  config IPVLAN_L3S
>  	depends on NETFILTER
> +	depends on INET || IPV6 # same as NET_L3_MASTER_DEV

Thanks for the fix! Lets just do the following instead ...

    depends on IPVLAN

... and we should be all set. Please submit against net-next, thanks!

>  	def_bool y
>  	select NET_L3_MASTER_DEV
>  
> 
> 

