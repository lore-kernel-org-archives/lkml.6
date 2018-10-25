Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1840ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C5120883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="STpXb/rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C5120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeJYWtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbeJYWtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:13 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0315620848;
        Thu, 25 Oct 2018 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476977;
        bh=7/AXBXlqVLHSozKAzLiFYjb2J3zMulxLngF0jB098BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STpXb/rrWYXgUYFothTa06FIQW1PQwfeZYaa3AxQ87jYDXDTH2w2Ni3dxVHtTOkt6
         1ZLn8rpgD5205JnDdbtFAgEWtylBTS6Ph4J4hpeL1qHdBgIu13zv/FgfZZG56VZHaO
         CefsVc6upvDHoAS5oqYP4E1oULn+DTesnob4FZ/c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 77/98] module: fix DEBUG_SET_MODULE_RONX typo
Date:   Thu, 25 Oct 2018 10:14:02 -0400
Message-Id: <20181025141423.213774-77-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 4d217a5adccf5e806790c37c61cc374a08bd7381 ]

The newly added 'rodata_enabled' global variable is protected by
the wrong #ifdef, leading to a link error when CONFIG_DEBUG_SET_MODULE_RONX
is turned on:

kernel/module.o: In function `disable_ro_nx':
module.c:(.text.unlikely.disable_ro_nx+0x88): undefined reference to `rodata_enabled'
kernel/module.o: In function `module_disable_ro':
module.c:(.text.module_disable_ro+0x8c): undefined reference to `rodata_enabled'
kernel/module.o: In function `module_enable_ro':
module.c:(.text.module_enable_ro+0xb0): undefined reference to `rodata_enabled'

CONFIG_SET_MODULE_RONX does not exist, so use the correct one instead.

Fixes: 39290b389ea2 ("module: extend 'rodata=off' boot cmdline parameter to module mappings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jessica Yu <jeyu@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 4313772d634a..3c7f71d8e704 100644
--- a/init/main.c
+++ b/init/main.c
@@ -915,7 +915,7 @@ static int try_to_run_init_process(const char *init_filename)
 
 static noinline void __init kernel_init_freeable(void);
 
-#if defined(CONFIG_DEBUG_RODATA) || defined(CONFIG_SET_MODULE_RONX)
+#if defined(CONFIG_DEBUG_RODATA) || defined(CONFIG_DEBUG_SET_MODULE_RONX)
 bool rodata_enabled __ro_after_init = true;
 static int __init set_debug_rodata(char *str)
 {
-- 
2.17.1

