Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754666AbeDWKS1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:18:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754565AbeDWKSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:18:21 -0400
Message-ID: <5ADDB2D6.3040703@huawei.com>
Date: Mon, 23 Apr 2018 18:17:58 +0800
From: Xishi Qiu <qiuxishi@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC: yeyunfeng <yeyunfeng@huawei.com>, Wenan Mao <maowenan@huawei.com>,
        "Linux MM" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] should BIOS change the efi type when we set CONFIG_X86_RESERVE_LOW
 ?
References: <5ACEBB47.3060300@huawei.com>
In-Reply-To: <5ACEBB47.3060300@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.25.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/12 9:49, Xishi Qiu wrote:

> Hi, I find CONFIG_X86_RESERVE_LOW=64 in my system, so trim_low_memory_range()
> will reserve low 64kb memory. But efi_free_boot_services() will free it to
> buddy system again later because BIOS set the type to EFI_BOOT_SERVICES_CODE.
> 
> Here is the log:
> ...
> efi: mem03: type=3, attr=0xf, range=[0x000000000000e000-0x0000000000010000) (0MB
> ...
> 
> 

When call memblock_is_region_reserved(), it will set md->num_pages = 0 if the
memblock region is reserved. But trim_low_memory_range() reserve the region
after efi, so this breaks the logic, and efi_free_boot_services() will free
the pages(efi code/data). That means trim_low_memory_range() has not reserve
the low memory range.

...
efi_reserve_boot_services()
...
trim_low_memory_range()
...
efi_free_boot_services()
...

Shall we move trim_low_memory_range() before efi_reserve_boot_services()?

Thanks,
Xishi Qiu

> .
> 
