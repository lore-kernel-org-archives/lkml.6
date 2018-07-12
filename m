Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6762FECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A30E20841
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A30E20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbeGLTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:45:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55703 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeGLTpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:45:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CJXtOU4025003
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 12:33:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CJXsbF4025000;
        Thu, 12 Jul 2018 12:33:54 -0700
Date:   Thu, 12 Jul 2018 12:33:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Geert Uytterhoeven <tipbot@zytor.com>
Message-ID: <tip-7a6e55375d5c584c7c11cfdcaa8ad9d6cccb419d@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, geert+renesas@glider.be,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, geert+renesas@glider.be,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180712144118.8819-1-geert+renesas@glider.be>
References: <20180712144118.8819-1-geert+renesas@glider.be>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Improve kernel message printing
Git-Commit-ID: 7a6e55375d5c584c7c11cfdcaa8ad9d6cccb419d
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

Commit-ID:  7a6e55375d5c584c7c11cfdcaa8ad9d6cccb419d
Gitweb:     https://git.kernel.org/tip/7a6e55375d5c584c7c11cfdcaa8ad9d6cccb419d
Author:     Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate: Thu, 12 Jul 2018 16:41:18 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 12 Jul 2018 21:29:30 +0200

hrtimer: Improve kernel message printing

  - Join split message for easier grepping,
  - Use pr_*() instead of printk*(),
  - Use %u to format unsigned cpu numbers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180712144118.8819-1-geert+renesas@glider.be

---
 kernel/time/hrtimer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 055a4a728c00..5c2af16c7c14 100644
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
@@ -1573,8 +1573,7 @@ retry:
 	else
 		expires_next = ktime_add(now, delta);
 	tick_program_event(expires_next, 1);
-	printk_once(KERN_WARNING "hrtimer: interrupt took %llu ns\n",
-		    ktime_to_ns(delta));
+	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
 }
 
 /* called with interrupts disabled */
