Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DD9C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8DF20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8DF20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeKHSHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:07:36 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42904 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeKHSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:07:36 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKfkP-0001qg-BY; Thu, 08 Nov 2018 09:33:05 +0100
Date:   Thu, 8 Nov 2018 09:33:04 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 23/23] x86/fpu: Defer FPU state load until return to
 userspace
Message-ID: <20181108083304.trxqwwhw4dgdtogn@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
 <20181107194858.9380-24-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107194858.9380-24-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-07 20:48:58 [+0100], To linux-kernel@vger.kernel.org wrote:
> index 8c03b42416656..d10b60d80d35a 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h

The bot complained about missing definition for local_bh_disable() so I
swapped the preempt.h for bottom_half.h at the beginning of this file.

> @@ -27,17 +27,31 @@ extern void __kernel_fpu_end(void);
>  extern void kernel_fpu_begin(void);
>  extern void kernel_fpu_end(void);
>  extern bool irq_fpu_usable(void);
> +extern void fpregs_mark_activate(void);
>  
>  static inline void __fpregs_changes_begin(void)
>  {
>  	preempt_disable();
> +	local_bh_disable();
>  }
>  
>  static inline void __fpregs_changes_end(void)
>  {
> +	local_bh_enable();
>  	preempt_enable();
>  }

Sebastian
