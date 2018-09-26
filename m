Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1BCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 04:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56B820833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 04:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/HsbXN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56B820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeIZKRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:17:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46612 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeIZKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 06:17:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so13099946pga.13;
        Tue, 25 Sep 2018 21:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JB4vxpq/yk9VnoWpJJyeyQdY5KPFoZgKRzKBFu+9ZmY=;
        b=J/HsbXN4MJMaq+VkBbmnGoN0eotE1A+qEeKCY3paYjjMTE35P2mUFh1rVK2lZc4/mS
         7pU8AzF7zkMDnzZm/c8jJKPfLmH27O0yt9SqYZgRpO88l9zhkc1KopgTEeOdL4YAq+nX
         yFOiCbvRJ8DWbkLzZPk5dQmWW8gv+48nzgGkigNCouvWs5FywgfLUlzatIQ6TECZK1EA
         l/k3qN1O5zGFZNF1RedmP8sqNabQulDpFVqLdvjBXfumQVWfsO970eFqRarjWJnz2k1p
         XJe4ea4zkWvpQ5uTPcJ52AGS8P0DzdD5dKyPAbmN2l/Koc9oqGoKg4PWZurB5FB49H5c
         OAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=JB4vxpq/yk9VnoWpJJyeyQdY5KPFoZgKRzKBFu+9ZmY=;
        b=Uemzl/LfFG/k2DDU3GSnnDCfGXXmANMUiEqO46CLmH/WDRVKFhABjN5UagKP3uAZQF
         INL8fjpryifzaavMWH+1wR3tmLh/qzQXjqQfLHvvW6zKcBLGVT2Iltuxzm/b7w5YR0N2
         rQSQHUSOATAeQapRoXS1xx0k3US1LJaph8hozCTwtZo339WrxvgnQsy7wighyNJUepFI
         lUOX1T2VfLdNKnc3zThLCYdlJVMNMg0urHwjECpCn6sy6C0calSxvG7D5UsY+CQUao7E
         fPALrheMncTc3AF06o1DtTHAdJyrB994joej4YlcIyEhs02y8Bd+4K1xqDpxdMwagFQR
         1Izg==
X-Gm-Message-State: ABuFfoiQL3QnoOzEokjmIAMXbk7Bvukj/TpMR31/gf4o1+8kQe3EEcNW
        DT3EB7GORxfkY0jqX21TFkg=
X-Google-Smtp-Source: ACcGV60wm4BMD5o+aRK5qWjniPTelREjSslB9iAJP1OIhyotUDQ7aGZhlbmauyCjPs3M3r1y9pHmYg==
X-Received: by 2002:a63:e0e:: with SMTP id d14-v6mr3856280pgl.38.1537934787621;
        Tue, 25 Sep 2018 21:06:27 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 26-v6sm5458404pfs.168.2018.09.25.21.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 21:06:26 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] of: unittest: Disable interrupt node tests for old world MAC systems
Date:   Tue, 25 Sep 2018 21:06:24 -0700
Message-Id: <1537934784-19819-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
v2: Do not use goto to skip tests.
    Provide test log in commit message.

 drivers/of/unittest.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 722537e14848..41b49716ac75 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -771,6 +771,9 @@ static void __init of_unittest_parse_interrupts(void)
 	struct of_phandle_args args;
 	int i, rc;
 
+	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
+		return;
+
 	np = of_find_node_by_path("/testcase-data/interrupts/interrupts0");
 	if (!np) {
 		pr_err("missing testcase data\n");
@@ -845,6 +848,9 @@ static void __init of_unittest_parse_interrupts_extended(void)
 	struct of_phandle_args args;
 	int i, rc;
 
+	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
+		return;
+
 	np = of_find_node_by_path("/testcase-data/interrupts/interrupts-extended0");
 	if (!np) {
 		pr_err("missing testcase data\n");
@@ -1001,15 +1007,19 @@ static void __init of_unittest_platform_populate(void)
 	pdev = of_find_device_by_node(np);
 	unittest(pdev, "device 1 creation failed\n");
 
-	irq = platform_get_irq(pdev, 0);
-	unittest(irq == -EPROBE_DEFER, "device deferred probe failed - %d\n", irq);
+	if (!(of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)) {
+		irq = platform_get_irq(pdev, 0);
+		unittest(irq == -EPROBE_DEFER,
+			 "device deferred probe failed - %d\n", irq);
 
-	/* Test that a parsing failure does not return -EPROBE_DEFER */
-	np = of_find_node_by_path("/testcase-data/testcase-device2");
-	pdev = of_find_device_by_node(np);
-	unittest(pdev, "device 2 creation failed\n");
-	irq = platform_get_irq(pdev, 0);
-	unittest(irq < 0 && irq != -EPROBE_DEFER, "device parsing error failed - %d\n", irq);
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
-- 
2.7.4

