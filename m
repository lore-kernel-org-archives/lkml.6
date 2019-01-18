Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D1FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99D420873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mYFB24vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfARCKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:10:42 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21044 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfARCKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547777442; x=1579313442;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zlOkxdwgTtcKUukUT/zB3tM58Winto37alvQsq8ejgo=;
  b=mYFB24vmDJu5ncyYFCKpvknsA67QFKfU0htf6kTDAb7FQCbcRxmfh2QB
   yM5HrFIF8okPUB1RLSxMu+H7K1RuBcry6yk6BKJHy6T3cFE0LFiJkQyNV
   uP4OoNjdK8lSVBMXawbkhPFbVihPPT60m8sl1NCDtefb9/QVpDlz74Gr9
   vuXrw2W7uiTtV1jEf88Bu7V6+wQErLHR43C/ka6foDrVgMs2I4/zHyqjI
   IRU3hc4mmqoZwmA8vJxaO3LwZrqGbyAhTnEKekqgZfmd86RnStdvB6sQx
   90qD6HkXPRfDUWF1x3LSSRXR7uSQmJKrnYu/qcZdJ+NYBlRDxZooLKflP
   g==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="100881259"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 10:10:42 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 17 Jan 2019 17:50:21 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.68.123]) ([10.111.68.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2019 18:10:42 -0800
Subject: Re: [PATCH v2 7/8] RISC-V: Check and continue in case of an invalid
 cpuid.
To:     Anup Patel <anup@brainfault.org>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?Q?Patrick_St=c3=a4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-8-git-send-email-atish.patra@wdc.com>
 <CAAhSdy17H_XpDea9bowUoinVmb17p8+ZAzZ7cyFuDfFDJ-LwaA@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <a92933c7-c489-04a9-5b21-ed78aac927ec@wdc.com>
Date:   Thu, 17 Jan 2019 18:10:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy17H_XpDea9bowUoinVmb17p8+ZAzZ7cyFuDfFDJ-LwaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 4:00 AM, Anup Patel wrote:
> Prefer, commit prefix "irqchip/irq-sifive-plic:" instead of "RISC-V:"
> 

Will do.

Regards,
Atish
> On Tue, Jan 8, 2019 at 3:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> riscv_hartid_to_cpuid can return invalid cpuid for a hart
>> that is present in DT but was never brought up.
>>
>> Print the appropriate warning message and continue.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   drivers/irqchip/irq-sifive-plic.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> index 357e9daf..254ecd76 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -237,6 +237,11 @@ static int __init plic_init(struct device_node *node,
>>                  }
>>
>>                  cpu = riscv_hartid_to_cpuid(hartid);
>> +               if (cpu < 0) {
>> +                       pr_warn("Invalid cpuid for context %d\n", i);
>> +                       continue;
>> +               }
>> +
>>                  handler = per_cpu_ptr(&plic_handlers, cpu);
>>                  handler->present = true;
>>                  handler->ctxid = i;
>> --
>> 2.7.4
>>
> 
> Otherwise, looks good to me.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> 
> Regards,
> Anup
> 

