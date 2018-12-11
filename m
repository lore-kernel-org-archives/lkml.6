Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDE7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1392146F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543796;
	bh=Y0f9E26U9k5rfXYldRoWbpsn8CGYMqPiKoD7VfivGqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T2j663eOOEGaNXEpijyEYfdmoH6IWKPMYQqESz6j3pg/pileH1aMBDwxsgeiwQwT/
	 YBLq9Q1Bb5FMW+XDnIfVlWBubhQHsJg0qzkIFLaZ4n58oPM0hLECNYzTbBhrB7iAzj
	 r+3qTV3nIvtzW7Sbicz8uintN9L4h/dRDZYUPe50=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1392146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbeLKP4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730577AbeLKP4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9139A205C9;
        Tue, 11 Dec 2018 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543791;
        bh=Y0f9E26U9k5rfXYldRoWbpsn8CGYMqPiKoD7VfivGqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=adJ1BImCfN/29aFGd329B5nGm++QHBMxLiU0GMOH5kvSQPtWcnaoMb/h76jKHaIS4
         bX4KqNSKXOuxJlaG/N4uwFKxy3YWykVtMV345057jTQibjq2FbdxJMlmraMhi+vJBE
         kC3pohULYBQjfphkeHf5ePEms/jqbJZLxcOKZ3Q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/118] cpufreq: ti-cpufreq: Only register platform_device when supported
Date:   Tue, 11 Dec 2018 16:40:57 +0100
Message-Id: <20181211151645.775739449@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d98ccfc3948ab63152494bb6b9c17e15295c0310 ]

Currently the ti-cpufreq driver blindly registers a 'ti-cpufreq' to force
the driver to probe on any platforms where the driver is built in.
However, this should only happen on platforms that actually can make use
of the driver. There is already functionality in place to match the
SoC compatible so let's factor this out into a separate call and
make sure we find a match before creating the ti-cpufreq platform device.

Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/ti-cpufreq.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 3f0e2a14895a..22b53bf26817 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -201,19 +201,28 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
 	{},
 };
 
+static const struct of_device_id *ti_cpufreq_match_node(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+
+	np = of_find_node_by_path("/");
+	match = of_match_node(ti_cpufreq_of_match, np);
+	of_node_put(np);
+
+	return match;
+}
+
 static int ti_cpufreq_probe(struct platform_device *pdev)
 {
 	u32 version[VERSION_COUNT];
-	struct device_node *np;
 	const struct of_device_id *match;
 	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
 	const char * const reg_names[] = {"vdd", "vbb"};
 	int ret;
 
-	np = of_find_node_by_path("/");
-	match = of_match_node(ti_cpufreq_of_match, np);
-	of_node_put(np);
+	match = dev_get_platdata(&pdev->dev);
 	if (!match)
 		return -ENODEV;
 
@@ -290,7 +299,14 @@ fail_put_node:
 
 static int ti_cpufreq_init(void)
 {
-	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
+	const struct of_device_id *match;
+
+	/* Check to ensure we are on a compatible platform */
+	match = ti_cpufreq_match_node();
+	if (match)
+		platform_device_register_data(NULL, "ti-cpufreq", -1, match,
+					      sizeof(*match));
+
 	return 0;
 }
 module_init(ti_cpufreq_init);
-- 
2.19.1



