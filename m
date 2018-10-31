Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34B82064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRJngXKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34B82064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeJaVLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:11:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41655 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbeJaVLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:11:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id c16so11444707lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKh6AKC7s50sb4NhmGF8CMKw5V2OrbYoAONlRi2DvCo=;
        b=WRJngXKL/Gq0wUjjswpTxRLWdI5Xz8DmB/KNOZu3MeE7+0dLnHPHhXaffhia9Z2jnW
         ZKtYEcoYfI1io1E/7pfy1Xj3NXZUD8ctiTbGNvVNCxNeIRQgIMsHBFM/EN4Ab2NT2pXH
         YAeDD3l3nkcfnCrNQcwVKG73qbFw2KmWi/+CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKh6AKC7s50sb4NhmGF8CMKw5V2OrbYoAONlRi2DvCo=;
        b=hIVXLyQrF2z208iszODJi1Nh7zwSsLqB0WN0lgtS41eMeMfUcm260nthlOgpNiqVS4
         gdEmR9mREGtG4Fl8lhgBjpsB+o1uS9hT3k7HVjHt//HQzomeL2nDkd0KqV8rIHWsV1aM
         U/8imOoaqDbuT/GVrmJsr/DinPgDTwTxdet8zVUczu0vJ7xA4LFMPfUE3CM6VExmz0CY
         MX15Ab3l/6Hv46ZAEsKA9I8E+EnksMiqbaoAUxmQkFgNVhtRk9NmqK3SBQdAM/HnEOW+
         wLkcr2IT/9vucxY2Y7dvEsXpQ0ATaAgnPy5uYitMZ0BWVLqIemM2YGD2O+P7nKhUq95j
         8aGQ==
X-Gm-Message-State: AGRZ1gJk+PEkgCFf4geklwV+D6XL+Embkq7a2Er574cKxr8LjzMzNG10
        LCy6OrogOfWgb4j4QdVxO0K6pg==
X-Google-Smtp-Source: AJdET5cWuUVLNR3NWY73O8OfuM6sITS0+a1RtHKPYffwVLxQZ81un2jhzvBF0Mu8t9YJ/XG1GdjJ6A==
X-Received: by 2002:a19:ca51:: with SMTP id h17mr1635438lfj.126.1540988042868;
        Wed, 31 Oct 2018 05:14:02 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id z195-v6sm4125930lff.82.2018.10.31.05.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 05:14:02 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     will.deacon@arm.com, jason.wessel@windriver.com,
        daniel.thompson@linaro.org, james.morse@arm.com
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        arnd@arndb.de, Anders Roxell <anders.roxell@linaro.org>
Subject: [RFC PATCH] arm64/mm: hit DEBUG_LOCKS_WARN_ON
Date:   Wed, 31 Oct 2018 13:13:56 +0100
Message-Id: <20181031121356.30654-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running an arm64 kernel in a qemu guest and I hit this
DEBUG_LOCKS_WARN_ON and this patch removes the warning. The
interrupts_enabled(reqs) should reflect the irq->enabled state of the
kgdb test process when it hit the breakpoint, and that should be the
same as the current->hardirqs_enabled flag

