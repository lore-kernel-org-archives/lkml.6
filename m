Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F6FC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BC62146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFINfVlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BC62146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeKUKui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:50:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33413 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeKUKui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:50:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id o89so4005408qko.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 16:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l0faow3B73yoICoATHRDlt3IMCmGORV26A1N3TLVngk=;
        b=FFINfVlJqb8xyfLfnWWh0PpxsH4bMuhxJ1NMJsuWF27PfU6M/NVOaUv25axrJoINaR
         0zhPgTNMyzltC3iBQFpYSvlt6q+ziP0nm3gVVIUcDyYxcTAnem++3fa5Up3tCMJXbbx2
         WXeEKTzLquYsPEKgZeeoRphbJQnrmBxBI+gQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=l0faow3B73yoICoATHRDlt3IMCmGORV26A1N3TLVngk=;
        b=HSzTtY7cXeQhN9LCfx+d9ohCxn8bwX7noblAOQGMDfhSjXxKoB89D2uKACbf0trS/x
         Sk/pDsRy1HETESKKoc3JJDqNbp3Yy/VlPFhH92OhdotJ0uqutsGQCh7Qch1GxAVgYmWo
         zVRwN3Bmk6NX6HrEChvCc6UE4YTv3gFt/cvPd41CWEHEH+2OsPL9YpAf2/3Yn3tGS6De
         4hdKT7lQUnkY+6eJhKIRroUvxEK0rpeb8U5nhUa/ONFRHjGTjEcQhlqaakCNrOU0dB71
         Mpt4k3AYXuY3LcgjEGt+7StX7GuTMKxMDH8NB1p2TBNn65dT9CECzzaYFOAFKee4/BMT
         GX9g==
X-Gm-Message-State: AA+aEWbmSMwrn/2h9grbYyFrMYH0ddlIhuK+Nsotv/umDza1eNzWNgun
        oZk1y9iAT13zlnr3A1juHxTWAA==
X-Google-Smtp-Source: AFSGD/VpYVf9eugb8FTOegtm/NiICqajEDHCUDsABzTjP0dY6TmiRy/RXdj/jSblIG9ds1PzDoTWXQ==
X-Received: by 2002:ae9:e895:: with SMTP id a143mr3548881qkg.242.1542759524854;
        Tue, 20 Nov 2018 16:18:44 -0800 (PST)
Received: from [192.168.48.13] ([168.194.163.17])
        by smtp.gmail.com with ESMTPSA id z196sm25567711qkz.37.2018.11.20.16.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 16:18:44 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Subject: Re: [PATCH v2] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
To:     linux@armlinux.org.uk
References: <20181025134344.GZ30658@n2100.armlinux.org.uk>
 <20181121001150.405-1-rafael.tinoco@linaro.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <91776bf8-0d12-1cc4-1ffb-ca3c486aeb0b@linaro.org>
