Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34AB206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=schoebel-theuer.de header.i=@schoebel-theuer.de header.b="aBmU9p0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbeLNSVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:21:24 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:14413 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLNSVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544811681;
        s=strato-dkim-0002; d=schoebel-theuer.de;
        h=Message-Id:Date:Subject:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=YRfiBnjiDwd7o31QlQBDVcGk87v/b118oQScvE5nOLo=;
        b=aBmU9p0Nf+M4Nyok3k9PhRHw/Ex8m/gmq38VDIUMxlOBpuTe29SqWkkxUmV00sqvZa
        W9/I93C1UukQgbuS4T9jfxPp+pPxaMfNQ7uSnpg6H8Euk5klgJlKS6wnTvxWzAXHjQGU
        /MRrGAMRH3pO6IIQkvhSK8anqfpYC1QxG9es1yfXvAYgcbhzooDyJNMZ2gmYt4mXraE2
        VIfQiIhAMaXmOBYiIR0xRQ8I6rylfcCgk0DBvD4if3sKPSnmFT8fss3ljtKdOeu7CJ/A
        ZY7nfdAH/zp+OPhqajY+/wG5vP2uzjyDtLFw4AhAzimvYea96EdzuSie4YiPHrPvBq1d
        zS7g==
X-RZG-AUTH: ":OH8QVVOrc/CP6za/qRmbF3BWedPGA1vjs2e0bDjfg8SjapJoMy/ngEsCKWYGdbtw+iItTz0PdE9lIA=="
X-RZG-CLASS-ID: mo00
Received: from schoebel-theuer.de
        by smtp.strato.de (RZmta 44.8 DYNA|AUTH)
        with ESMTPSA id V03c59uBEIFJ6lp
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <linux-kernel@vger.kernel.org>;
        Fri, 14 Dec 2018 19:15:19 +0100 (CET)
From:   Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] acpi / apei: fix NULL deref during init
Date:   Fri, 14 Dec 2018 19:15:14 +0100
Message-Id: <20181214181514.29891-1-tst@schoebel-theuer.de>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection
tolerance level"), starting with kernel 4.0, the following happens during
boot of a specific old hardware:

APEI: Can not request [mem 0x0009c2f2-0x0009c2fc] for APEI ERST registers
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: [<ffffffff81343d8e>] __list_del_entry+0x5c/0x98
PGD 0
Oops: 0000 [#1] SMP
Modules linked in:
CPU: 0 PID: 1 UID: 0 Comm: swapper/0 Not tainted 4.4.0-ui18344.004-uiabi1-infong-amd64 #1
Hardware name: IBM IBM eServer BladeCenter HS12 -[8028Z5S]-/Server Blade, BIOS -[N1E150AUS-1.11]- 11/04/2010
task: ffff88021fe4e040 ti: ffff88021fe7c000 task.ti: ffff88021fe7c000
RIP: 0010:[<ffffffff81343d8e>]  [<ffffffff81343d8e>] __list_del_entry+0x5c/0x98
RSP: 0000:ffff88021fe7fd18  EFLAGS: 00010207
RAX: 0000000000000000 RBX: ffff88021fe7fde0 RCX: ffff88021fe7fde0
RDX: ffffffff819bd040 RSI: dead000000000200 RDI: ffff88021fe7fde0
RBP: ffff88021fe7fd18 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff816ce240 R11: 0000000000000001 R12: ffffffff819bd040
R13: ffff88021fe7fda0 R14: ffff88021d2cd840 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88022fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000019b6000 CR4: 0000000000040670
Stack:
 ffff88021fe7fd30 ffffffff81343dd7 ffff88021fe7fde0 ffff88021fe7fd58
 ffffffff813931c0 ffff88021fe7fda0 ffff88021fe7fe00 ffff88021d2cd840
 ffff88021fe7fd70 ffffffff813931e5 00000000ffffffea ffff88021fe7fdf0
Call Trace:
 [<ffffffff81343dd7>] list_del+0xd/0x25
 [<ffffffff813931c0>] apei_res_clean+0x1f/0x37
 [<ffffffff813931e5>] apei_resources_fini+0xd/0x19
 [<ffffffff81393948>] apei_resources_request+0x24f/0x268
 [<ffffffff8139301d>] ? apei_exec_for_each_entry+0x77/0x8e
 [<ffffffff81b0f729>] ? setup_erst_disable+0x12/0x12
 [<ffffffff81b0f816>] erst_init+0xed/0x2ca
 [<ffffffff810003b2>] ? do_one_initcall+0x8c/0x174
 [<ffffffff81b0f729>] ? setup_erst_disable+0x12/0x12
 [<ffffffff81b0f729>] ? setup_erst_disable+0x12/0x12
 [<ffffffff8100040f>] do_one_initcall+0xe9/0x174
 [<ffffffff8105df00>] ? parse_args+0x161/0x296
 [<ffffffff81ad6070>] kernel_init_freeable+0x169/0x1f6
 [<ffffffff81ad579b>] ? do_early_param+0x88/0x88
 [<ffffffff81663202>] ? rest_init+0x79/0x79
 [<ffffffff8166320b>] kernel_init+0x9/0xd5
 [<ffffffff816683f5>] ret_from_fork+0x55/0x80
 [<ffffffff81663202>] ? rest_init+0x79/0x79
Code: 02 00 00 00 00 ad de 48 39 f0 75 1f 49 89 c0 48 c7 c2 38 de 8e 81 be 38 00 00 00 48 c7 c7 13 dd 8e 81 31 c0 e8 94 36 d0 ff eb 3a <48> 8b 30 48 39 fe 74 11 49 89 f0 48 c7 c2 6c de 8e 81 be 3b 00
RIP  [<ffffffff81343d8e>] __list_del_entry+0x5c/0x98
 RSP <ffff88021fe7fd18>
CR2: 0000000000000000
---[ end trace 3610e544cef27e81 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

Reason is a conditional initialization of variable arch_res, which happens
only under a specific precondition. When the condition is false, the
variable remains uninitialized.

This may later trigger a splat, e.g. when some error path is taken.

Solution: do the initialisation unconditionally. Also as a safeguard.

Fixes: d91525eb8ee6a622ce476955fe1a2530ade87c83
Signed-off-by: Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
---
 drivers/acpi/apei/apei-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index da370e1d31f4..ef931b8a0b11 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -494,8 +494,8 @@ int apei_resources_request(struct apei_resources *resources,
 	if (rc)
 		goto nvs_res_fini;
 
+	apei_resources_init(&arch_res);
 	if (arch_apei_filter_addr) {
-		apei_resources_init(&arch_res);
 		rc = apei_get_arch_resources(&arch_res);
 		if (rc)
 			goto arch_res_fini;
-- 
2.12.3

