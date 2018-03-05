Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeCEQsR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:48:17 -0500
Received: from mail-ot0-f181.google.com ([74.125.82.181]:46639 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCEQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:48:16 -0500
X-Google-Smtp-Source: AG47ELvb6t8Sl9qrQsKEHLTN1czZ3LH0NHHYN8l5TAlOjFVkQANqxgWh+D0DBSujfWHJJRycR9I1vzbvNeqMlI32MFQ=
MIME-Version: 1.0
In-Reply-To: <86o9k63f7a.wl-marc.zyngier@arm.com>
References: <20180215175803.6870-1-marc.zyngier@arm.com> <db215c1e-0ce8-32e4-d131-e790bebf353e@redhat.com>
 <86o9k63f7a.wl-marc.zyngier@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 16:47:55 +0000
Message-ID: <CAFEAcA8XYV=oSX81ON4CGDt0kfG1cgROqj30OC2Ov=bYhLSYig@mail.gmail.com>
Subject: Re: [REPOST PATCH] arm/arm64: KVM: Add PSCI version selection API
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Auger Eric <eric.auger@redhat.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 March 2018 at 11:11, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Fri, 02 Mar 2018 10:44:48 +0000,
> Auger Eric wrote:
>> I understand the get/set is called as part of the migration process.
>> So my understanding is the benefit of this series is migration fails in
>> those cases:
>>
>> >=0.2 source -> 0.1 destination
>> 0.1 source -> >=0.2 destination
>
> It also fails in the case where you migrate a 1.0 guest to something
> that cannot support it.

I think it would be useful if we could write out the various
combinations of source, destination and what we expect/want to
have happen. My gut feeling here is that we're sacrificing
exact migration compatibility in favour of having the guest
automatically get the variant-2 mitigations, but it's not clear
to me exactly which migration combinations that's intended to
happen for. Marc?

If this wasn't a mitigation issue the desired behaviour would be
straightforward:
 * kernel should default to 0.2 on the basis that
   that's what it did before
 * new QEMU version should enable 1.0 by default for virt-2.12
   and 0.2 for virt-2.11 and earlier
 * PSCI version info shouldn't appear in migration stream unless
   it's something other than 0.2
But that would leave some setups (which?) unnecessarily without the
mitigation, so we're not doing that. The question is, exactly
what *are* we aiming for?

thanks
-- PMM
