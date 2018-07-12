Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F45DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD082147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD082147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbeGLOvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:51:12 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:44826 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbeGLOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:51:12 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 9qhK1y00S3XaVaC01qhKzw; Thu, 12 Jul 2018 16:41:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fdcmV-00022l-GQ; Thu, 12 Jul 2018 16:41:19 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fdcmV-0002Iz-ET; Thu, 12 Jul 2018 16:41:19 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] time: hrtimer: Improve kernel message printing
Date:   Thu, 12 Jul 2018 16:41:18 +0200
Message-Id: <20180712144118.8819-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Join split message for easier grepping,
  - Use pr_*() instead of printk*(),
  - Use %u to format unsigned cpu numbers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/time/hrtimer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3e93c54bd3a16b7f..e1a549c9e3991830 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -718,8 +718,8 @@ static void hrtimer_switch_to_hres(void)
 	struct hrtimer_cpu_base *base = this_cpu_ptr(&hrtimer_bases);
 
 	if (tick_init_highres()) {
-		printk(KERN_WARNING "Could not switch to high resolution "
-				    "mode on CPU %d\n", base->cpu);
+		pr_warn("Could not switch to high resolution mode on CPU %u\n",
+			base->cpu);
 		return;
 	}
 	base->hres_active = 1;
@@ -1573,8 +1573,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	else
 		expires_next = ktime_add(now, delta);
 	tick_program_event(expires_next, 1);
-	printk_once(KERN_WARNING "hrtimer: interrupt took %llu ns\n",
-		    ktime_to_ns(delta));
+	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
 }
 
 /* called with interrupts disabled */
-- 
2.17.1

