Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D18AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF45221564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF45221564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeI0Mgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:36:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13183 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbeI0Mgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:36:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42LPmc3cLqz9ttCH;
        Thu, 27 Sep 2018 08:20:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id azRfGlaEeVVI; Thu, 27 Sep 2018 08:20:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42LPmc2s45z9ttC3;
        Thu, 27 Sep 2018 08:20:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2701A8B86C;
        Thu, 27 Sep 2018 08:20:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WM_ztUJgWrdu; Thu, 27 Sep 2018 08:20:01 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 732EE8B75A;
        Thu, 27 Sep 2018 08:20:00 +0200 (CEST)
Subject: Re: [PATCH v4 1/2] powerpc/32: add stack protector support
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <d6c43ab708bf9ae1266c745fece457ed2da43d7c.1537961921.git.christophe.leroy@c-s.fr>
 <20180926191615.GO23155@gate.crashing.org>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <220fbef8-429c-9485-d10e-c1eaa989918d@c-s.fr>
Date:   Thu, 27 Sep 2018 08:20:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926191615.GO23155@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/09/2018 à 21:16, Segher Boessenkool a écrit :
> On Wed, Sep 26, 2018 at 11:40:38AM +0000, Christophe Leroy wrote:
>> +static __always_inline void boot_init_stack_canary(void)
>> +{
>> +	unsigned long canary;
>> +
>> +	/* Try to get a semi random initial value. */
>> +	get_random_bytes(&canary, sizeof(canary));
>> +	canary ^= mftb();
>> +	canary ^= LINUX_VERSION_CODE;
>> +
>> +	current->stack_canary = canary;
>> +}
> 
> I still think you should wait until there is entropy available.  You
> haven't answered my questions about that (or I didn't see them): what
> does the kernel do in other similar cases?
> 
> Looks great otherwise!
> 

What do you mean by 'other similar cases' ? All arches have similar 
boot_init_stack_canary(). x86 uses rdtsc() which is equivalent to our 
mftb(). Most arches xor it with LINUX_VERSION_CODE.

The issue is that it is called very early in start_kernel(), however 
they try to set some entropy anyway:

	boot_cpu_init();
	page_address_init();
	pr_notice("%s", linux_banner);
	setup_arch(&command_line);
	/*
	 * Set up the the initial canary and entropy after arch
	 * and after adding latent and command line entropy.
	 */
	add_latent_entropy();
	add_device_randomness(command_line, strlen(command_line));
	boot_init_stack_canary();

Apparently, it is too early for calling wait_for_random_bytes(), see below.

However this is the canary for initial startup only. Only idle() still 
uses this canary once the system is running. A new canary is set for any 
new forked task.

Maybe should the idle canary be updated later once there is more entropy 
? Today there is a new call to boot_init_stack_canary() in 
cpu_startup_entry(), but it is enclosed inside #ifdef CONFIG_X86.

[    0.000000] Unable to handle kernel paging request for data at 
address 0x00000200
[    0.000000] Faulting instruction address: 0xc0048e2c
[    0.000000] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.000000] BE PREEMPT CMPC885
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 
4.19.0-rc4-s3k-dev-00498-g439f9fbadb38-dirty #6
[    0.000000] NIP:  c0048e2c LR: c05cf9ec CTR: c0018a68
[    0.000000] REGS: c07e9e40 TRAP: 0300   Not tainted 
(4.19.0-rc4-s3k-dev-00498-g439f9fbadb38-dirty)
[    0.000000] MSR:  00001032 <ME,IR,DR,RI>  CR: 28044222  XER: 00000000
[    0.000000] DAR: 00000200 DSISR: c0000000
[    0.000000] GPR00: c05cf9ec c07e9ef0 c078c560 00000000 00000000 
00000001 c080a405 626f6f74
[    0.000000] GPR08: 00001032 c07e8000 00000000 00000004 28044222 
100c82b6 00000000 07ff9580
[    0.000000] GPR16: 00000000 07ffb94c 00000000 00000000 00000000 
00000000 00000000 00000000
[    0.000000] GPR24: 00000000 07ff9580 c05cfb3c 00000000 c0790000 
c07e8000 c0797740 00000000
[    0.000000] NIP [c0048e2c] __schedule_bug+0x24/0x78
[    0.000000] LR [c05cf9ec] __schedule+0x4f4/0x614
[    0.000000] Call Trace:
[    0.000000] [c07e9ef0] [07ffb94c] 0x7ffb94c (unreliable)
[    0.000000] [c07e9f00] [c05cf9ec] __schedule+0x4f4/0x614
[    0.000000] [c07e9f50] [c05cfb3c] schedule+0x30/0x5c
[    0.000000] [c07e9f70] [c02bf15c] wait_for_random_bytes.part.4+0xa0/0xa8
[    0.000000] [c07e9fb0] [c06fc9c8] start_kernel+0x98/0x46c
[    0.000000] [c07e9ff0] [c00022cc] start_here+0x44/0x98
[    0.000000] Instruction dump:
[    0.000000] 419eff30 4bffff8c 4bfd6619 3d20c081 81298154 2f890000 
4cbe0020 9421fff0
[    0.000000] 7c0802a6 90010014 7c641b78 54290024 <80a40200> 80c90008 
3c60c06a 388402fc
[    0.000000] random: get_random_bytes called from 
print_oops_end_marker+0x34/0x6c with crng_init=0
[    0.000000] ---[ end trace 343b232a5e00519e ]---

Christophe
