Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C6620850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C6620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeGTIUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:20:07 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48515 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbeGTIUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:20:07 -0400
Received: from [192.168.0.5] (ip5f5bd29d.dynamic.kabel-deutschland.de [95.91.210.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9D10F2012BA076;
        Fri, 20 Jul 2018 09:33:10 +0200 (CEST)
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     x86@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel+linux-x86@molgen.mpg.de>
Subject: UBSAN: Undefined behaviour in arch/x86/events/core.c:668:25
Message-ID: <a6265475-25ff-0a46-4cd0-2c7a1176b0e5@molgen.mpg.de>
Date:   Fri, 20 Jul 2018 09:33:09 +0200
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

> [    1.945853] ================================================================================
> [    1.946192] UBSAN: Undefined behaviour in arch/x86/events/core.c:668:25
> [    1.946309] member access within null pointer of type 'struct perf_event'
> [    1.946500] CPU: 0 PID: 127 Comm: perf_4.17 Not tainted 4.18.0-rc5-00316-g4864b68cedf2 #104
> [    1.946502] Hardware name: ASROCK E350M1/E350M1, BIOS TIMELESS 01/01/1970
> [    1.946505] Call Trace:
> [    1.946518]  dump_stack+0x55/0x89
> [    1.946524]  ubsan_epilogue+0xb/0x33
> [    1.946529]  handle_null_ptr_deref+0x7f/0x90
> [    1.946534]  __ubsan_handle_type_mismatch_v1+0x55/0x60
> [    1.946540]  x86_pmu_enable_all+0x165/0x1b0
> [    1.946544]  x86_pmu_enable+0x162/0x480
> [    1.946550]  perf_pmu_enable.part.39+0x14/0x30
> [    1.946553]  ctx_resched+0xa4/0x130
> [    1.946558]  __perf_install_in_context+0x21e/0x3e0
> [    1.946562]  ? memcg_kmem_get_cache+0xb2/0x3a0
> [    1.946565]  ? memcg_kmem_get_cache+0xb2/0x3a0
> [    1.946569]  remote_function+0x45/0x60
> [    1.946574]  generic_exec_single+0x102/0x210
> [    1.946579]  ? get_empty_filp+0x6b/0x260
> [    1.946582]  ? task_function_call+0x80/0x80
> [    1.946586]  smp_call_function_single+0xf0/0x150
> [    1.946590]  ? get_empty_filp+0x102/0x260
> [    1.946594]  ? alloc_file+0x9b/0x1e0
> [    1.946598]  perf_install_in_context+0x14e/0x1d0
> [    1.946602]  ? perf_install_in_context+0x1d0/0x1d0
> [    1.946607]  __do_sys_perf_event_open+0x413/0xfa0
> [    1.946616]  sys_perf_event_open+0x21/0x30
> [    1.946619]  do_fast_syscall_32+0xce/0x3e0
> [    1.946624]  entry_SYSENTER_32+0x4e/0x7c
> [    1.946628] EIP: 0xb7f73bb5
> [    1.946630] Code: 89 e5 8b 55 08 85 d2 8b 80 5c cd ff ff 74 02 89 02 5d c3 8b 04 24 c3 8b 1c 24 c3 8b 3c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
> [    1.946699] EAX: ffffffda EBX: 00e3f49c ECX: ffffffff EDX: 00000000
> [    1.946701] ESI: ffffffff EDI: 00000008 EBP: 00000000 ESP: bfe3257c
> [    1.946704] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
> [    1.946708] ================================================================================


Kind regards,

Paul
