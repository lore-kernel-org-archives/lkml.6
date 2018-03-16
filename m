Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AG47ELuW7JuFZXGyhwW2DyhY/0rTCaOLJ9pXfR4SN1Zukp5eW+PgSAkAAdiVlbMSIBd1X4s9+qhY
ARC-Seal: i=1; a=rsa-sha256; t=1521206372; cv=none;
        d=google.com; s=arc-20160816;
        b=VnvVF/oEbkePaXpG2ChrwmcngAxDj6RviZBOD7oMwXcz9qfiA4bllVFhr1+yiprCSK
         wGtjp3pyH906Rw11J6JT4bw8peZbHzetKeoy/WtZ+fuBicCwQe/ujinFkUu4X/NRO1/q
         bBg93BDcAcZxyWd33UeqySYCnWi9mQPargTxO0eO+Ofbc38j7R+T1l72ZJOIvAWvgpLU
         vd9B95yGaPf1zy5OA281U6mSC4RiapSVjjsfnVGTGUlflmftfpq54Fucyob/1xyyanDu
         0OWANxyLS+P2wSVqfUy7YYXuLNSs+AO1aP83cXY6aPacBUDAjyuL0MbwKByG45SyjMw3
         Dn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=9oZtxQJ1+G5snHsjqVMv85mQi7S6AwICJihIE1feSNo=;
        b=LAsSSHTo8UCKKDqW+1PAUtgJo5UE2p+wyJjtaFt5S8NPJQWHntwanb/GKBTXJO7/QF
         Pn5fcV/FLb9BjI1y/u5wLXUakXAcNNm9etF3qfTUoPDCHnr2XXwEXEukqNcX9J06Ncxu
         dBTjs94RykEqfOll3cIs27P/qwT2egC81sXxqDzOPoUFjZ6lBr6v8myES4RHrTPnORk4
         NygZMNU4HxoqZUUHKewSxU3FAl/bFOVYUTNUhMj+c3XVtLsKjWrEmMEHspIPwTegggUX
         SY7ggH1OBGpt4eVqH8H+ABVE6+czc0qTJjnJJZbvXZgNsFnuwr2iyUETCvAe02n6yacQ
         WStA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.144.95 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.144.95 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Subject: Re: [PATCH] USB: wusbcore: crypto: Remove VLA usage
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180316130141.GA22594@embeddedgus>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <54e89cea-a1a1-90a3-912f-209172bb41ae@embeddedor.com>
Date: Fri, 16 Mar 2018 08:19:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316130141.GA22594@embeddedgus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1ewpGe-000D3y-Bc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:36710
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595099374713659126?=
X-GMAIL-MSGID: =?utf-8?q?1595100493977480266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


I just discovered an issue with this patch. Please, drop it. I'll send 
v2 shortly.

Thanks
--
Gustavo

On 03/16/2018 08:01 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with dynamic memory allocation instead.
> 
> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> or a security flaw. Also, in general, as code evolves it is easy to
> lose track of how big a VLA can get. Thus, we can end up having runtime
> failures that are hard to debug.
> 
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Notice that in this particular case, an alternative to kzalloc is kcalloc,
> in which case the code would look as follows instead:
> 
> iv = kcalloc(crypto_skcipher_ivsize(tfm_cbc), sizeof(*iv), GFP_KERNEL);
> 
> but if the data type of _iv_ never changes, or the type size is always one
> byte, kzalloc is good enough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/usb/wusbcore/crypto.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/wusbcore/crypto.c b/drivers/usb/wusbcore/crypto.c
> index 4c00be2d..3511473 100644
> --- a/drivers/usb/wusbcore/crypto.c
> +++ b/drivers/usb/wusbcore/crypto.c
> @@ -202,7 +202,7 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
>   	struct scatterlist sg[4], sg_dst;
>   	void *dst_buf;
>   	size_t dst_size;
> -	u8 iv[crypto_skcipher_ivsize(tfm_cbc)];
> +	u8 *iv;
>   	size_t zero_padding;
>   
>   	/*
> @@ -222,9 +222,11 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
>   		zero_padding;
>   	dst_buf = kzalloc(dst_size, GFP_KERNEL);
>   	if (!dst_buf)
> -		goto error_dst_buf;
> +		goto error_alloc;
>   
> -	memset(iv, 0, sizeof(iv));
> +	iv = kzalloc(crypto_skcipher_ivsize(tfm_cbc), GFP_KERNEL);
> +	if (!iv)
> +		goto error_alloc;
>   
>   	/* Setup B0 */
>   	scratch->b0.flags = 0x59;	/* Format B0 */
> @@ -276,8 +278,9 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
>   	bytewise_xor(mic, &scratch->ax, iv, 8);
>   	result = 8;
>   error_cbc_crypt:
> +	kfree(iv);
>   	kfree(dst_buf);
> -error_dst_buf:
> +error_alloc:
>   	return result;
>   }
>   
> 
