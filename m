Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E666C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A1320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H65mW9NM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfBVTVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:21:06 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63226 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBVTVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550863266; x=1582399266;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KIzAieqjVYb1fWzUTSzGwIHxVQIUt8sQEG/ZjjqjndQ=;
  b=H65mW9NMK2RYgMNGD0cF5u91krjKjP36Wxos1koqw10p3LChZ/N9Mp0J
   6toy3n9IKNO2ljPnkW/Zutir1gltV3uuEWjmKFo1R5bZ+cZ63ByFg+FXJ
   OUNdg1Ho7TOKqmZsFEPosySJgDUfwyLZukO4X+WRlszPAEdD92ldMssxj
   lvUGzUXQgj1jt7rCd39rBmtv56KDIyjB7TUvPmukU8kYsxpxSs/Gs8vln
   bGHP7NQUzz1PpL4OpK59UxG6CMpBk4rMYrxr+kJGoEKkGZMANzRa6Km+M
   QpdxRJXCnlL8hcjg+AxsNaVxqWJH5zLxp7vhiUdfHubS++j0WboLcJXEa
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,400,1544457600"; 
   d="scan'208";a="207178039"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2019 03:21:05 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 22 Feb 2019 11:01:24 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.76.145]) ([10.111.76.145])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Feb 2019 11:21:06 -0800
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
 <e3d0cb05-268a-6148-7723-fe6b94d96583@wdc.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <a956ae40-52c7-ace8-4756-bde8f6c80230@wdc.com>
Date:   Fri, 22 Feb 2019 11:21:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e3d0cb05-268a-6148-7723-fe6b94d96583@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 3:49 PM, Atish Patra wrote:
> On 2/13/19 4:38 PM, Palmer Dabbelt wrote:
>> On Wed, 13 Feb 2019 00:44:42 PST (-0800), johan@kernel.org wrote:
>>> On Tue, Feb 12, 2019 at 11:58:10AM -0800, Atish Patra wrote:
>>>> On 2/12/19 3:25 AM, Johan Hovold wrote:
>>>>> On Tue, Feb 12, 2019 at 03:10:12AM -0800, Atish Patra wrote:
>>>>>> Currently, we set hwcap based on first valid hart from DT. This may not
>>>>>> be correct always as that hart might not be current booting cpu or may
>>>>>> have a different capability.
>>>>>>
>>>>>> Set hwcap as the capabilities supported by all possible harts with "okay"
>>>>>> status.
>>>>>>
>>>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>>>> ---
>>>>>>     arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++-------------------
>>>>>>     1 file changed, 22 insertions(+), 19 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>>>>> index e7a4701f..a1e4fb34 100644
>>>>>> --- a/arch/riscv/kernel/cpufeature.c
>>>>>> +++ b/arch/riscv/kernel/cpufeature.c
>>>>>> @@ -20,6 +20,7 @@
>>>>>>     #include <linux/of.h>
>>>>>>     #include <asm/processor.h>
>>>>>>     #include <asm/hwcap.h>
>>>>>> +#include <asm/smp.h>
>>>>>>
>>>>>>     unsigned long elf_hwcap __read_mostly;
>>>>>>     #ifdef CONFIG_FPU
>>>>>> @@ -42,28 +43,30 @@ void riscv_fill_hwcap(void)
>>>>>>
>>>>>>     	elf_hwcap = 0;
>>>>>>
>>>>>> -	/*
>>>>>> -	 * We don't support running Linux on hertergenous ISA systems.  For
>>>>>> -	 * now, we just check the ISA of the first "okay" processor.
>>>>>> -	 */
>>>>>>     	for_each_of_cpu_node(node) {
>>>>>> -		if (riscv_of_processor_hartid(node) >= 0)
>>>>>> -			break;
>>>>>> -	}
>>>>>> -	if (!node) {
>>>>>> -		pr_warn("Unable to find \"cpu\" devicetree entry\n");
>>>>>> -		return;
>>>>>> -	}
>>>>>> +		unsigned long this_hwcap = 0;
>>>>>>
>>>>>> -	if (of_property_read_string(node, "riscv,isa", &isa)) {
>>>>>> -		pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>>>>>> -		of_node_put(node);
>>>>>> -		return;
>>>>>> -	}
>>>>>> -	of_node_put(node);
>>>>>> +		if (riscv_of_processor_hartid(node) < 0)
>>>>>> +			continue;
>>>>>>
>>>>
>>>>>> -	for (i = 0; i < strlen(isa); ++i)
>>>>>> -		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
>>>>>> +		if (of_property_read_string(node, "riscv,isa", &isa)) {
>>>>>> +			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>>>>>> +			return;
>>>>>
>>>>> Did you want "continue" here to continue processing the other harts?
>>>>
>>>> Hmm. If a cpu node doesn't have isa in DT, that means DT is wrong. A
>>>> "continue" here will let user space use other harts just with a warning
>>>> message?
>>>>
>>>> Returning here will not set elf_hwcap which forces the user to fix the
>>>> DT. I am not sure what should be the defined behavior in this case.
>>>>
>>>> Any thoughts ?
>>>
>>> The problem is that the proposed code might still set elf_hwcap -- it
>>> all depends on the order of the hart nodes in dt (i.e. it will only be
>>> left unset if the first node is malformed).
>>>
>>> For that reason, I'd say it's better to either bail out (hard or at
>>> least with elf_hwcap unset) or to continue processing the other nodes.
>>>
>>> The former might break current systems with malformed dt, though.
>>>
>>> And since the harts are expected to have the same ISA, continuing the
>>> processing while warning and ignoring the malformed node might be
>>> acceptable.
>>
>> Handling malformed device trees by providing a warning and an empty HWCAP seems
>> like the right way to go to me.
>>
> 
> If I understand you correctly, you prefer following things to be done in
> case of malformed DT.
> 
> 1. Print a warning message
> 2. Unset the entire HWCAP
> 3. Return without processing other harts. This will most likely result
> in panic when user space starts.
> 
> Is this correct ?
> 

As per our offline discussion, we should let kernel avoid setting any 
value for the cpu with incorrect DT entry and continue for other harts. 
A warning is enough. This is fine as long as user space never see that hart.

As the hart enumeration depends on riscv_of_processor_hartid, the hart 
with corrupted isa property will never boot. riscv_of_processor_hartid 
will return -ENODEV if "riscv,isa" property is not present.

Moreover, the discussed conditional statement will not even executed 
unless there is memory corruption or somebody corrupts the DT on the fly.

So we can continue with the patch as it is. I will just resend the 
series (dropping driver patches) for easy merge.

Regards,
Atish
> Regards,
> Atish
>>>
>>> Johan
>>
> 
> 

