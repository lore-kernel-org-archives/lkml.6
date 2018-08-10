Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=BUG6152_INVALID_DATE_TZ_ABSURD,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,L_SPAM_TOOL_13,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4C5C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28715223D9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28715223D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mageia.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeHJJbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:31:08 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:17754 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbeHJJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:31:08 -0400
From:   Thomas Backlund <tmb@mageia.org>
Subject: disabling psp in bios causes errors in dmesg
To:     <linux-crypto@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <thomas.lendacky@amd.com>, <gary.hook@amd.com>
Message-ID: <3be85fc6-6323-b368-747f-b7650b3898b4@mageia.org>
Date:   Fri, 10 Aug 2018 10:02:41 +0259
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-WatchGuard-Spam-ID: str=0001.0A0C0202.5B6D388C.00CC,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.195
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is tested on kernel 4.17.14

hw:

MSI X399 GAMING PRO CARBON AC (MS-7B09) bios 1.A0

AMD Ryzen Threadripper 1950X


Disabling psp in bios gets this in the logs:


[  246.748978] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  246.748978] systemd-udevd   D    0   724    716 0x80000124
[  246.748980] Call Trace:
[  246.748986]  ? __schedule+0x234/0x840
[  246.748988]  schedule+0x28/0x80
[  246.748993]  __sev_do_cmd_locked+0x1f0/0x270 [ccp]
[  246.748996]  ? wait_woken+0x80/0x80
[  246.748997]  ? 0xffffffffc0683000
[  246.749001]  __sev_platform_init_locked+0x2f/0x80 [ccp]
[  246.749001]  ? mutex_lock+0xe/0x30
[  246.749004]  sev_platform_init+0x1d/0x30 [ccp]
[  246.749007]  psp_pci_init+0x40/0xe0 [ccp]
[  246.749008]  ? 0xffffffffc0683000
[  246.749011]  sp_mod_init+0x16/0x1000 [ccp]
[  246.749012]  do_one_initcall+0x46/0x1c3
[  246.749014]  ? _cond_resched+0x15/0x30
[  246.749017]  ? kmem_cache_alloc_trace+0x3a/0x170
[  246.749019]  do_init_module+0x5a/0x210
[  246.749020]  load_module+0x215b/0x2530
[  246.749021]  ? kmem_cache_alloc_node_trace+0x45/0x190
[  246.749024]  ? vmap_page_range_noflush+0x24d/0x320
[  246.749026]  ? __do_sys_init_module+0x136/0x180
[  246.749026]  ? _cond_resched+0x15/0x30
[  246.749027]  __do_sys_init_module+0x136/0x180
[  246.749029]  do_syscall_64+0x55/0x100
[  246.749031]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  246.749032] RIP: 0033:0x7ffb1a09018a
[  246.749033] RSP: 002b:00007ffe196680c8 EFLAGS: 00000246 ORIG_RAX: 
00000000000000af
[  246.749034] RAX: ffffffffffffffda RBX: 00005562bb20d080 RCX: 
00007ffb1a09018a
[  246.749034] RDX: 00007ffb1994e6f8 RSI: 0000000000029e50 RDI: 
00005562bba5e710
[  246.749035] RBP: 00007ffb1994e6f8 R08: 0000000000000004 R09: 
0000000000000000
[  246.749035] R10: 0000000000000005 R11: 0000000000000246 R12: 
00005562bba5e710
[  246.749036] R13: 0000000000020000 R14: 00005562bb1fde70 R15: 
00005562bb20d080


Should it not detect that its disabled and bail out ?

--

Thomas


