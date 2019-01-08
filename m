Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F7BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A6A2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfAHRNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:13:39 -0500
Received: from foss.arm.com ([217.140.101.70]:56528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbfAHRNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:13:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D36DBA78;
        Tue,  8 Jan 2019 09:13:38 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B7F13F5AF;
        Tue,  8 Jan 2019 09:13:37 -0800 (PST)
Subject: Re: [PATCH 1/3] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
 <154502884653.30629.3172839440883293817.stgit@devbox>
 <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
 <20190108113953.8bc0cc7d196ddba370377217@kernel.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <b4109104-c438-f4c2-352a-d8b0ec47db37@arm.com>
Date:   Tue, 8 Jan 2019 17:13:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190108113953.8bc0cc7d196ddba370377217@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 08/01/2019 02:39, Masami Hiramatsu wrote:
> On Thu, 3 Jan 2019 17:05:18 +0000
> James Morse <james.morse@arm.com> wrote:
>> On 17/12/2018 06:40, Masami Hiramatsu wrote:
>>> Move extable address check into arch_prepare_kprobe() from
>>> arch_within_kprobe_blacklist().
>>
>> I'm trying to work out the pattern for what should go in the blacklist, and what
>> should be rejected by the arch code.
>>
>> It seems address-ranges should be blacklisted as the contents don't matter.
>> easy-example: the idmap text.
> 
> Yes, more precisely, the code smaller than a function (symbol), it must be
> rejected by arch_prepare_kprobe(), since blacklist is poplated based on
> kallsyms.

Ah, okay, so the pattern is the blacklist should only be for whole symbols,
(which explains why its usually based on sections).

I see kprobe_add_ksym_blacklist() would go wrong if you give it something like:
platform_drv_probe+0x50/0xb0, as it will log platform_drv_probe+0x50 as the
start_addr and platform_drv_probe+0x50+0xb0 as the end.

But how does anything from the arch code's blacklist get into the
kprobe_blacklist list?

We don't have an arch_populate_kprobe_blacklist(), so rely on
within_kprobe_blacklist() calling arch_within_kprobe_blacklist() with the
address, as well as walking kprobe_blacklist.

Is this cleanup ahead of a series that does away with
arch_within_kprobe_blacklist() so that debugfs list is always complete?


> As I pointed, the exception_table contains some range of code which inside
> functions, must be smaller than function.
> Since those instructions are expected to cause exception (that is main reason
> why it can not be probed on arm64), I thought such situation was similar to
> the limitation of instruction.
> 
> So I think below will be better.
> ----
> Please do not blacklisting instructions on exception_table,
> since those are smaller than one function.
> ----

I keep tripping over this because the exception_table lists addresses that are
allowed to fault. Nothing looks at the instruction, and we happily kprobe the
same instruction elsewhere.

(based on my assumptions about where you are going next!,), How about:
| The blacklist is exposed via debugfs as a list of symbols. extable entries are
| smaller, so must be filtered out by arch_prepare_kprobe().

(only we currently have more than one blacklist...)


Thanks,

James
