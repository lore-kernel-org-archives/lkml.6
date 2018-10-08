Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68219C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C7E2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C7E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJHRDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:03:42 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:37815 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbeJHRDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:03:42 -0400
Received: from [192.168.1.7] (x4db45a10.dyn.telefonica.de [77.180.90.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7C7692012D0DC0;
        Mon,  8 Oct 2018 11:52:48 +0200 (CEST)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: unwind_init() takes 100 ms
Message-ID: <81a1ff79-b303-c384-f926-c9618afac8f0@molgen.mpg.de>
Date:   Mon, 8 Oct 2018 11:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Josh, dear Linux folks,


Trying to decrease the boot time of the 64-bit Linux kernel (Linux 
4.19-rc7 (0238df64)) on a Asus F2A85-M PRO with an AMD processor, I 
noticed `unwind_init()` called from `setup_arch()` 
`arch/x86/kernel/setup.c` takes over 100 ms to initialize according to 
Linux time stamps (which are present for early boot now).

```
[…]
[    0.047650] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.047653] smpboot: Allowing 4 CPUs, 2 hotplug CPUs
[    0.047670] [mem 0x8f000000-0xfebfffff] available for PCI devices
[    0.047672] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.151426] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 
nr_node_ids:1
[    0.151892] percpu: Embedded 44 pages/cpu @(____ptrval____) s142552 
r8192 d29480 u524288
[…]
```

That’s a third of the time to get to unpacking the initramfs.

Therefore, I have several questions.

1.  Can you reproduce that on your systems?
2.  Can this be decreased or moved out of the “hot path”?
3.  If not, how can this be disabled? I was unable to do so in the 
configuration menu. I could always select an unwinder under *Kernel 
hacking*, and was not able to disable it. I
4.  Would a command line parameter be reasonable `disable_unwind`, so 
people could decrease their boot time with distribution kernels, and 
easily turn it back on, when they need a stacktrace without having to 
rebuild the Linux kernel?


Kind regards,

Paul
