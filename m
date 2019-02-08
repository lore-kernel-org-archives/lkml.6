Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4A3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A40821841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="djk3NTmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBHW4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:56:16 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:9486 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBHW4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549666575; x=1581202575;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JJVjRFZ0MjlKPtlNZx40KnljAAcqK9QsHXHfcYZKklo=;
  b=djk3NTmqlRgA50fxN/cjywDuhjyMM79EQouYR7mrokaiG5RwkF6DqySl
   nCG47KXU1QjNQbl1dq0CQ8dEIsYDRQeul2k6TTkCZ9ZPXxsTAu0xSFEus
   ZEU9mVtCFBvpwz5iy9/VVfgevNYwlMp/O1VHVqgaWi4xU5aYRUzODzyH/
   jjGweKdwH3gYVv1bdObTB1XnmqdogaCFmX8Scg/Lt+SZ/uTc9JK4GL8FH
   n4SYrvFGx9vKgW0mwmRDnDgrgbnKp/vX0Mc8vC3E8xfE3nTpMVb7cLndn
   +eACl8WhfxveGP6ubCifhpATdwt39fc98hniUaf3/nD7Hb/798y27itpT
   g==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="105811949"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2019 06:56:15 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 08 Feb 2019 14:36:56 -0800
Received: from usa003289.ad.shared (HELO [10.86.59.147]) ([10.86.59.147])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Feb 2019 14:56:15 -0800
Subject: Re: [v3 PATCH 6/8] clocksource/drivers/riscv: Add required checks
 during clock source init
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?Q?Patrick_St=c3=a4hlin?= <me@packi.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
 <1549590681-24125-7-git-send-email-atish.patra@wdc.com>
 <20190208090405.GC16932@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <7e6afb87-73e1-9688-7602-b7579fb94590@wdc.com>
Date:   Fri, 8 Feb 2019 14:56:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208090405.GC16932@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 1:04 AM, Christoph Hellwig wrote:
> On Thu, Feb 07, 2019 at 05:51:19PM -0800, Atish Patra wrote:
>> Currently, clocksource registration happens for an invalid cpu
>> for non-smp kernels. This lead to kernel panic as cpu hotplug
>> registration will fail for those cpus. Moreover,
>> riscv_hartid_to_cpuid can return errors now.
>>
>> Do not proceed if hartid or cpuid is invalid. Take this opprtunity
>> to print appropriate error strings for different failure cases.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
>> index 43189220..3c7ea75b 100644
>> --- a/drivers/clocksource/timer-riscv.c
>> +++ b/drivers/clocksource/timer-riscv.c
>> @@ -95,13 +95,30 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>   	struct clocksource *cs;
>>   
>>   	hartid = riscv_of_processor_hartid(n);
>> +	if (hartid < 0) {
>> +		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
>> +			n, hartid);
>> +		return hartid;
>> +	}
>> +
>>   	cpuid = riscv_hartid_to_cpuid(hartid);
>> +	if (cpuid < 0) {
>> +		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
>> +		return cpuid;
>> +	}
>>   
>>   	if (cpuid != smp_processor_id())
>>   		return 0;
>>   
>> +	pr_err("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
>> +	       __func__, cpuid, hartid);
> 
> This does not look like an error case to me.  At best it is info,
> if not debug.
> 
Thanks for catching. It was a typo. I will fix it in next version.

Regards,
Atish
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

