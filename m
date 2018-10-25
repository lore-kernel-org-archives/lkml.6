Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BCAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7919D20854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGzvCEfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7919D20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeJYWtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbeJYWte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:34 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C7920848;
        Thu, 25 Oct 2018 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476997;
        bh=XqxJCNXcKrGaarBOqqNsdvh3F84QXa13zEhkqTfJZG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGzvCEfzzZ66WEj59H8af3vHjq0oj38/gbNIDUmq/RYrSrDDtjtj1sJVs9ty9zUCn
         qe7yMPrZejtEi3ppHJy8kSljrebqPJcDE4i1mwATI3GqkKdtHFTcVF5hB6RSss18BQ
         bUR9VvOs3lQA737Ssnl+eTPm0PVIouQ+v4vy7poA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Aleksey Makarov <aleksey.makarov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 91/98] tty: serial: pl011: add ttyAMA for matching pl011 console
Date:   Thu, 25 Oct 2018 10:14:16 -0400
Message-Id: <20181025141423.213774-91-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit aea9a80ba98a0c9b4de88850260e9fbdcc98360b ]

Commit c7cef0a84912 ("console: Add extensible console matching") added
match() method to struct console which allows the console to perform
console command line matching instead of (or in addition to) default
console matching (ie., by fixed name and index).

Commit ad1696f6f09d ("ACPI: parse SPCR and enable matching console")
introduced support for SPCR as matching console.

Commit 10879ae5f12e ("serial: pl011: add console matching function")
added the match method for pl011 console which checks for the console
string to be "pl011"

Now on a platform which has both SPCR in the ACPI tables and ttyAMA in
the command line, the ttyAMA is chosen as "selected console" but it
doesn't pass the matching console method which results in CON_CONSDEV
not being set on the "selected console".

As a result of that, the bootconsole(SPCR in the above case) is not
unregistered and all the beginning boot messages are seen twice.

This patch adds "ttyAMA" so that it's considered to match pl011 console.

Fixes: 10879ae5f12e ("serial: pl011: add console matching function")
Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 41b0dd67fcce..11fb5464c43a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2361,7 +2361,7 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
 	resource_size_t addr;
 	int i;
 
-	if (strcmp(name, "pl011") != 0)
+	if (strcmp(name, "pl011") != 0 || strcmp(name, "ttyAMA") != 0)
 		return -ENODEV;
 
 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
-- 
2.17.1

