Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158EEC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2C32073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eeU2PHF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2C32073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeI2ILd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:11:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42769 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeI2ILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:11:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so5406895pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 18:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+BUVeW5f7nhpy1dnH/n6Ghv3BNDXkkcNFzAT4AvDmSM=;
        b=eeU2PHF5P3Mqkg+6qSYSOYMyH0psV3IBHwYcVLwjzIQep0esvXuq38jYXcuoUl5xzh
         rEbL7/aH5LyF941axglEbRVcAJLQ2q9n/7lynGBrynuid2CIc1KmH78FZNBWBhZgFeog
         zT6oUh4fiJvnQzVxFSIfFeV+9JHef9KihnAlHrOq3VQVigAzZVrCweHqG0kZh8iFs7QR
         5rlQOkHFPGNR92phAc6JpvWybeUeCgutfuvQQ7VTdx/XRJKFiexpAO4+R4BI4oWynV0N
         AEPLAjq84eiVe84PjlBbI2JPDUUWGSto+LQevdTBThYgdLmah2J8GiFfhtsnC0sYcWkZ
         9+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+BUVeW5f7nhpy1dnH/n6Ghv3BNDXkkcNFzAT4AvDmSM=;
        b=QGuvszcaNDDQYszav6YcTkI3UTyOit8YzUcbdUKPYogvXflyao+5pqjYsHCODG1XKn
         CQkUQMS4KV7fqxcWM+7VYfHY6ds41T1Pb4zhiTwwk1h4KuJcX3gUYUkWw6HTcw2obUnF
         MikVVSP2YuoO8JrR1xgsFjeko06kfz65APTHdhu3CS2yeShUfduGRa7EAUdtWddiJtJb
         q/5f6CbXV04zRZWTBjCMOdN/B6X7VXXnOJum11SfUXWgQ6gu5DLety1NY8PxgxleCwOU
         7WkvDFRLDrYFdXWcHVWwVClKfKPbskP4ZwDzS/Hs8650RBzqFUkNxfVvbijXLwOIrSoB
         IaMA==
X-Gm-Message-State: ABuFfoiGUk9DFhRS5MybZCK89mv3U45A6WMyFOSxd/mVhU0/Mrx9lDWZ
        iCYlZ+G1OPvHzKU9h9PRnxw1Vg==
X-Google-Smtp-Source: ACcGV62mj6cKF93FqpdBbf8nxxSwvlac+ZpIu4CJ7LXBtA3v1uYUhdF1Xo2+IxGiyQDseP+e0xXJtg==
X-Received: by 2002:a62:6781:: with SMTP id t1-v6mr1165389pfj.200.1538185504701;
        Fri, 28 Sep 2018 18:45:04 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h4-v6sm8579471pfe.49.2018.09.28.18.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 18:45:03 -0700 (PDT)
Date:   Fri, 28 Sep 2018 18:45:03 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Sep 2018 17:51:16 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Show IPI stats
In-Reply-To: <20180910134659.GA30774@infradead.org>
CC:     anup@brainfault.org, aou@eecs.berkeley.edu,
        Christoph Hellwig <hch@infradead.org>, atish.patra@wdc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-2395876e-5470-45f9-83e1-4abae5188b0c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 06:46:59 PDT (-0700), Christoph Hellwig wrote:
> On Fri, Sep 07, 2018 at 06:14:29PM +0530, Anup Patel wrote:
>> This patch provides arch_show_interrupts() implementation to
>> show IPI stats via /proc/interrupts.
>>
>> Now the contents of /proc/interrupts" will look like below:
>>            CPU0       CPU1       CPU2       CPU3
>>   8:         17          7          6         14  SiFive PLIC   8  virtio0
>>  10:         10         10          9         11  SiFive PLIC  10  ttyS0
>> IPI0:       170        673        251         79  Rescheduling interrupts
>> IPI1:         1         12         27          1  Function call interrupts
>> IPI2:         0          0          0          0  CPU wake-up interrupts
>>
>> Signed-off-by: Anup Patel <anup@brainfault.org>
>
> Thanks, this looks pretty sensible to me.  Maybe we want to also show
> timer interrupts if we do this?

IIRC we used to have some issue where the timer interrupt ID in 
/proc/interrupts aliased with a possible PLIC interrupt ID, but that was back 
when we had a big mess of chained interrupt drivers that didn't really talk to 
each other.  I think at some point I might have just removed the timer 
interrupt from /proc/interrupts as a hack, but now that our interrupt 
controller mess is sorted out it'd be better to have it.

I'm fine taking this without the timer interrupts, as something is better than 
nothing.

>> --- a/arch/riscv/kernel/irq.c
>> +++ b/arch/riscv/kernel/irq.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/irqchip.h>
>>  #include <linux/irqdomain.h>
>> +#include <linux/seq_file.h>
>>
>>  /*
>>   * Possible interrupt causes:
>> @@ -24,6 +25,14 @@
>>   */
>>  #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
>>
>> +int arch_show_interrupts(struct seq_file *p, int prec)
>> +{
>> +#ifdef CONFIG_SMP
>> +	show_ipi_stats(p, prec);
>> +#endif
>> +	return 0;
>> +}
>
> If we don't also add timer stats I'd just move arch_show_interrupts
> to smp.c and make it conditional.  If we don't this split might make
> more sense.

Makes sense, but I think timer interrupts are more interesting to see than IPIs 
so we'll eventually pipe them through.  Might just be my workloads, though :)

>> +static const char *ipi_names[IPI_MAX] = {
>> +	[IPI_RESCHEDULE] = "Rescheduling interrupts",
>> +	[IPI_CALL_FUNC] = "Function call interrupts",
>> +	[IPI_CALL_WAKEUP] = "CPU wake-up interrupts",
>> +};
>
> No need for the explicit array size.  Also please use a few tabs to
> align this nicely:
>
> static const char *ipi_names[] = {
> 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
> 	[IPI_CALL_FUNC]		= "Function call interrupts",
> 	[IPI_CALL_WAKEUP]	= "CPU wake-up interrupts",
> };

I don't see a v2 of this, was there one?  If not then I'll just clean up 
ipi_names and drop this on for-next.

Thanks for the patch!
