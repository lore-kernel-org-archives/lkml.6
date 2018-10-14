Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D00C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745CF20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745CF20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJNXLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35840 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbeJNXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0004cZ-Pv; Sun, 14 Oct 2018 16:30:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000fW-0A; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Santosh Shilimkar" <ssantosh@kernel.org>,
        "Olof Johansson" <olof@lixom.net>,
        "Russell King" <rmk+kernel@armlinux.org.uk>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.995283854@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 303/366] ARM: keystone: fix platform_domain_notifier
 array overrun
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

commit 9954b80b8c0e8abc98e17bba0fccd9876211ceaa upstream.

platform_domain_notifier contains a variable sized array, which the
pm_clk_notify() notifier treats as a NULL terminated array:

     for (con_id = clknb->con_ids; *con_id; con_id++)
             pm_clk_add(dev, *con_id);

Omitting the initialiser for con_ids means that the array is zero
sized, and there is no NULL terminator.  This leads to pm_clk_notify()
overrunning into what ever structure follows, which may not be NULL.
This leads to an oops:

Unable to handle kernel NULL pointer dereference at virtual address 0000008c
pgd = c0003000
[0000008c] *pgd=80000800004003c, *pmd=00000000c
Internal error: Oops: 206 [#1] PREEMPT SMP ARM
Modules linked in:c
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0+ #9
Hardware name: Keystone
PC is at strlen+0x0/0x34
LR is at kstrdup+0x18/0x54
pc : [<c0623340>]    lr : [<c0111d6c>]    psr: 20000013
sp : eec73dc0  ip : eed780c0  fp : 00000001
r10: 00000000  r9 : 00000000  r8 : eed71e10
r7 : 0000008c  r6 : 0000008c  r5 : 014000c0  r4 : c03a6ff4
r3 : c09445d0  r2 : 00000000  r1 : 014000c0  r0 : 0000008c
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 00003000  DAC: fffffffd
Process swapper/0 (pid: 1, stack limit = 0xeec72210)
Stack: (0xeec73dc0 to 0xeec74000)
...
[<c0623340>] (strlen) from [<c0111d6c>] (kstrdup+0x18/0x54)
[<c0111d6c>] (kstrdup) from [<c03a6ff4>] (__pm_clk_add+0x58/0x120)
[<c03a6ff4>] (__pm_clk_add) from [<c03a731c>] (pm_clk_notify+0x64/0xa8)
[<c03a731c>] (pm_clk_notify) from [<c004614c>] (notifier_call_chain+0x44/0x84)
[<c004614c>] (notifier_call_chain) from [<c0046320>] (__blocking_notifier_call_chain+0x48/0x60)
[<c0046320>] (__blocking_notifier_call_chain) from [<c0046350>] (blocking_notifier_call_chain+0x18/0x20)
[<c0046350>] (blocking_notifier_call_chain) from [<c0390234>] (device_add+0x36c/0x534)
[<c0390234>] (device_add) from [<c047fc00>] (of_platform_device_create_pdata+0x70/0xa4)
[<c047fc00>] (of_platform_device_create_pdata) from [<c047fea0>] (of_platform_bus_create+0xf0/0x1ec)
[<c047fea0>] (of_platform_bus_create) from [<c047fff8>] (of_platform_populate+0x5c/0xac)
[<c047fff8>] (of_platform_populate) from [<c08b1f04>] (of_platform_default_populate_init+0x8c/0xa8)
[<c08b1f04>] (of_platform_default_populate_init) from [<c000a78c>] (do_one_initcall+0x3c/0x164)
[<c000a78c>] (do_one_initcall) from [<c087bd9c>] (kernel_init_freeable+0x10c/0x1d0)
[<c087bd9c>] (kernel_init_freeable) from [<c0628db0>] (kernel_init+0x8/0xf0)
[<c0628db0>] (kernel_init) from [<c00090d8>] (ret_from_fork+0x14/0x3c)
Exception stack(0xeec73fb0 to 0xeec73ff8)
3fa0:                                     00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e3520000 1afffff7 e12fff1e c0801730 (e5d02000)
---[ end trace cafa8f148e262e80 ]---

Fix this by adding the necessary initialiser.

Fixes: fc20ffe1213b ("ARM: keystone: add PM domain support for clock management")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/mach-keystone/pm_domain.c | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -59,6 +59,7 @@ static struct dev_pm_domain keystone_pm_
 
 static struct pm_clk_notifier_block platform_domain_notifier = {
 	.pm_domain = &keystone_pm_domain,
+	.con_ids = { NULL },
 };
 
 static struct of_device_id of_keystone_table[] = {

