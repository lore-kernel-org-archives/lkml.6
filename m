Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E11C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBA8208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBA8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388377AbeKPAmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:42:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34768 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387839AbeKPAmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:42:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88451EBD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 06:34:01 -0800 (PST)
Received: from mail-it1-f174.google.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F7353F5CF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 06:34:01 -0800 (PST)
Received: by mail-it1-f174.google.com with SMTP id m15so29483548itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 06:34:01 -0800 (PST)
X-Gm-Message-State: AGRZ1gLStj+biW2Th4UzNvxlOBBsB4ZDL7dNSpwmn+A1UlrVQWaMj27x
        wvldBDH2c/Jq4c3urVUMt+YRomWXsPWNgbhqJdE=
X-Google-Smtp-Source: AFSGD/Ublc2MwsOU+5IrpNoxf/Qxc2NQ7kL0D4E0+fO6ztQfdGz1WaSDGia0xflCjbhe3C2rqv515+IA6rAsWfkEovI=
X-Received: by 2002:a24:e905:: with SMTP id f5-v6mr5298229ith.9.1542292440714;
 Thu, 15 Nov 2018 06:34:00 -0800 (PST)
MIME-Version: 1.0
References: <1539773280-4159-1-git-send-email-amit.kachhap@arm.com>
 <1539773280-4159-3-git-send-email-amit.kachhap@arm.com> <20181102083725.GV12057@e113682-lin.lund.arm.com>
 <20181112223212.5o4ipc5kt5ziuupt@localhost> <20181113134438.GH3835@e113682-lin.lund.arm.com>
In-Reply-To: <20181113134438.GH3835@e113682-lin.lund.arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Date:   Thu, 15 Nov 2018 20:03:49 +0530
X-Gmail-Original-Message-ID: <CADGdYn7Jha7b3qx-Thow-dvHZKHdn93eJE-CzC395OBZkPvAjw@mail.gmail.com>
Message-ID: <CADGdYn7Jha7b3qx-Thow-dvHZKHdn93eJE-CzC395OBZkPvAjw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] arm64/kvm: context-switch ptrauth registers
To:     christoffer.dall@arm.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, drjones@redhat.com,
        marc.zyngier@arm.com, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, kristina.martsenko@arm.com,
        kvmarm@lists.cs.columbia.edu, ramana.radhakrishnan@arm.com,
        Dave Martin <Dave.Martin@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 7:16 PM Christoffer Dall
<christoffer.dall@arm.com> wrote:
>
> On Mon, Nov 12, 2018 at 10:32:12PM +0000, Catalin Marinas wrote:
> > On Fri, Nov 02, 2018 at 09:37:25AM +0100, Christoffer Dall wrote:
> > > On Wed, Oct 17, 2018 at 04:17:55PM +0530, Amit Daniel Kachhap wrote:
> > > > From: Mark Rutland <mark.rutland@arm.com>
> > > >
> > > > When pointer authentication is supported, a guest may wish to use it.
> > > > This patch adds the necessary KVM infrastructure for this to work.
> > > >
> > > > When we schedule a vcpu, we enable guest usage of pointer
> > > > authentication instructions and accesses to the keys. After these are
> > > > enabled, we allow context-switching the keys.
> > > >
> > > > Pointer authentication consists of address authentication and generic
> > > > authentication, and CPUs in a system might have varied support for
> > > > either. Where support for either feature is not uniform, it is hidden
> > > > from guests via ID register emulation, as a result of the cpufeature
> > > > framework in the host.
> > > >
> > > > Unfortunately, address authentication and generic authentication cannot
> > > > be trapped separately, as the architecture provides a single EL2 trap
> > > > covering both. If we wish to expose one without the other, we cannot
> > > > prevent a (badly-written) guest from intermittently using a feature
> > > > which is not uniformly supported (when scheduled on a physical CPU which
> > > > supports the relevant feature). When the guest is scheduled on a
> > > > physical CPU lacking the feature, these attempts will result in an UNDEF
> > > > being taken by the guest.
> > > >
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> > > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > > Cc: Christoffer Dall <christoffer.dall@arm.com>
> > > > Cc: kvmarm@lists.cs.columbia.edu
> > [...]
> > > Two questions:
> > >
> > >  - Can we limit all ptrauth functionality to VHE systems so that we
> > >    don't need to touch the non-VHE path and so that we don't need any of
> > >    the __hyp_text stuff?
> >
> > I would say yes. ARMv8.3 implies v8.1, so can enable ptrauth only when
> > VHE is built into the kernel and present in the CPU implementation.
> >
>
> Sounds good.
>
> > >  - Can we move all the save/restore logic to vcpu load/put as long as
> > >    the host kernel itself isn't using ptrauth, and if the host kernel at
> > >    some point begins to use ptrauth, can we have a hook to save/restore
> > >    at that time (similar to what we do for FPSIMD) to avoid this
> > >    overhead on every switch?
> >
> > We will probably enable ptrauth for the kernel as well fairly soon, so I
> > don't think we should base the KVM assumption on the no ptrauth in
> > kernel use-case.
> >
>
> I assume in this case ptrauth will be used for all of the kernel,
> including most of the KVM code?
>
> In that case, I wonder if we always need to context-switch ptrauth
> configruation state or if we can be lazy until the guest actually uses
> the feature?

Sorry for the delayed reply. Lazy switching is possible and was
present in earlier Mark's Rutland v2 version.
However  removed it from v3 version as a mandatory user option to
enable ptrauth is added and to make it look
simpler. But yes both can exist together but with 1 trap cost if guest
always uses ptrauth.

Thanks,
Amit
>
>
> Thanks,
>
>     Christoffer
