Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E175C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97EE20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBtqXBiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97EE20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407013AbeKWGgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:36:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733189AbeKWGf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:35:59 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C6020865;
        Thu, 22 Nov 2018 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916507;
        bh=oYVC71icMvPxz7CAp1q4ImucdT1kcOOvQdMQapmju1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBtqXBiPeAYYgzkLsfvOg3nDiuE9FKD4Onj5FK39cZhd2zVR8tRwTcJfI1HczGMIC
         A+dXdizxmB/CfhropfW61P9tncjhLZVHnpb5ue/SJaj1dTYYi937nKuJAvvc0yESFU
         PP6GG9mXgMmsp+kg/YflJMRZ3tfPaL+iyZCvoAdQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/21] cpufreq: imx6q: add return value check for voltage scale
Date:   Thu, 22 Nov 2018 14:54:35 -0500
Message-Id: <20181122195452.13520-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195452.13520-1-sashal@kernel.org>
References: <20181122195452.13520-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

[ Upstream commit 6ef28a04d1ccf718eee069b72132ce4aa1e52ab9 ]

Add return value check for voltage scale when ARM clock
rate change fail.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 14466a9b01c0..63d28323a29c 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -135,8 +135,13 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	/* Ensure the arm clock divider is what we expect */
 	ret = clk_set_rate(arm_clk, new_freq * 1000);
 	if (ret) {
+		int ret1;
+
 		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
-		regulator_set_voltage_tol(arm_reg, volt_old, 0);
+		ret1 = regulator_set_voltage_tol(arm_reg, volt_old, 0);
+		if (ret1)
+			dev_warn(cpu_dev,
+				 "failed to restore vddarm voltage: %d\n", ret1);
 		return ret;
 	}
 
-- 
2.17.1

