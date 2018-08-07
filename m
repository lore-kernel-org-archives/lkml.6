Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E86C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926EE21757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926EE21757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbeHGPb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:31:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728258AbeHGPb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:31:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE61D33560FA4;
        Tue,  7 Aug 2018 21:17:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Tue, 7 Aug 2018 21:16:59 +0800
From:   John Garry <john.garry@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <hdegoede@redhat.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] ACPI / scan: Add static attribute to indirect_io_hosts[]
Date:   Tue, 7 Aug 2018 21:15:05 +0800
Message-ID: <1533647705-34313-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Array indirect_io_hosts[] is declared in acpi_is_indirect_io_slave() as a
const array, which means that the array will be re-built for each call.

Optimise by adding the static attribute, which means that the array is
added to const-data pool and not re-built per function call.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 970dd87..199c8ea6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1528,7 +1528,7 @@ static int acpi_check_serial_bus_slave(struct acpi_resource *ares, void *data)
 static bool acpi_is_indirect_io_slave(struct acpi_device *device)
 {
 	struct acpi_device *parent = device->parent;
-	const struct acpi_device_id indirect_io_hosts[] = {
+	static const struct acpi_device_id indirect_io_hosts[] = {
 		{"HISI0191", 0},
 		{}
 	};
-- 
1.9.1