Date:   Tue, 20 Nov 2018 22:18:40 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181121001150.405-1-rafael.tinoco@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 10:11 PM, Rafael David Tinoco wrote:
> On 32-bit systems, zsmalloc uses HIGHMEM and, when PAE is enabled, the
> physical frame number might be so big that zsmalloc obj encoding (to
> location) will break, causing:
> 
> BUG: KASAN: null-ptr-deref in zs_map_object+0xa4/0x2bc
> Read of size 4 at addr 00000000 by task mkfs.ext4/623
> CPU: 2 PID: 623 Comm: mkfs.ext4 Not tainted 4.19.0-rc8-00017-g8239bc6d3307-dirty #15
> Hardware name: Generic DT based system
> [<c0418f7c>] (unwind_backtrace) from [<c0410ca4>] (show_stack+0x20/0x24)
> [<c0410ca4>] (show_stack) from [<c16bd540>] (dump_stack+0xbc/0xe8)
> [<c16bd540>] (dump_stack) from [<c06cab74>] (kasan_report+0x248/0x390)
> [<c06cab74>] (kasan_report) from [<c06c94e8>] (__asan_load4+0x78/0xb4)
> [<c06c94e8>] (__asan_load4) from [<c06ddc24>] (zs_map_object+0xa4/0x2bc)
> [<c06ddc24>] (zs_map_object) from [<bf0bbbd8>] (zram_bvec_rw.constprop.2+0x324/0x8e4 [zram])
> [<bf0bbbd8>] (zram_bvec_rw.constprop.2 [zram]) from [<bf0bc3cc>] (zram_make_request+0x234/0x46c [zram])
> [<bf0bc3cc>] (zram_make_request [zram]) from [<c09aff9c>] (generic_make_request+0x304/0x63c)
> [<c09aff9c>] (generic_make_request) from [<c09b0320>] (submit_bio+0x4c/0x1c8)
> [<c09b0320>] (submit_bio) from [<c0743570>] (submit_bh_wbc.constprop.15+0x238/0x26c)
> [<c0743570>] (submit_bh_wbc.constprop.15) from [<c0746cf8>] (__block_write_full_page+0x524/0x76c)
> [<c0746cf8>] (__block_write_full_page) from [<c07472c4>] (block_write_full_page+0x1bc/0x1d4)
> [<c07472c4>] (block_write_full_page) from [<c0748eb4>] (blkdev_writepage+0x24/0x28)
> [<c0748eb4>] (blkdev_writepage) from [<c064a780>] (__writepage+0x44/0x78)
> [<c064a780>] (__writepage) from [<c064b50c>] (write_cache_pages+0x3b8/0x800)
> [<c064b50c>] (write_cache_pages) from [<c064dd78>] (generic_writepages+0x74/0xa0)
> [<c064dd78>] (generic_writepages) from [<c0748e64>] (blkdev_writepages+0x18/0x1c)
> [<c0748e64>] (blkdev_writepages) from [<c064e890>] (do_writepages+0x68/0x134)
> [<c064e890>] (do_writepages) from [<c06368a4>] (__filemap_fdatawrite_range+0xb0/0xf4)
> [<c06368a4>] (__filemap_fdatawrite_range) from [<c0636b68>] (file_write_and_wait_range+0x64/0xd0)
> [<c0636b68>] (file_write_and_wait_range) from [<c0747af8>] (blkdev_fsync+0x54/0x84)
> [<c0747af8>] (blkdev_fsync) from [<c0739dac>] (vfs_fsync_range+0x70/0xd4)
> [<c0739dac>] (vfs_fsync_range) from [<c0739e98>] (do_fsync+0x4c/0x80)
> [<c0739e98>] (do_fsync) from [<c073a26c>] (sys_fsync+0x1c/0x20)
> [<c073a26c>] (sys_fsync) from [<c0401000>] (ret_fast_syscall+0x0/0x2c)
> 
> when trying to decode (the pfn) and map the object.
> 
> That happens because one architecture might not re-define
> MAX_PHYSMEM_BITS, like in this ARM 32-bit w/ LPAE enabled example. For
> 32-bit systems, if not re-defined, MAX_POSSIBLE_PHYSMEM_BITS will
> default to BITS_PER_LONG (32) in most cases, and, with PAE enabled,
> _PFN_BITS might be wrong: which may cause obj variable to overflow if
> frame number is in HIGHMEM and referencing a page above the 4GB
> watermark.
> 
> commit 6e00ec00b1a7 ("staging: zsmalloc: calculate MAX_PHYSMEM_BITS if
> not defined") realized MAX_PHYSMEM_BITS depended on SPARSEMEM headers
> and "fixed" it by calculating it using BITS_PER_LONG if SPARSEMEM wasn't
> used, like in the example given above.
> 
> Systems with potential for PAE exist for a long time and assuming
> BITS_PER_LONG seems inadequate. Defining MAX_PHYSMEM_BITS looks better,
> however it is NOT a constant anymore for x86.
> 
> SO, instead, MAX_POSSIBLE_PHYSMEM_BITS should be defined by every
> architecture using zsmalloc, together with a sanity check for
> MAX_POSSIBLE_PHYSMEM_BITS being too big on 32-bit systems.
> 
> Link: https://bugs.linaro.org/show_bug.cgi?id=3765#c17
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
>   arch/arm/include/asm/pgtable-2level-types.h |  2 ++
>   arch/arm/include/asm/pgtable-3level-types.h |  2 ++
>   arch/arm64/include/asm/pgtable-types.h      |  2 ++
>   arch/ia64/include/asm/page.h                |  2 ++
>   arch/mips/include/asm/page.h                |  2 ++
>   arch/powerpc/include/asm/mmu.h              |  2 ++
>   arch/s390/include/asm/page.h                |  2 ++
>   arch/sh/include/asm/page.h                  |  2 ++
>   arch/sparc/include/asm/page_32.h            |  2 ++
>   arch/sparc/include/asm/page_64.h            |  2 ++
>   arch/x86/include/asm/pgtable-2level_types.h |  2 ++
>   arch/x86/include/asm/pgtable-3level_types.h |  3 +-
>   arch/x86/include/asm/pgtable_64_types.h     |  4 +--
>   mm/zsmalloc.c                               | 35 +++++++++++----------
>   14 files changed, 45 insertions(+), 19 deletions(-)

Russel,

I have tried to place MAX_POSSIBLE_PHYSMEM_BITS in the best available 
header for each architecture, considering different paging levels, PAE 
existence, and existing similar definitions. Also, I have only 
considered those architectures already having "sparsemem.h" header.

Would you mind reviewing it ?

Tks
--
Rafael D. Tinoco
Linaro Kernel Validation
