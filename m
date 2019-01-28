Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A91C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EC620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfA1HDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:03:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40036 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfA1HDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:03:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0A3FA78
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:03:04 -0800 (PST)
Received: from mail-it1-f174.google.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 977963F5AF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:03:04 -0800 (PST)
Received: by mail-it1-f174.google.com with SMTP id i145so19038644ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:03:04 -0800 (PST)
X-Gm-Message-State: AJcUukeeACp8MD2TWUWXcG8UvjSdK/Tztr8T2JBCf0tYX6h0ERW5FfKq
        PywpEQbQWOOcJKSYHExuhz1zKwrgyypbtuA5OFg=
X-Google-Smtp-Source: ALg8bN664xwq7reDknsxdCeBBZ8+zo98DEtoj4rF+RVtlyPWTYKQ61nL7fdEC6zgdhIHg6nqVSBJQRmi2PnVERQg/7g=
X-Received: by 2002:a24:7c58:: with SMTP id a85mr9778119itd.9.1548658983837;
 Sun, 27 Jan 2019 23:03:03 -0800 (PST)
MIME-Version: 1.0
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-5-git-send-email-amit.kachhap@arm.com> <33542a00-23f4-b159-91f5-f05d3afa5b9f@arm.com>
In-Reply-To: <33542a00-23f4-b159-91f5-f05d3afa5b9f@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Date:   Mon, 28 Jan 2019 12:32:52 +0530
X-Gmail-Original-Message-ID: <CADGdYn7kcBXO3YbB+QEfS-Aw4O-G-ssQaapRoXCoG6gD08JjAw@mail.gmail.com>
Message-ID: <CADGdYn7kcBXO3YbB+QEfS-Aw4O-G-ssQaapRoXCoG6gD08JjAw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64/kvm: enable pointer authentication
 cpufeature conditionally
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

Hi James,
On Fri, Jan 4, 2019 at 11:32 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Amit,
>
> On 18/12/2018 07:56, Amit Daniel Kachhap wrote:
> > According to userspace settings, pointer authentication cpufeature
> > is enabled/disabled from guests.
>
> This reads like the guest is changing something in the host. Isn't this hiding
> the id-register values from the guest?
I dropped this patch altogether in V5 series and now only key
registers are masked
if userspace disables it.

Thanks,
Amit Daniel
>
>
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 6af6c7d..ce6144a 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1066,6 +1066,15 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
> >                       kvm_debug("SVE unsupported for guests, suppressing\n");
> >
> >               val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> > +     } else if (id == SYS_ID_AA64ISAR1_EL1) {
> > +             const u64 ptrauth_mask = (0xfUL << ID_AA64ISAR1_APA_SHIFT) |
> > +                                      (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> > +                                      (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
> > +                                      (0xfUL << ID_AA64ISAR1_GPI_SHIFT);
> > +             if (!kvm_arm_vcpu_ptrauth_allowed(vcpu)) {
> > +                     kvm_debug("ptrauth unsupported for guests, suppressing\n");
> > +                     val &= ~ptrauth_mask;
> > +             }
>
> I think this hunk should have been in the previous patch as otherwise its a
> bisection oddity.
>
> Could you merge this hunk with the previous patch, and move the mechanical bits
> that pass vcpu around to a prior preparatory patch.
>
> (I'm still unsure if we need to hide this as a user-controlled policy)
>
>
> Thanks,
>
> James
