Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597F4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3972147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3972147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbeHPQ5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:57:50 -0400
Received: from foss.arm.com ([217.140.101.70]:37064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbeHPQ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:57:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915BF80D;
        Thu, 16 Aug 2018 06:59:02 -0700 (PDT)
Received: from [10.4.12.39] (e113632-lin.emea.arm.com [10.4.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E2673F5D0;
        Thu, 16 Aug 2018 06:59:01 -0700 (PDT)
Subject: Re: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
To:     Will Deacon <will.deacon@arm.com>,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
 <20180816102219.GF31093@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <6490931d-65b6-e524-f2d0-65cbac0a263b@arm.com>
Date:   Thu, 16 Aug 2018 14:58:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816102219.GF31093@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/08/18 11:22, Will Deacon wrote:
> Hi Tuomas, [+John]
> 
> On Thu, Aug 16, 2018 at 02:38:51AM +0300, Tuomas Tynkkynen wrote:
>> Booting Linus's master of today with the usual arm64 defconfig fails for
>> me on the Hikey960 board. I've bisected it down to:
>>
>> commit 693350a7998018391852c48f68956cf0f855b2b9 (HEAD, refs/bisect/bad)
>> Author: Will Deacon <will.deacon@arm.com>
>> Date:   Tue Jun 19 17:55:28 2018 +0100
>>
>>     arm64: insn: Don't fallback on nosync path for general insn patching
>>
>> Here's the boot log with earlycon enabled after which the boot hangs:
> 
> Thanks for the boot log, that's really helpful. Please can you try the diff
> below?
> 

I get the same "BUG: scheduling while atomic" when running the current master
(f91e654474d413201ae578820fb63f8a811f6c4e), and confirmed that I don't get
it on my setup when checking out the direct parent of 693350a7998018391852c48f68956cf0f855b2b9.

Tried out the diff and the board doesn't seem to die anymore, so FWIW:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

> Out of interest -- do you know if Hikey960 is used by any boot-testing
> farms? The patch above has been in linux-next for ages, but we didn't see
> any complaints until it hit mainline :(
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
> index c2dd1ad3e648..e0756416e567 100644
> --- a/arch/arm64/kernel/jump_label.c
> +++ b/arch/arm64/kernel/jump_label.c
> @@ -36,7 +36,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  		insn = aarch64_insn_gen_nop();
>  	}
>  
> -	aarch64_insn_patch_text(&addr, &insn, 1);
> +	aarch64_insn_patch_text_nosync(addr, insn);
>  }
>  
>  void arch_jump_label_transform_static(struct jump_entry *entry,
> 
