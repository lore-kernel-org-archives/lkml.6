Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D40C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0959520658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0959520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeJVTOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:14:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34709 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeJVTOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:14:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so8922009wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 03:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FxUq16/lM/BuGprTt1NGFyhvtVuKC7FchER62kSGApc=;
        b=sp2QjzQLwYRwXsqdEJfYQqP4q5Z3bin326mFk5uqBVwylvQJnoMlKP3FOSeKqKlgob
         zmor5SSC4hGd3+T8+7foDRFWUKTnF85Y/a7H5C8uWnmmmkTRQY4qXuCdFNggR74S/FUH
         GFkMa13nNid+u+9HuzDiOYyCv0wFZsXOG0Sbzjtc4KdIvFBFhfMyYmOL5x5AAiq4+Niz
         UDBTjokiMXgCS2LK2LBO611plu+4eY6ycgDcCxXGSWPhzdyHMHQAoDe1fhSe5vJfcp0I
         nVG7msE+/C8XDI5ELJxNR0wT7/S/VihTYxKMzQLrghafXxo1EvFQg+rg8lCdkE3eTrxq
         kTxQ==
X-Gm-Message-State: ABuFfoga9kGMb2MSkyKJIfPtZPM1zfoSdAqZNj7PYIkUA3tSzo6VFuLa
        5ox44W1jQ2xHtLXx4LAbWxdm2Kzgb14=
X-Google-Smtp-Source: ACcGV622FlNYH/QcWe4hWJnYlNrH+No/oY2W9aBf2Fy4XGIvbCKk+UikaC5KTf9v5deF0+g0hE7Q7A==
X-Received: by 2002:a1c:930c:: with SMTP id v12-v6mr16065587wmd.9.1540205779727;
        Mon, 22 Oct 2018 03:56:19 -0700 (PDT)
Received: from [172.22.36.222] ([167.98.65.38])
        by smtp.gmail.com with ESMTPSA id n7-v6sm479947wrx.17.2018.10.22.03.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 03:56:18 -0700 (PDT)
Subject: Re: [PATCH] arm64: kprobe: make page to RO mode when allocate it
To:     Anders Roxell <anders.roxell@linaro.org>, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20181015111600.5479-1-anders.roxell@linaro.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <071b035a-4eac-525c-f073-3e63867078c3@redhat.com>
Date:   Mon, 22 Oct 2018 03:56:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015111600.5479-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/2018 04:16 AM, Anders Roxell wrote:
> Commit 1404d6f13e47 ("arm64: dump: Add checking for writable and exectuable pages")
> has successfully identified code that leaves a page with W+X
> permissions.
> 
> [    3.245140] arm64/mm: Found insecure W+X mapping at address (____ptrval____)/0xffff000000d90000
> [    3.245771] WARNING: CPU: 0 PID: 1 at ../arch/arm64/mm/dump.c:232 note_page+0x410/0x420
> [    3.246141] Modules linked in:
> [    3.246653] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5-next-20180928-00001-ge70ae259b853-dirty #62
> [    3.247008] Hardware name: linux,dummy-virt (DT)
> [    3.247347] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    3.247623] pc : note_page+0x410/0x420
> [    3.247898] lr : note_page+0x410/0x420
> [    3.248071] sp : ffff00000804bcd0
> [    3.248254] x29: ffff00000804bcd0 x28: ffff000009274000
> [    3.248578] x27: ffff00000921a000 x26: ffff80007dfff000
> [    3.248845] x25: ffff0000093f5000 x24: ffff000009526f6a
> [    3.249109] x23: 0000000000000004 x22: ffff000000d91000
> [    3.249396] x21: ffff000000d90000 x20: 0000000000000000
> [    3.249661] x19: ffff00000804bde8 x18: 0000000000000400
> [    3.249924] x17: 0000000000000000 x16: 0000000000000000
> [    3.250271] x15: ffffffffffffffff x14: 295f5f5f5f6c6176
> [    3.250594] x13: 7274705f5f5f5f28 x12: 2073736572646461
> [    3.250941] x11: 20746120676e6970 x10: 70616d20582b5720
> [    3.251252] x9 : 6572756365736e69 x8 : 3039643030303030
> [    3.251519] x7 : 306666666678302f x6 : ffff0000095467b2
> [    3.251802] x5 : 0000000000000000 x4 : 0000000000000000
> [    3.252060] x3 : 0000000000000000 x2 : ffffffffffffffff
> [    3.252323] x1 : 4d151327adc50b00 x0 : 0000000000000000
> [    3.252664] Call trace:
> [    3.252953]  note_page+0x410/0x420
> [    3.253186]  walk_pgd+0x12c/0x238
> [    3.253417]  ptdump_check_wx+0x68/0xf8
> [    3.253637]  mark_rodata_ro+0x68/0x98
> [    3.253847]  kernel_init+0x38/0x160
> [    3.254103]  ret_from_fork+0x10/0x18
> 
> Reworked to that when allocate a page it sets mode RO. Inspired by
> commit 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()").
> 

Reviewed-by: Laura Abbott <labbott@redhat.com>

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   arch/arm64/kernel/probes/kprobes.c | 27 ++++++++++++++++++++-------
>   1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 9b65132e789a..b842e908b423 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -23,7 +23,9 @@
>   #include <linux/slab.h>
>   #include <linux/stop_machine.h>
>   #include <linux/sched/debug.h>
> +#include <linux/set_memory.h>
>   #include <linux/stringify.h>
> +#include <linux/vmalloc.h>
>   #include <asm/traps.h>
>   #include <asm/ptrace.h>
>   #include <asm/cacheflush.h>
> @@ -42,10 +44,21 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>   static void __kprobes
>   post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
>   
> +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> +{
> +	void *addrs[1];
> +	u32 insns[1];
> +
> +	addrs[0] = (void *)addr;
> +	insns[0] = (u32)opcode;
> +
> +	return aarch64_insn_patch_text(addrs, insns, 1);
> +}
> +
>   static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>   {
>   	/* prepare insn slot */
> -	p->ainsn.api.insn[0] = cpu_to_le32(p->opcode);
> +	patch_text(p->ainsn.api.insn, p->opcode);
>   
>   	flush_icache_range((uintptr_t) (p->ainsn.api.insn),
>   			   (uintptr_t) (p->ainsn.api.insn) +
> @@ -118,15 +131,15 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>   	return 0;
>   }
>   
> -static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
> +void *alloc_insn_page(void)
>   {
> -	void *addrs[1];
> -	u32 insns[1];
> +	void *page;
>   
> -	addrs[0] = (void *)addr;
> -	insns[0] = (u32)opcode;
> +	page = vmalloc_exec(PAGE_SIZE);
> +	if (page)
> +		set_memory_ro((unsigned long)page & PAGE_MASK, 1);
>   
> -	return aarch64_insn_patch_text(addrs, insns, 1);
> +	return page;
>   }
>   
>   /* arm kprobe: install breakpoint in text */
> 

