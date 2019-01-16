Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE643C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53BA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404405AbfAPP4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:56:30 -0500
Received: from foss.arm.com ([217.140.101.70]:51478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfAPP43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:56:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6667A78;
        Wed, 16 Jan 2019 07:56:28 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481B53F7D7;
        Wed, 16 Jan 2019 07:56:26 -0800 (PST)
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
To:     Mark Rutland <mark.rutland@arm.com>,
        Balbir Singh <bsingharora@gmail.com>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
 <20190114121359.GB26056@350D>
 <20190114122616.GD10258@lakrids.cambridge.arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <e82df4bd-804e-de46-d1d9-93b56f9db9c8@arm.com>
Date:   Wed, 16 Jan 2019 15:56:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114122616.GD10258@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/01/2019 12:26, Mark Rutland wrote:
> On Mon, Jan 14, 2019 at 11:13:59PM +1100, Balbir Singh wrote:
>> On Fri, Jan 04, 2019 at 05:50:18PM +0000, Mark Rutland wrote:
>>> Hi Torsten,
>>>
>>> On Fri, Jan 04, 2019 at 03:10:53PM +0100, Torsten Duwe wrote:
>>>> Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
>>>> of each function. Replace the first NOP thus generated with a quick LR
>>>> saver (move it to scratch reg x9), so the 2nd replacement insn, the call
>>>> to ftrace, does not clobber the value. Ftrace will then generate the
>>>> standard stack frames.
>>
>> Do we know what the overhead would be, if this was a link time change
>> for the first instruction?
> 
> No, but it should be possible to benchamrk that for a given workload,
> which is what I'd like to see.
> 

So, I hacked up something to have the -fpachable-function-entry=2 in the
build and then have ftrace_init() patch in the "mov x9, lr" in the first
nop of the function preludes.

I tested it on a 8 x Cortex A-57 machine and compared with a version
that just has the two nops in the function prelude.

On workloads like hackbench, the average difference is within the noise
(<1%). Time results below are in seconds.

	+------------+--------------------+
	| "nop; nop" | "mov x9, lr; nop"  |
	+------------+--------------------+
	|     43.497 |             42.694 |
	|     43.464 |             43.148 |
	|     43.599 |             43.131 |
	|     43.785 |              43.63 |
	|     43.458 |             43.281 |
	|       44.3 |             43.328 |
	|     43.541 |             43.059 |
	|     43.529 |             43.298 |
	|      43.58 |             43.937 |
	|     43.385 |             43.122 |
	|     43.514 |             43.825 |
	|     45.508 |             43.268 |
	|     43.757 |             43.316 |
	|     43.392 |             43.146 |
	|     44.029 |             43.236 |
	|     43.515 |             43.139 |
	|      43.22 |             43.108 |
	|     43.496 |             43.836 |
	|     43.669 |             43.083 |
	|     43.388 |              43.38 |
	+------------+--------------------+
average	|    43.6813 |           43.29825 |
	+------------+--------------------+


On a kernel build from defconfig, there seems to be around 5%
difference, but funnily enough it's the version with "mov x9, lr" that
seems faster (but maybe that might be caused by delays from the disk or
other IO related stuff).

I'll try a bit more runs of the kernel builds to make sure, but having
"mov x9, lr; nop" does not appear to deteriorate the performance
compared to "nop; nop" as function prelude.

Cheers,

-- 
Julien Thierry
