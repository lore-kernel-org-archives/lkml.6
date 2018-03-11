Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeCKBzL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 20:55:11 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:42423 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeCKBzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 20:55:10 -0500
X-Google-Smtp-Source: AG47ELt2AsZjSMTsogRmhLiyoaHQ8VtRA76sJK18AZX2AVIC/u0umADQz/Hbt/PhGUq5eQu4/yjATxAtqB1L06X+Cl0=
MIME-Version: 1.0
In-Reply-To: <86k1ukazr0.wl-marc.zyngier@arm.com>
References: <1520492490-7943-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <9ad47673-068e-f732-d2ca-9c76a8fbdfbc@arm.com> <0a15633d-8944-cb9b-3e6b-b08ee5ec42b9@arm.com>
 <20180308161900.GC1917@lvm> <86r2oubho3.wl-marc.zyngier@arm.com>
 <20180309213612.GD1917@lvm> <86k1ukazr0.wl-marc.zyngier@arm.com>
From: Christoffer Dall <cdall@kernel.org>
Date: Sun, 11 Mar 2018 01:55:08 +0000
X-Google-Sender-Auth: IKcRQCZXeu6sBJzHIJOJWnd-Qik
Message-ID: <CAEDV+g+29ZK6QQEn=2h_77dMZC7wmw+d4MZC-GU-CqeaK_xhMg@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm/arm64: vgic: change condition for level
 interrupt resampling
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Auger Eric <eric.auger@redhat.com>,
        david.daney@cavium.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 12:20 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Fri, 09 Mar 2018 21:36:12 +0000,
> Christoffer Dall wrote:
>>
>> On Thu, Mar 08, 2018 at 05:28:44PM +0000, Marc Zyngier wrote:
>> > I'd be more confident if we did forbid P+A for such interrupts
>> > altogether, as they really feel like another kind of HW interrupt.
>>
>> How about a slightly bigger hammer:  Can we avoid doing P+A for level
>> interrupts completely?  I don't think that really makes much sense, and
>> I think we simply everything if we just come back out and resample the
>> line.  For an edge, something like a network card, there's a potential
>> performance win to appending a new pending state, but I doubt that this
>> is the case for level interrupts.
>
> I started implementing the same thing yesterday. Somehow, it feels
> slightly better to have the same flow for all level interrupts,
> including the timer, and we only use the MI on EOI as a way to trigger
> the next state of injection. Still testing, but looking good so far.
>
> I'm still puzzled that we have this level-but-not-quite behaviour for
> VFIO interrupts. At some point, it is going to bite us badly.
>

Where is the departure from level-triggered behavior with VFIO?  As
far as I can tell, the GIC flow of the interrupts will be just a level
interrupt, but we just need to make sure the resamplefd mechanism is
supported for both types of interrupts.  Whether or not that's a
decent mechanism seems orthogonal to me, but that's a discussion for
another day I think.

Thanks,
-Christoffer
