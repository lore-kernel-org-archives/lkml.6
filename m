Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7847CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D984206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D984206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJDXCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:02:17 -0400
Received: from shell.v3.sk ([90.176.6.54]:35386 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbeJDXCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:02:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 25F2BB7379;
        Thu,  4 Oct 2018 18:08:18 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oeln5evrONlH; Thu,  4 Oct 2018 18:08:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 44379B7569;
        Thu,  4 Oct 2018 18:08:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pMm19MdErcSn; Thu,  4 Oct 2018 18:08:11 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2A6EEB7379;
        Thu,  4 Oct 2018 18:08:11 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] x86, olpc: Indicate that legacy PC platform should not register RTC
Date:   Thu,  4 Oct 2018 18:08:08 +0200
Message-Id: <20181004160808.307738-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On OLPC XO-1 we're discovering the RTC via device tree from the arch
initcall. Don't let the PC platform register another one from its
device initcall, it's not going to work:

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
---
 arch/x86/platform/olpc/olpc-xo1-rtc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/platform/olpc/olpc-xo1-rtc.c b/arch/x86/platform/ol=
pc/olpc-xo1-rtc.c
index a2b4efddd61a..8e7ddd7e313a 100644
--- a/arch/x86/platform/olpc/olpc-xo1-rtc.c
+++ b/arch/x86/platform/olpc/olpc-xo1-rtc.c
@@ -16,6 +16,7 @@
=20
 #include <asm/msr.h>
 #include <asm/olpc.h>
+#include <asm/x86_init.h>
=20
 static void rtc_wake_on(struct device *dev)
 {
@@ -75,6 +76,8 @@ static int __init xo1_rtc_init(void)
 	if (r)
 		return r;
=20
+	x86_platform.legacy.rtc =3D 0;
+
 	device_init_wakeup(&xo1_rtc_device.dev, 1);
 	return 0;
 }
--=20
2.19.0

