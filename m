Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2659C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB8420839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB8420839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeHaPgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:36:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43838 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:36:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so10887253wre.10;
        Fri, 31 Aug 2018 04:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=18xpDzUg4aSI8Y+d+E4thH9CpqxjdJP1ZXHicn24XBU=;
        b=XTYFJZ64DNxsQbcuP7AeaHWW6u3RyZrgn1VfhQ98+0W8FXu2n3hgtW/+Yp6uRxOShx
         4rNrKPDSlbjuaE0NUHLK/6q1J9l/ZZUi+06MFTdEFD6L7ERHBkoigcW8DxJJFwpbmJ7E
         Yiu7xUWbVqiL7V46id+Fd2uD3OMIAWvhADpua/CgGH4xCMa6THM5Ar1bJ3bAB7FWNUZ9
         +cXT7+gvIdaJNpUbFFbZCcWxD0LEj5wfR1RJq0d9YWlF93Xpy6ozeb7i43NR2Klx/bCy
         xr0c7UPCnLl9vbmYQ8ymoIMod52yA4xGNatX44N+IylHXJrv52TxwBMU/4DBgPcJmZc7
         lHpA==
X-Gm-Message-State: APzg51DoGM/iCMDv7XtdQ4H+YCBQKnL1Kb6+SV+SJJuOmWUy7K7+SKD4
        z0KZP1IWjtesDeI5MkX7DCwoV9euUvE=
X-Google-Smtp-Source: ANB0Vda2Hne1QgBGY5uCPYIzhFmz2EKi0V36ribgbDK8x/Qve/jYhDCDzmJEljebhgxBiDhNXjiYPw==
X-Received: by 2002:adf:9ab7:: with SMTP id a52-v6mr377405wrc.75.1535714945310;
        Fri, 31 Aug 2018 04:29:05 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id a11-v6sm8843630wrr.81.2018.08.31.04.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 04:29:04 -0700 (PDT)
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "mhocko@kernel.org" <mhocko@kernel.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
 <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz>
 <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
 <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
 <CAGM2reYcwyOcKrO=WhB3Cf0FNL3ZearC=KvxmTNUU6rkWviQOg@mail.gmail.com>
 <83d035f1-40b4-bed8-6113-f4c5a0c4d22f@suse.cz>
 <c4d46b63-5237-d002-faf5-4e0749d825d7@suse.cz>
 <7aee9274-9e8e-4a40-a9e5-3c9ef28511b7@microsoft.com>
 <87516e50-a17c-6c80-e9b5-ba68eda9ce33@microsoft.com>
 <597f3f35-6aad-6ca1-ba03-b93444b1cb5f@suse.cz>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0acf1c74-1bd3-e425-f92b-5d084ff954a4@suse.cz>
Date:   Fri, 31 Aug 2018 13:29:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <597f3f35-6aad-6ca1-ba03-b93444b1cb5f@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018, 01:26 PM, Jiri Slaby wrote:
> On 08/30/2018, 05:45 PM, Pasha Tatashin wrote:
>> Hi Jiri,
>>
>> I believe this bug is fixed with this change:
>>
>> d39f8fb4b7776dcb09ec3bf7a321547083078ee3
>> mm: make DEFERRED_STRUCT_PAGE_INIT explicitly depend on SPARSEMEM
> 
> Hi,
> 
> it only shifted. Enabling only SPARSEMEM works fine, enabling also
> DEFERRED_STRUCT_PAGE_INIT doesn't even boot – immediately reboots
> (config attached).

