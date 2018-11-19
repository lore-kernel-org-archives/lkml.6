Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D1FC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05539208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ybWpLgGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05539208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404206AbeKTDUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:20:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403780AbeKTDUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:20:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 957D221104;
        Mon, 19 Nov 2018 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646575;
        bh=dlS/Eu5qxk6DBuAo/e2DErl1rkY1DjXTrBte4Yr0l10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ybWpLgGW/Js8Eru0+yMKCDvi4rGbrM909NeDL1v1GmSa577hhxitQSD5fADSkA7Rk
         17vVr60nuwT5wsETTnv+RXZTjXNBTWC0dzeMr+5QNjPyi1n/m8GSabTg+CkKLYemR1
         8PKzV2EQj8L7tIPRtmlFYsjaqM/HQwR1VSypS1h0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 010/160] x86/corruption-check: Fix panic in memory_corruption_check() when boot option without value is provided
Date:   Mon, 19 Nov 2018 17:27:29 +0100
Message-Id: <20181119162631.259114346@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1534260823-87917-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/check.c |   15 +++++++++++++++
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


