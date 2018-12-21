Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069AEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA03321903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xs5vn3hJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C0lLKc4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbeLUH3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:29:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733056AbeLUH3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:29:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D884460E3D; Fri, 21 Dec 2018 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545377387;
        bh=0rh/Y3orgABr/6NpLslESGMZRGQdp5fE3fGdz1kPfxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xs5vn3hJ7Pc9C2m/D/wAwjQGZvQmlGZNCdIpQxD/mrbafwQQjCqXKh0TO43nDh4rY
         SYjCtWdU0l/i2GWIvLQDcRRTxDYdzZMs6o++gPQCnqJ6nFiyrPZ0e2NEfu8ZZEIIXW
         piXrqv+jzVrdidzRnEKjExX0+Q1OcQAdNPtch3I0=
Received: from prsood-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46DC960DE9;
        Fri, 21 Dec 2018 07:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545377369;
        bh=0rh/Y3orgABr/6NpLslESGMZRGQdp5fE3fGdz1kPfxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0lLKc4jpCmAfCR7d5Ju3wHNHN59GDgOKaOv1hAukMQzI5o4go/ZRG1hzmIfWEuFd
         Gqwg8aLMlGXyF9zYhgRfO9WBUv/G5NdelsahC4kfGuILI4Sml5EVtigLyqfx6wqFCa
         GR1Vj1PN8m1sCbgdLP7/ZRt0/Qh4Ih0KT1B7cZKU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46DC960DE9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
From:   Prateek Sood <prsood@codeaurora.org>
To:     dbueso@suse.de, andrea.parri@amarulasolutions.com,
        peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        Prateek Sood <prsood@codeaurora.org>
Subject: [PATCH] percpu_rwsem: fix missed wakeup due to reordering of load
Date:   Fri, 21 Dec 2018 12:59:13 +0530
Message-Id: <1545377353-30441-1-git-send-email-prsood@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <aa864e194ee4c987b7e2025d1fe6e88b@suse.de>
References: <aa864e194ee4c987b7e2025d1fe6e88b@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

P1 is releaseing the cpu_hotplug_lock and P2 is acquiring
cpu_hotplug_lock.

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

Since load of task can result in NULL, it can lead to missed wakeup
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
Acked-by: Davidlohr Bueso <dbueso@suse.de>

---
 kernel/exit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index ac1a814..696e0e1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -298,7 +298,7 @@ void rcuwait_wake_up(struct rcuwait *w)
 	/*
 	 * Order condition vs @task, such that everything prior to the load
 	 * of @task is visible. This is the condition as to why the user called
-	 * rcuwait_trywake() in the first place. Pairs with set_current_state()
+	 * rcuwait_wake_up() in the first place. Pairs with set_current_state()
 	 * barrier (A) in rcuwait_wait_event().
 	 *
 	 *    WAIT                WAKE
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

