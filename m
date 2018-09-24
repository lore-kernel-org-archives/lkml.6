Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70381C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312CC2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312CC2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389071AbeIXSpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:45:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388731AbeIXSpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:45:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32D6B109A;
        Mon, 24 Sep 2018 12:43:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 204/235] rcutorture: Use monotonic timestamp for stall detection
Date:   Mon, 24 Sep 2018 13:53:10 +0200
Message-Id: <20180924113124.454528127@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 622be33fcbc93e9b672b99ed338369eb5e843ac3 ]

The get_seconds() call is deprecated because it overflows on 32-bit
architectures. The algorithm in rcu_torture_stall() can deal with
the overflow, but another problem here is that using a CLOCK_REALTIME
stamp can lead to a false-positive stall warning when a settimeofday()
happens concurrently.

Using ktime_get_seconds() instead avoids those issues and will never
overflow. The added cast to 'unsigned long' however is necessary to
make ULONG_CMP_LT() work correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/rcu/rcutorture.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1446,7 +1446,7 @@ static int rcu_torture_stall(void *args)
 		VERBOSE_TOROUT_STRING("rcu_torture_stall end holdoff");
 	}
 	if (!kthread_should_stop()) {
-		stop_at = get_seconds() + stall_cpu;
+		stop_at = ktime_get_seconds() + stall_cpu;
 		/* RCU CPU stall is expected behavior in following code. */
 		rcu_read_lock();
 		if (stall_cpu_irqsoff)
@@ -1455,7 +1455,8 @@ static int rcu_torture_stall(void *args)
 			preempt_disable();
 		pr_alert("rcu_torture_stall start on CPU %d.\n",
 			 smp_processor_id());
-		while (ULONG_CMP_LT(get_seconds(), stop_at))
+		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
+				    stop_at))
 			continue;  /* Induce RCU CPU stall warning. */
 		if (stall_cpu_irqsoff)
 			local_irq_enable();


