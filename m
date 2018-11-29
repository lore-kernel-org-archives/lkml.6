Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0342AC07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B829C21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvcYZ3GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B829C21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbeK3Eyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:54:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36419 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbeK3Exz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so2541498ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j+EEeIQ8OjgKMk3l12109V9jWSNPdJq8ZcmjQ3ZkaQ8=;
        b=bvcYZ3GHOuNglPJo4PiEY9K7KfzwSQGeJ4tmewO/g/Yu3xWHquRm0tnoluQCIN8Gnb
         AjHWuHuSFdoKAwmZlQ+e2qP+HemBxddn0JGzfNKjQDsQr5Ab5t+zKWM5A1nR8dCKa2iZ
         ssMiBbaqHyQvPJYCg8Ipl6Gluutr4BDnX/nmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j+EEeIQ8OjgKMk3l12109V9jWSNPdJq8ZcmjQ3ZkaQ8=;
        b=CuTV4f7kwcLl81XyGft0j6CPGoLESXrfeAV4n4RgepZ+GvZssgthcpoadOGv+BC9w0
         dtR0uxVnUmta43iuUaoYJkxG5UDnn/Wxw+XaXwIrW+aOghVOHY7PHSVx0mHj3H3KbJpp
         ks9AoriyIKTr9ar/yhSvbYEr+DDkPLs3/SUu6CXHf9u/S0IiOUNezMNC26L003XDfL2r
         +2WJfd+qJrUkKAQWgTm7hs9gEngilcRn+RyScuqY92pKQsI5zyLT9pwV3jAyfCKUyZwK
         a1v/8uiHmPGBJS4q5m6m5+kuebTMfAZAefK5fwkZ4lJGzMPczTIFAxsNL4osTmbrFL5k
         EsOw==
X-Gm-Message-State: AA+aEWaHsRWP2NMBmHFn+QH1bPdhFU4gLxh64d777GqTzxmWdmvLUYaF
        NWvgPHuHuC3c1DAYdpavW9hjXA==
X-Google-Smtp-Source: AFSGD/UGOq9K9BxR66pfI/HJC8oYOClHD0rw9Tx1kGcB89/sYAmm9Q3eO+0KlfFRBTfNVzRUVMCVOA==
X-Received: by 2002:a2e:91d1:: with SMTP id u17-v6mr1720629ljg.160.1543513663478;
        Thu, 29 Nov 2018 09:47:43 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:42 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 20/27] drivers: firmware: psci: Introduce psci_dt_topology_init()
Date:   Thu, 29 Nov 2018 18:46:53 +0100
Message-Id: <20181129174700.16585-21-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to initiate the PM domain data structures, let's export a new
init function, psci_dt_topology_init() and make it call
psci_dt_init_pm_domains(). Following changes to the ARM64 code, invokes
this new init function.

At first glance, it may seem like feasible idea to hook into the existing
psci_dt_init() function, instead of adding yet another init function for
PSCI. However, this doesn't work because psci_dt_init() is called early in
the boot sequence, which means allocating dynamic data structures isn't yet
possible.

Moreover, additional following changes need to understand whether the
hierarchical PM domain topology has been successfully initialized,
therefore let's store the result from the initialization attempt into an
internal PSCI flag.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Simplified patch, by moving PSCI OSI related changes out into other
	  more appropriate patches.
	- Add a flag to store the result of the PM domain initialization.
	- Updated and clarified changelog.

---
 drivers/firmware/psci/psci.c | 18 ++++++++++++++++++
 include/linux/psci.h         |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 19af2093151b..5b481e91ccab 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -91,6 +91,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 
 static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
+static bool psci_dt_topology;
 
 u32 psci_get_domain_state(void)
 {
@@ -741,6 +742,23 @@ int __init psci_dt_init(void)
 	return ret;
 }
 
+int __init psci_dt_topology_init(void)
+{
+	struct device_node *np;
+	int ret;
+
+	np = of_find_matching_node_and_match(NULL, psci_of_match, NULL);
+	if (!np)
+		return -ENODEV;
+
+	/* Initialize the CPU PM domains based on topology described in DT. */
+	ret = psci_dt_init_pm_domains(np);
+	psci_dt_topology = ret > 0;
+
+	of_node_put(np);
+	return ret;
+}
+
 #ifdef CONFIG_ACPI
 /*
  * We use PSCI 0.2+ when ACPI is deployed on ARM64 and it's
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 4f29a3bff379..16beccccbbcc 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -55,8 +55,10 @@ extern struct psci_operations psci_ops;
 
 #if defined(CONFIG_ARM_PSCI_FW)
 int __init psci_dt_init(void);
+int __init psci_dt_topology_init(void);
 #else
 static inline int psci_dt_init(void) { return 0; }
+static inline int psci_dt_topology_init(void) { return 0; }
 #endif
 
 #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)
-- 
2.17.1

