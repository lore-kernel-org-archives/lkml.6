Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3352C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C260218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbeLXJfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:35:30 -0500
Received: from relay.sw.ru ([185.231.240.75]:44914 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbeLXJf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:35:29 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gbMds-0003An-Og; Mon, 24 Dec 2018 12:35:20 +0300
Subject: Re: [PATCH] net/net_namespace: Check the return value of
 register_pernet_subsys()
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181224014239.11601-1-pakki001@umn.edu>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6498f7f5-b3cb-2d86-b0dc-ebd807948c3b@virtuozzo.com>
Date:   Mon, 24 Dec 2018 12:35:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181224014239.11601-1-pakki001@umn.edu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.12.2018 04:42, Aditya Pakki wrote:
> In net_ns_init(), register_pernet_subsys() could fail while registering
> network namespace subsystems. The fix checks the return value and
> sends a panic() on failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  net/core/net_namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index fefe72774aeb..af8849a7a9c3 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -917,7 +917,8 @@ static int __init net_ns_init(void)
>  	init_net_initialized = true;
>  	up_write(&pernet_ops_rwsem);
>  
> -	register_pernet_subsys(&net_ns_ops);
> +	if (register_pernet_subsys(&net_ns_ops))
> +		panic("Could not register network namespace subsystems");
>  
>  	rtnl_register(PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL,
>  		      RTNL_FLAG_DOIT_UNLOCKED);
> 
