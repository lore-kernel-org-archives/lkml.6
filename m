Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbeBZKtq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:49:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50762 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbeBZKto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:49:44 -0500
Date: Mon, 26 Feb 2018 11:49:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180226104921.GA4377@pd.tnic>
References: <1519629838-4898-1-git-send-email-wanpengli@tencent.com>
 <20180226094148.GA15539@pd.tnic>
 <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 06:06:42PM +0800, Wanpeng Li wrote:
> I think it is the host admin(e.g. cloud provider)'s responsibility to
> set an expected microcode revision.

+       vcpu->arch.microcode_version = 0x1;

That already looks pretty arbitrary and non-sensical to me.

>In addition, the non-sensical value which is written by the guest will
>not reflect to guest-visible microcode revision and just be ignored in
>this implementation.

Huh? How so?

So a guest will have *two* microcode revisions - both of which are most
likely wrong?!

This whole thing sounds like the wrong approach to me.

> Linux (among the others) has checks to make sure that certain features
> aren't enabled on a certain family/model/stepping if the microcode version
> isn't greater than or equal to a known good version.

It sounds to me like the proper fix is to make the kernel *not* look at
microcode revisions when running virtualized. The same way we're not
loading microcode in a guest:

        if (native_cpuid_ecx(1) & BIT(31))

Letting userspace control the microcode revision number is revision
number management SNAFU waiting to happen IMO.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
