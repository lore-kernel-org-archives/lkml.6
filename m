Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0DECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA10B2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA10B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbeIRT77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:59:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57940 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbeIRT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:59:58 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g2Gxx-0003SF-Of; Tue, 18 Sep 2018 16:27:01 +0200
Date:   Tue, 18 Sep 2018 16:27:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
Message-ID: <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
 <20180912133353.20595-5-bigeasy@linutronix.de>
 <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
 <20180914203501.qibhpmueosvkr74w@linutronix.de>
 <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-17 10:37:20 [+0200], Paolo Bonzini wrote:
> > . This is (again)
> > untested since I have no box with this PKRU feature. This only available
> > on Intel's Xeon Scalable, right?
> 
> It is available on QEMU too (the slower JIT thing without KVM, i.e. use
> /usr/bin/qemu-system-x86_64 instead of /usr/bin/qemu-kvm or /usr/bin/kvm).

okay. I managed to get the kernel to report this flag as available now.

> > -	if (preload)
> > -		__fpregs_load_activate(new_fpu, cpu);
> > +	if (!preload)
> > +		return;
> > +
> > +	__fpregs_load_activate(new_fpu, cpu);
> > +
> > +#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> > +	/* Protection keys need to be in place right at context switch time. */
> > +	if (boot_cpu_has(X86_FEATURE_OSPKE)) {
> > +		if (new_fpu->pkru != __read_pkru())
> > +			__write_pkru(new_fpu->pkru);
> > +	}
> > +#endif
> 
> I think this would be before the "if (preload)"?

I did not find an explicit loading of pkru except this "xrestore"
which happens on "preload". From what I saw, preload was always set
except for kernel threads. Based on that, it looks to me like it can be
skipped if there is no FPU/kernel thread.

> > 
> >  	if (boot_cpu_has(X86_FEATURE_OSPKE))
> > -		copy_init_pkru_to_fpregs();
> > +		pkru_set_init_value();
> >  }
> >  
> 
> Likewise, move this to fpu__clear and outside "if
> (static_cpu_has(X86_FEATURE_FPU))"?

okay. But if there is no FPU we did not save/restore the pkru value. Is
this supposed to be an improvement?

> Also, a __read_pkru() seems to be missing in switch_fpu_prepare.

But the value is stored during write_pkru(). So the copy that is saved
should be identical to the value that would be read, correct?

> 
> Thanks,
> 
> Paolo

Sebastian
