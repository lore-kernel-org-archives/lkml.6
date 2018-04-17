Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeDQGTB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:19:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42890 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeDQGTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:19:00 -0400
X-Google-Smtp-Source: AIpwx4/GrYFESQKOzXMXbyKlwW7zSHKKJUtkLKm9zPrA3VovlD+zHvj11MDT9aqBQ5uPwL2c0m9NuQ==
Message-ID: <5AD591D0.5040404@gmail.com>
Date: Tue, 17 Apr 2018 14:18:56 +0800
From: zoucao-ipc <zoucaox@gmail.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
CC: zoucao@linux.alibaba.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/e820: add new chareater "-" to free BIOS memory
 in memmap bootargs
References: <20180410025912.49830-1-zoucao@linux.alibaba.com> <20180410025912.49830-2-zoucao@linux.alibaba.com>
In-Reply-To: <20180410025912.49830-2-zoucao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On 2018/4/10 上午10:59, zoucao@linux.alibaba.com wrote:
> From: zoucao <zoucao@localhost.localdomain>
>
> Normally every BIOS reserved memory is used for some features, we can't
> use them, but in some conditions,  users can ensure some BIOS memories
> are not used and reserved memory is well to free, they have not a good
> way to free these memories, here add a new chareater "-" in memmap to
> free reserved memory.
>
> Signed-off-by: zou cao <zoucao@linux.alibaba.com>
> ---
>   7u/Documentation/kernel-parameters.txt | 6 ++++++
>   7u/arch/x86/kernel/e820.c              | 3 +++
>   2 files changed, 9 insertions(+)
>
> diff --git a/7u/Documentation/kernel-parameters.txt b/7u/Documentation/kernel-parameters.txt
> index 9a1abb99a..dbea75e12 100644
> --- a/7u/Documentation/kernel-parameters.txt
> +++ b/7u/Documentation/kernel-parameters.txt
> @@ -1677,6 +1677,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>   			         or
>   			         memmap=0x10000$0x18690000
>   
> +	memmap=nn[KMG]-ss[KMG]
> +			Free E820 reserved memory, as specified by the user.
> +			Region of reserved memory to be free, from ss to ss+nn.
> +			Example: free reserved memory from 0x18690000-0x186a0000
> +					memmap=0x4101000-0x6aeff000
> +
>   	memory_corruption_check=0/1 [X86]
>   			Some BIOSes seem to corrupt the first 64k of
>   			memory when doing things like suspend/resume.
> diff --git a/7u/arch/x86/kernel/e820.c b/7u/arch/x86/kernel/e820.c
> index 174da5fc5..b8a042981 100644
> --- a/7u/arch/x86/kernel/e820.c
> +++ b/7u/arch/x86/kernel/e820.c
> @@ -875,6 +875,9 @@ static int __init parse_memmap_one(char *p)
>   	} else if (*p == '$') {
>   		start_at = memparse(p+1, &p);
>   		e820_add_region(start_at, mem_size, E820_RESERVED);
> +	} else if (*p == '-') {
> +		start_at = memparse(p+1, &p);
> +		e820_remove_range(start_at, mem_size, E820_RESERVED, E820_RAM);
>   	} else
>   		e820_remove_range(mem_size, ULLONG_MAX - mem_size, E820_RAM, 1);
>   
