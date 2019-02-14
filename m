Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EA0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BED20838
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d1lx9p1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfBNXdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:33:25 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46954 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBNXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550187242; x=1581723242;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JyIuzoahJhXItXaoaLO0BZt6YCodUNR0jk/suO+uHRY=;
  b=d1lx9p1xNhPUcOUpT5KUuwKP/eP3etWnkG5SlGujAzVX+cyte5audf3/
   6BzFk0rMd5JPpFg6bsInNB8+ZgKg3qyheDVPRSKg78WaRuUSALlG/RXTq
   Ty7iHqyiwgCZpp2CEmpVZaZ2uHeMPYt1rElF4ZV2xeHSKTEQrogJFmukY
   B/sNxJ27eib3OeyZ6ECFIxRq66jYqqeKdzgsRDZVcu1x69Ka4BC/HF8J5
   5A1kNSMqJLeZlpqFWo+x2MjipAFPalsPBbkWq+27uVguP2nFJph8TExlA
   wNuwLwjeKagXVJjA19d8UPWMcXBP3yXmAf7Mq7qfFgNPeyyp4tXDuJdYc
   w==;
X-IronPort-AV: E=Sophos;i="5.58,370,1544457600"; 
   d="scan'208";a="199529650"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2019 07:34:01 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 14 Feb 2019 15:13:56 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.47]) ([10.111.66.47])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2019 15:33:23 -0800
Subject: Re: [v5 PATCH 5/8] RISC-V: Compare cpuid with NR_CPUS before mapping.
To:     Christopher Lameter <cl@linux.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
References: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
 <1550089092-28783-6-git-send-email-atish.patra@wdc.com>
 <01000168ed298ba3-fea3ca2b-436b-4ce6-a0df-cebe727bf55c-000000@email.amazonses.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <e86e8239-bea8-b11f-f09b-63110ec16d88@wdc.com>
Date:   Thu, 14 Feb 2019 15:33:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <01000168ed298ba3-fea3ca2b-436b-4ce6-a0df-cebe727bf55c-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 9:59 AM, Christopher Lameter wrote:
> On Wed, 13 Feb 2019, Atish Patra wrote:
> 
>> --- a/arch/riscv/kernel/smpboot.c
>> +++ b/arch/riscv/kernel/smpboot.c
>> @@ -66,6 +66,11 @@ void __init setup_smp(void)
>>   			found_boot_cpu = 1;
>>   			continue;
>>   		}
>> +		if (cpuid >= NR_CPUS) {
> 
> Use nr_cpu_ids instead? Its initialized to NR_CPUS but can be restricted
> if we can determine on boot how many processor we truly have.
> 
nr_cpu_ids can be modified by nr_cpus in boot command line. If nr_cpus 
is set to a value less than number of cpus described in the DT, kernel 
may not boot depending on the boot hartid. This happens because we break 
out of the while loop and BUG_ON(!found_boot_cpu).

As the required fix will be different from the current fix, I would like 
to do this in a follow up patch if that's ok.

Btw, thanks for bringing this up.

Regards,
Atish
