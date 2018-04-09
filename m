Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeDITYh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:24:37 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:33960 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDITYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:24:35 -0400
X-Google-Smtp-Source: AIpwx4+jmTT7F3qRgznkXYNRhKm+zvgZDLUgQM6kuCupnmN0D4Oba6l+zGd2shh6SOgyOBZEy1SWdLeFQ2O0/2VbFFM=
MIME-Version: 1.0
In-Reply-To: <1523263049-31993-1-git-send-email-karahmed@amazon.de>
References: <1523263049-31993-1-git-send-email-karahmed@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Apr 2018 12:24:34 -0700
Message-ID: <CALMp9eSAK=k21pPsD_AOiDSWsPO88NE4HLYqNJmt_d10pWd1nw@mail.gmail.com>
Subject: Re: [PATCH v2] kvm: nVMX: Introduce KVM_CAP_STATE
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 1:37 AM, KarimAllah Ahmed <karahmed@amazon.de> wrote:

> +       /*
> +        * Force a nested exit that guarantees that any state capture
> +        * afterwards by any IOCTLs (MSRs, etc) will not capture a mix of L1
> +        * and L2 state.
> +        *
> +        * One example where that would lead to an issue is the TSC DEADLINE
> +        * MSR vs the guest TSC. If the L2 guest is running, the guest TSC will
> +        * be the L2 TSC while the TSC deadline MSR will contain the L1 TSC
> +        * deadline MSR. That would lead to a very large (and wrong) "expire"
> +        * diff when LAPIC is initialized during instance restore (i.e. the
> +        * instance will appear to have hanged!).
> +        */

This sounds like a bug in the virtualization of IA32_TSC_DEADLINE.
Without involving save/restore, what happens if L2 sets
IA32_TSC_DEADLINE (and L1 permits it via the MSR permission bitmap)?
The IA32_TSC_DEADLINE MSR is always specified with respect to L1's
time domain.
