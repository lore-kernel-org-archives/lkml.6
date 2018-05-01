Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755455AbeEAMlq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:41:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46470 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755182AbeEAMlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:41:45 -0400
Subject: Re: [PATCH 1/1] mfd: tps65911-comparator: Fix an off by one bug
To: Lee Jones <lee.jones@linaro.org>, dan.carpenter@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180501094553.31545-1-lee.jones@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <54e604bd-61cd-63a8-1d35-864137a5b19a@arm.com>
Date: Tue, 1 May 2018 13:41:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501094553.31545-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/18 10:45, Lee Jones wrote:
> The COMP1 and COMP2 elements are in 0 and 1 respectively so this code is
> accessing the wrong elements and one space beyond the end of the array.
> 
> The "id" variable is never COMP (0) so that code can be removed.
> 
> Fixes: 6851ad3ab346 ("TPS65911: Comparator: Add comparator driver")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> History:
> 
> Dan was the originator of this patch and the author of the commit log,
> but produced 2 code solutions which I wasn't happy with.  The first
> submission [0] introduced a COMP device, which after a quick check of
> the datasheet [1] appeared to be fictitious.  A subsequent submission
> [2] conducted arithmetic in array indexes.
> 
> It is my belief that the correct solution is to roll which the
> situation the hardware engineers presented us with and define COMP1
> at position 0 and COMP2 at position 1 such that we can use the
> simplest code possible to select them.
> 
> Dan wasn't happy to put his name to this, which I completely
> understand.  Calling SOMETHING1 0 (zero) is a little unnatural.
> 
> However, since I have no shame, I offered to submit it.

As an idly-curious passer-by, this looks perfectly reasonable to me - I 
don't see why a mapping between names and indices should have to be 
artificially constrained just because the names happen to contain 
numerals. If it's really that abhorrent, then I guess they could be 
named something like COMPn_ID for even more clarity.

That said, now that I've gone and looked, the whole business seems 
ridiculously over-engineered. AFAICS it would be infinitely simpler to 
just pass the register address directly where id is currently passed, 
statically define UV_MAX, and get rid of the otherwise-pointless struct 
comparator entirely. The current abstraction doesn't look like it could 
actually scale to support different chips without major surgery anyway.

Robin.

> [0] https://lkml.org/lkml/2018/4/19/449
> [1] http://www.ti.com/lit/ds/symlink/tps65911.pdf (page 52)
> [2] https://lkml.org/lkml/2018/4/20/204
> 
> drivers/mfd/tps65911-comparator.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/tps65911-comparator.c b/drivers/mfd/tps65911-comparator.c
> index d223857fb4ad..33591767fb9b 100644
> --- a/drivers/mfd/tps65911-comparator.c
> +++ b/drivers/mfd/tps65911-comparator.c
> @@ -22,9 +22,8 @@
>   #include <linux/gpio.h>
>   #include <linux/mfd/tps65910.h>
>   
> -#define COMP					0
> -#define COMP1					1
> -#define COMP2					2
> +#define COMP1					0
> +#define COMP2					1
>   
>   /* Comparator 1 voltage selection table in millivolts */
>   static const u16 COMP_VSEL_TABLE[] = {
> @@ -63,9 +62,6 @@ static int comp_threshold_set(struct tps65910 *tps65910, int id, int voltage)
>   	int ret;
>   	u8 index = 0, val;
>   
> -	if (id == COMP)
> -		return 0;
> -
>   	while (curr_voltage < tps_comp.uV_max) {
>   		curr_voltage = tps_comp.vsel_table[index];
>   		if (curr_voltage >= voltage)
> @@ -89,9 +85,6 @@ static int comp_threshold_get(struct tps65910 *tps65910, int id)
>   	unsigned int val;
>   	int ret;
>   
> -	if (id == COMP)
> -		return 0;
> -
>   	ret = tps65910_reg_read(tps65910, tps_comp.reg, &val);
>   	if (ret < 0)
>   		return ret;
> 
