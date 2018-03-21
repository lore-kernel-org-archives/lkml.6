Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCUBTY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:19:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46771 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeCUBTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:19:22 -0400
X-Google-Smtp-Source: AG47ELv3jwffeQhvayAODTRo5u5QM4CBxa5liYVWW+C4U3t+VFXcs4Wyc5NhdDQSHLUG2nK0cIrKxA==
Subject: Re: [PATCH 3/3] i2c: mux: pca9541: prepare for PCA9641 support
To: Vladimir Zapolskiy <vz@mleia.com>, Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org, Ken Chen <chen.kenyy@inventec.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, joel@jms.id.au,
        linux-i2c@vger.kernel.org
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-4-peda@axentia.se>
 <bc464354-660a-00ed-e713-eec987407695@mleia.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3cfc6e53-a86d-8ef1-b83d-9f3c1b3d7b9c@roeck-us.net>
Date: Tue, 20 Mar 2018 18:19:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bc464354-660a-00ed-e713-eec987407695@mleia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 04:17 PM, Vladimir Zapolskiy wrote:
> Hi Peter, Ken,
> 
> On 03/20/2018 11:32 AM, Peter Rosin wrote:
>> Make the arbitrate and release_bus implementation chip specific.
>>
> 
> by chance I took a look at the original implementation done by Ken, and
> I would say that this 3/3 change is an overkill as a too generic one.
> Is there any next observable extension? And do two abstracted (*arbitrate)
> and (*release_bus) cover it well? Probably no.
> 
> At first it would be simpler to add a new chip id field into struct pca9541
> (struct rename would be needed of course), and do a selection of specific
> pca9x41_arbitrate() and pca9x41_release_bus() depending on it:
> 

FWIW, I very much prefer Peter's code. I think it is much cleaner.

Guenter

> ----8<----
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> index 47685eb..a40e6d8 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> @@ -70,8 +70,13 @@
>   #define SELECT_DELAY_SHORT	50
>   #define SELECT_DELAY_LONG	1000
>   
> +enum chip_id {
> +	pca9541,
> +};
> +
>   struct pca9541 {
>   	struct i2c_client *client;
> +	enum chip_id id;
>   	unsigned long select_timeout;
>   	unsigned long arb_timeout;
>   };
> @@ -188,10 +193,13 @@ static int pca9541_reg_read(struct i2c_client *client, u8 command)
>    */
>   
>   /* Release bus. Also reset NTESTON and BUSINIT if it was set. */
> -static void pca9541_release_bus(struct i2c_client *client)
> +static void pca9541_release_bus(struct i2c_client *client, enum chip_id id)
>   {
>   	int reg;
>   
> +	if (id != pca9541)
> +		return;
> +
>   	reg = pca9541_reg_read(client, PCA9541_CONTROL);
>   	if (reg >= 0 && !pca9541_busoff(reg) && pca9541_mybus(reg))
>   		pca9541_reg_write(client, PCA9541_CONTROL,
> @@ -235,12 +243,15 @@ static const u8 pca9541_control[16] = {
>    *  0 : bus not acquired
>    *  1 : bus acquired
>    */
> -static int pca9541_arbitrate(struct i2c_client *client)
> +static int pca9541_arbitrate(struct i2c_client *client, enum chip_id id)
>   {
>   	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
>   	struct pca9541 *data = i2c_mux_priv(muxc);
>   	int reg;
>   
> +	if (id != pca9541)
> +		return -EOPNOTSUPP;
> +
>   	reg = pca9541_reg_read(client, PCA9541_CONTROL);
>   	if (reg < 0)
>   		return reg;
> @@ -318,7 +329,7 @@ static int pca9541_select_chan(struct i2c_mux_core *muxc, u32 chan)
>   		/* force bus ownership after this time */
>   
>   	do {
> -		ret = pca9541_arbitrate(client);
> +		ret = pca9541_arbitrate(client, data->id);
>   		if (ret)
>   			return ret < 0 ? ret : 0;
>   
> @@ -336,7 +347,7 @@ static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
>   	struct pca9541 *data = i2c_mux_priv(muxc);
>   	struct i2c_client *client = data->client;
>   
> -	pca9541_release_bus(client);
> +	pca9541_release_bus(client, data->id);
>   	return 0;
>   }
>   
> @@ -361,7 +372,7 @@ static int pca9541_probe(struct i2c_client *client,
>   	 * We have to lock the adapter before releasing the bus.
>   	 */
>   	i2c_lock_adapter(adap);
> -	pca9541_release_bus(client);
> +	pca9541_release_bus(client, pca9541);
>   	i2c_unlock_adapter(adap);
>   
>   	/* Create mux adapter */
> @@ -377,6 +388,7 @@ static int pca9541_probe(struct i2c_client *client,
>   
>   	data = i2c_mux_priv(muxc);
>   	data->client = client;
> +	data->id = pca9541;
>   
>   	i2c_set_clientdata(client, muxc);
>   
> ----8<----
> 
> 
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>   drivers/i2c/muxes/i2c-mux-pca9541.c | 62 +++++++++++++++++++++++++++----------
>>   1 file changed, 45 insertions(+), 17 deletions(-)
>>
> 
> The change above is trivial and it does not cancel any further
> extensions similar to your idea, the open question is if there
> is a demand right at the moment.
> 
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
>> index 47685eb4e0e9..cac629e36bf8 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/i2c-mux.h>
>>   #include <linux/jiffies.h>
>>   #include <linux/module.h>
>> +#include <linux/of_device.h>
>>   #include <linux/platform_data/pca954x.h>
>>   #include <linux/slab.h>
>>   
>> @@ -70,26 +71,22 @@
>>   #define SELECT_DELAY_SHORT	50
>>   #define SELECT_DELAY_LONG	1000
>>   
>> -struct pca9541 {
>> -	struct i2c_client *client;
>> -	unsigned long select_timeout;
>> -	unsigned long arb_timeout;
>> +enum chip_name {
> 
> chip_name sound like a string storage, chip_id might be better here.
> 
>> +	pca9541,
>>   };
>>   
> 
> --
> With best wishes,
> Vladimir
> 
