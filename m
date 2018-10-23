Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038E1C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D5720671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyNpJ6+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D5720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeJWUjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:39:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40067 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWUjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:39:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so1443184wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=C/KF7MofxQVQ7tBrLjxxvCQE9kr+TwazdOwljpCxdQg=;
        b=fyNpJ6+FFMkvlhq3BLhM2FvSr0vH/1tjMEL6lukPVrnmMYFHvMb0ZE+zrBzjyAVYkG
         Ul4S2EPVZNmCxyiDCDfy2Yqu0kMuW4IR1wt3cBOAYj5a8iOO1F5LvzCTobeR9vjAt6MI
         2K7lYVUDEu5xmSRNq3GhZOCBso70Z96m7sBHVWJgLbvisNez7c0j8mCFt68oez6J8XKZ
         D0jhWg0+hIwpGGkUZ2DiPehuWCfPlR+UR7PEFUWFvjTQQ+3QcNVZ0j24S7tIIYN2aUFw
         qi8Opzo9ksJRgy6zvJrCWDpD6jyLzd8wBSXDTXSCOcRbWVLPl9/wBotRvvsBEaQehC8J
         P9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=C/KF7MofxQVQ7tBrLjxxvCQE9kr+TwazdOwljpCxdQg=;
        b=FdkbTmA/cNa2pWevSk/KJhwTowZTA8NWTYVYu9yBf/7w9K6mnT3K4giVg52IL40r6G
         iDTFRQ0+Js3GxlvF29nmMNCbkK6ccZSDY2+5N0DoKCxI9QQF197Z/WDv5epfTJ9TtBVZ
         gY2LxJD+SQ3QXCve6LCwzrbWXIO6nxIdZQ34Tb478sXJ8Zn097Lf2e1ur1C547VnQyjv
         eb2sWcz+owv8aD0rX5VAypEjPEn/LjP2+HfGy13bCpB1Xzu69q9MAMUckdv2WT2n3WmX
         PzdjC7iMVIfHdDfeDxEzCingwbE9K9n6KJQAujpga4JCPHZTQBqQ6330vgYvb8C14yoa
         kTEg==
X-Gm-Message-State: AGRZ1gJq2CI1h8hQLEqb5LmxafxbF5yGaWxuAmu4OumQIRtE0Se8bMAL
        /Xx+7wQj4bnWxh8gBMC4uN4=
X-Google-Smtp-Source: AJdET5dMwketAwUTvr19Q04q04od3zDbH7IPorri4WkK38bA9n9MR+G843uumSqxXWFcUF1FV4Zc2Q==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr17990048wrj.130.1540296949967;
        Tue, 23 Oct 2018 05:15:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k12-v6sm937883wro.42.2018.10.23.05.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 05:15:49 -0700 (PDT)
Date:   Tue, 23 Oct 2018 14:15:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [GIT PULL] x86/platform changes for v4.20
Message-ID: <20181023121546.GA25973@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-platform-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

   # HEAD: fa112cf1e8bc693d5a666b1c479a2859c8b6e0f1 x86/olpc: Fix build error with CONFIG_MFD_CS5535=m

Two minor OLPC changes: a build fix and a new quirk.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/olpc: Fix build error with CONFIG_MFD_CS5535=m

Lubomir Rintel (1):
      x86/olpc: Indicate that legacy PC XO-1 platform should not register RTC


 arch/x86/Kconfig                      | 3 +--
 arch/x86/platform/olpc/olpc-xo1-rtc.c | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..285b5d6a5ea5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2742,8 +2742,7 @@ config OLPC
 
 config OLPC_XO1_PM
 	bool "OLPC XO-1 Power Management"
-	depends on OLPC && MFD_CS5535 && PM_SLEEP
-	select MFD_CORE
+	depends on OLPC && MFD_CS5535=y && PM_SLEEP
 	---help---
 	  Add support for poweroff and suspend of the OLPC XO-1 laptop.
 
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
