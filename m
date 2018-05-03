Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeECTJq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:09:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbeECTJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:09:45 -0400
Subject: Re: [PATCH] atm: zatm: Fix potential Spectre v1
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Chas Williams <3chas3@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180503181712.GA7443@embeddedor.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <98d11d2c-c7c9-e0ae-8a96-320ab9bca765@infradead.org>
Date: Thu, 3 May 2018 12:09:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503181712.GA7443@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 11:17 AM, Gustavo A. R. Silva wrote:
> pool can be indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/atm/zatm.c:1462 zatm_ioctl() warn: potential spectre issue
> 'zatm_dev->pool_info' (local cap)
> 
> Fix this by sanitizing pool before using it to index
> zatm_dev->pool_info
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Hi,

Just for (my) info:  all of these types of patches are to prevent
what is loaded in cache when the index is out of range, right?
Not some random pool_info[random], but pool_info[valid, i.e., 0].

Since the value of pool is already sanity checked and -EINVAL is
returned when it's out of range.

Thanks.

> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/atm/zatm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
> index 1ef67db..9c9a229 100644
> --- a/drivers/atm/zatm.c
> +++ b/drivers/atm/zatm.c
> @@ -28,6 +28,7 @@
>  #include <asm/io.h>
>  #include <linux/atomic.h>
>  #include <linux/uaccess.h>
> +#include <linux/nospec.h>
>  
>  #include "uPD98401.h"
>  #include "uPD98402.h"
> @@ -1458,6 +1459,8 @@ static int zatm_ioctl(struct atm_dev *dev,unsigned int cmd,void __user *arg)
>  					return -EFAULT;
>  				if (pool < 0 || pool > ZATM_LAST_POOL)
>  					return -EINVAL;
> +				pool = array_index_nospec(pool,
> +							  ZATM_LAST_POOL + 1);
>  				spin_lock_irqsave(&zatm_dev->lock, flags);
>  				info = zatm_dev->pool_info[pool];
>  				if (cmd == ZATM_GETPOOLZ) {
> 


-- 
~Randy
