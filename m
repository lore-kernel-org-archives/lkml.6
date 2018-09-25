Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB12DECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7833A20676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEbwsGGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7833A20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeIYXlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:41:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40147 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIYXlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:41:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so5180624pgm.7;
        Tue, 25 Sep 2018 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=SpeWzCzX8uiYqMFXazB52jv+zlxghiVCwGCJxl0mY5g=;
        b=dEbwsGGzakrH3A17Kl6IB6gfUbuR+CifqjMmW7+XXrMpEry9Bq1gUJ54d+YDmf8TA/
         3MdctxLqZ59ceIl5+WD3xWMqzwZ3HJ5JN4M8bSFWCCRdesW/li+tIcuc8KjsRatsQut4
         tJw6m3+7CxXp466iBAeY8YGN4485ycv0mwbPqxiTtPMzjghqf4+mY5K8iXIcjosmNCtP
         9IKBJxm+GRJFTEOHdg7va4/ojBK16kfDlv10QGrVh2DKIxgYVSsOg2kUgNohENzdILPU
         z40KRhCiLEWP85EFafhAnrYjFKMRtqGKn7+OTeqd72gzFpdODT4INS5AKhMfAs87KDx2
         3NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=SpeWzCzX8uiYqMFXazB52jv+zlxghiVCwGCJxl0mY5g=;
        b=BQHZyo3kiZHB8ayltJhZgjKqKSsbtM/+iLmqpIw1w39Gk/Alkx4HY5Bi/k1x33D0lv
         nAvwtWZSyxJtYXzSn7Py6f18H7AhbsQzwNwxKCCGqrJBYXt0N4KesH9ez28uc1uYvc+s
         roDez2EaKV3Yxuzg2X2Jlij5ZYUaaYC7CBt4KTZTLiIgOaXCEdQ6yqn2L2YSAlp0GGe5
         Xh0DJ6WyUMBzXFKvZ35ibohApiiZys/sKEXRHoNlpks7ET1lEwcsIKo4D/4JcncVPrvh
         vsQhCNRycgR8bzmUldoc61DagtW4Fhv2l+XwpSbF7jfry12zXURAfWCkUW4mhhJMaTuR
         2hFQ==
X-Gm-Message-State: ABuFfohW229nIiwzyYPO08D4AOKZVl1xDj4+UqmdMjyXbsE+ULen/mFJ
        EnBC0iDDeCseEZaFbMIUMIW7Nvom
X-Google-Smtp-Source: ACcGV62kP357eDGpcVpaH+JUN6wlW2KzUA839qrryr6NOQPdbSxoUEklaQr4Q2LMd7nJaqyxBmttgQ==
X-Received: by 2002:a63:d0e:: with SMTP id c14-v6mr1948214pgl.281.1537896766867;
        Tue, 25 Sep 2018 10:32:46 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id w23-v6sm4369988pgi.18.2018.09.25.10.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:32:45 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] of: unittest: Disable interrupt node tests for old world MAC systems
Date:   Tue, 25 Sep 2018 10:32:43 -0700
Message-Id: <1537896763-6160-1-git-send-email-linux@roeck-us.net>
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

Fixes: 53a42093d96ef ("of: Add device tree selftests")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
The changes in of_unittest_platform_populate() are kept at the minimum;
I wanted to avoid changing the intendation.
An alternative fix might be to move the interrupt tests to a separate
function.

 drivers/of/unittest.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 722537e14848..bd1d56cf1962 100644
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
@@ -1001,6 +1007,9 @@ static void __init of_unittest_platform_populate(void)
 	pdev = of_find_device_by_node(np);
 	unittest(pdev, "device 1 creation failed\n");
 
+	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
+		goto skip_irqtests;
+
 	irq = platform_get_irq(pdev, 0);
 	unittest(irq == -EPROBE_DEFER, "device deferred probe failed - %d\n", irq);
 
@@ -1011,6 +1020,7 @@ static void __init of_unittest_platform_populate(void)
 	irq = platform_get_irq(pdev, 0);
 	unittest(irq < 0 && irq != -EPROBE_DEFER, "device parsing error failed - %d\n", irq);
 
+skip_irqtests:
 	np = of_find_node_by_path("/testcase-data/platform-tests");
 	unittest(np, "No testcase data in device tree\n");
 	if (!np)
-- 
2.7.4

