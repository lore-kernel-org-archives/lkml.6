Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB44C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6664B2064C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfAIKOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:14:03 -0500
Received: from foss.arm.com ([217.140.101.70]:40130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbfAIKOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:14:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7071B80D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 02:14:02 -0800 (PST)
Received: from mail-io1-f53.google.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5496D3F70D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 02:14:02 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id m19so5589911ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 02:14:02 -0800 (PST)
X-Gm-Message-State: AJcUuke3sPYtypTMeqh2Wbj3HRpe/OT1gz5sEFV/Tgu6r/zR8dLa3/5P
        w7VxpEcLlrSo2pZUXZyLzWGAdBS+2qz7garB+38=
X-Google-Smtp-Source: ALg8bN4rS9je0ssN9b9Lgrez3YdeI51sDvjbjeHJqVX3jBo8reJXIsHK0pDA/yf1dPMY/68kf+ccQV8QOB02LmhtxBA=
X-Received: by 2002:a6b:b717:: with SMTP id h23mr3180991iof.14.1547028841575;
 Wed, 09 Jan 2019 02:14:01 -0800 (PST)
MIME-Version: 1.0
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-4-git-send-email-amit.kachhap@arm.com> <49474d5f-6f4e-b57d-4b45-94c16d85136c@arm.com>
In-Reply-To: <49474d5f-6f4e-b57d-4b45-94c16d85136c@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Date:   Wed, 9 Jan 2019 15:43:50 +0530
X-Gmail-Original-Message-ID: <CADGdYn7t7-vXNmQxBUxnCWq5UxG8uGJraCnRxjDgwvC0V6y8jA@mail.gmail.com>
Message-ID: <CADGdYn7t7-vXNmQxBUxnCWq5UxG8uGJraCnRxjDgwvC0V6y8jA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] arm64/kvm: add a userspace option to enable
 pointer authentication
To:     James Morse <james.morse@arm.com>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 5, 2019 at 12:05 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Amit,
>
> On 18/12/2018 07:56, Amit Daniel Kachhap wrote:
> > This feature will allow the KVM guest to allow the handling of
> > pointer authentication instructions or to treat them as undefined
> > if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
> > supply this parameter instead of creating a new API.
> >
> > A new register is not created to pass this parameter via
> > SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
> > supplied is enough to select this feature.
>
> What is the motivation for doing this? Doesn't ptrauth 'just' need turning on?
> It doesn't need additional setup to be useable, or rely on some qemu support to
> work properly. There isn't any hidden state that can't be migrated in the usual way.
> Is it just because we don't want to commit to the ABI?
This allows migration of guest to non pointer authenticated supported
systems and hides the extra ptrauth registers.
Basically this suggestion was given by Christoffer
(https://lore.kernel.org/lkml/20180206123847.GY21802@cbox/).
 I don't have strong reservation to have this option and can be
dropped if this doesn't make sense.
>
>
> > diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> > index 5baca42..8c0f338 100644
> > --- a/Documentation/arm64/pointer-authentication.txt
> > +++ b/Documentation/arm64/pointer-authentication.txt
> > @@ -87,7 +87,8 @@ used to get and set the keys for a thread.
> >  Virtualization
> >  --------------
> >
> > -Pointer authentication is not currently supported in KVM guests. KVM
> > -will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
> > -the feature will result in an UNDEFINED exception being injected into
> > -the guest.
> > +Pointer authentication is enabled in KVM guest when virtual machine is
> > +created by passing a flag (KVM_ARM_VCPU_PTRAUTH) requesting this feature
> > +to be enabled. Without this flag, pointer authentication is not enabled
> > +in KVM guests and attempted use of the feature will result in an UNDEFINED
> > +exception being injected into the guest.
>
> > diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> > index cd209f7..e20583a 100644
> > --- a/Documentation/virtual/kvm/api.txt
> > +++ b/Documentation/virtual/kvm/api.txt
> > @@ -2634,6 +2634,10 @@ Possible features:
> >         Depends on KVM_CAP_ARM_PSCI_0_2.
> >       - KVM_ARM_VCPU_PMU_V3: Emulate PMUv3 for the CPU.
> >         Depends on KVM_CAP_ARM_PMU_V3.
> > +     - KVM_ARM_VCPU_PTRAUTH: Emulate Pointer authentication for the CPU.
> > +       Depends on KVM_CAP_ARM_PTRAUTH and only on arm64 architecture. If
> > +       set, then the KVM guest allows the execution of pointer authentication
> > +       instructions or treats them as undefined if not set.
>
> > diff --git a/arch/arm64/kvm/hyp/ptrauth-sr.c b/arch/arm64/kvm/hyp/ptrauth-sr.c
> > index 1bfaf74..03999bb 100644
> > --- a/arch/arm64/kvm/hyp/ptrauth-sr.c
> > +++ b/arch/arm64/kvm/hyp/ptrauth-sr.c
> > @@ -71,3 +71,19 @@ void __hyp_text __ptrauth_switch_to_host(struct kvm_vcpu *vcpu,
> >       __ptrauth_save_state(guest_ctxt);
> >       __ptrauth_restore_state(host_ctxt);
> >  }
> > +
> > +/**
> > + * kvm_arm_vcpu_ptrauth_allowed - checks if ptrauth feature is present in vcpu
> > + *
> > + * @vcpu: The VCPU pointer
> > + *
> > + * This function will be used to enable/disable ptrauth in guest as configured
> > + * by the KVM userspace API.
> > + */
> > +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
> > +{
> > +     if (test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features))
> > +             return true;
> > +     else
> > +             return false;
> > +}
>
> Can't you return the result of test_bit() directly?
ok.
>
>
> Thanks,
>
> James

//Amit
