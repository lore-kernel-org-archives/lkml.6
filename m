Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8167C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847782087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847782087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeJERoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:44:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJERoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:44:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w95AjrOb3111100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Oct 2018 03:45:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w95AjrUf3111096;
        Fri, 5 Oct 2018 03:45:53 -0700
Date:   Fri, 5 Oct 2018 03:45:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lubomir Rintel <tipbot@zytor.com>
Message-ID: <tip-d92116b800fb79a72ad26121f5011f6aa3ad94c2@git.kernel.org>
Cc:     hpa@zytor.com, x86@kernel.org, lkundrak@v3.sk, bp@suse.de,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: mingo@redhat.com, tglx@linutronix.de, mingo@kernel.org,
          x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          bp@suse.de, lkundrak@v3.sk
In-Reply-To: <20181004160808.307738-1-lkundrak@v3.sk>
References: <20181004160808.307738-1-lkundrak@v3.sk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/olpc] x86/olpc: Indicate that legacy PC XO-1 platform
 should not register RTC
Git-Commit-ID: d92116b800fb79a72ad26121f5011f6aa3ad94c2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d92116b800fb79a72ad26121f5011f6aa3ad94c2
Gitweb:     https://git.kernel.org/tip/d92116b800fb79a72ad26121f5011f6aa3ad94c2
Author:     Lubomir Rintel <lkundrak@v3.sk>
AuthorDate: Thu, 4 Oct 2018 18:08:08 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 5 Oct 2018 12:29:20 +0200

x86/olpc: Indicate that legacy PC XO-1 platform should not register RTC

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
