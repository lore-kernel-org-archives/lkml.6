Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA86BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8577C20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfBFTLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:11:25 -0500
Received: from mail.windriver.com ([147.11.1.11]:34240 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:11:24 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x16JBIsG023046
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 6 Feb 2019 11:11:18 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.435.0; Wed, 6 Feb 2019
 11:11:18 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: tps68470: drop unused MODULE_DEVICE_TABLE
Date:   Wed, 6 Feb 2019 14:11:07 -0500
Message-ID: <1549480267-17822-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_TPS68470
drivers/mfd/Kconfig:    bool "TI TPS68470 Power Management / LED chips"

...meaning that it currently is not being built as a module by anyone.

Hence we remove the MODULE_DEVICE_TABLE since it is a no-op for
non-modular code.

There is no removal of <linux/module.h> here because there isn't one.
Instead, it is relying on including that implicitly from an ACPI header.

In cleaning up the ACPI instance of module.h (which also isn't strictly
needed), then this mfd driver breaks when MODULE_DEVICE_TABLE becomes
undefined here.

The easiest dependency solution is to simply defer the ACPI cleanup
until this change is present in mainline.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/mfd/tps68470.c b/drivers/mfd/tps68470.c
index a5981a79b29a..4a4df4ffd18c 100644
--- a/drivers/mfd/tps68470.c
+++ b/drivers/mfd/tps68470.c
@@ -86,7 +86,6 @@ static const struct acpi_device_id tps68470_acpi_ids[] = {
 	{"INT3472"},
 	{},
 };
-MODULE_DEVICE_TABLE(acpi, tps68470_acpi_ids);
 
 static struct i2c_driver tps68470_driver = {
 	.driver = {
-- 
2.7.4

