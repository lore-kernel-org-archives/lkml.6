Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A713ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5A820854
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUB2MdMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5A820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeKAIMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbeKAIL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9420B20840;
        Wed, 31 Oct 2018 23:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027506;
        bh=KPiJvz4He0AwSZ0ySKEL1Gu0R0Z7OVpxUWh1vKcO0so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUB2MdMgwBQ2vuXtfa6H50FE1F6pEFs38/mT44sCrZEqWGuupmuWokzEU7rOlMtqU
         bJ1qEcPLAv7eNgRpOWKpaEJMK96WWereaGwEbikgeN29lC6TLLgeSRCCIo2JzUA8gz
         OKViWWAO1ZRt655ZZf3cSrnM5KhB6MHeI90qb4t4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86-ml <x86@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 09/32] x86/olpc: Indicate that legacy PC XO-1 platform should not register RTC
Date:   Wed, 31 Oct 2018 19:11:14 -0400
Message-Id: <20181031231137.29429-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231137.29429-1-sashal@kernel.org>
References: <20181031231137.29429-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit d92116b800fb79a72ad26121f5011f6aa3ad94c2 ]

On OLPC XO-1, the RTC is discovered via device tree from the arch
initcall. Don't let the PC platform register another one from its device
initcall, it's not going to work:

  sysfs: cannot create duplicate filename '/devices/platform/rtc_cmos'
  CPU: 0 PID: 1 Comm: swapper Not tainted 4.19.0-rc6 #12
  Hardware name: OLPC XO/XO, BIOS OLPC Ver 1.00.01 06/11/2014
  Call Trace:
   dump_stack+0x16/0x18
   sysfs_warn_dup+0x46/0x58
   sysfs_create_dir_ns+0x76/0x9b
   kobject_add_internal+0xed/0x209
   ? __schedule+0x3fa/0x447
   kobject_add+0x5b/0x66
   device_add+0x298/0x535
   ? insert_resource_conflict+0x2a/0x3e
   platform_device_add+0x14d/0x192
   ? io_delay_init+0x19/0x19
   platform_device_register+0x1c/0x1f
   add_rtc_cmos+0x16/0x31
   do_one_initcall+0x78/0x14a
   ? do_early_param+0x75/0x75
   kernel_init_freeable+0x152/0x1e0
   ? rest_init+0xa2/0xa2
   kernel_init+0x8/0xd5
   ret_from_fork+0x2e/0x38
  kobject_add_internal failed for rtc_cmos with -EEXIST, don't try to
    register things with the same name in the same directory.
  platform rtc_cmos: registered platform RTC device (no PNP device found)

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181004160808.307738-1-lkundrak@v3.sk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/olpc/olpc-xo1-rtc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/platform/olpc/olpc-xo1-rtc.c b/arch/x86/platform/olpc/olpc-xo1-rtc.c
index a2b4efddd61a..8e7ddd7e313a 100644
--- a/arch/x86/platform/olpc/olpc-xo1-rtc.c
+++ b/arch/x86/platform/olpc/olpc-xo1-rtc.c
@@ -16,6 +16,7 @@
 
 #include <asm/msr.h>
 #include <asm/olpc.h>
+#include <asm/x86_init.h>
 
 static void rtc_wake_on(struct device *dev)
 {
@@ -75,6 +76,8 @@ static int __init xo1_rtc_init(void)
 	if (r)
 		return r;
 
+	x86_platform.legacy.rtc = 0;
+
 	device_init_wakeup(&xo1_rtc_device.dev, 1);
 	return 0;
 }
-- 
2.17.1

