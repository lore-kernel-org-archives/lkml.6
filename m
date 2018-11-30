Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8164DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A6E20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A6E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeK3XYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:24:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37302 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeK3XYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:24:10 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gShhC-00038v-Ct; Fri, 30 Nov 2018 13:14:58 +0100
Date:   Fri, 30 Nov 2018 13:14:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Norbert Manthey <nmanthey@amazon.de>
cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>, Nicolai Stange <nstange@suse.de>,
        Jan Beulich <JBeulich@suse.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] io_apic: initialize irq with -EINVAL
In-Reply-To: <1543403393-6004-1-git-send-email-nmanthey@amazon.de>
Message-ID: <alpine.DEB.2.21.1811301239460.17702@nanos.tec.linutronix.de>
References: <1543403393-6004-1-git-send-email-nmanthey@amazon.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert,

On Wed, 28 Nov 2018, Norbert Manthey wrote:

thanks for the patch.

> Subject: [PATCH] io_apic: initialize irq with -EINVAL

io_apic is not a proper subsystem prefix. git log should give you a hint:

   x86/ioapic: ....

Also please start the first word after the colon with an uppercase letter.

Now 'Initialize irq with -EINVAL' is not really informative. It tells what
the patch does, but does not give a consise hint, what this is about and
why you want to do it. Something like:

   x86/ioapic: Prevent uninitialized return value

provides precise information about the scope of the patch.

> To catch the case where the uninitialized variable irq might be
> returned.

I had to read this incomplete sentence 3 times until I discovered that this
is the second part of the subject line. Please don't do that.

> As the path that might lead to this situation can only
> occur based on invalid arguments, we initialize this variable with
> the value -EINVAL, so that callers are notified accordingly, and no
> uninitialized value is returned.
> 
> The path that would allow to return an uninitialized value for the
> variable irq would require legacy IRQs without the ALLOC flag.

Ideally you describe the problem first and not elaborate lengthy on the
solution, because the solution is obvious once the problem is
clear. Something like this:

  mp_map_pin_to_irq() has an exit path which returns an uninitialized
  variable. This is reached, when  called with arguments ......

  Initialize 'irq' with -EINVAL to prevent that.

> Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

This SOB chain is wrong. How is David involved in this? If he co-developed
the patch, then a 'Co-Developed-by: David...' tag is missing. If not, then
his SOB is just wrong here.

> ---
>  arch/x86/kernel/apic/io_apic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 2953bbf..219dbc1 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1031,7 +1031,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
>  static int mp_map_pin_to_irq(u32 gsi, int idx, int ioapic, int pin,
>  			     unsigned int flags, struct irq_alloc_info *info)
>  {
> -	int irq;
> +	int irq = -EINVAL;
>  	bool legacy = false;
>  	struct irq_alloc_info tmp;
>  	struct mp_chip_data *data;

Now, lets look at the actual error path:

        if (!(flags & IOAPIC_MAP_ALLOC)) {
                if (!legacy) {
                        irq = irq_find_mapping(domain, pin);
                        if (irq == 0)
                                irq = -ENOENT;
                }
		 <----------- (i.e. if legacy == true)
	}

That looks about right, but to get there something must set legacy to
'true' and the only code path which does so is:

        if (idx >= 0 && test_bit(mp_irqs[idx].srcbus, mp_bus_not_pci)) {
                irq = mp_irqs[idx].srcbusirq;
                legacy = mp_is_legacy_irq(irq);
        }

and this code path actually initializes 'irq'. So returning uninitialized
'irq' cannot happen.

How did you find that? Code inspection, static checker, ... ?

Thanks,

	tglx
