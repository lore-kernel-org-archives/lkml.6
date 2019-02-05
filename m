Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB848C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFFD2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfBESQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:16:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33478 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfBESQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:16:05 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gr5GL-0004Am-TX; Tue, 05 Feb 2019 19:16:02 +0100
Date:   Tue, 5 Feb 2019 19:16:01 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 08/22] x86/fpu: Remove user_fpu_begin()
Message-ID: <20190205181601.sshzxcj3wv65vhfm@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-9-bigeasy@linutronix.de>
 <20190125151840.GG27998@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190125151840.GG27998@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-25 16:18:40 [+0100], Borislav Petkov wrote:
> Reviewed-by: Borislav Petkov <bp@suse.de>
thanks.

> Should we do this microoptimization in addition, to save us the
> activation when the kernel thread here:
> 
> 	taskA -> kernel thread -> taskA
> 
> doesn't call kernel_fpu_begin() and thus fpu_fpregs_owner_ctx remains
> the same?

This might work now but at the end of the series this case will be
handled. The switch
	taskA -> kernel thread

will save taskA's registers. The switch
	kernel thread -> taskA

will only set TF flag to restore FPU registers on the return to
userland. The load happens only the ctx pointer is different.

> It would be a bit more correct as it won't invoke the
> trace_x86_fpu_regs_activated() TP in case the FPU context is the same.

The trace point is not wrong. As of now the same context will be loaded
again.

Sebastian
