Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeDQJYi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:24:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55295 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeDQJYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:24:36 -0400
Date: Tue, 17 Apr 2018 11:24:34 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Xiaoming Gao <gxm.linux.kernel@gmail.com>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com
Subject: Re: [PATCH] x86/tsc: fix 64bit divisor be truncated in
 calc_hpet_ref
In-Reply-To: <38894564-4fc9-b8ec-353f-de702839e44e@gmail.com>
Message-ID: <alpine.DEB.2.21.1804171121450.1694@nanos.tec.linutronix.de>
References: <38894564-4fc9-b8ec-353f-de702839e44e@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1533368428-1523957074=:1694"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1533368428-1523957074=:1694
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 13 Apr 2018, Xiaoming Gao wrote:
> From ba3d2fb699c4d8ee61b05d7e70be48b9c4e22baf Mon Sep 17 00:00:00 2001
> From: Xiaoming Gao <newtongao@tencent.com>
> Date: Fri, 13 Apr 2018 17:05:18 +0800
> Subject: [PATCH] x86/tsc: fix 64bit divisor be truncated in calc_hpet_ref
> 
> the HPET frequency got larger on intel skylake, thus could cause tmp to
> exceed 32bits.
> do_div will truncate 64bits tmp to 32bits, so the frequency calced via
> HPET will be wrong, use div64_u64 can fix it.
> 
> Signed-off-by: Xiaoming Gao <newtongao@tencent.com>
> ---
>  arch/x86/kernel/tsc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 9714a7a..8700269 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -160,7 +160,7 @@ static unsigned long calc_hpet_ref(u64 deltatsc, u64
> hpet1, u64 hpet2)
>      hpet2 -= hpet1;
>      tmp = ((u64)hpet2 * hpet_readl(HPET_PERIOD));
>      do_div(tmp, 1000000);
> -    do_div(deltatsc, tmp);
> +    deltatsc = div64_u64(deltatsc, tmp);
> 
>      return (unsigned long) deltatsc;

Please fix your MUA so it does not whitespace damage
patches. Documentation/process/email-clients.rst tells you how to teach
thunderbird to do the right thing.

Attaching the patch does not help either as it breaks the workflow. I've
fixed it up manually this time, but please be more careful next time.

Thanks,

	tglx
--8323329-1533368428-1523957074=:1694--
