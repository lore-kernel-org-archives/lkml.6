Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2F4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA52156E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFA52156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeHXGYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:24:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37339 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726140AbeHXGYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:24:14 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43888538"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Aug 2018 10:51:39 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id A7B224B6AE02;
        Fri, 24 Aug 2018 10:51:36 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 24 Aug 2018 10:51:36 +0800
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <lenb@kernel.org>, <rjw@rjwysocki.net>, <tglx@linutronix.de>,
        <rafael@kernel.org>, <indou.takao@jp.fujitsu.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v3] acpi/processor: Fix the return value of acpi_processor_ids_walk()
Date:   Fri, 24 Aug 2018 10:51:26 +0800
Message-ID: <20180824025126.19231-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: A7B224B6AE02.AB934
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI driver should make sure all the processor IDs in their ACPI Namespace
are unique. the driver performs a depth-first walk of the namespace tree
and calls the acpi_processor_ids_walk() to check the duplicate IDs.

But, the acpi_processor_ids_walk() mistakes the return value. If a
processor is checked, it returns true which causes the walk break
immediately, and other processors will never be checked.

Repace the value with AE_OK which is the standard acpi_status value.
And don't abort the namespace walk even on error.

Fixes 8c8cb30f49b8 ("acpi/processor: Implement DEVICE operator for processor enumeration")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
Changelog:
  v2 --> v3:
   - Fix a compiler error reported by LKP
  v1 --> v2:
   - Fix the check against duplicate IDs suggested by Rafael.
  
  Now，the duplicate IDs only be found in Ivb42 machine, and we have added this check at 
  linux-4.9. But, we introduced a bug in linux-4.12 by commit 8c8cb30f49b8.

  For resolving the bug, firstly, I removed the check[1]. because Linux will compare
  the coming ID with present processors when it hot-added a physical CPU and will avoid
  using duplicate IDs.

  But, seems we should consider all the possible processors. So, with this patch, All
  the processors with the same IDs will never be hot-plugged.

[1] https://lkml.org/lkml/2018/5/28/213
---
 drivers/acpi/acpi_processor.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 449d86d39965..fc447410ae4d 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -643,7 +643,7 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
 
 	status = acpi_get_type(handle, &acpi_type);
 	if (ACPI_FAILURE(status))
-		return false;
+		return status;
 
 	switch (acpi_type) {
 	case ACPI_TYPE_PROCESSOR:
@@ -663,11 +663,12 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
 	}
 
 	processor_validated_ids_update(uid);
-	return true;
+	return AE_OK;
 
 err:
+	/* Exit on error, but don't abort the namespace walk */
 	acpi_handle_info(handle, "Invalid processor object\n");
-	return false;
+	return AE_OK;
 
 }
 
-- 
2.14.3



