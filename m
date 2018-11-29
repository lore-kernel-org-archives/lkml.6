Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBE8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76AF213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zW9W/6+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76AF213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbeK3Bd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbeK3Bd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5914E2145D;
        Thu, 29 Nov 2018 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501673;
        bh=9PA6UorcPNWtyG0sw+UTdz6T5FuGoV6Jnr3UGAlH5M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zW9W/6+OgARpt8IFdf8O+9DJh7lttJzLjvcgO0yAa5XK3+Ejx5WGNuKOeLABOMKSc
         YKCNQLpdFhCd8KGAOjJUfsuQtFM2CeBTLolWp8mKjT6DRqOR881TE+e4dYBjEw6Xm3
         96qQ31CCkiWedTLACyf8s2+ITKF5TedwS3OnuUb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marius Hillenbrand <mhillenb@amazon.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 4.14 095/100] rcu: Make need_resched() respond to urgent RCU-QS needs
Date:   Thu, 29 Nov 2018 15:13:05 +0100
Message-Id: <20181129140106.967088733@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
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

From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

commit 92aa39e9dc77481b90cbef25e547d66cab901496 upstream.

The per-CPU rcu_dynticks.rcu_urgent_qs variable communicates an urgent
need for an RCU quiescent state from the force-quiescent-state processing
within the grace-period kthread to context switches and to cond_resched().
Unfortunately, such urgent needs are not communicated to need_resched(),
which is sometimes used to decide when to invoke cond_resched(), for
but one example, within the KVM vcpu_run() function.  As of v4.15, this
can result in synchronize_sched() being delayed by up to ten seconds,
which can be problematic, to say nothing of annoying.

This commit therefore checks rcu_dynticks.rcu_urgent_qs from within
rcu_check_callbacks(), which is invoked from the scheduling-clock
interrupt handler.  If the current task is not an idle task and is
not executing in usermode, a context switch is forced, and either way,
the rcu_dynticks.rcu_urgent_qs variable is set to false.  If the current
task is an idle task, then RCU's dyntick-idle code will detect the
quiescent state, so no further action is required.  Similarly, if the
task is executing in usermode, other code in rcu_check_callbacks() and
its called functions will report the corresponding quiescent state.

Reported-by: Marius Hillenbrand <mhillenb@amazon.de>
Reported-by: David Woodhouse <dwmw2@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Backported to make patch apply cleanly on older versions. ]
Tested-by: Marius Hillenbrand <mhillenb@amazon.de>
Cc: <stable@vger.kernel.org> # 4.12.x - 4.19.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/rcu/tree.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2772,6 +2772,15 @@ void rcu_check_callbacks(int user)
 		rcu_bh_qs();
 	}
 	rcu_preempt_check_callbacks();
+	/* The load-acquire pairs with the store-release setting to true. */
+	if (smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs))) {
+		/* Idle and userspace execution already are quiescent states. */
+		if (!rcu_is_cpu_rrupt_from_idle() && !user) {
+			set_tsk_need_resched(current);
+			set_preempt_need_resched();
+		}
+		__this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
+	}
 	if (rcu_pending())
 		invoke_rcu_core();
 	if (user)


