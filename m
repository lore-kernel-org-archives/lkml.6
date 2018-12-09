Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DDEC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAC12081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAC12081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeLIWTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:19:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35490 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbeLIVz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:26 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72o-0002ih-6P; Sun, 09 Dec 2018 21:55:22 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003gF-2n; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Frank Rowand" <frank.rowand@sony.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Rob Herring" <robh@kernel.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.283751659@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 307/328] of: unittest: Disable interrupt node tests
 for old world MAC systems
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 8894891446c9380709451b99ab45c5c53adfd2fc upstream.

On systems with OF_IMAP_OLDWORLD_MAC set in of_irq_workarounds, the
devicetree interrupt parsing code is different, causing unit tests of
devicetree interrupt nodes to fail. Due to a bug in unittest code, which
tries to dereference an uninitialized pointer, this results in a crash.

OF: /testcase-data/phandle-tests/consumer-a: arguments longer than property
Unable to handle kernel paging request for data at address 0x00bc616e
Faulting instruction address: 0xc08e9468
Oops: Kernel access of bad area, sig: 11 [#1]
BE PREEMPT PowerMac
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.14.72-rc1-yocto-standard+ #1
task: cf8e0000 task.stack: cf8da000
NIP:  c08e9468 LR: c08ea5bc CTR: c08ea5ac
REGS: cf8dbb50 TRAP: 0300   Not tainted  (4.14.72-rc1-yocto-standard+)
MSR:  00001032 <ME,IR,DR,RI>  CR: 82004044  XER: 00000000
DAR: 00bc616e DSISR: 40000000
GPR00: c08ea5bc cf8dbc00 cf8e0000 c13ca517 c13ca517 c13ca8a0 00000066 00000002
GPR08: 00000063 00bc614e c0b05865 000affff 82004048 00000000 c00047f0 00000000
GPR16: c0a80000 c0a9cc34 c13ca517 c0ad1134 05ffffff 000affff c0b05860 c0abeef8
GPR24: cecec278 cecec278 c0a8c4d0 c0a885e0 c13ca8a0 05ffffff c13ca8a0 c13ca517

NIP [c08e9468] device_node_gen_full_name+0x30/0x15c
LR [c08ea5bc] device_node_string+0x190/0x3c8
Call Trace:
[cf8dbc00] [c007f670] trace_hardirqs_on_caller+0x118/0x1fc (unreliable)
[cf8dbc40] [c08ea5bc] device_node_string+0x190/0x3c8
[cf8dbcb0] [c08eb794] pointer+0x25c/0x4d0
[cf8dbd00] [c08ebcbc] vsnprintf+0x2b4/0x5ec
[cf8dbd60] [c08ec00c] vscnprintf+0x18/0x48
[cf8dbd70] [c008e268] vprintk_store+0x4c/0x22c
[cf8dbda0] [c008ecac] vprintk_emit+0x94/0x130
[cf8dbdd0] [c008ff54] printk+0x5c/0x6c
[cf8dbe10] [c0b8ddd4] of_unittest+0x2220/0x26f8
[cf8dbea0] [c0004434] do_one_initcall+0x4c/0x184
[cf8dbf00] [c0b4534c] kernel_init_freeable+0x13c/0x1d8
[cf8dbf30] [c0004814] kernel_init+0x24/0x118
[cf8dbf40] [c0013398] ret_from_kernel_thread+0x5c/0x64

The problem was observed when running a qemu test for the g3beige machine
with devicetree unittests enabled.

Disable interrupt node tests on affected systems to avoid both false
unittest failures and the crash.

With this patch in place, unittest on the affected system passes with
the following message.

	dt-test ### end of unittest - 144 passed, 0 failed

Fixes: 53a42093d96ef ("of: Add device tree selftests")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
[bwh: Backported to 3.16: s/unittest/selftest/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/of/selftest.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/drivers/of/selftest.c
+++ b/drivers/of/selftest.c
@@ -326,6 +326,9 @@ static void __init of_selftest_parse_int
 	struct of_phandle_args args;
 	int i, rc;
 
+	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
+		return;
+
 	np = of_find_node_by_path("/testcase-data/interrupts/interrupts0");
 	if (!np) {
 		pr_err("missing testcase data\n");
@@ -398,6 +401,9 @@ static void __init of_selftest_parse_int
 	struct of_phandle_args args;
 	int i, rc;
 
+	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
+		return;
+
 	np = of_find_node_by_path("/testcase-data/interrupts/interrupts-extended0");
 	if (!np) {
 		pr_err("missing testcase data\n");
@@ -545,15 +551,19 @@ static void __init of_selftest_platform_
 	pdev = of_find_device_by_node(np);
 	selftest(pdev, "device 1 creation failed\n");
 
-	irq = platform_get_irq(pdev, 0);
-	selftest(irq == -EPROBE_DEFER, "device deferred probe failed - %d\n", irq);
-
-	/* Test that a parsing failure does not return -EPROBE_DEFER */
-	np = of_find_node_by_path("/testcase-data/testcase-device2");
-	pdev = of_find_device_by_node(np);
-	selftest(pdev, "device 2 creation failed\n");
-	irq = platform_get_irq(pdev, 0);
-	selftest(irq < 0 && irq != -EPROBE_DEFER, "device parsing error failed - %d\n", irq);
+	if (!(of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)) {
+		irq = platform_get_irq(pdev, 0);
+		selftest(irq == -EPROBE_DEFER,
+			 "device deferred probe failed - %d\n", irq);
+
+		/* Test that a parsing failure does not return -EPROBE_DEFER */
+		np = of_find_node_by_path("/testcase-data/testcase-device2");
+		pdev = of_find_device_by_node(np);
+		selftest(pdev, "device 2 creation failed\n");
+		irq = platform_get_irq(pdev, 0);
+		selftest(irq < 0 && irq != -EPROBE_DEFER,
+			 "device parsing error failed - %d\n", irq);
+	}
 
 	np = of_find_node_by_path("/testcase-data/platform-tests");
 	if (!np) {

