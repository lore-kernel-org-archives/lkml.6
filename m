Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22651C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC371222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0vC64doY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394170AbfBNTcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:32:01 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36170 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389635AbfBNTcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:32:00 -0500
Received: by mail-yb1-f196.google.com with SMTP id o129so1095511yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ymTetqCxQkH/gWrBLMleTrR9XZQMlMdB3tW36JbLzeo=;
        b=0vC64doYJxj3u46L57PzC+PF1KMBPV7TsxV5mb9gFTLzelru2Q/8CQaq2zlTgoKjN7
         HzkHnDOoc55WMEgqaUNN9Af3i0y36vKNQkB9bbj4+moimHQn1mQjBy/iFQ1gLz1+nXLJ
         aFy+9Lp0069Huzn79TyMlQxO318+rmzZ3SHyYHkzw5wc/kIHqb4foL2bqEzklikT3P/y
         r9ECSwOP4+2HgsYzDtAypzvXgwJCxi8FpIhg2fWz6VzVIIx4xk1lf5Q00XcV4AM6hOUv
         vYlRKF3pGicTXHhAY4AT5Hk0qW7WyIWpPYXZLCWN3JjLSBiBXsKyEc3aLdOc9GQTtowy
         +DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ymTetqCxQkH/gWrBLMleTrR9XZQMlMdB3tW36JbLzeo=;
        b=PwNcyfwipitaYEvpXNXysPVTfQusmSuAK56LTbHH/kvMM+QqeQFS3L5UbWPaEvjXJS
         2eFvH6dn+sn5627zf5uInVMH6UAwyhsW5dV6QlrcX2k/HII0UWie7Glx7TpjZIdZUMac
         GeDy6tKI2DPGpekBovuH1vscXx+uA/lnQNmU3S6zZ0trdCpNWTnWfQAB13DrcyUFuaIn
         Pz61HAbqjvBGNOytNP5+w3b07mjNgcA/vS4u5+wFMMatm6s2Lr4/OgG7hyOghDUsFQM1
         g/dpMUCVCqZ9rrojaNruhnjD9Q6z/rSa2RrD/niAxElu5sy2PfpbKjIF8EEivH6oLm7t
         0Vkw==
X-Gm-Message-State: AHQUAuYPUdnZz5HXjUHYxQAaYNGIJWo3MI9IcUBSZn15QKWXvAzd6kCH
        jytal3DFRyYKgUokOwrdM0MvF/LuzSo=
X-Google-Smtp-Source: AHgI3Ia4ziWhxAdP0rAwp3ibPNpx3P7fE9R/9qg9oS915c4CYnZ9kF4h8hHkKUBL54nnyxnm/G7vHg==
X-Received: by 2002:a25:37cd:: with SMTP id e196mr4610415yba.169.1550172719404;
        Thu, 14 Feb 2019 11:31:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:80d4])
        by smtp.gmail.com with ESMTPSA id a72sm1223823ywh.42.2019.02.14.11.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 11:31:58 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?=C5=81ukasz=20Siudut?= <lsiudut@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] psi: avoid divide-by-zero crash inside virtual machines
Date:   Thu, 14 Feb 2019 14:31:57 -0500
Message-Id: <20190214193157.15788-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've been seeing hard-to-trigger psi crashes when running inside VM
instances:

[ 1255.840325] divide error: 0000 [#1] SMP PTI
[ 1255.840325] Modules linked in: [...]
[ 1255.840325] CPU: 0 PID: 212 Comm: kworker/0:2 Not tainted 4.16.18-119_fbk9_3817_gfe944c98d695 #119
[ 1255.840325] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[ 1255.840325] Workqueue: events psi_clock
[ 1255.840325] RIP: 0010:psi_update_stats+0x270/0x490
[ 1255.840325] RSP: 0018:ffffc90001117e10 EFLAGS: 00010246
[ 1255.840325] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8800a35a13f8
[ 1255.840325] RDX: 0000000000000000 RSI: ffff8800a35a1340 RDI: 0000000000000000
[ 1255.840325] RBP: 0000000000000658 R08: ffff8800a35a1470 R09: 0000000000000000
[ 1255.840325] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 1255.840325] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000f8502
[ 1255.840325] FS:  0000000000000000(0000) GS:ffff88023fc00000(0000) knlGS:0000000000000000
[ 1255.840325] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1255.840325] CR2: 00007fbe370fa000 CR3: 00000000b1e3a000 CR4: 00000000000006f0
[ 1255.840325] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1255.840325] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1255.840325] Call Trace:
[ 1255.840325]  psi_clock+0x12/0x50
[ 1255.840325]  process_one_work+0x1e0/0x390
[ 1255.840325]  worker_thread+0x2b/0x3c0
[ 1255.840325]  ? rescuer_thread+0x330/0x330
[ 1255.840325]  kthread+0x113/0x130
[ 1255.840325]  ? kthread_create_worker_on_cpu+0x40/0x40
[ 1255.840325]  ? SyS_exit_group+0x10/0x10
[ 1255.840325]  ret_from_fork+0x35/0x40
[ 1255.840325] Code: 48 0f 47 c7 48 01 c2 45 85 e4 48 89 16 0f 85 e6 00 00 00 4c 8b 49 10 4c 8b 51 08 49 69 d9 f2 07 00 00 48 6b c0 64 4c 8b 29 31 d2 <48> f7 f7 49 69 d5 8d 06 00 00 48 89 c5 4c 69 f0 00 98 0b 00 48

The Code-line points to `period` being 0 inside update_stats(), and we
divide by that when calculating that period's pressure percentage.

The elapsed period should never be 0. The reason this can happen is
due to an off-by-one in the idle time / missing period calculation
combined with a coarse sched_clock() in the virtual machine.

The target time for aggregation is advanced into the future on a fixed
grid to prevent clock drift. So when an aggregation runs after some
idle period, we can not just set it to "now + psi_period", but have to
calculate the downtime and advance the target time relative to itself.

However, if the aggregator was disabled exactly one psi_period (ns),
we drop one idle period in the calculation due to a > when we should
do >=. In that case, next_update will be advanced from 'now -
psi_period' to 'now' when it should be moved to 'now + psi_period'.
The run finishes with last_update == next_update == sched_clock().

With hardware clocks, this exact nanosecond match isn't likely in the
first place; but if it does happen, the clock will still have moved on
and the period non-zero by the time the worker runs. A pointlessly
short period, but besides the extra work, no harm no foul. However, a
slow sched_clock() like we have on VMs might not have advanced either
by the time the worker runs again. And when we calculate the elapsed
period, the result, our pressure divisor, will be 0. Ouch.

Fix this by correctly handling the situation when the elapsed time
between aggregation runs is precisely two periods, and advance the
expiration timestamp correctly to period into the future.

Reported-by: Łukasz Siudut <lsiudut@fb.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index c3484785b179..0e97ca9306ef 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -322,7 +322,7 @@ static bool update_stats(struct psi_group *group)
 	expires = group->next_update;
 	if (now < expires)
 		goto out;
-	if (now - expires > psi_period)
+	if (now - expires >= psi_period)
 		missed_periods = div_u64(now - expires, psi_period);
 
 	/*
-- 
2.20.1

