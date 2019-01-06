Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24934C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 05:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF5A2184C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 05:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfAFFuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 00:50:11 -0500
Received: from mail1.windriver.com ([147.11.146.13]:38625 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfAFFuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 00:50:11 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x065nFxW008201
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 5 Jan 2019 21:49:15 -0800 (PST)
Received: from [128.224.155.90] (128.224.155.90) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 5 Jan
 2019 21:49:15 -0800
Subject: Re: [PATCH] tipc: fix memory leak in tipc_nl_compat_publ_dump
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kangjie Lu <kjlu@umn.edu>, Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190105165223.GA3296@embeddedor>
From:   Ying Xue <ying.xue@windriver.com>
Message-ID: <6fb4bb46-5f2e-ae8d-df16-500d7a39c118@windriver.com>
Date:   Sun, 6 Jan 2019 13:41:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190105165223.GA3296@embeddedor>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.90]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/19 12:52 AM, Gustavo A. R. Silva wrote:
> There is a memory leak in case genlmsg_put fails.
> 
> Fix this by freeing *args* before return.
> 
> Addresses-Coverity-ID: 1476406 ("Resource leak")
> Fixes: 46273cf7e009 ("tipc: fix a missing check of genlmsg_put")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Ying Xue <ying.xue@windriver.com>

> ---
>  net/tipc/netlink_compat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
> index 40f5cae623a7..77e4b2418f30 100644
> --- a/net/tipc/netlink_compat.c
> +++ b/net/tipc/netlink_compat.c
> @@ -904,8 +904,10 @@ static int tipc_nl_compat_publ_dump(struct tipc_nl_compat_msg *msg, u32 sock)
>  
>  	hdr = genlmsg_put(args, 0, 0, &tipc_genl_family, NLM_F_MULTI,
>  			  TIPC_NL_PUBL_GET);
> -	if (!hdr)
> +	if (!hdr) {
> +		kfree_skb(args);
>  		return -EMSGSIZE;
> +	}
>  
>  	nest = nla_nest_start(args, TIPC_NLA_SOCK);
>  	if (!nest) {
> 
