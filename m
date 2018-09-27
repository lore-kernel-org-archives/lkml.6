Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D13C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AA12156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AA12156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeI0PlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:41:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeI0PlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:41:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34EE81113;
        Thu, 27 Sep 2018 09:23:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, John Crispin <john@phrozen.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4.14 63/64] tick/nohz: Prevent bogus softirq pending warning
Date:   Thu, 27 Sep 2018 11:04:20 +0200
Message-Id: <20180927090258.473509321@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

Commit 0a0e0829f990 ("nohz: Fix missing tick reprogram when interrupting an
inline softirq") got backported to stable trees and now causes the NOHZ
softirq pending warning to trigger. It's not an upstream issue as the NOHZ
update logic has been changed there.

The problem is when a softirq disabled section gets interrupted and on
return from interrupt the tick/nohz state is evaluated, which then can
observe pending soft interrupts. These soft interrupts are legitimately
pending because they cannot be processed as long as soft interrupts are
disabled and the interrupted code will correctly process them when soft
interrupts are reenabled.

Add a check for softirqs disabled to the pending check to prevent the
warning.

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reported-by: John Crispin <john@phrozen.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Tested-by: John Crispin <john@phrozen.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: 2d898915ccf4838c ("nohz: Fix missing tick reprogram when interrupting an inline softirq")
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/time/tick-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -908,7 +908,7 @@ static bool can_stop_idle_tick(int cpu,
 	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
 		static int ratelimit;
 
-		if (ratelimit < 10 &&
+		if (ratelimit < 10 && !in_softirq() &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
 			pr_warn("NOHZ: local_softirq_pending %02x\n",
 				(unsigned int) local_softirq_pending());


