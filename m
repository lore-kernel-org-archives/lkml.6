Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F7BC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39592086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39592086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeIKLRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:17:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeIKLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:17:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8B6IwkN2135511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 23:18:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8B6IwHS2135508;
        Mon, 10 Sep 2018 23:18:58 -0700
Date:   Mon, 10 Sep 2018 23:18:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for He Zhe <tipbot@zytor.com>
Message-ID: <tip-ccde460b9ae5c2bd5e4742af0a7f623c2daad566@git.kernel.org>
Cc:     zhe.he@windriver.com, peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          mingo@kernel.org, zhe.he@windriver.com, peterz@infradead.org
In-Reply-To: <1534260823-87917-1-git-send-email-zhe.he@windriver.com>
References: <1534260823-87917-1-git-send-email-zhe.he@windriver.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/corruption-check: Fix panic in
 memory_corruption_check() when boot option without value is provided
Git-Commit-ID: ccde460b9ae5c2bd5e4742af0a7f623c2daad566
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ccde460b9ae5c2bd5e4742af0a7f623c2daad566
Gitweb:     https://git.kernel.org/tip/ccde460b9ae5c2bd5e4742af0a7f623c2daad566
Author:     He Zhe <zhe.he@windriver.com>
AuthorDate: Tue, 14 Aug 2018 23:33:42 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 14:47:32 +0200

x86/corruption-check: Fix panic in memory_corruption_check() when boot option without value is provided

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
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1534260823-87917-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/check.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/check.c b/arch/x86/kernel/check.c
index 33399426793e..cc8258a5378b 100644
--- a/arch/x86/kernel/check.c
+++ b/arch/x86/kernel/check.c
@@ -31,6 +31,11 @@ static __init int set_corruption_check(char *arg)
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
@@ -45,6 +50,11 @@ static __init int set_corruption_check_period(char *arg)
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
@@ -59,6 +69,11 @@ static __init int set_corruption_check_size(char *arg)
 	char *end;
 	unsigned size;
 
+	if (!arg) {
+		pr_err("memory_corruption_check_size config string not provided\n");
+		return -EINVAL;
+	}
+
 	size = memparse(arg, &end);
 
 	if (*end == '\0')
