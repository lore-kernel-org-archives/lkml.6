Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A424C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B5820855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfBIArl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:47:41 -0500
Received: from foss.arm.com ([217.140.101.70]:58602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfBIArd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:47:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DC481688;
        Fri,  8 Feb 2019 16:47:32 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 092F23F719;
        Fri,  8 Feb 2019 16:47:32 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 3/3] perf: arm_spe: Enable ACPI/Platform automatic module loading
Date:   Fri,  8 Feb 2019 18:47:18 -0600
Message-Id: <20190209004718.3292087-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190209004718.3292087-1-jeremy.linton@arm.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets add the MODULE_TABLE and platform id_table entries so that
the SPE driver can attach to the ACPI platform device created by
the core pmu code.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 8e46a9dad2fa..9be11d814fa5 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1176,7 +1176,13 @@ static const struct of_device_id arm_spe_pmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_spe_pmu_of_match);
 
-static int arm_spe_pmu_device_dt_probe(struct platform_device *pdev)
+static const struct platform_device_id arm_spe_match[] = {
+	{ "arm,spe-v1", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, arm_spe_match);
+
+static int arm_spe_pmu_device_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct arm_spe_pmu *spe_pmu;
@@ -1236,11 +1242,12 @@ static int arm_spe_pmu_device_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver arm_spe_pmu_driver = {
+	.id_table = arm_spe_match,
 	.driver	= {
 		.name		= DRVNAME,
 		.of_match_table	= of_match_ptr(arm_spe_pmu_of_match),
 	},
-	.probe	= arm_spe_pmu_device_dt_probe,
+	.probe	= arm_spe_pmu_device_probe,
 	.remove	= arm_spe_pmu_device_remove,
 };
 
-- 
2.17.2

