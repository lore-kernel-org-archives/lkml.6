Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE37C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DC9208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="va2TH84R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DC9208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbeG3UqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731047AbeG3UqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:46:15 -0400
Received: from sinan-ubuntu.corp.microsoft.com (unknown [131.107.160.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4940420894;
        Mon, 30 Jul 2018 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532977792;
        bh=9Ush5/dssOYrZI/Mqr1d/Q0Pdd+oTvYAUQHPWN1gg0w=;
        h=From:To:Cc:Subject:Date:From;
        b=va2TH84RPsvTlxEQJ8evjYOg/9al0uq5Cjmj/G78xSQZxk23ez3Zaok5E9FNHtsdO
         rnF9TSWKVGoTAeSGcoLYxJ/7r5ldtK/EmL0VQRqeIUBU/OgryzIdpOywu5R3HRtfeR
         kGRBE/tLah/+tp+2JOOO142SuPjPOojpzx/VDP3Q=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Zickus <dzickus@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] watchdog: Reduce message verbosity
Date:   Mon, 30 Jul 2018 12:09:47 -0700
Message-Id: <20180730190949.141996-1-okaya@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reducing the verbosity level to debug for people that are interested in
debugging watchdog issues.

[    0.152492] NMI watchdog: Perf event create on CPU 0 failed with -2
[    0.156002] NMI watchdog: Perf NMI watchdog permanently disabled

Signed-off-by: Sinan Kaya <okaya@kernel.org>
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

