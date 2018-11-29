Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B227C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CFF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWVhY22s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CFF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbeK3B1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbeK3B1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:27:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1C3205C9;
        Thu, 29 Nov 2018 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501289;
        bh=pJU5us8Xwsv2eGRVe/jUJOTUAT1Gr52oq4UPu65u1Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWVhY22swToNOhN5aklBZVbrsVsBcjKJWGE3HUU3pYURYZdlb/Mcy8qyScDqBbxQ2
         GoC8nFWPn8ZhTZrHL5Hr4/U+rfEU+Vu2qCnOcfCNwOT/LU2YkngcTrleLSL4AdUNQm
         bxc8dkAxvY/GstUMKTag8+SP25iVctv5VAd9dtBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 30/92] cpufreq: imx6q: add return value check for voltage scale
Date:   Thu, 29 Nov 2018 15:11:59 +0100
Message-Id: <20181129140108.832826759@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ef1fa8145419..fa86946d12aa 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -130,8 +130,13 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
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



