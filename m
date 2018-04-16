Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeDPRPr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:15:47 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:48050 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeDPRPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:15:44 -0400
X-IronPort-AV: E=Sophos;i="5.48,459,1517875200";
   d="scan'208";a="675003615"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "jmattson@google.com" <jmattson@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH 2/2] kvm: nVMX: Introduce KVM_CAP_STATE
Thread-Topic: [PATCH 2/2] kvm: nVMX: Introduce KVM_CAP_STATE
Thread-Index: AQHT0nC6+MLPx/lKCUKGTnSUimWtFqQDmW6AgAAOw4A=
Date: Mon, 16 Apr 2018 17:15:37 +0000
Message-ID: <1523898937.22952.13.camel@amazon.de>
References: <1523545958-28059-1-git-send-email-karahmed@amazon.de>
         <1523545958-28059-2-git-send-email-karahmed@amazon.de>
         <CALMp9eSS4nL1-1i1Df=vyPFT1FZVprPB0Yx-JX0auknNc09Gtg@mail.gmail.com>
In-Reply-To: <CALMp9eSS4nL1-1i1Df=vyPFT1FZVprPB0Yx-JX0auknNc09Gtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C865D56FD93A604FBB6A7AC3A6AEFBD2@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GHFv4Z020926

On Mon, 2018-04-16 at 09:22 -0700, Jim Mattson wrote:
> On Thu, Apr 12, 2018 at 8:12 AM, KarimAllah Ahmed <karahmed@amazon.de> wrote:
> 
> > 
> > v2 -> v3:
> > - Remove the forced VMExit from L2 after reading the kvm_state. The actual
> >   problem is solved.
> > - Rebase again!
> > - Set nested_run_pending during restore (not sure if it makes sense yet or
> >   not).
> 
> This doesn't actually make sense. Nested_run_pending should only be
> set between L1 doing a VMLAUNCH/VMRESUME and the first instruction
> executing in L2. That is extremely unlikely at a restore point.

Yeah, I am afraid I put very little thought into it as I was focused
on the TSC issue :)

Will handle it properly in next version.

> 
> To deal with nested_run_pending and nested save/restore,
> nested_run_pending should be set to 1 before calling
> enter_vmx_non_root_mode, as it was prior to commit 7af40ad37b3f. That
> means that it has to be cleared when emulating VM-entry to the halted
> state (prior to calling kvm_vcpu_halt). And all of the from_vmentry
> arguments that Paolo added when rebasing commit cf8b84f48a59 should be
> removed, so that nested_run_pending is propagated correctly duting a
> restore.
> 
> It should be possible to eliminate this strange little wart, but I
> haven't looked deeply into it.
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
