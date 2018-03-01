Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965724AbeCAD2b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 22:28:31 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34764 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965657AbeCAD2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 22:28:00 -0500
X-Google-Smtp-Source: AG47ELv9oiESraX9qldFNrJgcDMoJi8zFj+/9kOraIiVi/z8QhHFtGPz3hEPVV+FOWDQrs3xm7VVTw==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: bigeasy@linutronix.de, rafael.j.wysocki@intel.com, alex.shi@linaro.org,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] cpu_pm: add syscore_suspend error handling
Date: Wed, 28 Feb 2018 19:27:54 -0800
Message-Id: <20180301032754.146788-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cpu_cluster_pm_enter() fails, cpu_pm_exit() should be called. This
will put the CPU in the correct state to resume from the failure.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 kernel/cpu_pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 67b02e138a47..03bcc0751a51 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -186,6 +186,9 @@ static int cpu_pm_suspend(void)
 		return ret;
 
 	ret = cpu_cluster_pm_enter();
+	if (ret)
+		cpu_pm_exit();
+
 	return ret;
 }
 
-- 
2.16.2.395.g2e18187dfd-goog