[   25.682116] kgdbts:RUN singlestep test 1000 iterations
[   25.695926] ------------[ cut here ]------------
[   25.696410] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
[   25.697407] WARNING: CPU: 0 PID: 1 at ../kernel/locking/lockdep.c:3761 check_flags+0x64/0x198
[   25.698349] Modules linked in:
[   25.699144] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 4.19.0-next-20181030+ #6
[   25.699739] Hardware name: linux,dummy-virt (DT)
[   25.700359] pstate: 404003c5 (nZcv DAIF +PAN -UAO)
[   25.700901] pc : check_flags+0x64/0x198
[   25.701381] lr : check_flags+0x64/0x198
[   25.701779] sp : ffffff800814b800
[   25.702160] x29: ffffff800814b800 x28: ffffffc03ffbc000
[   25.702721] x27: ffffff80081ee4d0 x26: 0000000000000000
[   25.703240] x25: 0000000000000000 x24: 0000000000000002
[   25.703753] x23: 0000000000000000 x22: 0000000000000000
[   25.704276] x21: ffffff800aa23000 x20: 00000000000003c0
[   25.704792] x19: ffffff8009c14000 x18: 00000000ffffffff
[   25.705315] x17: 0000000000000000 x16: 0000000000000000
[   25.705833] x15: 1740000000000000 x14: 2f6f69747269762f
[   25.706356] x13: ffffffffffff0000 x12: ffffffffffffffff
[   25.706877] x11: 000000000000000e x10: 7f7f7f7f7f7f7f7f
[   25.707431] x9 : ffffff800814b800 x8 : 7261683e2d746e65
[   25.707954] x7 : 72727563284e4f5f x6 : ffffff800aa2283e
[   25.708471] x5 : 0000000000000000 x4 : 0000000000000000
[   25.708990] x3 : ffffff8008318584 x2 : ffffffc03ffbc000
[   25.709512] x1 : 0344ea595a8c0b00 x0 : 0000000000000000
[   25.710104] Call trace:
[   25.710553]  check_flags+0x64/0x198
[   25.711023]  lock_acquire+0x60/0x248
[   25.711477]  call_step_hook+0x5c/0x190
[   25.711937]  single_step_handler+0x48/0xa0
[   25.712399]  do_debug_exception+0x104/0x160
[   25.712846]  el1_dbg+0x18/0xa8
[   25.713252]  el1_irq+0xa8/0x1c0
[   25.713709]  kgdbts_break_test+0x0/0x40
[   25.714171]  kgdbts_run_tests+0x2b0/0x430
[   25.714637]  configure_kgdbts+0x7c/0xb0
[   25.715110]  init_kgdbts+0x70/0xac
[   25.715551]  do_one_initcall+0x1fc/0x490
[   25.716010]  do_initcall_level+0x458/0x49c
[   25.716462]  do_initcalls+0x60/0xa4
[   25.716892]  do_basic_setup+0x3c/0x68
[   25.717343]  kernel_init_freeable+0x170/0x2b8
[   25.717860]  kernel_init+0x20/0x130
[   25.718302]  ret_from_fork+0x10/0x18
[   25.718712] irq event stamp: 266621
[   25.719209] hardirqs last  enabled at (266621): [<ffffff80081e935c>] do_debug_exception+0x13c/0x160
[   25.719949] hardirqs last disabled at (266620): [<ffffff8008215a58>] kgdb_roundup_cpus+0x30/0x38
[   25.720675] softirqs last  enabled at (266616): [<ffffff80081e9f24>] __do_softirq+0x4e4/0x52c
[   25.721374] softirqs last disabled at (266609): [<ffffff8008279694>] irq_exit+0xbc/0x128
[   25.722050] ---[ end trace ecb2b85abf3c30a2 ]---
[   25.722537] possible reason: unannotated irqs-off.
[   25.722960] irq event stamp: 266621

Rework code to drop the 'if (interrupts_enabled(regs))' before
trace_hardirqs_*() in function do_debug_exception().

We don't know why current->hardirqs_enabled and interrupts_enabled(regs)
don't match.

Fixes: 6afedcd23cfd ("arm64: mm: Add trace_irqflags annotations to do_debug_exception()")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/mm/fault.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7d9571f4ae3d..9afe5a7ba55b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -819,11 +819,9 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	int rv;
 
 	/*
-	 * Tell lockdep we disabled irqs in entry.S. Do nothing if they were
-	 * already disabled to preserve the last enabled/disabled addresses.
+	 * Tell lockdep we disabled irqs in entry.S.
 	 */
-	if (interrupts_enabled(regs))
-		trace_hardirqs_off();
+	trace_hardirqs_off();
 
 	if (user_mode(regs) && instruction_pointer(regs) > TASK_SIZE)
 		arm64_apply_bp_hardening();
@@ -836,8 +834,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 		rv = 0;
 	}
 
-	if (interrupts_enabled(regs))
-		trace_hardirqs_on();
+	trace_hardirqs_on();
 
 	return rv;
 }
-- 
2.19.1

