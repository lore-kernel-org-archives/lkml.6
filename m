Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9261C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61CB217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfAVNtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:49:55 -0500
Received: from foss.arm.com ([217.140.101.70]:53702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfAVNty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:49:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73030EBD;
        Tue, 22 Jan 2019 05:49:54 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1229B3F614;
        Tue, 22 Jan 2019 05:49:51 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To:     Torsten Duwe <duwe@lst.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        "Singh, Balbir" <bsingharora@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <bdcbdda9-d9e8-20e5-429e-35473ade56cc@arm.com>
 <20190122132832.GB16778@lst.de>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <72a3bb44-60d6-daba-0c9b-099eab2d05e7@arm.com>
Date:   Tue, 22 Jan 2019 13:49:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122132832.GB16778@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/01/2019 13:28, Torsten Duwe wrote:
> On Tue, Jan 22, 2019 at 10:18:17AM +0000, Julien Thierry wrote:
>> Hi Torsten,
>>
>> A few suggestions below.
>>
>>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>>> +#define ARCH_SUPPORTS_FTRACE_OPS 1
>>> +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
>>> +/* All we need is some magic value. Simply use "_mCount:" */
>>
>> Nit: Should the casing be "_mcount" ?
> 
> No! The string makes it clear what it's supposed to be and the peculiar
> casing makes it unique and leaves no doubt were it came from. So whenever
> you see this register value in a crash dump you don't have to wonder about
> weird linkage errors, as it surely did not originate from a symtab.
> 

Right, I had missed the point that the value below is actually the
binary representation of that string. Things make more sense now, thanks.

>>> +#define MCOUNT_ADDR		(0x5f6d436f756e743a)
>>> +#else
>>> +#define REC_IP_BRANCH_OFFSET 0
>>> +#define MCOUNT_ADDR		((unsigned long)_mcount)
>>> +#endif
>>> +


-- 
Julien Thierry
