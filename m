Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeEHJaW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:30:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53637 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754457AbeEHJaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:30:20 -0400
X-Google-Smtp-Source: AB8JxZr8/APfYAMkzK5QkA+7SSU41wOYXu+rH6w/Fv5V2Qr9OBpEvoMtKom+AeOQ3XVz3Phz3xWFXQ==
Subject: Re: [PATCH] nvmem: properly handle returned value nvmem_reg_read
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org
References: <20180505202450.26630-1-malat@debian.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <86ae1cf5-8145-63f1-1464-973aeb056103@linaro.org>
Date: Tue, 8 May 2018 10:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180505202450.26630-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch,

On 05/05/18 21:24, Mathieu Malaterre wrote:
> Function nvmem_reg_read can return a non zero value indicating an error.
> This returned value must be read and error propagated to
> nvmem_cell_prepare_write_buffer. Silence the following gcc warning (W=1):
> 
>    drivers/nvmem/core.c:1093:9: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   drivers/nvmem/core.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index b05aa8e81303..f34f2363925a 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1107,6 +1107,8 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
>   
>   		/* setup the first byte with lsb bits from nvmem */
>   		rc = nvmem_reg_read(nvmem, cell->offset, &v, 1);
> +		if (rc)
> +			goto err;
>   		*b++ |= GENMASK(bit_offset - 1, 0) & v;
>   
>   		/* setup rest of the byte if any */
> @@ -1125,11 +1127,16 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
>   		/* setup the last byte with msb bits from nvmem */
>   		rc = nvmem_reg_read(nvmem,
>   				    cell->offset + cell->bytes - 1, &v, 1);
> +		if (rc)
> +			goto err;
>   		*p |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) & v;
>   
>   	}
>   
>   	return buf;
> +err:
> +	kfree(buf);
> +	return NULL;
You should return an error pointer here, not NULL.

thanks,
srini


>   }
>   
>   /**
> 
