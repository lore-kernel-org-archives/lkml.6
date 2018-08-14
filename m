Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22424C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D505B217BC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D505B217BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbeHNLUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:20:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39910 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbeHNLUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:20:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 075A180D;
        Tue, 14 Aug 2018 01:33:56 -0700 (PDT)
Received: from [10.4.13.92] (e112298-lin.emea.arm.com [10.4.13.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37ED93F5D0;
        Tue, 14 Aug 2018 01:33:54 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: implement ftrace with regs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
References: <20180810160043.9E45568C76@newverein.lst.de>
 <20180810160223.D360D68C76@newverein.lst.de>
 <2b5c1092-2cc0-00ec-ba3d-341dc61452b4@arm.com>
 <20180813220315.6e8dfc9c@vmware.local.home>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <a19d9e23-3dfa-ba9b-a177-cdc0d1035964@arm.com>
Date:   Tue, 14 Aug 2018 09:33:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180813220315.6e8dfc9c@vmware.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/08/18 03:03, Steven Rostedt wrote:
> On Mon, 13 Aug 2018 11:54:06 +0100
> Julien Thierry <julien.thierry@arm.com> wrote:
> 
>>> --- a/arch/arm64/Makefile
>>> +++ b/arch/arm64/Makefile
>>> @@ -78,6 +78,15 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
>>>    KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
>>>    endif
>>>    
>>> +ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>>> +  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
>>> +  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>>> +  ifeq ($(call cc-option,-fpatchable-function-entry=2),)
>>> +    $(warning Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: \
>>> +             -fpatchable-function-entry not supported by compiler)
>>
>> Shouldn't this be an error? The option -fpatchable-function-entry has
>> been added to the CC_FLAGS_FTRACE, so any call to the compiler is gonna
>> break anyway. Or am I missing something?
> 
> I'm guessing this adds a more informative message on that error. One
> will know why -fpatchable-function-entry was added to the CFLAGS. I'm
> for more informative error messages being a victim of poor error
> messages causing me to dig deep into the guts of the build
> infrastructure to figure out simple issues.
> 

Yes, I agree it is better to have this message. My point was that we 
could have "$error" instead of "$warning" to stop the compilation right 
away since we know everything is gonna break (and on parallel builds 
this warning is gonna be drowned in compiler errors).

-- 
Julien Thierry
