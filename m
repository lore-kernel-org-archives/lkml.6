Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA30CC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF4A215E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF4A215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbeHOAPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:15:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41327 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeHOAPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:15:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so18379158wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9OFpwz5ByVNmnzo9Fc9nHt9E0byxgQtgO41mybWsZ0s=;
        b=bbFUbIbO2D2gxw2lx8RgoNWykD44CAkUPtMeis4sJ3k2WfdVgw2d1eIa47fJQgT6Nr
         tbMR/i+9EzxxgfditbYR8EqHWP9X5SPcyJ8YJWHLWyU2Elyh+eriCOZRtyRtrjqAQoFT
         oyOIKbaP8XLWZsbM3J0GvkaCZsQdB0z/T8sr9rTISf9Go7GWgYm9INvwtC462TJvTXMn
         fBhBVPc4TD3dlUPjCr2RuYJOdEbT/THrAyscP5TcI79Lc1uc5X/T5v1UqEwofc9Bc3H5
         nFGXWmkSaGCmoGcN783/9pruCtGvBcPIbXsn4mQ2skwUPdiyziwbmYfi7b1wokEdSmgZ
         z5/g==
X-Gm-Message-State: AOUpUlG+emrgS9Vm+FkXxBvmWFpxvWLlIRo1Ib0gIhhfzFjnFvCpU3bd
        tdTmFu0NcC8VMvK+IVprv4s=
X-Google-Smtp-Source: AA+uWPx2igb2pzQGnmQF9TUpnZ5Nlb68VBcZeYVZtvAChv6l70ztV/qq4bzH9pf6HYBq6tBm24WNXg==
X-Received: by 2002:adf:fc45:: with SMTP id e5-v6mr15011841wrs.157.1534281963162;
        Tue, 14 Aug 2018 14:26:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f01:510a:2300:e740:c455:eab6:4e69])
        by smtp.gmail.com with ESMTPSA id r8-v6sm95888wmh.37.2018.08.14.14.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 14:26:02 -0700 (PDT)
From:   Abel Vesa <abelvesa@linux.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] cpu/hotplug: Non-SMP machines do not make use of booted_once
Date:   Wed, 15 Aug 2018 00:26:00 +0300
Message-Id: <20180814212600.19132-1-abelvesa@linux.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following commit breaks the non-SMP builds.

[0cc3cd21657be04cb0] cpu/hotplug: Boot HT siblings at least once

Signed-off-by: Abel Vesa <abelvesa@linux.com>
---
 kernel/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 099fb20cd7be..f06c513c5c42 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2272,6 +2272,8 @@ void __init boot_cpu_init(void)
  */
 void __init boot_cpu_hotplug_init(void)
 {
+#ifdef CONFIG_SMP
 	this_cpu_write(cpuhp_state.booted_once, true);
+#endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }
-- 
2.18.0

