Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeBGBni (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:43:38 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39945 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932197AbeBGBl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:41:27 -0500
X-Google-Smtp-Source: AH8x227cB3ytF3jTKSrl60ggN2dNRVHGoL5TjMELMhwIQqkaJIJQfaQ6Pxw/3DwnIpodjQog/1ZGDg==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v5 1/4] cpu_pm: add syscore_suspend error handling
Date: Tue,  6 Feb 2018 17:41:14 -0800
Message-Id: <20180207014117.62611-2-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180207014117.62611-1-dbasehore@chromium.org>
References: <20180207014117.62611-1-dbasehore@chromium.org>
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
2.16.0.rc1.238.g530d649a79-goog
