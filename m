Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeEQQ4i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:56:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45229 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbeEQQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:56:35 -0400
X-Google-Smtp-Source: AB8JxZrIO/M9nvonWHreweqVcZaGdimYfOFUAfc5gADTZYWI7dBzUFamJKLrfNORT4/lXLVmb5HAFA==
Subject: Re: [PATCH] of: overlay: validate offset from property fixups
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1526530791-18591-1-git-send-email-frowand.list@gmail.com>
Message-ID: <21ae05b7-e9d4-d518-c341-861c74f32922@gmail.com>
Date: Thu, 17 May 2018 09:56:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526530791-18591-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 05/16/18 21:19, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The smatch static checker marks the data in offset as untrusted,
> leading it to warn:
> 
>   drivers/of/resolver.c:125 update_usages_of_a_phandle_reference()
>   error: buffer underflow 'prop->value' 's32min-s32max'
> 
> Add check to verify that offset is within the property data.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/resolver.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
> index 65d0b7adfcd4..7edfac6f1914 100644
> --- a/drivers/of/resolver.c
> +++ b/drivers/of/resolver.c
> @@ -122,6 +122,11 @@ static int update_usages_of_a_phandle_reference(struct device_node *overlay,
>  			goto err_fail;
>  		}
>  
> +		if (offset < 0 || offset + sizeof(__be32) > prop->length) {
> +			err = -EINVAL;
> +			goto err_fail;
> +		}
> +
>  		*(__be32 *)(prop->value + offset) = cpu_to_be32(phandle);
>  	}
>  
> 

I should have mentioned that this results in a new compile warning
for W=2 and W=3.  The new if statement results in:

drivers/of/resolver.c:125:45: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

There are other pre-existing warnings in the same file for comparing
an integer to prop->length.  The correct solution is probably to
change the type of the length field in struct property to be
unsigned.  I have added that task to my todo list.

-Frank
