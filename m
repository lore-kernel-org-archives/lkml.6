Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA23CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D9C21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttPXs5xP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D9C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbeJKXKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:10:53 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72642098A;
        Thu, 11 Oct 2018 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272588;
        bh=wxUJALj1MgfqXRgg3PM/O8N2D536JVqGT2MinVejw2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttPXs5xPq+2fGXFxsadxIB6HtVUlY6/rHejnmY5CWyvsfSzR6bHWUeeS9tqwcoAa5
         cMcZMuS6zW7/DYxb5TY1VkkYa80SPSP7RbVl+hGtjKY9Pv80kjZCJnwHbQ2OfrfI8B
         qIbXRdEd6mJ0iQCVy6UCp0rlynOAQW9om9uhbp28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.9 15/35] of: unittest: Disable interrupt node tests for old world MAC systems
Date:   Thu, 11 Oct 2018 17:35:17 +0200
Message-Id: <20181011152520.788763992@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/unittest.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -548,6 +548,9 @@ static void __init of_unittest_parse_int
 	struct of_phandle_args args;
 	int i, rc;
 
+	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
+		return;
+
 	np = of_find_node_by_path("/testcase-data/interrupts/interrupts0");
 	if (!np) {
 		pr_err("missing testcase data\n");
@@ -622,6 +625,9 @@ static void __init of_unittest_parse_int
 	struct of_phandle_args args;
 	int i, rc;
 
+	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
+		return;
+
 	np = of_find_node_by_path("/testcase-data/interrupts/interrupts-extended0");
 	if (!np) {
 		pr_err("missing testcase data\n");
@@ -778,15 +784,19 @@ static void __init of_unittest_platform_
 	pdev = of_find_device_by_node(np);
 	unittest(pdev, "device 1 creation failed\n");
 
-	irq = platform_get_irq(pdev, 0);
-	unittest(irq == -EPROBE_DEFER, "device deferred probe failed - %d\n", irq);
-
-	/* Test that a parsing failure does not return -EPROBE_DEFER */
-	np = of_find_node_by_path("/testcase-data/testcase-device2");
-	pdev = of_find_device_by_node(np);
-	unittest(pdev, "device 2 creation failed\n");
-	irq = platform_get_irq(pdev, 0);
-	unittest(irq < 0 && irq != -EPROBE_DEFER, "device parsing error failed - %d\n", irq);
+	if (!(of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)) {
+		irq = platform_get_irq(pdev, 0);
+		unittest(irq == -EPROBE_DEFER,
+			 "device deferred probe failed - %d\n", irq);
+
+		/* Test that a parsing failure does not return -EPROBE_DEFER */
+		np = of_find_node_by_path("/testcase-data/testcase-device2");
+		pdev = of_find_device_by_node(np);
+		unittest(pdev, "device 2 creation failed\n");
+		irq = platform_get_irq(pdev, 0);
+		unittest(irq < 0 && irq != -EPROBE_DEFER,
+			 "device parsing error failed - %d\n", irq);
+	}
 
 	np = of_find_node_by_path("/testcase-data/platform-tests");
 	unittest(np, "No testcase data in device tree\n");


