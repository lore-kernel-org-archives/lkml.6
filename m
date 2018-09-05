Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DA4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F9220839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TKi3Cib7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TKi3Cib7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F9220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeIEXrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:47:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:47:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E20E6606CF; Wed,  5 Sep 2018 19:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536174958;
        bh=30VTsZ7vpxQwrjESYZNbfrjYirSX3+B/sm1V0bZ8i24=;
        h=From:To:Cc:Subject:Date:From;
        b=TKi3Cib7xJ4QWIgPcrGUWaKJlfynPAQMrWdDTt1regFMhX4sljtp1d2MZGgL7XTQl
         MgYnpFU64DovT8HwxIFV1gxw948YJ+UCvrOkipztNHUmz14xHwHG9ttGFjQ+MigfQk
         f2yC2hdrr58hjQibhLOhnSp1mcZ6WY6/ls6VdqxQ=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04BDB6055B;
        Wed,  5 Sep 2018 19:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536174958;
        bh=30VTsZ7vpxQwrjESYZNbfrjYirSX3+B/sm1V0bZ8i24=;
        h=From:To:Cc:Subject:Date:From;
        b=TKi3Cib7xJ4QWIgPcrGUWaKJlfynPAQMrWdDTt1regFMhX4sljtp1d2MZGgL7XTQl
         MgYnpFU64DovT8HwxIFV1gxw948YJ+UCvrOkipztNHUmz14xHwHG9ttGFjQ+MigfQk
         f2yC2hdrr58hjQibhLOhnSp1mcZ6WY6/ls6VdqxQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04BDB6055B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH] kernel: cpu: Handle hotplug failure for state CPUHP_AP_IDLE_DEAD
Date:   Wed,  5 Sep 2018 12:15:17 -0700
Message-Id: <1536174917-11408-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the tear down hotplug handler is run, cpu is dead and enters
into CPUHP_AP_IDLE_DEAD state. Any callbacks that fail in the state
machine with state < CPUHP_AP_IDLE must be treated as fatal as this
could result into timer not beig migrated away from dead cpu and run
into issues like work queue lock ups, sched_clock timer wrapping to
zero as sched_clock_poll which is in the hrtimer base of cpu being
hotplugged does not get migrated.

The function sched_clock_poll() updates the epoch_ns and epoch_cyc. If
this function present in the hrtimer base of cpu being hotplugged
doesn't migrate, there is no update on the epoch_ns and epoch_cyc.
Subseqently, when sched_clock() is called, the non updated values of
epoch_ns and epoch_cyc are obtained which looks like the timer wrapped
around.
[ 8792.168842] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=6801s workers=2 manager: 4884
[ 8792.168862] pool 16: cpus=0-7 flags=0x4 nice=0 hung=0s workers=34 idle: 4482 1390 1394 1396 4492 5442 5447 5445
[    0.017714] Modules linked in: wlan(O)
[    0.017733] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W  O    4.9.37+ #1
[    0.017746] task: ffffffc1b05c8080 task.stack: ffffffc1b05c4000

As seen, the time rolls over to 0 after 8792.

Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0db8938..51fa38f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -837,6 +837,7 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 
 	for (; st->state > target; st->state--) {
 		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
+		BUG_ON(ret && st->state < CPUHP_AP_IDLE_DEAD);
 		if (ret) {
 			st->target = prev_state;
 			undo_cpu_down(cpu, st);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

