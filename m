Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182ECECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC4620818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewPuxByf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC4620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeKIDBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:01:54 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54382 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeKIDBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:01:54 -0500
Received: by mail-it1-f195.google.com with SMTP id d6so2709756itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 09:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5etHN3UQXMfjWI3clr9iuXOz3kdlEQoNbXvvJOJaz1Y=;
        b=ewPuxByfqraObKBmVCcD4j2xgxyYtUA2cnBvH/Q+/Zsxfrk+Azc+DREAy6eLdlm7qQ
         kdC6IXOpgjfpaIRDuUIOyJX1VqMsTdCqWP4fTASUrCkVAHXZEFAeD/Z3bR7pcD8Zzcch
         h2+jdGbqTvO/n5JVWux29bHx9ttTJ1cBCsMD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5etHN3UQXMfjWI3clr9iuXOz3kdlEQoNbXvvJOJaz1Y=;
        b=EkSM54kNzzjiznJOVg6X//3R9btChYTwYDcPRpqXNvLr0F+UZfarV1m1SpbwqVYui3
         Hw7t1FpwWgceWDxGsEe4CaOQo+rWMorZgZe45V8b5AvIRm4GbRu08mqUzpgp07qXY17v
         WBXcQ8+lKk8AUzQtbqGvqXfNXCjIq9lGrYIKOE5EMRfIIXwW3m+wzgy4hFVKsr7P/XpK
         kPUlJbGFoQEq7rhQHHXLYTIlchBwQoVnq6erUxOOnuRMS1i7GLV61CQYCMW1KsZAqWMT
         QdcAVWTjfKIbzu3SsB3gBSeccQdaPBhM7VqLdO9bpDgopjG41qU+ezenyymT5kqKwzWH
         /LQg==
X-Gm-Message-State: AGRZ1gJfmDEYyCGsaSCfyh7fUP4kKxDJnIWp5SrTosAc6e7e4Pt34Gdj
        u71RGllNNDCCzillUrtQZ8bz6z0X8BPP3PIvROfSoA==
X-Google-Smtp-Source: AJdET5c3+Rw7A6KHvpM8N9vRf3+YvgyL8M9mMoipdWuB3fymfHiwhHqcjH7Eq2jHXg2RFsbWwDNz7Za99leyTb7ReW4=
X-Received: by 2002:a24:8347:: with SMTP id d68-v6mr2106108ite.158.1541697923484;
 Thu, 08 Nov 2018 09:25:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Thu, 8 Nov 2018 09:25:22 -0800 (PST)
In-Reply-To: <trinity-73b7af5e-ab88-495b-932a-2ffd6dd81623-1541697732607@3c-app-mailcom-bs15>
References: <trinity-7128b38b-7a1d-4584-aa34-174a2906ec88-1541694235634@3c-app-mailcom-bs15>
 <trinity-73b7af5e-ab88-495b-932a-2ffd6dd81623-1541697732607@3c-app-mailcom-bs15>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 8 Nov 2018 18:25:22 +0100
Message-ID: <CAKv+Gu_1ckSP_O6TdYRL=+dUbWDsogOaU3-nnWMKijtANw8t6Q@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at mm/slab.h:421
To:     Qian Cai <cai@gmx.us>, Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Marc)

On 8 November 2018 at 18:22, Qian Cai <cai@gmx.us> wrote:
> Looks like more of an EFI issue where it called efi_mem_reserve_persistent().
>
>> Sent: Thursday, November 08, 2018 at 11:23 AM
>> From: "Qian Cai" <cai@gmx.us>
>> To: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Subject: BUG: sleeping function called from invalid context at mm/slab.h:421
>>
>> Just booting up the latest git master (b00d209) on an aarch64 server and saw this.
>>
>> Nov  8 11:06:36 huawei-t2280-03 kernel: BUG: sleeping function called from invalid context at mm/slab.h:421
>> Nov  8 11:06:36 huawei-t2280-03 kernel: in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/1
>> Nov  8 11:06:36 huawei-t2280-03 kernel: no locks held by swapper/1/0.
>> Nov  8 11:06:36 huawei-t2280-03 kernel: irq event stamp: 0
>> Nov  8 11:06:36 huawei-t2280-03 kernel: hardirqs last  enabled at (0): [<0000000000000000>]           (null)
>> Nov  8 11:06:36 huawei-t2280-03 kernel: hardirqs last disabled at (0): [<ffff2000080e24ec>] copy_process.isra.32.part.33+0x460/0x1534
>> Nov  8 11:06:36 huawei-t2280-03 kernel: softirqs last  enabled at (0): [<ffff2000080e24ec>] copy_process.isra.32.part.33+0x460/0x1534
>> Nov  8 11:06:36 huawei-t2280-03 kernel: softirqs last disabled at (0): [<0000000000000000>]           (null)
>> Nov  8 11:06:36 huawei-t2280-03 kernel: CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.20.0-rc1+ #3
>> Nov  8 11:06:36 huawei-t2280-03 kernel: Call trace:
>> Nov  8 11:06:36 huawei-t2280-03 kernel: dump_backtrace+0x0/0x190
>> Nov  8 11:06:36 huawei-t2280-03 kernel: show_stack+0x24/0x2c
>> Nov  8 11:06:36 huawei-t2280-03 kernel: dump_stack+0xa4/0xe0
>> Nov  8 11:06:36 huawei-t2280-03 kernel: ___might_sleep+0x208/0x234
>> Nov  8 11:06:36 huawei-t2280-03 kernel: __might_sleep+0x58/0x8c
>> Nov  8 11:06:36 huawei-t2280-03 kernel: kmem_cache_alloc_trace+0x29c/0x420
>> Nov  8 11:06:36 huawei-t2280-03 kernel: efi_mem_reserve_persistent+0x50/0xe8
>> Nov  8 11:06:36 huawei-t2280-03 kernel: its_cpu_init_lpis+0x298/0x2e0
>> Nov  8 11:06:36 huawei-t2280-03 kernel: its_cpu_init+0x7c/0x1a8
>> Nov  8 11:06:36 huawei-t2280-03 kernel: gic_starting_cpu+0x28/0x34
>> Nov  8 11:06:36 huawei-t2280-03 kernel: cpuhp_invoke_callback+0x104/0xd04
>> Nov  8 11:06:36 huawei-t2280-03 kernel: notify_cpu_starting+0x60/0xa0
>> Nov  8 11:06:36 huawei-t2280-03 kernel: secondary_start_kernel+0xcc/0x178
>>
>> Any idea?

OK, so apparently, we are being invoked from atomic context

Please try this

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 249eb70691b0..44ed6792de7c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -971,7 +971,7 @@ int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
        if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
                return -ENODEV;

-       rsv = kmalloc(sizeof(*rsv), GFP_KERNEL);
+       rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
        if (!rsv)
                return -ENOMEM;
