Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D6AC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44E820854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44E820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbeIMTI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:08:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731472AbeIMTI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:08:28 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93513D19;
        Thu, 13 Sep 2018 13:58:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Gross <mark.gross@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 079/197] ACPICA: ACPICA: add status check for acpi_hw_read before assigning return value
Date:   Thu, 13 Sep 2018 15:30:28 +0200
Message-Id: <20180913131844.685542049@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Schmauss <erik.schmauss@intel.com>

[ Upstream commit f016b19a9275089a2ab06c2144567c2ad8d5d6ad ]

The value coming from acpi_hw_read() should not be used if it
returns an error code, so check the status returned by it before
using that value in two places in acpi_hw_register_read().

Reported-by: Mark Gross <mark.gross@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
[ rjw: Changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpica/hwregs.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -528,13 +528,18 @@ acpi_status acpi_hw_register_read(u32 re
 
 		status =
 		    acpi_hw_read(&value64, &acpi_gbl_FADT.xpm2_control_block);
-		value = (u32)value64;
+		if (ACPI_SUCCESS(status)) {
+			value = (u32)value64;
+		}
 		break;
 
 	case ACPI_REGISTER_PM_TIMER:	/* 32-bit access */
 
 		status = acpi_hw_read(&value64, &acpi_gbl_FADT.xpm_timer_block);
-		value = (u32)value64;
+		if (ACPI_SUCCESS(status)) {
+			value = (u32)value64;
+		}
+
 		break;
 
 	case ACPI_REGISTER_SMI_COMMAND_BLOCK:	/* 8-bit access */


