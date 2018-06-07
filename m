Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ffhRKMBIGVufSgAAmS7hNA
	; Thu, 07 Jun 2018 15:01:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 842EF608BA; Thu,  7 Jun 2018 15:01:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E2ACF607E7;
	Thu,  7 Jun 2018 15:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2ACF607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964780AbeFGPBW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:01:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41380 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934578AbeFGPBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:01:19 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbb-0005Zm-Kd; Thu, 07 Jun 2018 15:09:35 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-00034z-CZ; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Dave Airlie" <airlied@redhat.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        "Lai Jiangshan" <jiangshanlai@gmail.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Tejun Heo" <tj@kernel.org>, "Lukas Wunner" <lukas@wunner.de>,
        "Lyude Paul" <lyude@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.132840234@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 254/410] workqueue: Allow retrieval of current task's
 work struct
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 27d4ee03078aba88c5e07dcc4917e8d01d046f38 upstream.

Introduce a helper to retrieve the current task's work struct if it is
a workqueue worker.

This allows us to fix a long-standing deadlock in several DRM drivers
wherein the ->runtime_suspend callback waits for a specific worker to
finish and that worker in turn calls a function which waits for runtime
suspend to finish.  That function is invoked from multiple call sites
and waiting for runtime suspend to finish is the correct thing to do
except if it's executing in the context of the worker.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://patchwork.freedesktop.org/patch/msgid/2d8f603074131eb87e588d2b803a71765bd3a2fd.1518338788.git.lukas@wunner.de
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -455,6 +455,7 @@ extern bool cancel_delayed_work_sync(str
 
 extern void workqueue_set_max_active(struct workqueue_struct *wq,
 				     int max_active);
+extern struct work_struct *current_work(void);
 extern bool current_is_workqueue_rescuer(void);
 extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
 extern unsigned int work_busy(struct work_struct *work);
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4369,6 +4369,22 @@ void workqueue_set_max_active(struct wor
 EXPORT_SYMBOL_GPL(workqueue_set_max_active);
 
 /**
+ * current_work - retrieve %current task's work struct
+ *
+ * Determine if %current task is a workqueue worker and what it's working on.
+ * Useful to find out the context that the %current task is running in.
+ *
+ * Return: work struct if %current task is a workqueue worker, %NULL otherwise.
+ */
+struct work_struct *current_work(void)
+{
+	struct worker *worker = current_wq_worker();
+
+	return worker ? worker->current_work : NULL;
+}
+EXPORT_SYMBOL(current_work);
+
+/**
  * current_is_workqueue_rescuer - is %current workqueue rescuer?
  *
  * Determine whether %current is a workqueue rescuer.  Can be used from
