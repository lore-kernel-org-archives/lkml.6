Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeCWV1z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:27:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42399 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeCWV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:27:54 -0400
Date: Fri, 23 Mar 2018 22:27:51 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
cc: x86 <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/2] x86, msr: add rdmsr_safe_on_cpu_resched() and
 use it in msr_read()
In-Reply-To: <20180319152503.123372-1-edumazet@google.com>
Message-ID: <alpine.DEB.2.21.1803232221550.1481@nanos.tec.linutronix.de>
References: <20180319152503.123372-1-edumazet@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018, Eric Dumazet wrote:

> I noticed high latencies caused by a daemon periodically reading
> various MSR on all cpus. KASAN kernels would see ~10ms latencies
> simply reading one MSR. Even without KASAN, sending IPI to CPU
> in deep sleep state or blocking hard IRQ in a a long section,
> then waiting for the answer can consume hundreds of usec.
> 
> This patch adds rdmsr_safe_on_cpu_resched() which does not spin.
> 
> I use this function from msr_read() but future patches might
> convert other callers to use this variant as well.
> 
> Overall daemon cpu usage was reduced by 35 %,
> and latencies caused by msr_read() disappeared.

Looking at all call sites. None of them is performance critical and all of
them are in preemptible context.

So we simply can switch the rdmsr_safe_on_cpu() implementation over to wait
mode completely.

> +/* Note: This version spins in smp_call_function_single().
> + * Consider using rdmsr_safe_on_cpu_resched() variant instead.

Bah. This is not networking code. x86 uses sensible comment style :)

Thanks,

	tglx
