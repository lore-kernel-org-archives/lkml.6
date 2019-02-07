Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B354FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8776F2080A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBGLtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:49:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37883 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfBGLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:49:49 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1griBa-0008I5-An; Thu, 07 Feb 2019 12:49:42 +0100
Date:   Thu, 7 Feb 2019 12:49:42 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 15/22] x86/entry: Add TIF_NEED_FPU_LOAD
Message-ID: <20190207114941.jzydrry5xpjngyiv@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-16-bigeasy@linutronix.de>
 <20190130115507.GE18383@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130115507.GE18383@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-30 12:55:07 [+0100], Borislav Petkov wrote:
> This definitely needs to be written somewhere in
> 
> arch/x86/include/asm/fpu/internal.h
> 
> or where we decide to put the FPU handling rules.

Added:

Index: staging/arch/x86/include/asm/fpu/internal.h
===================================================================
--- staging.orig/arch/x86/include/asm/fpu/internal.h
+++ staging/arch/x86/include/asm/fpu/internal.h
@@ -537,6 +537,12 @@ static inline void __fpregs_load_activat
  *
  * The FPU context is only stored/restore for user task and ->mm is used to
  * distinguish between kernel and user threads.
+ *
+ * If TIF_NEED_FPU_LOAD is cleared then CPU's FPU registers are holding the
+ * current content of current()'s FPU register state.
+ * If TIF_NEED_FPU_LOAD is set then CPU's FPU registers may not hold current()'s
+ * FPU registers. It is required to load the register before returning to
+ * userland or using the content otherwise.
  */
 static inline void
 switch_fpu_prepare(struct fpu *old_fpu, int cpu)

Sebastian
