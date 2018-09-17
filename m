Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04EFECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972A42146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972A42146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbeIREbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:31:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeIREbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:31:35 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C899EC77;
        Mon, 17 Sep 2018 23:02:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infraded.org>,
        josh@joshtriplett.org, peterz@infradead.org,
        jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org, mojha@codeaurora.org,
        sramana@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 4.14 014/126] cpu/hotplug: Adjust misplaced smb() in cpuhp_thread_fun()
Date:   Tue, 18 Sep 2018 00:41:02 +0200
Message-Id: <20180917211705.614335388@linuxfoundation.org>
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

From: Neeraj Upadhyay <neeraju@codeaurora.org>

commit f8b7530aa0a1def79c93101216b5b17cf408a70a upstream.

The smp_mb() in cpuhp_thread_fun() is misplaced. It needs to be after the
load of st->should_run to prevent reordering of the later load/stores
w.r.t. the load of st->should_run.

Fixes: 4dddfb5faa61 ("smp/hotplug: Rewrite AP state machine core")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infraded.org>
Cc: josh@joshtriplett.org
Cc: peterz@infradead.org
Cc: jiangshanlai@gmail.com
Cc: dzickus@redhat.com
Cc: brendan.jackman@arm.com
Cc: malat@debian.org
Cc: mojha@codeaurora.org
Cc: sramana@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1536126727-11629-1-git-send-email-neeraju@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/cpu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -612,15 +612,15 @@ static void cpuhp_thread_fun(unsigned in
 	bool bringup = st->bringup;
 	enum cpuhp_state state;
 
+	if (WARN_ON_ONCE(!st->should_run))
+		return;
+
 	/*
 	 * ACQUIRE for the cpuhp_should_run() load of ->should_run. Ensures
 	 * that if we see ->should_run we also see the rest of the state.
 	 */
 	smp_mb();
 
-	if (WARN_ON_ONCE(!st->should_run))
-		return;
-
 	cpuhp_lock_acquire(bringup);
 
 	if (st->single) {


