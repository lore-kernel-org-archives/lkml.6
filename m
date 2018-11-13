Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BF3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7D122360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7D122360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbeKNCP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:15:58 -0500
Received: from foss.arm.com ([217.140.101.70]:58944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeKNCP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:15:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 943E5A78;
        Tue, 13 Nov 2018 08:17:12 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC193F5CF;
        Tue, 13 Nov 2018 08:17:09 -0800 (PST)
Subject: Re: [PATCH 00/17] ARMv8.3 pointer authentication support
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
Message-ID: <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com>
Date:   Tue, 13 Nov 2018 16:17:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for the really late response!)

On 15/10/2018 23:42, Kees Cook wrote:
> On Fri, Oct 5, 2018 at 1:47 AM, Kristina Martsenko
> <kristina.martsenko@arm.com> wrote:
>> This series adds support for the ARMv8.3 pointer authentication
>> extension. The series contains Mark's original patches to enable pointer
>> authentication for userspace [1], followed by early RFC patches using
>> pointer authentication in the kernel.
> 
> It wasn't obvious to me where the PAC mismatch exceptions will be
> caught. I'm mainly curious to compare the PAC exception handling to
> the existing stack-protector panic(). Can you point me to which
> routines manage that? (Perhaps I just missed it in the series...)

When the PAC authentication fails, it doesn't actually generate an
exception, it just flips a bit in the high-order bits of the pointer,
making the pointer invalid. Then when the pointer is dereferenced (e.g.
as a function return address), it generates the usual type of exception
for an invalid address.

So when a function return fails in user mode, the exception is handled
in __do_user_fault and a forced SIGSEGV is delivered to the task. When a
function return fails in kernel mode, the exception is handled in
__do_kernel_fault and the task is killed.

This is different from stack protector as we don't panic the kernel, we
just kill the task. It would be difficult to panic as we don't have a
reliable way of knowing that the exception was caused by a PAC
authentication failure (we just have an invalid pointer with a specific
bit flipped). We also don't print out any PAC-related warning.

Thanks,
Kristina
