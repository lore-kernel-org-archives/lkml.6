Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E1DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B46E24835
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RNLqPVZs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RNLqPVZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B46E24835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934735AbeFVTtW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:49:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33484 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934399AbeFVTtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:49:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B878E60B15; Fri, 22 Jun 2018 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529696957;
        bh=4YH7zUXB9uysXF1AY0kEzc8hBNIgUA2yk1xRvlkTZf4=;
        h=From:To:Cc:Subject:Date:From;
        b=RNLqPVZsF+uKXE3be75c9X77+ApdSjDAXZcrIRceWBfIx6xMi/MVyeBRHpMJBoqZn
         1KaTKIVtFYZyk1ybHcSHY7FjevBWEayG34VlYJ4B6JgpcykbhGotq7eqiECdkB0Yrf
         8m9zQXNXVQzO/TCqX5JB7e4efHKQ5reEL7FuuBDw=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC89660AD8;
        Fri, 22 Jun 2018 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529696957;
        bh=4YH7zUXB9uysXF1AY0kEzc8hBNIgUA2yk1xRvlkTZf4=;
        h=From:To:Cc:Subject:Date:From;
        b=RNLqPVZsF+uKXE3be75c9X77+ApdSjDAXZcrIRceWBfIx6xMi/MVyeBRHpMJBoqZn
         1KaTKIVtFYZyk1ybHcSHY7FjevBWEayG34VlYJ4B6JgpcykbhGotq7eqiECdkB0Yrf
         8m9zQXNXVQzO/TCqX5JB7e4efHKQ5reEL7FuuBDw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC89660AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From:   Agustin Vega-Frias <agustinv@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     timur@codeaurora.org, agustinv@codeaurora.org
Subject: [RFC V3 1/3] ACPI: add support for sentinel-delimited probe tables
Date:   Fri, 22 Jun 2018 15:49:06 -0400
Message-Id: <1529696948-16991-1-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tables declared with the ACPI_PROBE_TABLE linker macro are typically
traversed by using the start and end symbols created by the linker
script. However, there are some APIs that use sentinel-delimited
tables (e.g. acpi_match_device). To better support these APIs an
additional section is added at the end of the probe table. This
section can be used to add a sentinel for tables that require it.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 include/asm-generic/vmlinux.lds.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index af24057..5894049 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -219,7 +219,8 @@
 	. = ALIGN(8);							\
 	VMLINUX_SYMBOL(__##name##_acpi_probe_table) = .;		\
 	KEEP(*(__##name##_acpi_probe_table))				\
-	VMLINUX_SYMBOL(__##name##_acpi_probe_table_end) = .;
+	VMLINUX_SYMBOL(__##name##_acpi_probe_table_end) = .;		\
+	KEEP(*(__##name##_acpi_probe_table_end))
 #else
 #define ACPI_PROBE_TABLE(name)
 #endif
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

