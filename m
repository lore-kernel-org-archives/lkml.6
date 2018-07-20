Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45E1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622B32084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622B32084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeGTIgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:36:42 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:33379 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727160AbeGTIgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:36:42 -0400
Received: from [192.168.0.5] (ip5f5bd29d.dynamic.kabel-deutschland.de [95.91.210.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 062422012BA076;
        Fri, 20 Jul 2018 09:49:41 +0200 (CEST)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel+linux-x86@molgen.mpg.de>
Subject: UBSAN: Undefined behaviour in arch/x86/events/amd/ibs.c:582:24:
 member access within null pointer of type 'struct perf_event'
Message-ID: <eb1d1d7d-7ca6-677d-2ae5-911935706516@molgen.mpg.de>
Date:   Fri, 20 Jul 2018 09:49:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Enabling the undefined behavior sanitizer and building GNU/Linux 
4.18-rc5+ (with some unrelated commits) with GCC 8.1.0 from Debian 
Sid/unstable, the warning below is shown.

> [    2.111913] ================================================================================
> [    2.111917] UBSAN: Undefined behaviour in arch/x86/events/amd/ibs.c:582:24
> [    2.111919] member access within null pointer of type 'struct perf_event'
> [    2.111926] CPU: 0 PID: 144 Comm: udevadm Not tainted 4.18.0-rc5-00316-g4864b68cedf2 #104
> [    2.111928] Hardware name: ASROCK E350M1/E350M1, BIOS TIMELESS 01/01/1970
> [    2.111930] Call Trace:
> [    2.111943]  dump_stack+0x55/0x89
> [    2.111949]  ubsan_epilogue+0xb/0x33
> [    2.111953]  handle_null_ptr_deref+0x7f/0x90
> [    2.111958]  __ubsan_handle_type_mismatch_v1+0x55/0x60
> [    2.111964]  perf_ibs_handle_irq+0x596/0x620
> [    2.111968]  ? perf_output_sample+0x771/0xa90
> [    2.111971]  ? perf_prepare_sample+0x48a/0x8b0
> [    2.111976]  ? sched_clock_cpu+0x13/0x200
> [    2.111978]  ? perf_prepare_sample+0x8b0/0x8b0
> [    2.111982]  ? perf_output_end+0xd/0x10
> [    2.111985]  ? perf_event_output_forward+0x4e/0x70
> [    2.111990]  ? __perf_event_overflow+0x7b/0x1a0
> [    2.111993]  ? perf_event_overflow+0x15/0x20
> [    2.111996]  ? x86_pmu_handle_irq+0x180/0x230
> [    2.112001]  ? x86_pmu_enable_all+0x6c/0x1b0
> [    2.112005]  ? x86_pmu_commit_txn+0xc1/0x190
> [    2.112012]  ? native_sched_clock+0x32/0x120
> [    2.112017]  perf_ibs_nmi_handler+0x2b/0x65
> [    2.112020]  nmi_handle+0x8f/0x240
> [    2.112025]  default_do_nmi+0x4e/0x2e0
> [    2.112028]  do_nmi+0xb7/0x100
> [    2.112032]  nmi+0x51/0x6c
> [    2.112036] EIP: x86_pmu_enable_all+0x6c/0x1b0
> [    2.112037] Code: 10 01 00 00 8b 45 e8 8b 75 e4 81 ca 00 00 40 00 f7 d0 21 d0 8b 93 14 01 00 00 f7 d6 8b 9b 20 01 00 00 21 d6 89 d9 89 f2 0f 30 <0f> 1f 44 00 00 47 39 3d 08 cd 40 d6 0f 8e a1 00 00 00 83 ff 3f 0f 
> [    2.112079] EAX: 00530076 EBX: c0010000 ECX: c0010000 EDX: 00000000
> [    2.112081] ESI: 00000000 EDI: 00000000 EBP: f2cffaf0 ESP: f2cffacc
> [    2.112083] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000046
> [    2.112089]  x86_pmu_enable+0x162/0x480
> [    2.112094]  perf_pmu_enable.part.39+0x14/0x30
> [    2.112097]  ctx_resched+0xa4/0x130
> [    2.112101]  __perf_event_enable+0x1d0/0x390
> [    2.112104]  ? ctx_resched+0x130/0x130
> [    2.112107]  event_function+0xb2/0x1b0
> [    2.112111]  ? task_function_call+0x80/0x80
> [    2.112113]  remote_function+0x45/0x60
> [    2.112118]  flush_smp_call_function_queue+0x6c/0x1e0
> [    2.112123]  generic_smp_call_function_single_interrupt+0x12/0x2a
> [    2.112126]  smp_call_function_single_interrupt+0x3c/0x1c0
> [    2.112129]  call_function_single_interrupt+0x3c/0x44
> [    2.112134] EIP: kmem_cache_alloc+0x65/0x3e0
> [    2.112135] Code: 45 e4 89 da e8 1c d8 f9 ff 85 c0 0f 85 eb 01 00 00 e9 ef 00 00 00 8b 45 e4 89 45 e8 8b 75 e8 85 f6 0f 84 d5 01 00 00 8b 45 e8 <8b> 30 64 8b 4e 04 64 03 35 28 71 51 d6 85 f6 0f 84 e9 02 00 00 8b 
> [    2.112172] EAX: f4c60300 EBX: 00000000 ECX: 00000001 EDX: 00611ac0
> [    2.112174] ESI: f4c60300 EDI: f4c60300 EBP: f2cffc5c ESP: f2cffc28
> [    2.112177] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000286
> [    2.112183]  ? create_object+0x3a/0x3a0
> [    2.112186]  create_object+0x3a/0x3a0
> [    2.112190]  ? create_object+0x270/0x3a0
> [    2.112194]  kmemleak_alloc+0x9b/0xb0
> [    2.112199]  __kmalloc_track_caller+0x18c/0x420
> [    2.112203]  ? __alloc_skb+0x6c/0x2b0
> [    2.112208]  __kmalloc_reserve.isra.16+0x28/0x80
> [    2.112211]  __alloc_skb+0x6c/0x2b0
> [    2.112215]  alloc_uevent_skb+0x4a/0x160
> [    2.112218]  ? add_uevent_var+0x57/0x130
> [    2.112222]  kobject_uevent_env+0x599/0xa10
> [    2.112228]  ? device_get_devnode+0x1a0/0x1a0
> [    2.112231]  kobject_synth_uevent+0x36e/0x515
> [    2.112234]  ? mntput+0x2f/0x60
> [    2.112239]  uevent_store+0x2b/0x70
> [    2.112241]  ? __check_heap_object+0x4c/0x190
> [    2.112244]  ? dev_err+0x50/0x50
> [    2.112247]  dev_attr_store+0x33/0x60
> [    2.112249]  ? dev_uevent_name+0x40/0x40
> [    2.112254]  sysfs_kf_write+0x5e/0x100
> [    2.112257]  ? mutex_lock+0x2a/0x80
> [    2.112260]  ? sysfs_kf_bin_read+0x170/0x170
> [    2.112263]  kernfs_fop_write+0x132/0x250
> [    2.112266]  ? kernfs_fop_open+0x660/0x660
> [    2.112270]  __vfs_write+0x52/0x2d0
> [    2.112273]  ? kmemleak_free+0x6d/0x90
> [    2.112277]  ? kmem_cache_free+0xc6/0x440
> [    2.112281]  vfs_write+0xb0/0x2b0
> [    2.112284]  ? do_sys_open+0x174/0x2a0
> [    2.112287]  ksys_write+0x51/0xc0
> [    2.112291]  sys_write+0x16/0x20
> [    2.112294]  do_fast_syscall_32+0xce/0x3e0
> [    2.112298]  entry_SYSENTER_32+0x4e/0x7c
> [    2.112301] EIP: 0xb7f0fbb5
> [    2.112302] Code: 89 e5 8b 55 08 85 d2 8b 80 5c cd ff ff 74 02 89 02 5d c3 8b 04 24 c3 8b 1c 24 c3 8b 3c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
> [    2.112339] EAX: ffffffda EBX: 00000003 ECX: bfadbf54 EDX: 00000003
> [    2.112341] ESI: 01f0a640 EDI: 00000003 EBP: bfadaf0c ESP: bfadae80
> [    2.112344] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
> [    2.112347] ================================================================================


Kind regards,

Paul
