Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86848C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB5320664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB5320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441489AbeKXHJI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:09:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42695 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441477AbeKXHJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:09:07 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wANKMqFA137747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 23 Nov 2018 12:22:52 -0800
Date:   Fri, 23 Nov 2018 12:22:44 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20181123200307.GA6223@roeck-us.net>
References: <20181119184556.11479-1-bp@alien8.de> <20181123200307.GA6223@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
To:     Guenter Roeck <linux@roeck-us.net>, Borislav Petkov <bp@alien8.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
From:   hpa@zytor.com
Message-ID: <62E011F5-639B-4CF9-8A8B-091C84749F43@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 23, 2018 12:03:07 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
>Hi,
>
>On Mon, Nov 19, 2018 at 07:45:56PM +0100, Borislav Petkov wrote:
>> From: Borislav Petkov <bp@suse.de>
>> 
>> Currently, the kernel uses
>> 
>>   [LM]FENCE; RDTSC
>> 
>> in the timekeeping code, to guarantee monotonicity of time where the
>> *FENCE is selected based on vendor.
>> 
>> Replace that sequence with RDTSCP which is faster or on-par and gives
>> the same guarantees.
>> 
>> A microbenchmark on Intel shows that the change is on-par.
>> 
>> On AMD, the change is either on-par with the current LFENCE-prefixed
>> RDTSC and some are slightly better with RDTSCP.
>> 
>> The comparison is done with the LFENCE-prefixed RDTSC (and not with
>the
>> MFENCE-prefixed one, as one would normally expect) because all modern
>> AMD families make LFENCE serializing and thus avoid the heavy MFENCE
>by
>> effectively enabling X86_FEATURE_LFENCE_RDTSC.
>> 
>> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Borislav Petkov <bp@suse.de>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
>> Cc: x86@kernel.org
>> ---
>>  arch/x86/include/asm/msr.h | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
>> index 91e4cf189914..f00f2b61d326 100644
>> --- a/arch/x86/include/asm/msr.h
>> +++ b/arch/x86/include/asm/msr.h
>> @@ -217,6 +217,8 @@ static __always_inline unsigned long long
>rdtsc(void)
>>   */
>>  static __always_inline unsigned long long rdtsc_ordered(void)
>>  {
>> +	DECLARE_ARGS(val, low, high);
>> +
>>  	/*
>>  	 * The RDTSC instruction is not ordered relative to memory
>>  	 * access.  The Intel SDM and the AMD APM are both vague on this
>> @@ -227,9 +229,18 @@ static __always_inline unsigned long long
>rdtsc_ordered(void)
>>  	 * ordering guarantees as reading from a global memory location
>>  	 * that some other imaginary CPU is updating continuously with a
>>  	 * time stamp.
>> +	 *
>> +	 * Thus, use the preferred barrier on the respective CPU, aiming
>for
>> +	 * RDTSCP as the default.
>>  	 */
>> -	barrier_nospec();
>> -	return rdtsc();
>> +	asm volatile(ALTERNATIVE_2("mfence; rdtsc",
>> +				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
>> +				   "rdtscp", X86_FEATURE_RDTSCP)
>> +			: EAX_EDX_RET(val, low, high)
>> +			/* RDTSCP clobbers ECX with MSR_TSC_AUX. */
>> +			:: "ecx");
>> +
>> +	return EAX_EDX_VAL(val, low, high);
>>  }
>>  
>
>This patch results in a crash with certain qemu emulations.
>
>[    0.756869] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
>[    0.762233] invalid opcode: 0000 [#1] PTI
>[    0.762435] CPU: 0 PID: 1 Comm: swapper Not tainted
>4.20.0-rc3-next-20181123 #2
>[    0.762644] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>Ubuntu-1.8.2-1ubuntu1 04/01/2014
>[    0.762832] EIP: read_tsc+0x4/0x10
>
>To reproduce:
>
>make ARCH=i386 defconfig
>echo "CONFIG_HIGHMEM64G=y" >> .config
>make ARCH=i386 olddefconfig
>make -j30 ARCH=i386
>
>qemu-system-i386 \
>	-kernel arch/x86/boot/bzImage \
>	-M q35 -cpu pentium3 -no-reboot -m 256 \
>	-initrd rootfs.cpio \
>	--append 'earlycon=uart8250,io,0x3f8,9600n8 rdinit=/sbin/init panic=-1
>console=ttyS0 console=tty' \
>	-nographic -monitor none
>
>initrd or root file system doesn't really matter since the code never
>gets there, but it is available from here:
>	https://github.com/groeck/linux-build-test/blob/master/rootfs/x86/rootfs.cpio.gz
>The qemu version does not matter either (I tried with 2.5 and 3.0).
>
>Reverting the patch fixes the problem.
>
>Guenter
>
>---
>crash log:
>
>...
>[    0.756366] HPET: 3 timers in total, 0 timers will be used for
>per-cpu timer
>[    0.756718] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>[    0.756869] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
>[    0.762233] invalid opcode: 0000 [#1] PTI
>[    0.762435] CPU: 0 PID: 1 Comm: swapper Not tainted
>4.20.0-rc3-next-20181123
>#2
>[    0.762644] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>Ubuntu-1.8.2-1ubuntu1 04/01/2014
>[    0.762832] EIP: read_tsc+0x4/0x10
>[    0.762832] Code: 00 01 00 eb 89 90 55 89 e5 5d c3 90 90 90 90 90 90
>90 90 90 90 90 55 a1 44 5a 8b c5 89 e5 5d c3 8d b6 00 00 00 00 55 89 e5
>57 <0f> ae f0b
>[    0.762832] EAX: c58062c0 EBX: c58062c0 ECX: 00000008 EDX: c4c1f0a0
>[    0.762832] ESI: c58168c0 EDI: 00200086 EBP: cb495ed4 ESP: cb495ed0
>[    0.762832] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS:
>00200002
>[    0.762832] CR0: 80050033 CR2: 00000000 CR3: 0597a000 CR4: 000006f0
>[    0.762832] Call Trace:
>[    0.762832]  tk_setup_internals.constprop.10+0x3d/0x260
>[    0.762832]  timekeeping_notify+0x56/0xc0
>[    0.762832]  __clocksource_select+0xf3/0x150
>[    0.762832]  ? boot_override_clock+0x42/0x42
>[    0.762832]  clocksource_done_booting+0x2d/0x3b
>[    0.762832]  do_one_initcall+0x68/0x15e
>[    0.762832]  ? set_debug_rodata+0xf/0xf
>[    0.762832]  kernel_init_freeable+0xec/0x18b
>[    0.762832]  ? rest_init+0x80/0x80
>[    0.762832]  kernel_init+0x8/0xf0
>[    0.762832]  ret_from_fork+0x2e/0x38
>[    0.762832] Modules linked in:
>[    0.762832] ---[ end trace ba4ba4587aec46c9 ]---
>[    0.762832] EIP: read_tsc+0x4/0x10
>[    0.762832] Code: 00 01 00 eb 89 90 55 89 e5 5d c3 90 90 90 90 90 90
>90 90 90 90 90 55 a1 44 5a 8b c5 89 e5 5d c3 8d b6 00 00 00 00 55 89 e5
>57 <0f> ae f0b
>[    0.762832] EAX: c58062c0 EBX: c58062c0 ECX: 00000008 EDX: c4c1f0a0
>[    0.762832] ESI: c58168c0 EDI: 00200086 EBP: cb495ed4 ESP: c597f47c
>[    0.762832] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS:
>00200002
>[    0.762832] CR0: 80050033 CR2: 00000000 CR3: 0597a000 CR4: 000006f0
>
>---
>bisect log:
>
># bad: [8c9733fd9806c71e7f2313a280f98cb3051f93df] Add linux-next
>specific files for 20181123
># good: [9ff01193a20d391e8dbce4403dd5ef87c7eaaca6] Linux 4.20-rc3
>git bisect start 'HEAD' 'v4.20-rc3'
># good: [34c2101b4f765edf1b91c2837da9c60fbf9f6912] Merge
>remote-tracking branch 'spi-nor/spi-nor/next'
>git bisect good 34c2101b4f765edf1b91c2837da9c60fbf9f6912
># good: [15367a0657fc8027ff3466bf0202bde9f270259b] Merge
>remote-tracking branch 'kgdb/kgdb-next'
>git bisect good 15367a0657fc8027ff3466bf0202bde9f270259b
># bad: [d29686ab179c34c5dbaac067a9effbeeb6a8073e] Merge remote-tracking
>branch 'soundwire/next'
>git bisect bad d29686ab179c34c5dbaac067a9effbeeb6a8073e
># bad: [7cd63670817c236ccaf21ffe9d7b4921afeab130] Merge remote-tracking
>branch 'tip/auto-latest'
>git bisect bad 7cd63670817c236ccaf21ffe9d7b4921afeab130
># good: [f9c8ebdcb052214954136426990e13a88e45e906] Merge
>remote-tracking branch 'audit/next'
>git bisect good f9c8ebdcb052214954136426990e13a88e45e906
># good: [4142a8a10e7673fa71ff4cb5b4693c4dda299f7c] Merge
>remote-tracking branch 'spi/for-next'
>git bisect good 4142a8a10e7673fa71ff4cb5b4693c4dda299f7c
># good: [fc922a4c7c72131f6c65e4af4e36ff25f3af1485] Merge branch
>'x86/cpu'
>git bisect good fc922a4c7c72131f6c65e4af4e36ff25f3af1485
># good: [906d11c1ff007ad18e2f3477cca04c437ce19c64] Merge branch
>'x86/microcode'
>git bisect good 906d11c1ff007ad18e2f3477cca04c437ce19c64
># good: [d836e1d42739a86738dd92a1b7ab6729b2485cba] Merge branch
>'x86/platform'
>git bisect good d836e1d42739a86738dd92a1b7ab6729b2485cba
># bad: [191bba684b7459842e72b52718ec61f8bdbd8499] Merge branch
>'x86/timers'
>git bisect bad 191bba684b7459842e72b52718ec61f8bdbd8499
># good: [f9cc0921aa4edd9bd4dd6943d5e38f69a301e8ee] Merge branch
>'x86/pti'
>git bisect good f9cc0921aa4edd9bd4dd6943d5e38f69a301e8ee
># bad: [2e94061096c5c3aa6c3fe3ec2bec176c1f9c1b07] x86/TSC: Use RDTSCP
>git bisect bad 2e94061096c5c3aa6c3fe3ec2bec176c1f9c1b07
># good: [a786ef152cdcfebc923a67f63c7815806eefcf81] x86/tsc: Make
>calibration refinement more robust
>git bisect good a786ef152cdcfebc923a67f63c7815806eefcf81
># first bad commit: [2e94061096c5c3aa6c3fe3ec2bec176c1f9c1b07] x86/TSC:
>Use RDTSCP

Right, because that cpu predates RDTSCP, so it needs to use a fallback.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
