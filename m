Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0D1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A7520842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfBYR3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:29:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35420 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbfBYR3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:29:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFDA880D;
        Mon, 25 Feb 2019 09:29:09 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEF673F703;
        Mon, 25 Feb 2019 09:29:08 -0800 (PST)
Subject: Re: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001
To:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        'Will Deacon' <will.deacon@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
References: <8898674D84E3B24BA3A2D289B872026A6A311EAE@G01JPEXMBKW03>
 <20190214155605.GC27547@lakrids.cambridge.arm.com>
 <90347cf4-4d7b-d553-d4db-1bacd000ff75@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A313313@G01JPEXMBKW03>
 <8898674D84E3B24BA3A2D289B872026A6A319D26@G01JPEXMBKW03>
From:   James Morse <james.morse@arm.com>
Message-ID: <d391d125-86a9-82e3-5add-10a15e578dd7@arm.com>
Date:   Mon, 25 Feb 2019 17:29:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A319D26@G01JPEXMBKW03>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

On 23/02/2019 13:06, Zhang, Lei wrote:
> Zhang, Lei wrote:
>> I think you mean it may be a problem to modify the KPTI trampoline because
>> some patches about KPTI will be merged to mainline in the near future.
>> I understood that.
>> I should discuss with my colleagues whether we can set NFDx=0 all of time on
>> A64FX.
> 
> The result of our investigation also supports your suggestion. 
> We surely agree with you that your proposed method (never set NFDx=1 on A64FX)
> is the best to resolve this erratum.
> 	
> For this erratum, James's patch should be merged to mainline
> instead of my previous patches (v1 to v4).
> Since KPTI fully covers the effect of NFD1 for A64FX, KPTI is
> recommended to be used in conjunction with James’s patch.

>> And thanks for your patch.
>> If we can set NFDx=0 all of time, I will review, test and report the result.
> 
> I have already tested James's patch on A64FX, and the result is no problem at all.
> 
> Tested-by:zhang.lei<zhang.lei@jp.fujitsu.com>

Thanks, I'll post it properly with this tag.


>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
>> a4168d366127..b0b7f1c4e816 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -643,6 +643,25 @@ config QCOM_FALKOR_ERRATUM_E1041
>>
>>  	  If unsure, say Y.
>>
>> +config FUJITSU_ERRATUM_010001
>> +	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur wrongly"
>> +	default y
>> +	help
>> +	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
>> +	  On some variants of the Fujitsu-A64FX cores version (1.0, 1.1), memory
>> +	  accesses may cause undefined fault (Data abort, DFSC=0b111111).
>> +	  This fault occurs under a specific hardware condition when a
>> +	  load/store instruction performs an address translation using:
>> +	  case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
>> +	  case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
>> +	  case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
>> +	  case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
>> +
>> +	  The workaround is to ensure these bits are clear in TCR_ELx.
>> +	  The workaround only affect the Fujitsu-A64FX.
> 
> I think it is better to add a notice here as follows:
> 
>   Recommend to enable KPTI (UNMAP_KERNEL_AT_EL0 = y).

That unmap option is on by default, you can't turn it off without CONFIG_EXPERT. While I
agree, I don't think we need to spell this out.


Thanks,

James
