Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E65C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E051520873
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E051520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIDTHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:07:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727266AbeIDTHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:07:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC25D40241C4;
        Tue,  4 Sep 2018 14:42:30 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-111.ams2.redhat.com [10.36.116.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19FE42027069;
        Tue,  4 Sep 2018 14:42:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH] x86/setup: Deal with "quiet" commandline option earlier
Date:   Tue,  4 Sep 2018 16:42:25 +0200
Message-Id: <20180904144225.14831-2-hdegoede@redhat.com>
In-Reply-To: <20180904144225.14831-1-hdegoede@redhat.com>
References: <20180904144225.14831-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 04 Sep 2018 14:42:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 04 Sep 2018 14:42:30 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X86's setup_arch() calls parse_early_param() somewhat late, to make
sure that everything is setup correcty to deal with earlyprintk over
the EHCI debug port.

This means that a number of pr_info-s get done before
"early_param("quiet", quiet_kernel)" from init/main.c gets processed.

Until commit 375899cddcbb ("printk: make sure to print log on console.")
this was not a problem because the printk code would evaluate the
console_loglevel vs the message-loglevel when flushing the buffer.

After this commit the check is done at the time that pr_info is actually
called and the console_loglevel at calling time.

This causes the following messages to get printed with the "quiet" option:

[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
...
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000874ffffff] usable

This commit fixes this by making x86's setup_arch() explicitly check for
quiet early on.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Maninder Singh <maninder1.s@samsung.com>
Fixes: 375899cddcbb ("printk: make sure to print log on console.")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/kernel/setup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b4866badb235..38f66b14cf3d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -93,6 +93,7 @@
 #include <asm/processor.h>
 #include <asm/bugs.h>
 #include <asm/kasan.h>
+#include <asm/cmdline.h>
 
 #include <asm/vsyscall.h>
 #include <asm/cpu.h>
@@ -864,6 +865,16 @@ void __init setup_arch(char **cmdline_p)
 	boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
 #endif
 
+#if !defined CONFIG_CMDLINE_BOOL || !defined CONFIG_CMDLINE_OVERRIDE
+	/*
+	 * We call parse_early_param() somewhat late, see x86_configure_nx()
+	 * comment. Deal with "quiet" here to suppress printing of early
+	 * boot messages when quiet has been requested.
+	 */
+	if (cmdline_find_option_bool(boot_command_line, "quiet"))
+		console_loglevel = CONSOLE_LOGLEVEL_QUIET;
+#endif
+
 	/*
 	 * If we have OLPC OFW, we might end up relocating the fixmap due to
 	 * reserve_top(), so do this before touching the ioremap area.
-- 
2.19.0.rc0

