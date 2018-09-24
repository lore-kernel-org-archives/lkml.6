Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783B7ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0413D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVICW1gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0413D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeIYCZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:25:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34793 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeIYCZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:25:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id t15so13089152wrx.1;
        Mon, 24 Sep 2018 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zOkMycCNomM+tkX40f26rC7ZqqZUrX9yYgChChqMigM=;
        b=NVICW1gb/h+pDN+91ImMQ7gXfj+9skz+WNu4WAHeJQVIjbCF+ICtXoDeRvORiaxAiA
         iJYQYsFwJcp71Ao1ZFCRFwWS06NpPHfeFJDpIUpW5IPsS2twYNtAFPNFSghXvrfpeR6X
         dxhSm+Dar6NwNygM62J9Y6H6zMOvLJRPble79czYQGmJ5zUCfQ4c82jRof6pIhB/FxLa
         wKOWnBP7GuRQMBzt8RqMyzM6NtGVspTVM80LVg/h9HBWk63vegZfi2sI50MBvp+afmzZ
         ZtmpbL0uDpWfTLz25fDHBPsNOl4CGAfMCJjtQ0GBY86sGTZkVdGhga/ZR2RZj7tuVYt/
         cskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zOkMycCNomM+tkX40f26rC7ZqqZUrX9yYgChChqMigM=;
        b=ZLWwGe2Y1tZJ48DyH/jXKCLDmL5c0tI6K4XB/PM+8F/p+CfSbYZ3XdltPQFLPzvlt+
         I6e9o8XJdk053I+oGbKH5h5vT1L37RsaTTQCe6VsgzXGdcDlALySAO3BULHiLAklJrmn
         1/+MJHsUZpMVn1DgrI1uYZgw1yU+2lpQ1+9Y9AxWkWBSgFKXda01qUYZ7qCWI/az0ABY
         JgL9g6rGwp63BHky8W/uz786B1OXL1n51e66u3EvPw0+WncSycW2qDpsrlS6fz5s7TZk
         V64VMuhTqo6sKvzmuGFGHlUpR4I8T/MhcxSfkiyc+n31YOISEM9Dsd5nJBQV1HW1/Jiu
         iCDw==
X-Gm-Message-State: ABuFfoiDkvUB+GqCSM0wK4Zvwfz+JEt6EBmMHOYNS6U8fvdi8Uftse7U
        RLAlLhf89N5AZNzPAKJtQCfFBgIiMlc=
X-Google-Smtp-Source: ACcGV60WvBGpre3fIG7+ce55a0Gqi1oPH2L1VDW/JnxYEYFRP/KIeDGS1+JpLoMDHFUOY+g4q9+Y0w==
X-Received: by 2002:a5d:574b:: with SMTP id q11-v6mr334715wrw.272.1537820493604;
        Mon, 24 Sep 2018 13:21:33 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bc0:ba00:f974:926a:cc36:6029? (p200300EA8BC0BA00F974926ACC366029.dip0.t-ipconnect.de. [2003:ea:8bc0:ba00:f974:926a:cc36:6029])
        by smtp.googlemail.com with ESMTPSA id q135-v6sm55361wmd.4.2018.09.24.13.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:21:33 -0700 (PDT)
