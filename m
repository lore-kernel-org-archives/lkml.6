Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4FAC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2A120685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2A120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeJaKDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:03:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:45374 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbeJaKDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:03:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 18:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="102079869"
Received: from lifengji-mobl.ccr.corp.intel.com ([10.255.29.174])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2018 18:07:10 -0700
Message-ID: <1540948029.2254.57.camel@intel.com>
Subject: Re: 4.18: early boot crash in thermal_cooling_device_destroy_sysfs
From:   Zhang Rui <rui.zhang@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 31 Oct 2018 09:07:09 +0800
In-Reply-To: <6eaa3393-f7aa-8f1a-a5c4-72aaafa2d1f9@infradead.org>
References: <c1e0c7c7-2ed9-39fd-b3e0-aebf4d5839a3@infradead.org>
         <4a200a32-7d7f-1248-2ecd-74600083b1c1@infradead.org>
         <3743579.MQBqPkux9Q@aspire.rjw.lan>
         <6eaa3393-f7aa-8f1a-a5c4-72aaafa2d1f9@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy,

On 五, 2018-10-26 at 20:35 -0700, Randy Dunlap wrote:
> On 10/26/18 2:14 AM, Rafael J. Wysocki wrote:
> > 
> > On Monday, October 22, 2018 8:37:25 PM CEST Randy Dunlap wrote:
> > > 
> > > 
> > > On 8/16/18 2:33 PM, Randy Dunlap wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > Sorry for the photo.  That's all I have available so far.
> > > > 
> > > > https://www.infradead.org/~rdunlap/doc/IMG_20180816_133254743_H
> > > > DR.jpg
> > > > 
> > > > 
> > > > Does anyone recognize this?
> > > > 
> > > > This is an (older) Toshiba laptop.  The kernel .config is
> > > > mostly an
> > > > allmodconfig with some DEBUG options disabled and other options
> > > > enabled
> > > > so that it can boot without using an initramfs.  (and with
> > > > COMPILE_TEST
> > > > disabled :)
> > > > 
> > > > 
> > > > The full kernel .config file is attached.
> > > > 
> > > > Thanks,
> > > > 
> > > This is a result of CONFIG_DEBUG_TEST_DRIVER_REMOVE=y.
> > > [switch from 64-bit to 32-bit machine]
> > > 
> > > 
> > > When using CONFIG_DEBUG_VM=y, it BUGs at:
> > > [    5.553603] ------------[ cut here ]------------
> > > [    5.553733] kernel BUG at arch/x86/mm/physaddr.c:75!
> > > [    5.557788] invalid opcode: 0000 [#1] PREEMPT SMP
> > > DEBUG_PAGEALLOC
> > > [    5.558738] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.19.0-
> > > rc7 #4
> > > [    5.558738] Hardware name: Dell Inc. Inspiron
> > > 1318                   /0C236D, BIOS A04 01/15/2009
> > > [    5.558738] EIP: __phys_addr+0x40/0x90
> > > [    5.558738] Code: 00 40 75 2e 8b 15 00 57 23 d5 85 d2 74 12 89
> > > d9 c1 e9 0c 39 ca 72 5b e8 2e ca ff ff 39 d8 75 4a 89 d8 5b 5d c3
> > > 8d 74 26 00 90 <0f> 0b 8d b6 00 00 00 00 8b 0d 80 56 23 d5 8d 91
> > > 00 00 80 00 39 d0
> > > [    5.558738] EAX: 6b6b6b6b EBX: 6b6b6b6b ECX: 00140011 EDX:
> > > 00000000
> > > [    5.558738] ESI: f4890000 EDI: d4a58d60 EBP: f40c1e0c ESP:
> > > f40c1e08
> > > [    5.558738] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> > > EFLAGS: 00210a97
> > > [    5.558738] CR0: 80050033 CR2: 00000000 CR3: 14cad000 CR4:
> > > 000406d0
> > > [    5.558738] Call Trace:
> > > [    5.558738]  kfree+0x1f/0x160
> > > [    5.558738]  thermal_cooling_device_destroy_sysfs+0x11/0x20
> > > [    5.558738]  thermal_cooling_device_unregister+0x168/0x180
> > > [    5.558738]  acpi_pss_perf_exit.isra.4+0x32/0x50
> > > [    5.558738]  acpi_processor_stop+0x4d/0x60
> > > [    5.558738]  really_probe+0xa3/0x3e0
> > > [    5.558738]  driver_probe_device+0x5b/0x120
> > > [    5.558738]  __driver_attach+0xd9/0x100
> > > [    5.558738]  ? driver_probe_device+0x120/0x120
> > > [    5.558738]  bus_for_each_dev+0x56/0x90
> > > [    5.558738]  driver_attach+0x14/0x20
> > > [    5.558738]  ? driver_probe_device+0x120/0x120
> > > [    5.558738]  bus_add_driver+0x117/0x210
> > > [    5.558738]  driver_register+0x61/0xb0
> > > [    5.558738]  acpi_processor_driver_init+0x19/0x88
> > > [    5.558738]  ? acpi_pci_slot_init+0xf/0xf
> > > [    5.558738]  do_one_initcall+0x3e/0x15a
> > > [    5.558738]  ? do_early_param+0x75/0x75
> > > [    5.558738]  kernel_init_freeable+0x170/0x1f3
> > > [    5.558738]  ? rest_init+0xcd/0xcd
> > > [    5.558738]  kernel_init+0x8/0xdb
> > > [    5.558738]  ret_from_fork+0x2e/0x38
> > > [    5.558738] Modules linked in:
> > > [    5.625269] _warn_unseeded_randomness: 1 callbacks suppressed
> > > [    5.625272] random: get_random_bytes called from
> > > init_oops_id+0x3a/0x40 with crng_init=0
> > > [    5.629758] ---[ end trace 65b17bf4d18e7692 ]---
> > > [    5.631573] EIP: __phys_addr+0x40/0x90
> > > [    5.633242] Code: 00 40 75 2e 8b 15 00 57 23 d5 85 d2 74 12 89
> > > d9 c1 e9 0c 39 ca 72 5b e8 2e ca ff ff 39 d8 75 4a 89 d8 5b 5d c3
> > > 8d 74 26 00 90 <0f> 0b 8d b6 00 00 00 00 8b 0d 80 56 23 d5 8d 91
> > > 00 00 80 00 39 d0
> > > [    5.638618] EAX: 6b6b6b6b EBX: 6b6b6b6b ECX: 00140011 EDX:
> > > 00000000
> > > [    5.640703] ESI: f4890000 EDI: d4a58d60 EBP: f40c1e0c ESP:
> > > d4cb13dc
> > > [    5.642801] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> > > EFLAGS: 00210a97
> > > [    5.645053] CR0: 80050033 CR2: 00000000 CR3: 14cad000 CR4:
> > > 000406d0
> > > [    5.647179] Kernel panic - not syncing: Fatal exception
> > > [    5.648172] Kernel Offset: 0x13000000 from 0xc1000000
> > > (relocation range: 0xc0000000-0xf77fdfff)
> > > [    5.648172] ---[ end Kernel panic - not syncing: Fatal
> > > exception ]---
> > > 
> > > 
> > > When not using CONFIG_DEBUG_VM, it BUGs in kfree:
> > > [    5.497864] ------------[ cut here ]------------
> > > [    5.498215] kernel BUG at mm/slub.c:3901!
> > > [    5.501739] invalid opcode: 0000 [#1] PREEMPT SMP
> > > [    5.502720] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-
> > > rc7 #3
> > > [    5.502720] Hardware name: Dell Inc. Inspiron
> > > 1318                   /0C236D, BIOS A04 01/15/2009
> > > [    5.502720] EIP: kfree+0x117/0x150
> > > [    5.502720] Code: 74 21 8b 06 31 d2 f6 c4 80 74 04 0f b6 56 31
> > > 89 f0 e8 7d e0 fa ff e9 7b ff ff ff 8d b4 26 00 00 00 00 90 8b 46
> > > 04 a8 01 75 d8 <0f> 0b 8d b4 26 00 00 00 00 8b 75 f0 ff 75 ec 89
> > > d9 89 f8 6a 01 53
> > > [    5.502720] EAX: 00000100 EBX: 6b6b6b6b ECX: 00140011 EDX:
> > > 00000000
> > > [    5.502720] ESI: f67dac70 EDI: ccc4aca0 EBP: f4083e28 ESP:
> > > f4083e10
> > > [    5.502720] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> > > EFLAGS: 00210246
> > > [    5.502720] CR0: 80050033 CR2: ffd14000 CR3: 0ce94000 CR4:
> > > 000406d0
> > > [    5.502720] Call Trace:
> > > [    5.502720]  thermal_cooling_device_destroy_sysfs+0x11/0x20
> > > [    5.502720]  thermal_cooling_device_unregister+0x168/0x180
> > > [    5.502720]  acpi_pss_perf_exit.isra.4+0x32/0x50
> > > [    5.502720]  acpi_processor_stop+0x4d/0x60
> > > [    5.502720]  really_probe+0xa3/0x3e0
> > > [    5.502720]  driver_probe_device+0x5b/0x120
> > > [    5.502720]  __driver_attach+0xd9/0x100
> > > [    5.502720]  ? driver_probe_device+0x120/0x120
> > > [    5.502720]  bus_for_each_dev+0x56/0x90
> > > [    5.502720]  driver_attach+0x14/0x20
> > > [    5.502720]  ? driver_probe_device+0x120/0x120
> > > [    5.502720]  bus_add_driver+0x117/0x210
> > > [    5.502720]  driver_register+0x61/0xb0
> > > [    5.502720]  acpi_processor_driver_init+0x19/0x88
> > > [    5.502720]  ? acpi_pci_slot_init+0xf/0xf
> > > [    5.502720]  do_one_initcall+0x3e/0x15a
> > > [    5.502720]  ? do_early_param+0x75/0x75
> > > [    5.502720]  kernel_init_freeable+0x170/0x1f3
> > > [    5.502720]  ? rest_init+0xcd/0xcd
> > > [    5.502720]  kernel_init+0x8/0xdb
> > > [    5.502720]  ret_from_fork+0x2e/0x38
> > > [    5.502720] Modules linked in:
> > > [    5.567678] _warn_unseeded_randomness: 1 callbacks suppressed
> > > [    5.567682] random: get_random_bytes called from
> > > init_oops_id+0x3a/0x40 with crng_init=0
> > > [    5.572237] ---[ end trace 1b6e88c03e412db2 ]---
> > > [    5.574099] EIP: kfree+0x117/0x150
> > > [    5.575673] Code: 74 21 8b 06 31 d2 f6 c4 80 74 04 0f b6 56 31
> > > 89 f0 e8 7d e0 fa ff e9 7b ff ff ff 8d b4 26 00 00 00 00 90 8b 46
> > > 04 a8 01 75 d8 <0f> 0b 8d b4 26 00 00 00 00 8b 75 f0 ff 75 ec 89
> > > d9 89 f8 6a 01 53
> > > [    5.581124] EAX: 00000100 EBX: 6b6b6b6b ECX: 00140011 EDX:
> > > 00000000
> > > [    5.583243] ESI: f67dac70 EDI: ccc4aca0 EBP: f4083e28 ESP:
> > > cce983dc
> > > [    5.585347] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> > > EFLAGS: 00210246
> > > [    5.587600] CR0: 80050033 CR2: ffd14000 CR3: 0ce94000 CR4:
> > > 000406d0
> > > [    5.589747] Kernel panic - not syncing: Fatal exception
> > > [    5.590740] Kernel Offset: 0xb200000 from 0xc1000000
> > > (relocation range: 0xc0000000-0xf77fdfff)
> > > [    5.590740] ---[ end Kernel panic - not syncing: Fatal
> > > exception ]---
> > > 
> > > 
> > > 
> > > 
> > This admittedly is a long shot, but does the appended patch help?
> Thanks for the patch, but:
> Nope, same crash.
> 

thanks for the report, please confirm if the following patch fixes the
problem or not
https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git/commit
/?h=next&id=3c587768271e9c20276522025729e4ebca51583b

thanks,
rui



