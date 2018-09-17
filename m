Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FCDECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93935214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93935214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbeIREbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:31:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeIREbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:31:39 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F043FC03;
        Mon, 17 Sep 2018 23:02:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sudeep Holla <sudeep.holla@arm.com>, josh@joshtriplett.org,
        peterz@infradead.org, jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 4.14 015/126] cpu/hotplug: Prevent state corruption on error rollback
Date:   Tue, 18 Sep 2018 00:41:03 +0200
Message-Id: <20180917211705.700936708@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
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

commit 69fa6eb7d6a64801ea261025cce9723d9442d773 upstream.

When a teardown callback fails, the CPU hotplug code brings the CPU back to
the previous state. The previous state becomes the new target state. The
rollback happens in undo_cpu_down() which increments the state
unconditionally even if the state is already the same as the target.

As a consequence the next CPU hotplug operation will start at the wrong
state. This is easily to observe when __cpu_disable() fails.

Prevent the unconditional undo by checking the state vs. target before
incrementing state and fix up the consequently wrong conditional in the
unplug code which handles the failure of the final CPU take down on the
control CPU side.

Fixes: 4dddfb5faa61 ("smp/hotplug: Rewrite AP state machine core")
Reported-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: josh@joshtriplett.org
Cc: peterz@infradead.org
Cc: jiangshanlai@gmail.com
Cc: dzickus@redhat.com
Cc: brendan.jackman@arm.com
Cc: malat@debian.org
Cc: sramana@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----

---
 kernel/cpu.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -932,7 +932,8 @@ static int cpuhp_down_callbacks(unsigned
 		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
 		if (ret) {
 			st->target = prev_state;
-			undo_cpu_down(cpu, st);
+			if (st->state < prev_state)
+				undo_cpu_down(cpu, st);
 			break;
 		}
 	}
@@ -985,7 +986,7 @@ static int __ref _cpu_down(unsigned int
 	 * to do the further cleanups.
 	 */
 	ret = cpuhp_down_callbacks(cpu, st, target);
-	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
+	if (ret && st->state == CPUHP_TEARDOWN_CPU && st->state < prev_state) {
 		cpuhp_reset_state(st, prev_state);
 		__cpuhp_kick_ap(st);
 	}


