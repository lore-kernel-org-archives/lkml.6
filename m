Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2167FC282D0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBF52177B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690436;
	bh=Swx/Wgnt/nrKoCx34LrA7E0gpVup2H/ktlG0cw8WvQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=18xqUDoh9INDPCkswyMcx1Acfr8xTRikBakGx1zniIYewPkSyGYZtI0YGmUDtNHmJ
	 X6czahjS2ScSjoYtBWacS/LFGbPSbcPYNoa03cJBTqojj2HXlyTKX9mEZWMLW/Z1GJ
	 e1LEv6UcsK9mZInVSZDtAeHytA3FJgQTom3xFksk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfA1PrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfA1PrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:47:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 075982147A;
        Mon, 28 Jan 2019 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690430;
        bh=Swx/Wgnt/nrKoCx34LrA7E0gpVup2H/ktlG0cw8WvQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKN3yZgpJguji7JEHgahaqhQCV5UUf9v/cOuIQq2Zra53RK0bdT26vaeSSqGO/Mu4
         i1BBK3XorfCqJWixG84pPH8SPhpyjbG1gS2GRbL2nmzyetCDPJc4yTd+Zuo0HIzqsO
         JW/I3fGRp1JCfRreN+j3WppjaENZWiySfNq70Hvs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 083/304] ACPI: SPCR: Consider baud rate 0 as preconfigured state
Date:   Mon, 28 Jan 2019 10:40:00 -0500
Message-Id: <20190128154341.47195-83-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit b413b1abeb21b4a152c0bf8d1379efa30759b6e3 ]

Since SPCR 1.04 [1] the baud rate of 0 means a preconfigured state of UART.
Assume firmware or bootloader configures console correctly.

[1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/spcr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 9d52743080a4..c336784d0bcb 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -148,6 +148,13 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	}
 
 	switch (table->baud_rate) {
+	case 0:
+		/*
+		 * SPCR 1.04 defines 0 as a preconfigured state of UART.
+		 * Assume firmware or bootloader configures console correctly.
+		 */
+		baud_rate = 0;
+		break;
 	case 3:
 		baud_rate = 9600;
 		break;
@@ -196,6 +203,10 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		 * UART so don't attempt to change to the baud rate state
 		 * in the table because driver cannot calculate the dividers
 		 */
+		baud_rate = 0;
+	}
+
+	if (!baud_rate) {
 		snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, iotype,
 			 table->serial_port.address);
 	} else {
-- 
2.19.1

