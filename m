Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86915C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DFE2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DFE2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeKEWin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:38:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34831 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbeKEWin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:38:43 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJemM-0005h6-Br; Mon, 05 Nov 2018 14:18:54 +0100
Date:   Mon, 5 Nov 2018 14:18:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V3 1/3] x86/mm/pageattr: Introduce helper function to
 unmap EFI boot services
In-Reply-To: <20181104201019.26142-2-sai.praneeth.prakhya@intel.com>
Message-ID: <alpine.DEB.2.21.1811051418340.1566@nanos.tec.linutronix.de>
References: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com> <20181104201019.26142-2-sai.praneeth.prakhya@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2018, Sai Praneeth Prakhya wrote:

> Ideally, after kernel assumes control of the platform, firmware
> shouldn't access EFI boot services code/data regions. But, it's noticed
> that this is not so true in many x86 platforms. Hence, during boot,
> kernel reserves EFI boot services code/data regions [1] and maps [2]
> them to efi_pgd so that call to set_virtual_address_map() doesn't fail.
> After returning from set_virtual_address_map(), kernel frees the
> reserved regions [3] but they still remain mapped. Hence, introduce
> kernel_unmap_pages_in_pgd() which will later be used to unmap EFI boot
> services code/data regions.
> 
> While at it modify kernel_map_pages_in_pgd() by
> 1. Adding __init modifier because it's always used *only* during boot.
> 2. Add a warning if it's used after SMP is initialized because it uses
>    __flush_tlb_all() which flushes mappings only on current CPU.
> 
> Unmapping EFI boot services code/data regions will result in clearing
> PAGE_PRESENT bit and it shouldn't bother L1TF cases because it's already
> handled by protnone_mask() at arch/x86/include/asm/pgtable-invert.h.
> 
> [1] efi_reserve_boot_services()
> [2] efi_map_region() -> __map_region() -> kernel_map_pages_in_pgd()
> [3] efi_free_boot_services()
> 
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
