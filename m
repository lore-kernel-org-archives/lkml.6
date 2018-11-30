Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB77C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1FB20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hxVUUNuu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dqJuV36Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1FB20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeLACU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:20:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38432 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLACU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:20:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 69BCE6020A; Fri, 30 Nov 2018 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543590678;
        bh=lxaIqP9U+KhM07BlGYGCxmM2dwCNlyP94hJ1XtgbF/o=;
        h=From:To:Cc:Subject:Date:From;
        b=hxVUUNuuNjr8tvdiu0z1dE5nJLQL1SxwCO8XjCKvpZdPYT2VRKbumU5bu6efmr9z8
         d4ToKUVfy6xLy87WrF6MWma5hrRrK10/7/7kI1pf5siqTWo8KmRLqfMwV7rvrUPPhJ
         yrx2yZ1LAl/oN47+A4PtJBfGSxnOZaVI93eY3EfU=
Received: from prsood-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C30160850;
        Fri, 30 Nov 2018 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543590677;
        bh=lxaIqP9U+KhM07BlGYGCxmM2dwCNlyP94hJ1XtgbF/o=;
        h=From:To:Cc:Subject:Date:From;
        b=dqJuV36Y2zIs+lR3XJSFp4VbW7rqZM5gImmzaCUULxhOvyTF6AO44fsNRhqyOzIlt
         wCb9YXaP6lVq+30hGfTzT18T9o+Ot/Lg0dFp4dr8AjsGgNw0XxvyzObfvzy1vZEpcm
         rkear/Ghp/HZz2O6A/rmAExn8Srun4flyu7N0TsM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C30160850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
From:   Prateek Sood <prsood@codeaurora.org>
To:     peterz@infradead.org, mingo@redhat.com, dbueso@suse.de,
        prsood@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, sramana@codeaurora.org
Subject: [PATCH] percpu_rwsem: fix missed wakeup due to reordering of load
Date:   Fri, 30 Nov 2018 20:40:56 +0530
Message-Id: <1543590656-7157-1-git-send-email-prsood@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a scenario where cpu_hotplug_lock percpu_rw_semaphore is already
acquired for read operation by P1 using percpu_down_read().

Now we have P1 in the path of releaseing the cpu_hotplug_lock and P2
is in the process of acquiring cpu_hotplug_lock.

P1                                               P2
percpu_up_read() path                      percpu_down_write() path

                                          rcu_sync_enter() //gp_state=GP_PASSED

rcu_sync_is_idle() //returns false        down_write(rw_sem)

__percpu_up_read()

[L] task = rcu_dereference(w->task) //NULL

smp_rmb()                                  [S] w->task = current

                                            smp_mb()

                                           [L] readers_active_check() //fails
					     schedule()

[S] __this_cpu_dec(read_count)

Since load of task can result in NULL. This can lead to missed wakeup
in rcuwait_wake_up(). Above sequence violated the following constraint
in rcuwait_wake_up():

	 WAIT                WAKE
[S] tsk = current	  [S] cond = true
MB (A)	                    MB (B)
[L] cond		  [L] tsk

This can happen as smp_rmb() in rcuwait_wake_up() will provide ordering
of load before barrier with load and store after barrier for arm64
architecture. Here the requirement is to order store before smp_rmb()
with load after the smp_rmb().

For the usage of rcuwait_wake_up() in __percpu_up_read() full barrier
(smp_mb) is required to complete the constraint of rcuwait_wake_up().

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f1d74f0..a10820d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -306,7 +306,7 @@ void rcuwait_wake_up(struct rcuwait *w)
 	 *        MB (A)	      MB (B)
 	 *    [L] cond		  [L] tsk
 	 */
-	smp_rmb(); /* (B) */
+	smp_mb(); /* (B) */
 
 	/*
 	 * Avoid using task_rcu_dereference() magic as long as we are careful,
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

