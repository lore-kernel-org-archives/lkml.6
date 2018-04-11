Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeDKKav (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:30:51 -0400
Received: from mail.windriver.com ([147.11.1.11]:54109 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeDKKat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:30:49 -0400
Subject: Re: [PATCH v3] net: tipc: Replace GFP_ATOMIC with GFP_KERNEL in
 tipc_mon_create
To: Jia-Ju Bai <baijiaju1990@gmail.com>, <jon.maloy@ericsson.com>,
        <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1523442262-4823-1-git-send-email-baijiaju1990@gmail.com>
From: Ying Xue <ying.xue@windriver.com>
Message-ID: <7bf48d79-54fe-421a-e04c-f2d6cd2c71e2@windriver.com>
Date: Wed, 11 Apr 2018 18:26:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523442262-4823-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.98]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2018 06:24 PM, Jia-Ju Bai wrote:
> tipc_mon_create() is never called in atomic context.
> 
> The call chain ending up at tipc_mon_create() is:
> [1] tipc_mon_create() <- tipc_enable_bearer() <- tipc_nl_bearer_enable()
> tipc_nl_bearer_enable() calls rtnl_lock(), which indicates this function
> is not called in atomic context.
> 
> Despite never getting called from atomic context,
> tipc_mon_create() calls kzalloc() with GFP_ATOMIC,
> which does not sleep for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> which can sleep and improve the possibility of successful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Acked-by: Ying Xue <ying.xue@windriver.com>

> ---
> v2:
> * Modify the description of GFP_ATOMIC in v1.
>   Thank Eric for good advice.
> v3:
> * Modify wrong text in description in v2.
>   Thank Ying for good advice.
> ---
>  net/tipc/monitor.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
> index 9e109bb..9714d80 100644
> --- a/net/tipc/monitor.c
> +++ b/net/tipc/monitor.c
> @@ -604,9 +604,9 @@ int tipc_mon_create(struct net *net, int bearer_id)
>  	if (tn->monitors[bearer_id])
>  		return 0;
>  
> -	mon = kzalloc(sizeof(*mon), GFP_ATOMIC);
> -	self = kzalloc(sizeof(*self), GFP_ATOMIC);
> -	dom = kzalloc(sizeof(*dom), GFP_ATOMIC);
> +	mon = kzalloc(sizeof(*mon), GFP_KERNEL);
> +	self = kzalloc(sizeof(*self), GFP_KERNEL);
> +	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
>  	if (!mon || !self || !dom) {
>  		kfree(mon);
>  		kfree(self);
> 
