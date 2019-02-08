Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7327AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F0421841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hdot/TzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBHXCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:02:54 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8199 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfBHXCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549666974; x=1581202974;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HJS0dqTZ8pL/wWqfL161CgRt5Xxy3W9rZvtNpfXa3YI=;
  b=hdot/TzRe4GrwFRnljYtM2k9vy77Fh7Bz0cM9dIOxd2vXiFS8m50QZy/
   OBdNQ+56ABkvZhnQyShVUhpDWoiWFRiTeaIn6PNjYI9aq8p4NQ3UnNZJR
   0qFo8Wihy9HQu9OcMkYBHv9q0UjWMi0F2ALFvOAhU7d1XLv5SxMRxbXgh
   2SArTiYiIm24CaKl35aq7WTXz3WAXp3nkwlWPRV5eyGpGt0CgSMiBioVu
   haC7mqyIBY77vLtcNylfHL+8eguhqfnVLOcdDY80NWeY3Z/RoJycpQNsS
   b4feV8JJApHcyGlUr/h1ofKxFMqN5dq6UI9mG6FFibt936l3MFQBuEm/S
   w==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="102116688"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2019 07:02:53 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Feb 2019 14:41:35 -0800
Received: from usa003289.ad.shared (HELO [10.86.59.147]) ([10.86.59.147])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Feb 2019 15:02:52 -0800
Subject: Re: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
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
 <1549590681-24125-9-git-send-email-atish.patra@wdc.com>
 <20190208091133.GD16932@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <8f5fd0c8-0320-00b1-4ddf-b1225be352c8@wdc.com>
Date:   Fri, 8 Feb 2019 15:02:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208091133.GD16932@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 1:11 AM, Christoph Hellwig wrote:
>> +	 * We don't support running Linux on hertergenous ISA systems.
>> +	 * But first "okay" processor might not be the boot cpu.
>> +	 * Check the ISA of boot cpu.
> 
> Please use up your available 80 characters per line in comments.
> 
I will fix it.

>> +		/*
>> +		 * All "okay" hart should have same isa. We don't know how to
>> +		 * handle if they don't. Throw a warning for now.
>> +		 */
>> +		if (elf_hwcap && temp_hwcap != elf_hwcap)
>> +			pr_warn("isa mismatch: 0x%lx != 0x%lx\n",
>> +				elf_hwcap, temp_hwcap);
>> +
>> +		if (hartid == boot_cpu_hartid)
>> +			boot_hwcap = temp_hwcap;
>> +		elf_hwcap = temp_hwcap;
> 
> So we always set elf_hwcap to the capabilities of the previous cpu.
> 
>> +		temp_hwcap = 0;
> 
> I think tmp_hwcap should be declared and initialized inside the outer loop
> instead having to manually reset it like this.
> 
>> +	}
>>   
>> +	elf_hwcap = boot_hwcap;
> 
> And then reset it here to the boot cpu.
> 
> Shoudn't we only report the features supported by all cores?  Otherwise
> we'll still have problems if the boot cpu supports a feature, but not
> others.
> 

Hmm. The other side of the argument is boot cpu does have a feature that 
is not supported by other hart that didn't even boot.
The user space may execute something based on boot cpu capability but 
that won't be enabled.

At least, in this way we know that we are compatible completely with 
boot cpu capabilities. Thoughts ?

Regards,
Atish
> Something like:
> 
> 	for () {
> 		unsigned long this_hwcap = 0;
> 
> 		for (i = 0; i < strlen(isa); i++)
> 			this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
> 
> 		if (elf_hwcap)
> 			elf_hwcap &= this_hwcap;
> 		else
> 			elf_hwcap = this_hwcap;
> 	}
> 
> 

