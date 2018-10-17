Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6FFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D673F214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D673F214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJQORi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:17:38 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:38486 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbeJQORi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:17:38 -0400
Subject: Re: netconsole warning in 4.19.0-rc7
To:     Dave Jones <davej@codemonkey.org.uk>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <e0611057-1b5b-9990-b9fa-060a9b5eba40@linux.ee>
 <CAM_iQpU0+LVwgMea32KQWf8z6Bp1VTmWOGnWNwNSmV0PZzf_ew@mail.gmail.com>
 <20181017034047.nrhstc3b4wzevnri@codemonkey.org.uk>
 <20181017035038.czaqown24rnjn2pw@codemonkey.org.uk>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <fc91f629-8b91-c8c6-3c62-ffb400588597@linux.ee>
Date:   Wed, 17 Oct 2018 09:22:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017035038.czaqown24rnjn2pw@codemonkey.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I took another look at that error path. Turns out this is all we need I
> think..

With this patch applied on top of 4.19-rc8, I stll get the warning:

[   13.722919] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:168 __local_bh_enable_ip+0x2e/0x44
[   13.722922] Modules linked in:
[   13.722924] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc8-dirty #212
[   13.722926] Hardware name: MicroLink                       /D850MV                         , BIOS MV85010A.86A.0067.P24.0304081124 04/08/2003
[   13.722927] EIP: __local_bh_enable_ip+0x2e/0x44
[   13.722929] Code: cc 02 5f de a9 00 00 0f 00 75 1f 83 ea 01 f7 da 01 15 cc 02 5f de a1 cc 02 5f de a9 00 ff 1f 00 74 0c ff 0d cc 02 5f de 5d c3 <0f> 0b eb dd 66 a1 80 cd 5e de 66 85 c0 74 e9 e8 87 ff ff ff eb e2
[   13.722931] EAX: 80010200 EBX: f602b000 ECX: 36346b30 EDX: 00000200
[   13.722932] ESI: f620ed20 EDI: f620ebac EBP: f600de40 ESP: f600de40
[   13.722933] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010006
[   13.722934] CR0: 80050033 CR2: bfc87ffc CR3: 3633c000 CR4: 000006d0
[   13.722935] Call Trace:
[   13.722936]  <IRQ>
[   13.722937]  netpoll_send_skb_on_dev+0xa5/0x1bf
[   13.722938]  netpoll_send_udp+0x2ab/0x462
[   13.722939]  write_msg+0xc9/0xd4
[   13.722940]  ? netconsole_netdev_event+0xd0/0xd0
[   13.722941]  console_unlock+0x283/0x376
[   13.722942]  vprintk_emit+0xfa/0x13a
[   13.722943]  vprintk_default+0x32/0x34
[   13.722944]  vprintk_func+0x26/0x82
[   13.722946]  ? __wake_up+0x1a/0x20
[   13.722947]  printk+0xe/0x10
[   13.722948]  crng_fast_load+0x138/0x142
[   13.722949]  add_interrupt_randomness+0x1cd/0x1ec
[   13.722950]  ? handle_fasteoi_irq+0x127/0x127
[   13.722951]  handle_irq_event_percpu+0x33/0x6d
[   13.722952]  ? irqd_cfg+0xc/0x11
[   13.722953]  handle_irq_event+0x1d/0x29
[   13.722954]  handle_edge_irq+0x61/0x161
[   13.722955]  handle_irq+0x83/0xa0
[   13.722956]  </IRQ>
[   13.722956]  do_IRQ+0x3b/0xd7
[   13.722957]  common_interrupt+0xd3/0xd8
[   13.722958] EIP: default_idle+0x5/0x7
[   13.722961] Code: ff ff ff fb eb e7 b8 00 00 01 00 0f c1 03 31 c0 eb ac e8 ba cc bc ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 e5 fb f4 <5d> c3 55 89 e5 a1 d4 02 5f de 80 48 02 20 8b 10 83 e2 08 75 2c 8b
[   13.722962] EAX: de4795c0 EBX: 00000000 ECX: 31ef550d EDX: 00000000
[   13.722963] ESI: 00000000 EDI: f73fd684 EBP: de5d5f20 ESP: de5d5f20
[   13.722964] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00000246
[   13.722965]  ? __cpuidle_text_start+0x8/0x8
[   13.722966]  arch_cpu_idle+0xd/0xf
[   13.722967]  default_idle_call+0x1a/0x29
[   13.722968]  do_idle+0x131/0x18e
[   13.722969]  cpu_startup_entry+0x52/0x54
[   13.722970]  rest_init+0x6e/0x70
[   13.722971]  start_kernel+0x365/0x37e
[   13.722972]  i386_start_kernel+0x92/0x96
[   13.722973]  startup_32_smp+0x164/0x168
[   13.722974] ---[ end trace 74d36b4b49749ac1 ]---

-- 
Meelis Roos <mroos@linux.ee>
