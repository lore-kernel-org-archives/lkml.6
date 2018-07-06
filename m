Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A071C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C70723EF1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C70723EF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932310AbeGFI5T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:57:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32806 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753755AbeGFI5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:57:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F0DFED1;
        Fri,  6 Jul 2018 01:57:17 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D1B03F2EA;
        Fri,  6 Jul 2018 01:57:15 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] arm64/mm: Make __enable_mmu() take the ttbr1 page
 as an argument
To:     Jun Yao <yaojun8558363@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-3-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <faf6dcaf-6f52-6bdf-c66d-0bfe1a1dc181@arm.com>
Date:   Fri, 6 Jul 2018 09:57:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702111659.25570-3-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 02/07/18 12:16, Jun Yao wrote:
> Make __enable_mmu() take the physical address of the ttbr1 page as
> an argument.

> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 3f99c59ba193..a1c7a4d3b9f3 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -760,6 +761,7 @@ ENDPROC(__secondary_switched)
>   * Enable the MMU.
>   *
>   *  x0  = SCTLR_EL1 value for turning on the MMU.
> + *  x26 = TTBR1_EL1 value for turning on the MMU.

This works, but I'd really like as many assembly functions as possible to follow
the PCS [0]. We don't want the assembly code to become a maze of register-usage,
sticking to the existing conventions makes it predictable.

Passing arguments in callee-saved registers looks weird, and its just to avoid
shuffling the existing users of x1/x2 up.

e.g. something like movign the existing use of {x1, x2} -> {x5, x6}:
----------%<----------
-       mrs     x1, ID_AA64MMFR0_EL1
-       ubfx    x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
-       cmp     x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
+       mrs     x5, ID_AA64MMFR0_EL1
+       ubfx    x6, x5, #ID_AA64MMFR0_TGRAN_SHIFT, 4
+       cmp     x6, #ID_AA64MMFR0_TGRAN_SUPPORTED
        b.ne    __no_granule_support
-       update_early_cpu_boot_status 0, x1, x2
-       adrp    x1, idmap_pg_dir
-       adrp    x2, swapper_pg_dir
-       phys_to_ttbr x3, x1
-       phys_to_ttbr x4, x2
+       update_early_cpu_boot_status 0, x5, x6
+
+       adrp    x5, idmap_pg_dir
+       phys_to_ttbr x3, x5
+       phys_to_ttbr x4, x1
----------%<----------


Thanks,

James

[0] http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055b/IHI0055B_aapcs64.pdf
