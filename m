Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B70DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D62621B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WMZaNkXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfBNXtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:49:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38113 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBNXtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550188151; x=1581724151;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=m/m/GY5maHFTnaGubRna8IuXMU1j8X4Gcoz2PKN+T5s=;
  b=WMZaNkXLAooddOH/sEUfbr7zsfb3pKqLIra82v6w3GGn6crRg749VUkX
   xGpOe2Oq6SAAN23vUXTfI1HyBVnbe/FYjAbuK5Oc5Tti6U0ZeXJ5sheXu
   MNSMJkx8nrLUSbuZLQBEi4dF8IhooydsBbhIdHCYrbdVBrhIN1pMvV41o
   DkMHlpsRic2gBKxBpJm8bleMPc3H77AX/nHGGDqiREnIDajkrKolK/E+U
   DK2wSrtZfOXGAKqJeFJEXnU/2bXKiYmvfVutVimubLpARpC3ZkgiYdXle
   OC/TP0oQBdOXE+HMgdjQVeZ2UlKUz2vvYTPh/cVc6j2uCobOTamAfo92/
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,370,1544457600"; 
   d="scan'208";a="101282672"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2019 07:49:10 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 14 Feb 2019 15:27:41 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.47]) ([10.111.66.47])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Feb 2019 15:49:10 -0800
Subject: Re: [v4 PATCH 8/8] RISC-V: Assign hwcap as per comman capabilities.
To:     Palmer Dabbelt <palmer@sifive.com>,
        "johan@kernel.org" <johan@kernel.org>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "schwab@suse.de" <schwab@suse.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <mhng-d7d9894c-d6f6-485b-95e8-962c4ab0f3f1@palmer-si-x1c4>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <e3d0cb05-268a-6148-7723-fe6b94d96583@wdc.com>
Date:   Thu, 14 Feb 2019 15:49:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <mhng-d7d9894c-d6f6-485b-95e8-962c4ab0f3f1@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 4:38 PM, Palmer Dabbelt wrote:
> On Wed, 13 Feb 2019 00:44:42 PST (-0800), johan@kernel.org wrote:
>> On Tue, Feb 12, 2019 at 11:58:10AM -0800, Atish Patra wrote:
>>> On 2/12/19 3:25 AM, Johan Hovold wrote:
>>>> On Tue, Feb 12, 2019 at 03:10:12AM -0800, Atish Patra wrote:
>>>>> Currently, we set hwcap based on first valid hart from DT. This may not
>>>>> be correct always as that hart might not be current booting cpu or may
>>>>> have a different capability.
>>>>>
>>>>> Set hwcap as the capabilities supported by all possible harts with "okay"
>>>>> status.
>>>>>
>>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>>> ---
>>>>>    arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++-------------------
>>>>>    1 file changed, 22 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>>>> index e7a4701f..a1e4fb34 100644
>>>>> --- a/arch/riscv/kernel/cpufeature.c
>>>>> +++ b/arch/riscv/kernel/cpufeature.c
>>>>> @@ -20,6 +20,7 @@
>>>>>    #include <linux/of.h>
>>>>>    #include <asm/processor.h>
>>>>>    #include <asm/hwcap.h>
>>>>> +#include <asm/smp.h>
>>>>>
>>>>>    unsigned long elf_hwcap __read_mostly;
>>>>>    #ifdef CONFIG_FPU
>>>>> @@ -42,28 +43,30 @@ void riscv_fill_hwcap(void)
>>>>>
>>>>>    	elf_hwcap = 0;
>>>>>
>>>>> -	/*
>>>>> -	 * We don't support running Linux on hertergenous ISA systems.  For
>>>>> -	 * now, we just check the ISA of the first "okay" processor.
>>>>> -	 */
>>>>>    	for_each_of_cpu_node(node) {
>>>>> -		if (riscv_of_processor_hartid(node) >= 0)
>>>>> -			break;
>>>>> -	}
>>>>> -	if (!node) {
>>>>> -		pr_warn("Unable to find \"cpu\" devicetree entry\n");
>>>>> -		return;
>>>>> -	}
>>>>> +		unsigned long this_hwcap = 0;
>>>>>
>>>>> -	if (of_property_read_string(node, "riscv,isa", &isa)) {
>>>>> -		pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>>>>> -		of_node_put(node);
>>>>> -		return;
>>>>> -	}
>>>>> -	of_node_put(node);
>>>>> +		if (riscv_of_processor_hartid(node) < 0)
>>>>> +			continue;
>>>>>
>>>
>>>>> -	for (i = 0; i < strlen(isa); ++i)
>>>>> -		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
>>>>> +		if (of_property_read_string(node, "riscv,isa", &isa)) {
>>>>> +			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>>>>> +			return;
>>>>
>>>> Did you want "continue" here to continue processing the other harts?
>>>
>>> Hmm. If a cpu node doesn't have isa in DT, that means DT is wrong. A
>>> "continue" here will let user space use other harts just with a warning
>>> message?
>>>
>>> Returning here will not set elf_hwcap which forces the user to fix the
>>> DT. I am not sure what should be the defined behavior in this case.
>>>
>>> Any thoughts ?
>>
>> The problem is that the proposed code might still set elf_hwcap -- it
>> all depends on the order of the hart nodes in dt (i.e. it will only be
>> left unset if the first node is malformed).
>>
>> For that reason, I'd say it's better to either bail out (hard or at
>> least with elf_hwcap unset) or to continue processing the other nodes.
>>
>> The former might break current systems with malformed dt, though.
>>
>> And since the harts are expected to have the same ISA, continuing the
>> processing while warning and ignoring the malformed node might be
>> acceptable.
> 
> Handling malformed device trees by providing a warning and an empty HWCAP seems
> like the right way to go to me.
> 

If I understand you correctly, you prefer following things to be done in 
case of malformed DT.

1. Print a warning message
2. Unset the entire HWCAP
3. Return without processing other harts. This will most likely result 
in panic when user space starts.

Is this correct ?

Regards,
Atish
>>
>> Johan
> 

