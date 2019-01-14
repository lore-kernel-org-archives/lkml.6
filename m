Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F888C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F9F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfANRZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:25:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfANRZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:25:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1692BA78;
        Mon, 14 Jan 2019 09:25:05 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24033F5BD;
        Mon, 14 Jan 2019 09:25:02 -0800 (PST)
Subject: Re: [PATCH v8 01/26] arm64: Fix HCR.TGE status for NMI contexts
To:     Julien Thierry <julien.thierry@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        linux-arch@vger.kernel.org, daniel.thompson@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, christoffer.dall@arm.com,
        joel@joelfernandes.org
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-2-git-send-email-julien.thierry@arm.com>
 <20190114155634.GB84430@arrakis.emea.arm.com>
 <229aade3-5bb3-aad4-bd9a-d6220db836c0@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <41c6dc69-3bdc-2ea1-4862-5f4df9b843dd@arm.com>
Date:   Mon, 14 Jan 2019 17:25:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <229aade3-5bb3-aad4-bd9a-d6220db836c0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 14/01/2019 16:12, Julien Thierry wrote:
> On 14/01/2019 15:56, Catalin Marinas wrote:
>> On Tue, Jan 08, 2019 at 02:07:19PM +0000, Julien Thierry wrote:
>>> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
>>> to interract with guest TLBs, switching from EL2&0 translation regime
>>> to EL1&0.
>>>
>>> However, some non-maskable asynchronous event could happen while TGE is
>>> cleared like SDEI. Because of this address translation operations
>>> relying on EL2&0 translation regime could fail (tlb invalidation,
>>> userspace access, ...).
>>
>> Why would an NMI context need to access user space? (just curious what
>> breaks exactly without this patch; otherwise it looks fine)
> 
> If I remember correctly, the SDEI interrupt might perform cache
> maintenance with EL2&0 translation regime, but James can probably give
> more detail (or correct me if I'm wrong).

Yup, spot on.
The APEI driver has to map/unmap memory using the fixmap. If it interrupts a
guest, the TLB maintenance would affect EL1&0 instead.


> Otherwise, if we decide to use the pseudo NMI for profiling with perf, I
> believe the perf interrupt can access user space (although I'm not
> completely sure whether that might be to record profiling data in
> buffers shared with user space or something else).

It does a stack walk, I think its the PERF_SAMPLE_CALLCHAIN feature, and the
code is:
arch/arm64/kernel/perf_callchain.c::user_backtrace()


Thanks,

James
