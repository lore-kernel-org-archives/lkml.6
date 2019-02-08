Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC9FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACCE21841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OURAzpmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBHW5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:57:18 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46759 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549666635; x=1581202635;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AaXLsLkp5lCyJS9vlcxg9SAChjUSNy6OwDD0PjlSrYA=;
  b=OURAzpmoNlAVyHRkCC2X8eeo4VNZ+Macs5LJfIvugxrjIrpteITPNGao
   niWJF0/EKPRvP8ecXmUS9BanGIkIPzy6Rofipq+Doi+y4rdvisgv56toz
   +2FKtTmO6PhTVebqIkIiMgylx2T2S5bBIVVasM7VmFdn1ct8VnLBxWI8K
   EvaFTz0Q6HP6zCtoeNvjSPye4MouSedIiyiN4s1WOXSB2X2ZQlEaK3I3x
   hlepcHwm4aPzh+/b3BFb1O8tyqyGwf7R7axiKhlesLEKQS2hf5yPeExhb
   Ppg3ARE7DNOSTEWVEO/sxxCbQaN9KBzcm+L1mFcy7/Pg1SPMdzz6Gq0xQ
   A==;
X-IronPort-AV: E=Sophos;i="5.58,348,1544457600"; 
   d="scan'208";a="100816451"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2019 06:56:59 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 08 Feb 2019 14:37:41 -0800
Received: from usa003289.ad.shared (HELO [10.86.59.147]) ([10.86.59.147])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Feb 2019 14:56:59 -0800
Subject: Re: [v3 PATCH 2/8] RISC-V: Move cpuid to hartid mapping to SMP.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        =?UTF-8?Q?Patrick_St=c3=a4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zong Li <zongbox@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
 <1549590681-24125-3-git-send-email-atish.patra@wdc.com>
 <20190208090316.GB16932@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <1090db6a-f4c1-a522-7c2d-d7367846df35@wdc.com>
Date:   Fri, 8 Feb 2019 14:56:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208090316.GB16932@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 1:03 AM, Christoph Hellwig wrote:
> On Thu, Feb 07, 2019 at 05:51:15PM -0800, Atish Patra wrote:
>> Currently, logical CPU id to physical hartid mapping is
>> defined for both smp and non-smp configurations. This
>> is not required as we need this only for smp configuration.
>> The mapping function can define directly boot_cpu_hartid
>> for non-smp use case.
> 
> Please use up your available 72 chars for the changelog.  (probably also
> in other patches).
> 

Sorry. I will fix all patches to use 72 chars.

>>
>> The reverse mapping function i.e. hartid to cpuid can be called
>> for any valid but not booted harts. So it should return default
>> cpu 0 only if it is a boot hartid.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> ---
>>   arch/riscv/include/asm/smp.h | 14 +++++++++++---
>>   arch/riscv/kernel/setup.c    |  9 ---------
>>   arch/riscv/kernel/smp.c      |  9 +++++++++
>>   3 files changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
>> index 41aa73b4..21fd2d75 100644
>> --- a/arch/riscv/include/asm/smp.h
>> +++ b/arch/riscv/include/asm/smp.h
>> @@ -22,12 +22,13 @@
>>   /*
>>    * Mapping between linux logical cpu index and hartid.
>>    */
>> -extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
>> -#define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
>>   
>> +extern unsigned long boot_cpu_hartid;
>>   struct seq_file;
> 
> We usually try to keep forward declatations at the top of the file.
> 
> Can you add the new external declaration below the forward one?
> 
Sure.

Regards,
Atish
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

