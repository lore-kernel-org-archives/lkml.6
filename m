Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B98C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E1D218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545405743;
	bh=CA8kPAFpYpNNtBIzfNjXCVdgd6oU5AXibeM3VUsftCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=KLCRbc5eCwQ7ymGKbfjT4Mlxfxd2cYru1UUw+hc4x6K6K99mNx3AUEkVRsnP3XDi9
	 4WOR+icmx71OutgU9vQt9uApB5pJgEvDgfjFR50SYVQksBH6XOLSssYV5NARSTJV6i
	 1E8oDLm1asLmfvjkkFq3hRO6LxO8Ic6o/QjpAI1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404146AbeLUPVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404114AbeLUPVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:33 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B52E721928;
        Fri, 21 Dec 2018 15:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545405692;
        bh=CA8kPAFpYpNNtBIzfNjXCVdgd6oU5AXibeM3VUsftCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=znFfDkxQc5CxDIODO0G6zlnSd0N/S1/2dG9DoeAgSlQ+AcuLvzwdtrSndlBrmZsE/
         BurnnLf5bWx4JzDA7S+eXg5rprR5X0bgVhRuzM0GcCdlEYXSmpGBn+S5Us4x38VWfV
         ebA6JczXL8bbVKtfWvYXKbgHy9Hs0/6oKdrXhHTc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
Subject: [PATCH RT 2/9] efi: Disable runtime services on RT
Date:   Fri, 21 Dec 2018 09:21:14 -0600
Message-Id: <4b7dce66c503f20080605dc39b812056c51d4a23.1545347029.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 55544e1d5eb0d7608e2b41452729649c8ea1607a ]

Based on meassurements the EFI functions get_variable /
get_next_variable take up to 2us which looks okay.
The functions get_time, set_time take around 10ms. Those 10ms are too
much. Even one ms would be too much.
Ard mentioned that SetVariable might even trigger larger latencies if
the firware will erase flash blocks on NOR.

The time-functions are used by efi-rtc and can be triggered during
runtimed (either via explicit read/write or ntp sync).

The variable write could be used by pstore.
These functions can be disabled without much of a loss. The poweroff /
reboot hooks may be provided by PSCI.

Disable EFI's runtime wrappers.

This was observed on "EFI v2.60 by SoftIron Overdrive 1000".

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

 Conflicts:
	drivers/firmware/efi/efi.c
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e47c522e1d8f..f2be407247e5 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -41,7 +41,7 @@ struct efi __read_mostly efi = {
 };
 EXPORT_SYMBOL(efi);
 
-static bool disable_runtime;
+static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT_BASE);
 static int __init setup_noefi(char *arg)
 {
 	disable_runtime = true;
-- 
2.14.1

