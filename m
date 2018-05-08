Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeEHHCL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:02:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:47318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754417AbeEHHCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:02:08 -0400
Subject: Re: [PATCH] xen: xenbus: Fix a possible data race in xs_request_enter
To: Jia-Ju Bai <baijiaju1990@gmail.com>, boris.ostrovsky@oracle.com,
        simon@invisiblethingslab.com, joao.m.martins@oracle.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180508033429.12749-1-baijiaju1990@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <ea5634a2-b0e2-0fac-e5ec-cef1083958fe@suse.com>
Date: Tue, 8 May 2018 09:02:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508033429.12749-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/18 05:34, Jia-Ju Bai wrote:
> The read operation to "req->type" is protected by
> the lock on line 128, but the write operation to
> this data on line 118 is not protected by the lock.
> Thus, there may exist a data race for "req->type".
> 
> To fix this data race, the write operation to "req->type" 
> should be also protected by the lock.

No, xs_request_enter() is never called for a request already visible to
another thread or processor. So no race exists.


Juergen

> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/xen/xenbus/xenbus_xs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index 49a3874ae6bb..274cdfee08b1 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -115,10 +115,10 @@ static uint32_t xs_request_enter(struct xb_req_data *req)
>  {
>  	uint32_t rq_id;
>  
> -	req->type = req->msg.type;
> -
>  	spin_lock(&xs_state_lock);
>  
> +	req->type = req->msg.type;
> +
>  	while (!xs_state_users && xs_suspend_active) {
>  		spin_unlock(&xs_state_lock);
>  		wait_event(xs_state_enter_wq, xs_suspend_active == 0);
> 
