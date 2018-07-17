Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2ECECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF7121470
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF7121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeGQJnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:43:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35709 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeGQJnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:43:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9Bfh31458671
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:11:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9BfpB1458668;
        Tue, 17 Jul 2018 02:11:41 -0700
Date:   Tue, 17 Jul 2018 02:11:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-cd23ac8ddb7be993f88bee893b89a8b4971c3651@git.kernel.org>
Cc:     paulmck@linux.vnet.ibm.com, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org
Reply-To: mingo@kernel.org, paulmck@linux.vnet.ibm.com, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          rostedt@goodmis.org
In-Reply-To: <20180524223839.GU3803@linux.vnet.ibm.com>
References: <20180524223839.GU3803@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rcu] rcu: Add comment to the last sleep in the rcu tasks
 loop
Git-Commit-ID: cd23ac8ddb7be993f88bee893b89a8b4971c3651
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

Commit-ID:  cd23ac8ddb7be993f88bee893b89a8b4971c3651
Gitweb:     https://git.kernel.org/tip/cd23ac8ddb7be993f88bee893b89a8b4971c3651
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Thu, 24 May 2018 18:58:16 -0400
Committer:  Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CommitDate: Thu, 12 Jul 2018 15:39:21 -0700

rcu: Add comment to the last sleep in the rcu tasks loop

At the end of rcu_tasks_kthread() there's a lonely
schedule_timeout_uninterruptible() call with no apparent rationale for
its existence. But there is. It is to keep the thread from going into
a tight loop if there's some anomaly. That really needs a comment.

Link: http://lkml.kernel.org/r/20180524223839.GU3803@linux.vnet.ibm.com
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 4c7c49c106ee..39cb23d22109 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -814,6 +814,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			list = next;
 			cond_resched();
 		}
+		/* Paranoid sleep to keep this from entering a tight loop */
 		schedule_timeout_uninterruptible(HZ/10);
 	}
 }
