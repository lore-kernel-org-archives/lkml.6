Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB60C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7B220870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fR/Gwm5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfAUPml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:42:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38739 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbfAUPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:42:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so11300996wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mOHRY9GecvR+zxuWJYSMLBDQ2KcwLpDTRI+yrgkHn2w=;
        b=fR/Gwm5uDyVf8kvr7f/Rw+Or8RDtRiDTXnbpdc5hGFstxhrTrpkL+utGhNw6JbRWJ5
         92PsbST9aFJTObXUv5gw86T8+fuD1QF9SgnC1v7qnKqLqyQbUn9K2It1FwHfRSATE4GD
         /EbNTH+2oc1l8/DiC2tkH6PAlsWStqza59+A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mOHRY9GecvR+zxuWJYSMLBDQ2KcwLpDTRI+yrgkHn2w=;
        b=ZJHtyIqLBOUrEeFEDVR5CqzDySzKB/2X13Ui1O0HdnHle4iJnCNZGARbijt8E7qhoG
         4JUA8IfrlmlyZuF9wa6SPOwKziotgsQaf8vAa1ZOmRBE9I3qrDsFskXWNdfri5EmXzQz
         da1fZHmrBzBr4JBs1JIidS81UFOBHWgk6xW7Vhb329o9oQDLnB4qisrqkMXJLWchnlTa
         93vSd7Sh9CTE9r55TNN/VmqotxyBUo2y89s6M/QsTuXBIWzbHV1qfOf4Jf6crQglsMYi
         9yKRqjllBH8Ky9VggBFW5b8u5HrJ/UcmEUD+wi1gvn0JrbGL2YBY3WCfys7u4mSnkEuV
         NSdA==
X-Gm-Message-State: AJcUukf90QS6vKW+TKiSrGNBCmgC0X/CTcBOLX/G1DESQpZKCK+hMokG
        n9A4ipgwogPAhFFF1bbhKrQiBZkkJmk=
X-Google-Smtp-Source: ALg8bN7mVEEGu84AIvoar7FCr2bfqmiVOHSGNUBmImtZ5e3qFO1ZC7+JOhHGhdI7osyWe8coUpPUBg==
X-Received: by 2002:a1c:c008:: with SMTP id q8mr22990286wmf.99.1548085357709;
        Mon, 21 Jan 2019 07:42:37 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id n127sm57377257wmd.20.2019.01.21.07.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:42:37 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/9] thermal: cpu_cooling: Require thermal core to be compiled in
Date:   Mon, 21 Jan 2019 21:10:26 +0530
Message-Id: <3f3e38e55c2de4b730fd7c6aa30c125f3a6a8704.1548084260.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU cooling driver (cpu_cooling.c) allows the platform's cpufreq
driver to register as a cooling device and cool down the platform by
throttling the CPU frequency. In order to be able to auto-register a
cpufreq driver as a cooling device from the cpufreq core, we need access
to code inside cpu_cooling.c which, in turn, accesses code inside
thermal core.

CPU_FREQ is a bool while THERMAL is tristate.  In some configurations
(e.g. allmodconfig), CONFIG_THERMAL ends up as a module while
CONFIG_CPU_FREQ is compiled in. This leads to following error:

drivers/cpufreq/cpufreq.o: In function `cpufreq_offline':
cpufreq.c:(.text+0x407c): undefined reference to `cpufreq_cooling_unregister'
drivers/cpufreq/cpufreq.o: In function `cpufreq_online':
cpufreq.c:(.text+0x70c0): undefined reference to `of_cpufreq_cooling_register'

Given that platforms using CPU_THERMAL usually want it compiled-in so it
is available early in boot, make CPU_THERMAL depend on THERMAL being
compiled-in instead of allowing it to be a module.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 30323426902e..58bb7d72dc2b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -152,6 +152,7 @@ config CPU_THERMAL
 	bool "generic cpu cooling support"
 	depends on CPU_FREQ
 	depends on THERMAL_OF
+	depends on THERMAL=y
 	help
 	  This implements the generic cpu cooling mechanism through frequency
 	  reduction. An ACPI version of this already exists
-- 
2.17.1

