Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D1FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B652064C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfAIKQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:16:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40232 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbfAIKQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:16:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DC3180D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 02:16:38 -0800 (PST)
Received: from mail-io1-f54.google.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0212D3F70D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 02:16:38 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id f4so5603545ion.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 02:16:37 -0800 (PST)
X-Gm-Message-State: AJcUukcOJza/zqb+eX4YZjJM6Kxj5d6R/3L0pg4tE4p5Gv9igje3F1+1
        Db3mIQRON+yeg2FJosUtlnrVXuNl9C21ySuD9rw=
X-Google-Smtp-Source: ALg8bN4q0RONROXhot3X814LR9sbULrqqBstUpCX9WJYcaQLikAnaAZOcBUnueE6h/lYTG6avqMBSMrfEg2IQdzK+bM=
X-Received: by 2002:a6b:b717:: with SMTP id h23mr3185349iof.14.1547028997269;
 Wed, 09 Jan 2019 02:16:37 -0800 (PST)
MIME-Version: 1.0
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-5-git-send-email-amit.kachhap@arm.com> <33542a00-23f4-b159-91f5-f05d3afa5b9f@arm.com>
In-Reply-To: <33542a00-23f4-b159-91f5-f05d3afa5b9f@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Date:   Wed, 9 Jan 2019 15:46:25 +0530
X-Gmail-Original-Message-ID: <CADGdYn6KxdPXdFEgMfVbiynCnq+ODAQUgKHC6AseNEB-i3QHnw@mail.gmail.com>
Message-ID: <CADGdYn6KxdPXdFEgMfVbiynCnq+ODAQUgKHC6AseNEB-i3QHnw@mail.gmail.com>
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

Hi,

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
Yes will do.
>
> (I'm still unsure if we need to hide this as a user-controlled policy)
>
>
> Thanks,
>
> James
//Amit