Wow, earlyprintk is up at the moment of crash already:
[    0.000000] Linux version 4.19.0-rc1-pae (jslaby@kunlun) (gcc version
4.8.5 (SUSE Linux)) #4 SMP PREEMPT Fri Aug 31 13:18:33 CEST 2018
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007cfdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007cfe0000-0x000000007cffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff]
reserved
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.0.0-prebuilt.qemu-project.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000002] kvm-clock: cpu 0, msr 1d12c001, primary cpu clock
[    0.000002] kvm-clock: using sched offset of 1597117996 cycles
[    0.001395] clocksource: kvm-clock: mask: 0xffffffffffffffff
max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.006245] tsc: Detected 2808.000 MHz processor
[    0.010055] last_pfn = 0x7cfe0 max_arch_pfn = 0x1000000
[    0.011483] x86/PAT: PAT not supported by CPU.
[    0.012580] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC-
UC
[    0.020644] found SMP MP-table at [mem 0x000f5d20-0x000f5d2f] mapped
at [(ptrval)]
[    0.023528] Scanning 1 areas for low memory corruption
[    0.025047] ACPI: Early table checksum verification disabled
[    0.026581] ACPI: RSDP 0x00000000000F5B40 000014 (v00 BOCHS )
[    0.028031] ACPI: RSDT 0x000000007CFE157C 000030 (v01 BOCHS  BXPCRSDT
00000001 BXPC 00000001)
[    0.029996] ACPI: FACP 0x000000007CFE1458 000074 (v01 BOCHS  BXPCFACP
00000001 BXPC 00000001)
[    0.032234] ACPI: DSDT 0x000000007CFE0040 001418 (v01 BOCHS  BXPCDSDT
00000001 BXPC 00000001)
[    0.034662] ACPI: FACS 0x000000007CFE0000 000040
[    0.036126] ACPI: APIC 0x000000007CFE14CC 000078 (v01 BOCHS  BXPCAPIC
00000001 BXPC 00000001)
[    0.038235] ACPI: HPET 0x000000007CFE1544 000038 (v01 BOCHS  BXPCHPET
00000001 BXPC 00000001)
[    0.040373] No NUMA configuration found
[    0.041407] Faking a node at [mem 0x0000000000000000-0x000000007cfdffff]
[    0.043306] NODE_DATA(0) allocated [mem 0x367fc000-0x367fcfff]
[    0.044958] 1127MB HIGHMEM available.
[    0.045940] 871MB LOWMEM available.
[    0.046978]   mapped low ram: 0 - 367fe000
[    0.048200]   low ram: 0 - 367fe000
[    0.050830] Zone ranges:
[    0.051625]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.053295]   Normal   [mem 0x0000000001000000-0x00000000367fdfff]
[    0.054921]   HighMem  [mem 0x00000000367fe000-0x000000007cfdffff]
[    0.056408] Movable zone start for each node
[    0.057452] Early memory node ranges
[    0.058377]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.059946]   node   0: [mem 0x0000000000100000-0x000000007cfdffff]
[    0.061825] Reserved but unavailable: 12418 pages
[    0.061828] Initmem setup node 0 [mem
0x0000000000001000-0x000000007cfdffff]
[    0.074252] Using APIC driver default
[    0.075615] ACPI: PM-Timer IO Port: 0x608
[    0.076574] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.077995] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI
0-23
[    0.079610] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.081111] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.082786] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.084297] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.085933] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.087729] Using ACPI (MADT) for SMP configuration information
[    0.089119] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.090351] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.091561] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.093361] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.096382] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.098130] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.099729] [mem 0x7d000000-0xfeffbfff] available for PCI devices
[    0.101034] Booting paravirtualized kernel on KVM
[    0.102034] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.104207] random: get_random_bytes called from
start_kernel+0x77/0x47c with crng_init=0
[    0.105913] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1
nr_node_ids:1
[    0.107548] percpu: Embedded 31 pages/cpu @(ptrval) s94604 r0 d32372
u126976
[    0.109019] KVM setup async PF for cpu 0
[    0.109825] kvm-stealtime: cpu 0, msr 367e5300
[    0.110755] Built 1 zonelists, mobility grouping on.  Total pages: 509908
[    0.112113] Policy zone: HighMem
[    0.112755] Kernel command line: earlyprintk=serial
[    0.113773] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.115788] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.117465] Initializing CPU#0
[    0.118522] Initializing HighMem for node 0 (000367fe:0007cfe0)
[    0.161140] BUG: unable to handle kernel NULL pointer dereference at
00000028
[    0.162671] *pdpt = 0000000000000000 *pde = f000ff53f000ff53
[    0.163857] Oops: 0000 [#1] PREEMPT SMP PTI
[    0.164862] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc1-pae #4
openSUSE Tumbleweed (unreleased)
[    0.167041] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[    0.169389] EIP: free_unref_page_prepare.part.75+0x26/0x50
[    0.170337] Code: 00 00 00 00 e8 e7 a4 e9 ff 89 d1 c1 ea 11 55 8b 14
d5 84 d2 1c dd c1 e9 07 89 e5 56 81 e1 fc 03 00 00 53 89 cb c1 eb 05 89
ce <8b> 14 9a 83 e6 1f b9 1d 00 00 00 29 f1 d3 ea 83 e2 07 89 50 10 b8
[    0.174205] EAX: f4cfa000 EBX: 0000000a ECX: 00000150 EDX: 00000000
[    0.175422] ESI: 00000150 EDI: 00d80000 EBP: dcf2be50 ESP: dcf2be48
[    0.176724] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210007
[    0.178075] CR0: 80050033 CR2: 00000028 CR3: 1d118000 CR4: 000006b0
[    0.179354] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.180629] DR6: fffe0ff0 DR7: 00000400
[    0.181400] Call Trace:
[    0.181907]  free_unref_page+0x3a/0x90
[    0.182642]  __free_pages+0x25/0x30
[    0.183748]  free_highmem_page+0x1e/0x50
[    0.184594]  add_highpages_with_active_regions+0x123/0x125
[    0.185813]  set_highmem_pages_init+0x83/0x8d
[    0.186847]  mem_init+0x26/0x240
[    0.187590]  ? vprintk_func+0x38/0xd0
[    0.188427]  ? idt_setup_from_table.constprop.1+0x45/0x70
[    0.189666]  ? set_intr_gate+0x39/0x40
[    0.190551]  ? general_protection+0xc/0xc
[    0.191818]  ? update_intr_gate+0x1e/0x20
[    0.192817]  ? kvm_apf_trap_init+0x17/0x19
[    0.193800]  ? trap_init+0x77/0x7d
[    0.194644]  start_kernel+0x203/0x47c
[    0.195491]  ? set_init_arg+0x57/0x57
[    0.196385]  i386_start_kernel+0x143/0x146
[    0.197351]  startup_32_smp+0x164/0x168
[    0.198232] Modules linked in:
[    0.199072] CR2: 0000000000000028
[    0.199983] ---[ end trace 69f4a864c8bd9bcd ]---
[    0.201198] EIP: free_unref_page_prepare.part.75+0x26/0x50
[    0.202610] Code: 00 00 00 00 e8 e7 a4 e9 ff 89 d1 c1 ea 11 55 8b 14
d5 84 d2 1c dd c1 e9 07 89 e5 56 81 e1 fc 03 00 00 53 89 cb c1 eb 05 89
ce <8b> 14 9a 83 e6 1f b9 1d 00 00 00 29 f1 d3 ea 83 e2 07 89 50 10 b8
[    0.206942] EAX: f4cfa000 EBX: 0000000a ECX: 00000150 EDX: 00000000
[    0.208177] ESI: 00000150 EDI: 00d80000 EBP: dcf2be50 ESP: dd11fefc
[    0.209438] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210007
[    0.210826] CR0: 80050033 CR2: 00000028 CR3: 1d118000 CR4: 000006b0
[    0.212155] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.213752] DR6: fffe0ff0 DR7: 00000400


> 
> thanks,
> 


-- 
js
suse labs
