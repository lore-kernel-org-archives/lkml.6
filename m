Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F8CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2072820847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZLuCa0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2072820847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbeKAI2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbeKAIKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D161A20838;
        Wed, 31 Oct 2018 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027406;
        bh=ubZKX24iCN3x9EGA0j7cvaO4h3JPmWBoEebIFDN8AkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZLuCa0K45044qRbEOL1+UYqyUdYnYuDZY3NHxUBrdFLYlRlGYT5F3MyxsLggVDbj
         3c0+J52WKHUXis8OEutO0+95hiLwk9D1PAtetYM/vbv1njtLr37zZEUS/q+xPa7bwS
         X2vqZD7hfxyEABYemwANsrqG6er+FujM36oA90H0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 19/73] ACPI / processor: Fix the return value of acpi_processor_ids_walk()
Date:   Wed, 31 Oct 2018 19:08:54 -0400
Message-Id: <20181031230948.29203-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

[ Upstream commit d0381bf4f80c571dde1244fe5b85dc35e8b3f546 ]

ACPI driver should make sure all the processor IDs in their ACPI Namespace
are unique. the driver performs a depth-first walk of the namespace tree
and calls the acpi_processor_ids_walk() to check the duplicate IDs.

But, the acpi_processor_ids_walk() mistakes the return value. If a
processor is checked, it returns true which causes the walk break
immediately, and other processors will never be checked.

Repace the value with AE_OK which is the standard acpi_status value.
And don't abort the namespace walk even on error.

Fixes: 8c8cb30f49b8 (acpi/processor: Implement DEVICE operator for processor enumeration)
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_processor.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 86c10599d9f8..ccf07674a2a0 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -642,7 +642,7 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
 
 	status = acpi_get_type(handle, &acpi_type);
 	if (ACPI_FAILURE(status))
-		return false;
+		return status;
 
 	switch (acpi_type) {
 	case ACPI_TYPE_PROCESSOR:
@@ -662,11 +662,12 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
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
2.17.1

