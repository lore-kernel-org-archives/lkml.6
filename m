Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272EBC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0075820861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfAUNzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:55:20 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:3095 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730998AbfAUNzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:14 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id D7C4913F8B6;
        Mon, 21 Jan 2019 14:54:27 +0100 (CET)
Subject: Re: kmemleak panic
To:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sachin Nikam <snikam@nvidia.com>, Prateek <prpatel@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>,
        Vinayak Menon <vinmenon@codeaurora.org>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
 <20190119132832.GA29881@MBP.local>
 <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr>
 <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
 <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <96070098-7f05-7eb8-2c5c-9c9da1a45e4a@free.fr>
Date:   Mon, 21 Jan 2019 14:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2019 14:35, Rob Herring wrote:

> On Mon, Jan 21, 2019 at 6:19 AM Robin Murphy wrote:
>>
>> On 21/01/2019 11:57, Marc Gonzalez wrote:
>> [...]
>>> # echo dump=0xffffffc021e00000 > /sys/kernel/debug/kmemleak
>>> kmemleak: Object 0xffffffc021e00000 (size 2097152):
>>> kmemleak:   comm "swapper/0", pid 0, jiffies 4294892296
>>> kmemleak:   min_count = 0
>>> kmemleak:   count = 0
>>> kmemleak:   flags = 0x1
>>> kmemleak:   checksum = 0
>>> kmemleak:   backtrace:
>>>       kmemleak_alloc_phys+0x48/0x60
>>>       memblock_alloc_range_nid+0x8c/0xa4
>>>       memblock_alloc_base_nid+0x4c/0x60
>>>       __memblock_alloc_base+0x3c/0x4c
>>>       early_init_dt_alloc_reserved_memory_arch+0x54/0xa4
>>>       fdt_init_reserved_mem+0x308/0x3ec
>>>       early_init_fdt_scan_reserved_mem+0x88/0xb0
>>>       arm64_memblock_init+0x1dc/0x254
>>>       setup_arch+0x1c8/0x4ec
>>>       start_kernel+0x84/0x44c
>>>       0xffffffffffffffff
>>
>> OK, so via the __va(phys) call in kmemleak_alloc_phys(), you end up with
>> the linear map address of a no-map reservation, which unsurprisingly
>> turns out not to be mapped. Is there a way to tell kmemleak that it
>> can't scan within a particular object?
> 
> There was this patch posted[1]. I never got a reply, so it hasn't been applied.
> 
> Rob
> 
> https://patchwork.ozlabs.org/patch/995367/

It is worth noting that the author's email address appears to be dead.
<schowdary@nvidia.com>: host hqemgate08.nvidia.com[216.228.121.117] said:
550 #5.1.0 Address rejected. (in reply to RCPT TO command)

Adding a few nvidia devs for comment.
