Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F16BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501AF208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501AF208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934366AbeGJPlN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:41:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933737AbeGJPku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:40:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 335D91682;
        Tue, 10 Jul 2018 08:40:50 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 497653F589;
        Tue, 10 Jul 2018 08:40:49 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal_hwmon: Sanitize attribute name passed to hwmon
Date:   Tue, 10 Jul 2018 16:40:34 +0100
Message-Id: <20180710154035.26828-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710154035.26828-1-marc.zyngier@arm.com>
References: <20180710154035.26828-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Chromebook Plus (kevin) is spitting the following at boot time:

(NULL device *): hwmon: 'sbs-9-000b' is not a valid name attribute, please fix

Clearly, __hwmon_device_register is unhappy about the property name.
Some investigation reveals that thermal_add_hwmon_sysfs doesn't
sanitize the name of the attribute.

In order to keep it quiet, let's replace '-' with '_' in hwmon->type
This is consistent with what iio-hwmon does since b92fe9e3379c8.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/thermal/thermal_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 11278836ed12..0bd47007c57f 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -142,6 +142,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	INIT_LIST_HEAD(&hwmon->tz_list);
 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
+	strreplace(hwmon->type, '-', '_');
 	hwmon->device = hwmon_device_register_with_info(NULL, hwmon->type,
 							hwmon, NULL, NULL);
 	if (IS_ERR(hwmon->device)) {
-- 
2.18.0

