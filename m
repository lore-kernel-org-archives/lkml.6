Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F8C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24C22754B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24C22754B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936908AbeF2QSH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:18:07 -0400
Received: from foss.arm.com ([217.140.101.70]:36712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936665AbeF2QSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:18:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4A7D18A;
        Fri, 29 Jun 2018 09:18:05 -0700 (PDT)
Received: from usa.arm.com (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B316C3F266;
        Fri, 29 Jun 2018 09:18:03 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        shunyong.yang@hxt-semitech.com, yu.zheng@hxt-semitech.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI/PPTT: use ACPI ID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set
Date:   Fri, 29 Jun 2018 17:17:57 +0100
Message-Id: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use the ACPI processor ID only for the leaf/processor nodes
as the specification states it must match the value of ACPI processor ID
field in the processor’s entry in the MADT.

However, if a PPTT structure represents processors group, it match a
processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
flag describe whether the ACPI processor ID is valid.

Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
consistent instead of using table offset as it's currently done for non
leaf nodes.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/pptt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Hi,

There's ongoing discussion on assigning ID based in OS using simple
counters. It can never be consistent with firmware's view. So if the
firmware provides valid UID for non-processors node, we must use it.

Regards,
Sudeep

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index e5ea1974d1e3..d1e26cb599bf 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -481,8 +481,14 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 	if (cpu_node) {
 		cpu_node = acpi_find_processor_package_id(table, cpu_node,
 							  level, flag);
-		/* Only the first level has a guaranteed id */
-		if (level == 0)
+		/*
+		 * As per specification if the processor structure represents
+		 * an actual processor, then ACPI processor ID must be valid.
+		 * For processor containers ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
+		 * should be set if the UID is valid
+		 */
+		if (level == 0 ||
+		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
 			return cpu_node->acpi_processor_id;
 		return ACPI_PTR_DIFF(cpu_node, table);
 	}
-- 
2.7.4

