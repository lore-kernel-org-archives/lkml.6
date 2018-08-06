Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B00C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED32221A15
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TeZhn0SN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED32221A15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbeHFXLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:11:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHFXLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c7RNYEEpwHcnRB3SHJ0doUBOAYB0Ktoxvs9rsjiA7Kc=; b=TeZhn0SN4eeVdQ2a9xecyktIs
        JNtGPXnq6NrJ2Br6aiiWHJUrbocDWtPVu+JQcwWVuPrEdI9BzvNt7E7mBRp3DXsndhqgL0BcmxOGs
        gDzLQJXn5oTIjOd8hwNVnOar/B3PGfFpu1mYHPyaspPKXO+POzfTp0c8BbHIe6i4UpKG1v+pAG4w8
        DFeq5hoApfhoX0iPIOdkJUT5LgN8qcgZrJ/3/FcTlQ1zexoMcRM0BhH+qppt4oDcreBuTg4i898Nw
        xKMDaRKVTZVob5k6F7WAEelfH8FClEDZuWsx9+gnHAYBl3uLTUECoIxoFZVfCtMc4z8TnwWsU4vrg
        2NV5hAYew==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmmcY-00059k-MI; Mon, 06 Aug 2018 21:00:54 +0000
Subject: Re: [PATCH v2] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
To:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        tklauser@distanz.ch, linux-kernel@vger.kernel.org,
        Marcus Comstedt <marcus@mc.pp.se>
References: <20180804085438.GA15840@infradead.org>
 <20180806204258.22280-1-palmer@sifive.com>
 <20180806204258.22280-2-palmer@sifive.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ba59adba-29d3-1559-e2f2-58f1149ba58c@infradead.org>
Date:   Mon, 6 Aug 2018 14:00:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806204258.22280-2-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 01:42 PM, Palmer Dabbelt wrote:
> This file is expected to be included multiple times in the same file in
> order to allow the __SYSCALL macro to generate system call tables.  With
> a global include guard we end up missing __NR_riscv_flush_icache in the
> syscall table, which results in icache flushes that escape the vDSO call
> to not actually do anything.
> 
> The fix is to move to per-#define include guards, which allows the
> system call tables to actually be populated.  Thanks to Macrus Comstedt
> for finding and fixing the bug!
> 
> I also went ahead and fixed the SPDX header to use a //-style comment,
> which I've been told is the canonical way to do it.
> 
> Cc: Marcus Comstedt <marcus@mc.pp.se>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/riscv/include/asm/unistd.h        |  5 +++++
>  arch/riscv/include/uapi/asm/syscalls.h | 15 +++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
> index 080fb28061de..508be1780323 100644
> --- a/arch/riscv/include/asm/unistd.h
> +++ b/arch/riscv/include/asm/unistd.h
> @@ -11,6 +11,11 @@
>   *   GNU General Public License for more details.
>   */
>  
> +/*
> + * There is explicitly no include guard here because this file is expected to

to .. be .. included

> + * included multiple times.  See uapi/asm/syscalls.h for more info.
> + */
> +
>  #define __ARCH_WANT_SYS_CLONE
>  #include <uapi/asm/unistd.h>
>  #include <uapi/asm/syscalls.h>
> diff --git a/arch/riscv/include/uapi/asm/syscalls.h b/arch/riscv/include/uapi/asm/syscalls.h
> index 818655b0d535..690beb002d1d 100644
> --- a/arch/riscv/include/uapi/asm/syscalls.h
> +++ b/arch/riscv/include/uapi/asm/syscalls.h
> @@ -1,10 +1,13 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2017 SiFive
> + * Copyright (C) 2017-2018 SiFive
>   */
>  
> -#ifndef _ASM__UAPI__SYSCALLS_H
> -#define _ASM__UAPI__SYSCALLS_H
> +/*
> + * There is explicitly no include guard here because this file is expected to
> + * be included multiple times in order to define the syscall macros via

like that one :)

> + * __SYSCALL.
> + */
>  
>  /*
>   * Allows the instruction cache to be flushed from userspace.  Despite RISC-V


-- 
~Randy
