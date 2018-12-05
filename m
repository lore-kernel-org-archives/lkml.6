Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A14C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6232081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6232081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeLENCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:02:40 -0500
Received: from foss.arm.com ([217.140.101.70]:54050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbeLENCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:02:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0D5FA78;
        Wed,  5 Dec 2018 05:02:39 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0525D3F575;
        Wed,  5 Dec 2018 05:02:37 -0800 (PST)
Subject: Re: [PATCH v6 21/24] arm64: Handle serror in NMI context
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        daniel.thompson@linaro.org, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, joel@joelfernandes.org,
        Dave Martin <dave.martin@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-22-git-send-email-julien.thierry@arm.com>
 <20181204180917.GE19210@arrakis.emea.arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <3ff15164-11db-d3c9-e194-a35facf9971d@arm.com>
Date:   Wed, 5 Dec 2018 13:02:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204180917.GE19210@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 04/12/2018 18:09, Catalin Marinas wrote:
> On Mon, Nov 12, 2018 at 11:57:12AM +0000, Julien Thierry wrote:
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 5f4d9ac..66344cd 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -897,13 +897,17 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
>>  
>>  asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
>>  {
>> -	nmi_enter();
>> +	const bool was_in_nmi = in_nmi();
>> +
>> +	if (!was_in_nmi)
>> +		nmi_enter();
>>  
>>  	/* non-RAS errors are not containable */
>>  	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
>>  		arm64_serror_panic(regs, esr);
>>  
>> -	nmi_exit();
>> +	if (!was_in_nmi)
>> +		nmi_exit();
>>  }
> 
> Do we actually need nmi_enter/exit in the outer do_serror() function?
> Could we just move it to arm64_serror_panic()?

They might need to be here in the future: if we support kernel-first we would
have extra calls in here that need to be in_nmi(), the same if we call out to
APEI to support APCI's NOTIFY_SEI.


Thanks,

James
