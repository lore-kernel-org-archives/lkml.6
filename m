Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753753AbeD3RV3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 13:21:29 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36549 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbeD3RV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 13:21:28 -0400
X-Google-Smtp-Source: AB8JxZoLMyG/Tt1W1XBOhVwMSYrDQ2O1L4mTxiI3ulwgI5jYFgo4kbyI6TdLB3KvpPc9FzsxVOnXHA==
Subject: Re: [PATCHv2 1/1] arm64: To remove initrd reserved area entry from
 memblock
To: CHANDAN VN <chandan.vn@samsung.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com,
        robin.murphy@arm.com, steve.capper@arm.com, kristina.martsenko@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cpgs@samsung.com, vn.chandan@gmail.com
References: <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
 <CGME20180430042028epcas2p24418c10ebe7b2c656cdfc31e98ed540b@epcas2p2.samsung.com>
 <1525062018-8065-1-git-send-email-chandan.vn@samsung.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <689d9682-e6d8-c1ca-bba6-43dca09957ea@redhat.com>
Date: Mon, 30 Apr 2018 10:21:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525062018-8065-1-git-send-email-chandan.vn@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/2018 09:20 PM, CHANDAN VN wrote:
> INITRD reserved area entry is not removed from memblock
> even though initrd reserved area is freed. After freeing
> the memory it is released from memblock. The same can be
> checked from /sys/kernel/debug/memblock/reserved.
> 
> The patch makes sure that the initrd entry is removed from
> memblock when keepinitrd is not enabled.
> 
> The patch only affects accounting and debugging. This does not
> fix any memory leak.
> 
> Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
> ---
>   arch/arm64/mm/init.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9f3c47a..1b18b47 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -646,8 +646,10 @@ void free_initmem(void)
>   
>   void __init free_initrd_mem(unsigned long start, unsigned long end)
>   {
> -	if (!keep_initrd)
> +	if (!keep_initrd) {
>   		free_reserved_area((void *)start, (void *)end, 0, "initrd");
> +		memblock_free(__virt_to_phys(start), end - start);
> +	}
>   }
>   
>   static int __init keepinitrd_setup(char *__unused)
> 

Acked-by: Laura Abbott <labbott@redhat.com>
