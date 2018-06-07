Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id N25wDdJGGVuqOQAAmS7hNA
	; Thu, 07 Jun 2018 14:53:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 275A1608BF; Thu,  7 Jun 2018 14:53:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8B4886074D;
	Thu,  7 Jun 2018 14:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B4886074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935252AbeFGOxD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:53:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40932 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935245AbeFGOw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:52:59 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbX-0005Zv-9d; Thu, 07 Jun 2018 15:09:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0003AP-QY; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "David Vrabel" <david.vrabel@citrix.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.109599554@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 309/410] xen: Add xen_arch_suspend()
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

From: Ben Hutchings <ben@decadent.org.uk>

This is based on commit 2b953a5e994ce279904ec70220f7d4f31d380a0a
upstream, "xen: Suspend ticks on all CPUs during suspend", but
excluding the bug fix in that commit which is not needed in 3.16.
We only need the xen_arch_suspend() hook for the following fix.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -91,8 +91,17 @@ static void xen_vcpu_notify_restore(void
 	clockevents_notify(reason, NULL);
 }
 
+static void xen_vcpu_notify_suspend(void *data)
+{
+}
+
 void xen_arch_resume(void)
 {
 	on_each_cpu(xen_vcpu_notify_restore,
 		    (void *)CLOCK_EVT_NOTIFY_RESUME, 1);
 }
+
+void xen_arch_suspend(void)
+{
+	on_each_cpu(xen_vcpu_notify_suspend, NULL, 1);
+}
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -131,6 +131,8 @@ static void do_suspend(void)
 		goto out_resume;
 	}
 
+	xen_arch_suspend();
+
 	si.cancelled = 1;
 
 	err = stop_machine(xen_suspend, &si, cpumask_of(0));
@@ -148,11 +150,12 @@ static void do_suspend(void)
 		si.cancelled = 1;
 	}
 
+	xen_arch_resume();
+
 out_resume:
-	if (!si.cancelled) {
-		xen_arch_resume();
+	if (!si.cancelled)
 		xs_resume();
-	} else
+	else
 		xs_suspend_cancel();
 
 	dpm_resume_end(si.cancelled ? PMSG_THAW : PMSG_RESTORE);
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -12,6 +12,7 @@ void xen_arch_post_suspend(int suspend_c
 
 void xen_timer_resume(void);
 void xen_arch_resume(void);
+void xen_arch_suspend(void);
 
 void xen_resume_notifier_register(struct notifier_block *nb);
 void xen_resume_notifier_unregister(struct notifier_block *nb);
