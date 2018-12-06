Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2241C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9091B208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9091B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeLFSAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:00:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57412 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLFSAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:00:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66B7E80D;
        Thu,  6 Dec 2018 10:00:02 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33F853F5AF;
        Thu,  6 Dec 2018 10:00:01 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:59:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@gmx.us>
Cc:     akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] efi: let kmemleak ignore false positives
Message-ID: <20181206175958.GS54495@arrakis.emea.arm.com>
References: <1543517152-23969-1-git-send-email-cai@gmx.us>
 <20181206161633.36292-1-cai@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206161633.36292-1-cai@gmx.us>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 11:16:33AM -0500, Qian Cai wrote:
> unreferenced object 0xffff8096c1acf580 (size 128):
>   comm "swapper/63", pid 0, jiffies 4294937418 (age 1201.230s)
>   hex dump (first 32 bytes):
>     80 87 b5 c1 96 00 00 00 00 00 cc c2 16 00 00 00  ................
>     00 00 01 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
>   backtrace:
>     [<000000001d2549ba>] kmem_cache_alloc_trace+0x430/0x500
>     [<0000000093a6dfab>] efi_mem_reserve_persistent+0x50/0xf8
>     [<000000000a730828>] its_cpu_init_lpis+0x394/0x4b8
>     [<00000000edf04e07>] its_cpu_init+0x104/0x150
>     [<000000004d0342c5>] gic_starting_cpu+0x34/0x40
>     [<000000005d9da772>] cpuhp_invoke_callback+0x228/0x1d68
>     [<0000000061eace9b>] notify_cpu_starting+0xc0/0x118
>     [<0000000048bc2dc5>] secondary_start_kernel+0x23c/0x3b0
>     [<0000000015137d6a>] 0xffffffffffffffff
> 
> efi_mem_reserve_persistent+0x50/0xf8:
> kmalloc at include/linux/slab.h:546
> (inlined by) efi_mem_reserve_persistent at drivers/firmware/efi/efi.c:979
> 
> This line,
> 
> rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
> 
> Kmemleak has a known limitation that can only track pointers in the kernel
> virtual space. Hence, it will report false positives due to "rsv" will only
> reference to other physical addresses,
> 
> rsv->next = efi_memreserve_root->next;
> efi_memreserve_root->next = __pa(rsv);
> 
> Signed-off-by: Qian Cai <cai@gmx.us>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
