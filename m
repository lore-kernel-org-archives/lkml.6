Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933661AbeCSOnS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:43:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755243AbeCSOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:43:15 -0400
Date: Mon, 19 Mar 2018 15:43:10 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, davem@davemloft.net,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        ganeshgr@chelsio.com, nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [RFC PATCH 2/3] x86/io: implement 256-bit IO read and write
In-Reply-To: <6ec3e7e0c70e85a804933f27bb4275d5363c044b.1521469118.git.rahul.lakkireddy@chelsio.com>
Message-ID: <alpine.DEB.2.21.1803191525010.2010@nanos.tec.linutronix.de>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com> <6ec3e7e0c70e85a804933f27bb4275d5363c044b.1521469118.git.rahul.lakkireddy@chelsio.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018, Rahul Lakkireddy wrote:

> Use VMOVDQU AVX CPU instruction when available to do 256-bit
> IO read and write.

That's not what the patch does. See below.

> Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>

That Signed-off-by chain is wrong....

> +#ifdef CONFIG_AS_AVX
> +#include <asm/fpu/api.h>
> +
> +static inline u256 __readqq(const volatile void __iomem *addr)
> +{
> +	u256 ret;
> +
> +	kernel_fpu_begin();
> +	asm volatile("vmovdqu %0, %%ymm0" :
> +		     : "m" (*(volatile u256 __force *)addr));
> +	asm volatile("vmovdqu %%ymm0, %0" : "=m" (ret));
> +	kernel_fpu_end();
> +	return ret;

You _cannot_ assume that the instruction is available just because
CONFIG_AS_AVX is set. The availability is determined by the runtime
evaluated CPU feature flags, i.e. X86_FEATURE_AVX.

Aside of that I very much doubt that this is faster than 4 consecutive
64bit reads/writes as you have the full overhead of
kernel_fpu_begin()/end() for each access.

You did not provide any numbers for this so its even harder to
determine.

As far as I can tell the code where you are using this is a debug
facility. What's the point? Debug is hardly a performance critical problem.

Thanks,

	tglx
