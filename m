Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934971AbeEJJ6b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:58:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52648 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934430AbeEJJ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:58:30 -0400
X-Google-Smtp-Source: AB8JxZrghiMVeIihxknk2kRnB24ClPbnfpkBnr+DfGVYhttTJF8DQNrEitU5THvXydjniB1+VZMbMg==
Subject: Re: [PATCH v2] nvmem: properly handle returned value nvmem_reg_read
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org
References: <20180505202450.26630-1-malat@debian.org>
 <20180509185724.24079-1-malat@debian.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2cb62de4-f8be-e3cf-f415-54de60bb669e@linaro.org>
Date: Thu, 10 May 2018 10:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180509185724.24079-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/18 19:57, Mathieu Malaterre wrote:
> Function nvmem_reg_read can return a non zero value indicating an error.
> This returned value must be read and error propagated to
> nvmem_cell_prepare_write_buffer. Silence the following gcc warning (W=1):
> 
>    drivers/nvmem/core.c:1093:9: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: prefer ERR_PTR(-EINVAL) over a simple return NULL
> 
>   drivers/nvmem/core.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index b05aa8e81303..f7b6c85cf393 100644
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
> +	return ERR_PTR(-EINVAL);
You should return ERR_PTR(rc) not EINVAL here.
errors should always propagate to caller!

thanks,
srini
>   }
>   
>   /**
> 
