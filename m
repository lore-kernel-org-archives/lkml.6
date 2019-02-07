Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F4CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDE420863
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfBGQOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:14:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50366 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbfBGQOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:14:08 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 571F8A1F3AA1B816CC6A;
        Fri,  8 Feb 2019 00:14:05 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Fri, 8 Feb 2019 00:13:56 +0800
From:   John Garry <john.garry@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeremy.linton@arm.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] ACPI/PPTT: Add acpi_pptt_warn_missing() to consolidate logs
Date:   Fri, 8 Feb 2019 00:14:21 +0800
Message-ID: <1549556061-107418-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a system using ACPI-based FW without a PPTT, we may get many warnings
about the lack of a PPTT, as shown:

root@(none)$ dmesg | grep -i pptt
[    0.010125] ACPI PPTT: No PPTT table found, cpu topology may be inaccurate
[    7.138339] ACPI PPTT: No PPTT table found, cache topology may be inaccurate
[    7.145368] ACPI PPTT: No PPTT table found, cache topology may be inaccurate

These logs are generated with pr_warn_once(), so the intention was for a
single log, but the logs overlap, so consolidate them.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index da031b1df6f5..ad31c50de3be 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -451,6 +451,11 @@ static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_ta
 	return cpu;
 }
 
+static void acpi_pptt_warn_missing(void)
+{
+	pr_warn_once("No PPTT table found, cpu and cache topology may be inaccurate\n");
+}
+
 /**
  * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
  * @table: Pointer to the head of the PPTT table
@@ -498,7 +503,7 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 
 	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
 	if (ACPI_FAILURE(status)) {
-		pr_warn_once("No PPTT table found, cpu topology may be inaccurate\n");
+		acpi_pptt_warn_missing();
 		return -ENOENT;
 	}
 	retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
@@ -531,7 +536,7 @@ int acpi_find_last_cache_level(unsigned int cpu)
 	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
 	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
 	if (ACPI_FAILURE(status)) {
-		pr_warn_once("No PPTT table found, cache topology may be inaccurate\n");
+		acpi_pptt_warn_missing();
 	} else {
 		number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
 		acpi_put_table(table);
@@ -563,7 +568,7 @@ int cache_setup_acpi(unsigned int cpu)
 
 	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
 	if (ACPI_FAILURE(status)) {
-		pr_warn_once("No PPTT table found, cache topology may be inaccurate\n");
+		acpi_pptt_warn_missing();
 		return -ENOENT;
 	}
 
@@ -617,7 +622,7 @@ int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 
 	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
 	if (ACPI_FAILURE(status)) {
-		pr_warn_once("No PPTT table found, topology may be inaccurate\n");
+		acpi_pptt_warn_missing();
 		return -ENOENT;
 	}
 
-- 
2.17.1

