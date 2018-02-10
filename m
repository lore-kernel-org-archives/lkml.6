Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbeBJQ5r (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 11:57:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50598 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeBJQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 11:57:46 -0500
Subject: Re: [PATCH 2/2] xen: xenbus: WARN_ON XS_TRANSACTION_{START,END}
 misuse
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20180207222236.7434-1-simon@invisiblethingslab.com>
 <20180207222236.7434-2-simon@invisiblethingslab.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <8a0fd059-7acf-3279-10f9-649c19522e2a@oracle.com>
Date: Sat, 10 Feb 2018 11:57:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207222236.7434-2-simon@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8801 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802100224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 05:22 PM, Simon Gaiser wrote:
> As the previous commit shows it's quite easy to confuse the transaction
> reference counting by ending a transaction twice. So at least try to
> detect and report it.
> 
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
> ---
>   drivers/xen/xenbus/xenbus_xs.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index 3e59590c7254..aed954b09b9b 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -137,11 +137,20 @@ static uint32_t xs_request_enter(struct xb_req_data *req)
>   
>   void xs_request_exit(struct xb_req_data *req)
>   {
> +	unsigned int users_old;
> +
>   	spin_lock(&xs_state_lock);
> +	users_old = xs_state_users;
>   	xs_state_users--;
>   	if ((req->type == XS_TRANSACTION_START && req->msg.type == XS_ERROR) ||
>   	    req->type == XS_TRANSACTION_END)
>   		xs_state_users--;
> +	if (WARN_ON(xs_state_users > users_old))


WARN_ON_ONCE()?

-boris


> +		/*
> +		 * Someone misused XS_TRANSACTION_{START,END}. Reset the
> +		 * reference counter so we might survive.
> +		 */
> +		xs_state_users = 0;
>   	spin_unlock(&xs_state_lock);
>   
>   	if (xs_suspend_active && !xs_state_users)
> 
