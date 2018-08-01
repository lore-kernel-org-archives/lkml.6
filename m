Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94ADC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5649020851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Th0Eo70v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5649020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbeHACU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 22:20:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14911 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732804AbeHACU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 22:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533083884; x=1564619884;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cRwpb806eoN2V/XRQZyPOZ4jDvSx1zVOCyJyfbKm+nk=;
  b=Th0Eo70v4dofObt1bX/fIoS6/yynbwhimB8o7ktpjNLEt+MKj6XdQBoy
   9j0L4N05ocKGk0FYnUU9NVXNluJs8m034uPlGu0ORT3DBjobT+acAaxl7
   CGwsopNAk0qvR1gLgot9+O//0SP5NJQPK7sjZpzz5dbEXHtyh/Ztkfzah
   aoVfvXVhY9uOx8gvukfIOcOzvp20XqoHv5q1Kd9qiTMGVBL3hCVfPAmPt
   MHUqvv2CACMrGUZcG0reNjXcsR2IH2M6X/ieb5HvDD1EdB7NJOItZD35N
   NzF+XHMiVuE2z6f8/2NKVQmfcUPuwfrzf458EJ2sGWPdyevLlOf0JJdi3
   A==;
X-IronPort-AV: E=Sophos;i="5.51,429,1526313600"; 
   d="scan'208";a="189491081"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2018 08:38:01 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 31 Jul 2018 17:25:52 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2018 17:38:01 -0700
Subject: Re: [PATCH 7/9] irqchip: add a RISC-V PLIC driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <20180726143723.16585-1-hch@lst.de>
 <20180726143723.16585-8-hch@lst.de>
 <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com>
 <dc69d688-f765-74cc-3234-563fecff6002@wdc.com> <20180731165712.GA2521@lst.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <dcb17e67-9f83-0ff5-a2c6-a6dd1b4d9c0d@wdc.com>
Date:   Tue, 31 Jul 2018 17:38:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731165712.GA2521@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/18 9:52 AM, Christoph Hellwig wrote:
> On Mon, Jul 30, 2018 at 08:21:33PM -0700, Atish Patra wrote:
>> I found the issue. As per PLIC documentation, a hart context is a given
>> privilege mode on a given hart. Thus, cpu context ID & cpu numbers are not
>> same. Here is the PLIC register Maps in U54 core:
>>
>> Ref: https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf
>>
>> Memory address for Interrupt enable
>> Address
>> 0x0C00-2080   Hart 1 M-mode enables
>> 0x0C00 2094   End of Hart 1 M-mode enables
>>
>> 0x0C00-2100   Hart 1 S-mode enables
>> 0x0C00-2114   End of Hart 1 S-mode enables
>>
>> Memory map Claim/Threshold
>> Address
>> 0x0C20-1000 4B 	 M-mode priority threshold
>> 0x0C20-1004 4B   M-mode claim/complete
>> 0x0C20-2000 4B   S-mode priority threshold
>> 0x0C20-2004 4B   S-mode claim/complete
>>
>> The original PLIC patch was calculating based on handle->contextid which
>> will assume numbers on a HighFive Unleashed board as 2 4 6 8.
>>
>> In this patch, context id is assigned as cpu numbers which will be 1 2 3 4.
>> Thus it will lead to incorrect plic address access as shown below.
> 
> Indeed.  Can you try this branch, which puts back the OF contextid
> parsing from the original code:
> 
>     git://git.infradead.org/users/hch/riscv.git riscv-irq-simple.2
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-irq-simple.2
> 
> 

Some typos in the above repo in the PLIC driver patch. The following 
changes are required. Inline patch below

diff --git a/drivers/irqchip/irq-riscv-plic.c 
b/drivers/irqchip/irq-riscv-plic.c
index 0e524e3e..9dbaca47 100644
--- a/drivers/irqchip/irq-riscv-plic.c
+++ b/drivers/irqchip/irq-riscv-plic.c
@@ -79,7 +79,7 @@ static DEFINE_SPINLOCK(plic_toggle_lock);
  static inline void plic_toggle(int ctxid, int hwirq, int enable)
  {
         u32 __iomem *reg = plic_regs + ENABLE_BASE +
-               ctxid * ENABLE_PER_HART + (hwirq / 32);
+               ctxid * ENABLE_PER_HART + (hwirq / 32) * 4;
         u32 hwirq_mask = 1 << (hwirq % 32);

         spin_lock(&plic_toggle_lock);
@@ -166,7 +166,7 @@ static void plic_handle_irq(struct pt_regs *regs)
  static int __init plic_init(struct device_node *node,
                 struct device_node *parent)
  {
-       int error = 0, nr_mapped = 0, cpu, i;
+       int error = 0, nr_mapped = 0, i;
         u32 nr_irqs;

         if (plic_regs) {
@@ -211,8 +211,7 @@ static int __init plic_init(struct device_node *node,
                         pr_err("invalid OF parent, skipping context 
%d.\n", i);
                         continue;
                 }
-
-               if (riscv_of_processor_hart(parent.np->parent < 0))
+               if (riscv_of_processor_hart(parent.np->parent) < 0)
                         continue;

                 plic_handler_present[i] = true;


With the above changes, I am able to boot quite far. But it still 
crashes which may be a driver issue. I might have missed something while 
merging all the out-of-tree drivers from riscv-all branch.

Here is my git repo.
https://github.com/atishp04/riscv-linux/tree/master_chris_cleanup_v4

crash details are at
https://paste.debian.net/1036078/

Regards,
Atish
