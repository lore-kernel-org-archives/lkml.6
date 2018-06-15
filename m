Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1909208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1909208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966048AbeFOQZr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:25:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50358 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965957AbeFOQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:25:45 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fTrXi-0003ME-Kg; Fri, 15 Jun 2018 18:25:42 +0200
Date:   Fri, 15 Jun 2018 18:25:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context
 switch
In-Reply-To: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806151815080.1582@nanos.tec.linutronix.de>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Jason A. Donenfeld wrote:
> In a loop this looks like:
> 
> for (thing) {
>   kernel_fpu_begin();
>   encrypt(thing);
>   kernel_fpu_end();
> }
> 
> This is obviously very bad, because begin() and end() are slow, so
> WireGuard does the obvious:
> 
> kernel_fpu_begin();
> for (thing)
>   encrypt(thing);
> kernel_fpu_end();
> 
> This is fine and well, and the crypto API I'm working on will enable

It might be fine crypto performance wise, but it's a total nightmare
latency wise because kernel_fpu_begin() disables preemption. We've seen
latencies in the larger millisecond range due to processing large data sets
with kernel FPU.

If you want to go there then we really need a better approach which allows
kernel FPU usage in preemptible context and in case of preemption a way to
stash the preempted FPU context and restore it when the task gets scheduled
in again. Just using the existing FPU stuff and moving the loops inside the
begin/end section and keeping preemption disabled for arbitrary time spans
is not going to fly.

Thanks,

	tglx


  


