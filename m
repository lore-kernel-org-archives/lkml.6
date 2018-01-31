Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932087AbeAaOfR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:35:17 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:42770 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeAaOfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:35:16 -0500
X-Google-Smtp-Source: AH8x2278dbeaYkNaL2PdBy4nn92j1dnlwKH4q+hIcYmdN0ijQQus1Rd8g7l68X3BvPezgPnwMOKgekbTIe/2FXpFsPc=
MIME-Version: 1.0
In-Reply-To: <49853e5e-f093-2e79-1cfb-182f51fcd6a0@arm.com>
References: <20180129174559.1866-1-marc.zyngier@arm.com> <20180129174559.1866-17-marc.zyngier@arm.com>
 <476d111e-6fb0-9bef-2448-a94d0cc03f45@huawei.com> <49853e5e-f093-2e79-1cfb-182f51fcd6a0@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 31 Jan 2018 14:35:14 +0000
Message-ID: <CAKv+Gu-XidYPh0hi1nzG5m0AO7EfRE6bnKfxCToG+9zsmvzmNg@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP
 hardening support
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VEZNH6025713

On 31 January 2018 at 14:11, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 31/01/18 13:56, Hanjun Guo wrote:
>> Hi Marc,
>>
>> On 2018/1/30 1:45, Marc Zyngier wrote:
>>>  static int enable_psci_bp_hardening(void *data)
>>>  {
>>>      const struct arm64_cpu_capabilities *entry = data;
>>>
>>> -    if (psci_ops.get_version)
>>> +    if (psci_ops.get_version) {
>>> +            if (check_smccc_arch_workaround_1(entry))
>>> +                    return 0;
>>
>> If I'm using the new version SMCCC, the firmware have the choicARM_SMCCC_ARCH_WORKAROUND_1e to decide
>> whether this machine needs the workaround, even if the CPU is vulnerable
>> for CVE-2017-5715, but..
>>
>>> +
>>>              install_bp_hardening_cb(entry,
>>>                                     (bp_hardening_cb_t)psci_ops.get_version,
>>>                                     __psci_hyp_bp_inval_start,
>>>                                     __psci_hyp_bp_inval_end);
>>
>> ..the code above seems will enable get_psci_version() for CPU and will
>> trap to trust firmware even the new version of firmware didn't say
>> we need the workaround, did I understand it correctly?
>
> Well, you only get there if we've established that your CPU is affected
> (it has an entry matching its MIDR with the HARDEN_BRANCH_PREDICTOR
> capability), and that entry points to enable_psci_bp_hardening. It is
> not the firmware that decides whether we need hardening, but the kernel.
> The firmware merely provides a facility to apply the hardening.
>
>> I'm ask this because some platform will not expose to users to
>> take advantage of CVE-2017-5715, and we can use different firmware
>> to report we need such workaround or not, then use a single kernel
>> image for both vulnerable platforms and no vulnerable ones.
>
> You cannot have your cake and eat it. If you don't want to workaround
> the issue, you can disable the hardening. But asking for the same kernel
> to do both depending on what the firmware reports doesn't make much
> sense to me.

The SMCCC v1.1. document does appear to imply that systems that
implement SMCCC v1.1 but don't implement ARM_SMCCC_ARCH_WORKAROUND_1
should be assumed to be unaffected.

"""
If the discovery call returns NOT_SUPPORTED:
• SMCCC_ARCH_WORKAROUND_1 must not be invoked on any PE in the system, and
• none of the PEs in the system require firmware mitigation for CVE-2017-5715.
"""

How to deal with conflicting information in this regard (quirk table
vs firmware implementation) is a matter of policy, of course.
