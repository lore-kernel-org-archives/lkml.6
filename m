Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA9C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E54721570
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E54721570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeHUSzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:55:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbeHUSzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:55:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ABFA7A9;
        Tue, 21 Aug 2018 08:34:46 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA72C3F5BC;
        Tue, 21 Aug 2018 08:34:44 -0700 (PDT)
Subject: Re: bisected - arm64 kvm unit test failures
To:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
 <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
 <1532864867.1618.32.camel@gmx.de> <1532967899.30205.62.camel@gmx.de>
 <1533061729.12487.26.camel@gmx.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <c96d252c-6ed7-320e-0d47-c4b78af20ce0@arm.com>
Date:   Tue, 21 Aug 2018 16:34:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533061729.12487.26.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 31/07/18 19:28, Mike Galbraith wrote:
> On Mon, 2018-07-30 at 18:24 +0200, Mike Galbraith wrote:
>> On Sun, 2018-07-29 at 13:47 +0200, Mike Galbraith wrote:
>>> FYI, per kvm unit tests, 4.16-rt definitely has more kvm issues.
> 
> But it's not RT, or rather most of it isn't...
> 
>>> huawei5:/abuild/mike/kvm-unit-tests # uname -r
>>> 4.16.18-rt11-rt
>>> huawei5:/abuild/mike/kvm-unit-tests # ./run_tests.sh
>>> PASS selftest-setup (2 tests)
>>> FAIL selftest-vectors-kernel 
>>> FAIL selftest-vectors-user 
>>> PASS selftest-smp (65 tests)
>>> PASS pci-test (1 tests)
>>> PASS pmu (3 tests)
>>> FAIL gicv2-ipi 
>>> FAIL gicv3-ipi 
>>> FAIL gicv2-active 
>>> FAIL gicv3-active 
>>> PASS psci (4 tests)
>>> FAIL timer 
>>> huawei5:/abuild/mike/kvm-unit-tests #
>>>
>>> 4.14-rt passes all tests.  The above is with the kvm raw_spinlock_t
>>> conversion patch applied, but the 4.12 based SLERT tree I cloned to
>>> explore arm-land in the first place shows only one timer failure, and
>>> has/needs it applied as well, which would seem to vindicate it.
>>>
>>> huawei5:/abuild/mike/kvm-unit-tests # uname -r
>>> 4.12.14-0.gec0b559-rt
>>> huawei5:/abuild/mike/kvm-unit-tests # ./run_tests.sh
>>> PASS selftest-setup (2 tests)
>>> PASS selftest-vectors-kernel (2 tests)
>>> PASS selftest-vectors-user (2 tests)
>>> PASS selftest-smp (65 tests)
>>> PASS pci-test (1 tests)
>>> PASS pmu (3 tests)
>>> PASS gicv2-ipi (3 tests)
>>> PASS gicv3-ipi (3 tests)
>>> PASS gicv2-active (1 tests)
>>> PASS gicv3-active (1 tests)
>>> PASS psci (4 tests)
>>> FAIL timer (8 tests, 1 unexpected failures)
>>
>> FWIW, this single timer failure wass inspired by something in the 4-15
>> merge window.
> 
> As noted, the single timer failure is an RT issue of some sort, and
> remains.  The rest I bisected in @stable with the attached config, and
> confirmed that revert fixes up 4.16-rt as well (modulo singleton).

Could you give that patchlet[1] a go? It solves a similar issue for me
on a different platform.

Thanks,

	M.

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-August/032469.html
-- 
Jazz is not dead. It just smells funny...
