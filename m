Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A321C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68A0216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfUT5d91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68A0216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeHCIE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbeHCIE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:04:29 -0400
Received: from localhost.localdomain (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849D5216F6;
        Fri,  3 Aug 2018 06:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533276587;
        bh=ZxDvz3ikkx6daRULt4qsN7GOy+WXnYCn5pLa4yUivlU=;
        h=From:To:Cc:Subject:Date:From;
        b=RfUT5d91HCrOTLEn+tuq5vxwBav9IIwbaypeFc7j0NiY8llIAWpA/mgYd5bQ0vx2H
         26uTgYqq7QfCzCsny4oB/VFctphiDgwjfrvCu2Xsd04g9dWwXxAcmIOPlK/6GXVYMo
         2jEfN9KgfNN8PxQiO7MLkNkhMQKKBUTWvBWHqhDk=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Zickus <dzickus@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] watchdog: Reduce message verbosity
Date:   Thu,  2 Aug 2018 23:09:41 -0700
Message-Id: <20180803060943.2643-1-okaya@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code is emitting the following error message during boot on systems
without PMU hardware support while probing NMI capability.

NMI watchdog: Perf event create on CPU 0 failed with -2

This error is coming from this path:

lockup_detector_init
  watchdog_nmi_probe
    hardlockup_detector_perf_init
      hardlockup_detector_event_create
        perf_event_create_kernel_counter
          perf_event_alloc
            perf_init_event (9539)
              pmu = ERR_PTR(-ENOENT) due to lack of PMUs in the system

followed by the warning that NMI watchdog is disabled as follows.

NMI watchdog: Perf NMI watchdog permanently disabled

While NMI disabled information is usefel for ordinary users, seeing
a PERF event create failed with error code -2 is too verbose.

Reducing the message severity to debug so that if somebody is really
wants to debug this, they can find out the error source by increasing
the kernel loglevel during boot.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=599368
---
 kernel/watchdog_hld.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index e449a23e9d59..1f7020d65d0a 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -175,8 +175,8 @@ static int hardlockup_detector_event_create(void)
 	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
 					       watchdog_overflow_callback, NULL);
 	if (IS_ERR(evt)) {
-		pr_info("Perf event create on CPU %d failed with %ld\n", cpu,
-			PTR_ERR(evt));
+		pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
+			 PTR_ERR(evt));
 		return PTR_ERR(evt);
 	}
 	this_cpu_write(watchdog_ev, evt);
-- 
2.17.1

