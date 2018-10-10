Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFC6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3EE20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hNMwJtCm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PXSjiaZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3EE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeJKEpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:45:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeJKEpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:45:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B0AC760C7D; Wed, 10 Oct 2018 21:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206494;
        bh=0lhzS25MklLZZhZMk9kpgz6k/DU9SoDNv2mDTJSstZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNMwJtCmEJcUNt3bqiAWxA1FBr/TRO+oQBi+e1EnrEYgTGIGagurwBPiKVI8Lmtgc
         fs7sI68S37HamyjZ/Vr+cPNNiFkQoc7DdZrgwuhIg36lTBpemvQhBsIzJCJ4W9Vtyx
         5Wl0RwEaqkMQ9c7Y3DPAJoxXII6NdWVnejBT8WSs=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6FFD2601A8;
        Wed, 10 Oct 2018 21:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206492;
        bh=0lhzS25MklLZZhZMk9kpgz6k/DU9SoDNv2mDTJSstZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXSjiaZn50nT3CCY3AVL28DHlfMzKeiAmk1xrc2iwXEVlYGJjDT2JR3jd+vCLm5bb
         oejVBq5y4+0GlcWVRKgJDBEFSlush87+TdD2+o++QppzAMixL4sfnfqzxKw76TXKZy
         ap2AoqPr/ny6qcs8HR9TLse1z5HCxwTR3mFsb5H0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FFD2601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 2/8] kernel/cpu_pm: Manage runtime PM in the idle path for CPUs
Date:   Thu, 11 Oct 2018 02:50:49 +0530
Message-Id: <1539206455-29342-3-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

To allow CPUs being power managed by PM domains, let's deploy support for
runtime PM for the CPU's corresponding struct device.

More precisely, at the point when the CPU is about to enter an idle state,
decrease the runtime PM usage count for its corresponding struct device,
via calling pm_runtime_put_sync_suspend(). Then, at the point when the CPU
resumes from idle, let's increase the runtime PM usage count, via calling
pm_runtime_get_sync().

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
(am from https://patchwork.kernel.org/patch/10478153/)
---
 kernel/cpu_pm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 67b02e1..492d4a8 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -16,9 +16,11 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
@@ -91,6 +93,7 @@ int cpu_pm_enter(void)
 {
 	int nr_calls;
 	int ret = 0;
+	struct device *dev = get_cpu_device(smp_processor_id());
 
 	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
 	if (ret)
@@ -100,6 +103,9 @@ int cpu_pm_enter(void)
 		 */
 		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
 
+	if (!ret && dev && dev->pm_domain)
+		pm_runtime_put_sync_suspend(dev);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_enter);
@@ -118,6 +124,11 @@ int cpu_pm_enter(void)
  */
 int cpu_pm_exit(void)
 {
+	struct device *dev = get_cpu_device(smp_processor_id());
+
+	if (dev && dev->pm_domain)
+		pm_runtime_get_sync(dev);
+
 	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_exit);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

