Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8455C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CAA205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CAA205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeH3TH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:07:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50516 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbeH3TH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:07:58 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvOVb-0006Xh-Ls; Thu, 30 Aug 2018 17:05:19 +0200
Date:   Thu, 30 Aug 2018 17:05:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Crispin <john@phrozen.org>
cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH stable] tick/nohz: Prevent bogus softirq pending warning
Message-ID: <alpine.DEB.2.21.1808301702450.1210@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
---
 kernel/time/tick-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -888,7 +888,7 @@ static bool can_stop_idle_tick(int cpu,
 	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
 		static int ratelimit;
 
-		if (ratelimit < 10 &&
+		if (ratelimit < 10 && !in_softirq() &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
 			pr_warn("NOHZ: local_softirq_pending %02x\n",
 				(unsigned int) local_softirq_pending());
