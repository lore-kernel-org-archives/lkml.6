Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeDFQRK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:17:10 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45170 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751926AbeDFQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:17:09 -0400
X-Google-Smtp-Source: AIpwx4/3POIawLN5WXcY7FM8LDHpl7TiMZzU5qXncMjS+k8xy1R+RC8p4twq3MlEiR4GuSGwJ7RV0g==
Subject: Re: [PATCH 1/1] arm64: To remove initrd reserved area entry from
 memblock
To: CHANDAN VN <chandan.vn@samsung.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com,
        robin.murphy@arm.com, steve.capper@arm.com, kristina.martsenko@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cpgs@samsung.com, vn.chandan@gmail.com
References: <CGME20180406045340epcas1p1ae6416dc25823212303c9109d125c018@epcas1p1.samsung.com>
 <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <ff125919-66f7-6658-e9b1-817188c1bdd9@redhat.com>
Date: Fri, 6 Apr 2018 09:17:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 09:53 PM, CHANDAN VN wrote:
> INITRD reserved area entry is not removed from memblock
> even though initrd reserved area is freed. After freeing
> the memory it is released from memblock. The same can be
> checked from /sys/kernel/debug/memblock/reserved.
> 
> The patch makes sure that the initrd entry is removed from
> memblock when keepinitrd is not enabled.
> 

Does this have an impact on anything besides accounting
in memblock?

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
