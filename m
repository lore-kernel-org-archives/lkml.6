Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD769C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793A02084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfAUMTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:19:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60902 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfAUMTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:19:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC9AA80D;
        Mon, 21 Jan 2019 04:19:38 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEB0B3F614;
        Mon, 21 Jan 2019 04:19:35 -0800 (PST)
Subject: Re: kmemleak panic
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
 <20190119132832.GA29881@MBP.local>
 <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
Date:   Mon, 21 Jan 2019 12:19:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2019 11:57, Marc Gonzalez wrote:
[...]
> # echo dump=0xffffffc021e00000 > /sys/kernel/debug/kmemleak
> kmemleak: Object 0xffffffc021e00000 (size 2097152):
> kmemleak:   comm "swapper/0", pid 0, jiffies 4294892296
> kmemleak:   min_count = 0
> kmemleak:   count = 0
> kmemleak:   flags = 0x1
> kmemleak:   checksum = 0
> kmemleak:   backtrace:
>       kmemleak_alloc_phys+0x48/0x60
>       memblock_alloc_range_nid+0x8c/0xa4
>       memblock_alloc_base_nid+0x4c/0x60
>       __memblock_alloc_base+0x3c/0x4c
>       early_init_dt_alloc_reserved_memory_arch+0x54/0xa4
>       fdt_init_reserved_mem+0x308/0x3ec
>       early_init_fdt_scan_reserved_mem+0x88/0xb0
>       arm64_memblock_init+0x1dc/0x254
>       setup_arch+0x1c8/0x4ec
>       start_kernel+0x84/0x44c
>       0xffffffffffffffff

OK, so via the __va(phys) call in kmemleak_alloc_phys(), you end up with 
the linear map address of a no-map reservation, which unsurprisingly 
turns out not to be mapped. Is there a way to tell kmemleak that it 
can't scan within a particular object?

Robin.