Subject: Re: r8169 hang on 4.18
To:     =?UTF-8?Q?Ortwin_Gl=c3=bcck?= <odi@odi.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
References: <332fecce-3fab-1c92-1558-67a1d90d6372@odi.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <680acec6-f610-7f9d-5aa2-a03e878354d1@gmail.com>
Date:   Mon, 24 Sep 2018 22:21:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <332fecce-3fab-1c92-1558-67a1d90d6372@odi.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.2018 14:00, Ortwin Glück wrote:
> Hi,
> 
> Stable kernel has stability problems on r8169 that were not present in 4.17.3:
> 
> [    0.000000] Linux version 4.18.8 (kbuild@lofw) (gcc version 7.3.0 (Gentoo 7.3.0-r3 p1.4)) #70 SMP PREEMPT Mon Sep 17 17:56:57 CEST 2018
> [    0.000000] Command line: BOOT_IMAGE=/boot/linux-4.18.8 root=LABEL=ROOT ro rootfstype=ext4 net.ifnames=0 pci=nomsi
> 
> [    1.772849] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    1.772852] r8169 0000:07:00.0: can't disable ASPM; OS doesn't have ASPM control
> [    1.784948] r8169 0000:07:00.0 eth4: RTL8168h/8111h, 50:9a:4c:2e:92:be, XID 54100800, IRQ 16
> [    1.784949] r8169 0000:07:00.0 eth4: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> 
> We saw the interface unresponsive twice during the last 3 days with:
> 
> [Mon Sep 24 11:35:56 2018] ------------[ cut here ]------------
> [Mon Sep 24 11:35:56 2018] NETDEV WATCHDOG: wan (r8169): transmit queue 0 timed out
> [Mon Sep 24 11:35:56 2018] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:461 dev_watchdog+0x215/0x220
> [Mon Sep 24 11:35:56 2018] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.18.8 #70
> [Mon Sep 24 11:35:56 2018] Hardware name: Dell Inc. OptiPlex 3050/0W0CHX, BIOS 1.6.5 09/09/2017
> [Mon Sep 24 11:35:56 2018] RIP: 0010:dev_watchdog+0x215/0x220
> [Mon Sep 24 11:35:56 2018] Code: 49 63 4c 24 e8 eb 8c 4c 89 ef c6 05 1a 19 ca 00 01 e8 5f 52 fd ff 89 d9 4c 89 ee 48 c7 c7 78 ab 67 89 48 89 c2 e8 1b 2b 49 ff <0f> 0b eb be 0f 1f 80 00 00 00 00 41 57 45 89 cf 41 56 49 89 d6 41
> [Mon Sep 24 11:35:56 2018] RSP: 0018:ffff96f05dd03e98 EFLAGS: 00010282
> [Mon Sep 24 11:35:56 2018] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
> [Mon Sep 24 11:35:56 2018] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff96f05dd15350
> [Mon Sep 24 11:35:56 2018] RBP: ffff96f0462ee41c R08: 0000000000000001 R09: 000000000000133d
> [Mon Sep 24 11:35:56 2018] R10: 0000000000000202 R11: 0000000000000000 R12: ffff96f0462ee438
> [Mon Sep 24 11:35:56 2018] R13: ffff96f0462ee000 R14: 0000000000000001 R15: ffff96f0455eaa80
> [Mon Sep 24 11:35:56 2018] FS:  0000000000000000(0000) GS:ffff96f05dd00000(0000) knlGS:0000000000000000
> [Mon Sep 24 11:35:56 2018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Mon Sep 24 11:35:56 2018] CR2: 000055c9498766e0 CR3: 00000000bb80a006 CR4: 00000000003606e0
> [Mon Sep 24 11:35:56 2018] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [Mon Sep 24 11:35:56 2018] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [Mon Sep 24 11:35:56 2018] Call Trace:
> [Mon Sep 24 11:35:56 2018]  <IRQ>
> [Mon Sep 24 11:35:56 2018]  ? pfifo_fast_reset+0x130/0x130
> [Mon Sep 24 11:35:56 2018]  ? pfifo_fast_reset+0x130/0x130
> [Mon Sep 24 11:35:56 2018]  call_timer_fn+0x11/0x70
> [Mon Sep 24 11:35:56 2018]  expire_timers+0x8e/0xa0
> [Mon Sep 24 11:35:56 2018]  run_timer_softirq+0xb9/0x160
> [Mon Sep 24 11:35:56 2018]  ? __hrtimer_run_queues+0x135/0x1a0
> [Mon Sep 24 11:35:56 2018]  ? hw_breakpoint_pmu_read+0x10/0x10
> [Mon Sep 24 11:35:56 2018]  ? ktime_get+0x39/0x90
> [Mon Sep 24 11:35:56 2018]  ? lapic_next_event+0x20/0x20
> [Mon Sep 24 11:35:56 2018]  __do_softirq+0xcb/0x1f8
> [Mon Sep 24 11:35:56 2018]  irq_exit+0xa9/0xb0
> [Mon Sep 24 11:35:56 2018]  smp_apic_timer_interrupt+0x59/0x90
> [Mon Sep 24 11:35:56 2018]  apic_timer_interrupt+0xf/0x20
> [Mon Sep 24 11:35:56 2018]  </IRQ>
> [Mon Sep 24 11:35:56 2018] RIP: 0010:cpuidle_enter_state+0x129/0x200
> [Mon Sep 24 11:35:56 2018] Code: 45 00 89 c3 e8 d8 3b 55 ff 65 8b 3d b1 eb 45 77 e8 8c 3a 55 ff 31 ff 49 89 c4 e8 72 43 55 ff fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 89 e1 4c 29 e9 48 89 c8 48 c1 f9 3f 48 f7 ea b8 ff ff ff 7f 48
> [Mon Sep 24 11:35:56 2018] RSP: 0018:ffff9a93c06e7ea8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
> [Mon Sep 24 11:35:56 2018] RAX: ffff96f05dd1f800 RBX: 0000000000000003 RCX: 000000000000001f
> [Mon Sep 24 11:35:56 2018] RDX: 20c49ba5e353f7cf RSI: 00000000258f0602 RDI: 0000000000000000
> [Mon Sep 24 11:35:56 2018] RBP: ffff96f05dd25ee0 R08: 00000000000002b4 R09: 00000000ffffffff
> [Mon Sep 24 11:35:56 2018] R10: ffff9a93c06e7e90 R11: 0000000000000142 R12: 00012ec849a182b9
> [Mon Sep 24 11:35:56 2018] R13: 00012ec8499ddf88 R14: 0000000000000003 R15: 0000000000000000
> [Mon Sep 24 11:35:56 2018]  ? cpuidle_enter_state+0x11e/0x200
> [Mon Sep 24 11:35:56 2018]  do_idle+0x1c0/0x200
> [Mon Sep 24 11:35:56 2018]  cpu_startup_entry+0x6a/0x70
> [Mon Sep 24 11:35:56 2018]  start_secondary+0x18a/0x1c0
> [Mon Sep 24 11:35:56 2018]  secondary_startup_64+0xa5/0xb0
> [Mon Sep 24 11:35:56 2018] ---[ end trace 327bd9c035abe307 ]---
> 
> This is the built-in ethernet port on a Dell main board:
> 07:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 15)
>         Subsystem: Dell RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [1028:07a3]
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         I/O ports at e000 [size=256]
>         Memory at f7404000 (64-bit, non-prefetchable) [size=4K]
>         Memory at f7400000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 01
>         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Virtual Channel
>         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
>         Capabilities: [170] Latency Tolerance Reporting
>         Capabilities: [178] L1 PM Substates
>         Kernel driver in use: r8169
> 
> The box has an extra 4-way ethernet card that uses the same driver. We had to set pci=nomsi because the card frequently behaved erratic with msi on.
> 
> Thanks,
> 
> Ortwin
> 
Thanks for the report. Here come a few inquiries:

You say the box has one on-board network port and four network ports on
an extension card, all five driven by r8169. The on-board chip is a
RTL8168h, what's the type of the chips on the extension card?
I'm asking because r8169 supports ~ 50 chip variants of the RTL8169/8
family.
Are the problems the same on all five ports?

Can you reproduce the problem (how)? Any specific network usage
triggering the problem?

The root cause of the problem not necessarily is in r8169, some other
change could have broken it too. Can you test using r8169 from 4.18
on top of 4.17?

When stating "behaves erratic" you refer to the network hangs
mentioned before? Or to some other issue?

A similar report is here:
https://bugzilla.kernel.org/show_bug.cgi?id=201109
There the problem seems to start with the upgrade from 4.18.4 to 4.18.5.
Can you try with 4.18.4 ?

The diff between 4.18.4 and 4.18.5 shows nothing related to r8169.

Rgds, Heiner
