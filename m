Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932889AbeD0P6e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:58:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbeD0P6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:58:32 -0400
Subject: Re: [PATCH] tee: check shm references are consistent in offset/size
To: Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alexandre Jutras <alexandre.jutras@nxp.com>
References: <CAN5uoS_GfCgWCc7QLPhtYkRzXfV+5Xy-TJobC7-NopQe5MGwMw@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4b24ee15-4366-279b-45bd-e8b2f4325ab2@infradead.org>
Date: Fri, 27 Apr 2018 08:58:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN5uoS_GfCgWCc7QLPhtYkRzXfV+5Xy-TJobC7-NopQe5MGwMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 06:53 AM, Etienne Carriere wrote:
> This change prevents userland from referencing TEE shared memory
> outside the area initially allocated by its owner. Prior this change an
> application could not reference or access memory it did not own but
> it could reference memory not explicitly allocated by owner.
> 
> Reported-by: Alexandre Jutras <alexandre.jutras@nxp.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> 
> ---
>  drivers/tee/tee_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 0124a91..dd46b75 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -238,6 +238,17 @@ static int params_from_user(struct tee_context
> *ctx, struct tee_param *params,

Those 2 lines above should be only one line.

>              if (IS_ERR(shm))
>                  return PTR_ERR(shm);
> 
> +            /*
> +             * Ensure offset + size does not overflow offset
> +             * and does not overflow the size of the referred
> +             * shared memory object.
> +             */
> +            if ((ip.a + ip.b) < ip.a ||
> +                (ip.a + ip.b) > shm->size) {
> +                tee_shm_put(shm);
> +                return -EINVAL;
> +            }
> +

Hi,
The patch makes sense but the whitespace and indentation are all mucked up.
Could be your email client.
Please check/fix and test by emailing it to yourself.

>              params[n].u.memref.shm_offs = ip.a;
>              params[n].u.memref.size = ip.b;
>              params[n].u.memref.shm = shm;
> 

thanks,
-- 
~Randy
