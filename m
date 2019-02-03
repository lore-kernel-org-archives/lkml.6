Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BDDC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6A8218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfBCNuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53084 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728041AbfBCNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:47 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9X-0003tj-4c; Sun, 03 Feb 2019 13:49:43 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006ot-7M; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "He Zhe" <zhe.he@windriver.com>, gregkh@linuxfoundation.org,
        "Ingo Molnar" <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        kstewart@linuxfoundation.org,
        "Thomas Gleixner" <tglx@linutronix.de>, pombredanne@nexb.com
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.841460751@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 024/305] x86/corruption-check: Fix panic in
 memory_corruption_check() when boot option without value is provided
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: He Zhe <zhe.he@windriver.com>

commit ccde460b9ae5c2bd5e4742af0a7f623c2daad566 upstream.

memory_corruption_check[{_period|_size}]()'s handlers do not check input
argument before passing it to kstrtoul() or simple_strtoull(). The argument
would be a NULL pointer if each of the kernel parameters, without its
value, is set in command line and thus cause the following panic.

PANIC: early exception 0xe3 IP 10:ffffffff73587c22 error 0 cr2 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18-rc8+ #2
[    0.000000] RIP: 0010:kstrtoull+0x2/0x10
...
[    0.000000] Call Trace
[    0.000000]  ? set_corruption_check+0x21/0x49
[    0.000000]  ? do_early_param+0x4d/0x82
[    0.000000]  ? parse_args+0x212/0x330
[    0.000000]  ? rdinit_setup+0x26/0x26
[    0.000000]  ? parse_early_options+0x20/0x23
[    0.000000]  ? rdinit_setup+0x26/0x26
[    0.000000]  ? parse_early_param+0x2d/0x39
[    0.000000]  ? setup_arch+0x2f7/0xbf4
[    0.000000]  ? start_kernel+0x5e/0x4c2
[    0.000000]  ? load_ucode_bsp+0x113/0x12f
[    0.000000]  ? secondary_startup_64+0xa5/0xb0

This patch adds checks to prevent the panic.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org
Cc: pombredanne@nexb.com
Link: http://lkml.kernel.org/r/1534260823-87917-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/check.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/x86/kernel/check.c
+++ b/arch/x86/kernel/check.c
@@ -30,6 +30,11 @@ static __init int set_corruption_check(c
 	ssize_t ret;
 	unsigned long val;
 
+	if (!arg) {
+		pr_err("memory_corruption_check config string not provided\n");
+		return -EINVAL;
+	}
+
 	ret = kstrtoul(arg, 10, &val);
 	if (ret)
 		return ret;
@@ -44,6 +49,11 @@ static __init int set_corruption_check_p
 	ssize_t ret;
 	unsigned long val;
 
+	if (!arg) {
+		pr_err("memory_corruption_check_period config string not provided\n");
+		return -EINVAL;
+	}
+
 	ret = kstrtoul(arg, 10, &val);
 	if (ret)
 		return ret;
@@ -58,6 +68,11 @@ static __init int set_corruption_check_s
 	char *end;
 	unsigned size;
 
+	if (!arg) {
+		pr_err("memory_corruption_check_size config string not provided\n");
+		return -EINVAL;
+	}
+
 	size = memparse(arg, &end);
 
 	if (*end == '\0')

