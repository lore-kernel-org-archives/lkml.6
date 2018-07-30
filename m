Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148211625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73B7204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73B7204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeG3TNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:13:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeG3TNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:13:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UHaonv2388487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 10:36:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UHaoYo2388484;
        Mon, 30 Jul 2018 10:36:50 -0700
Date:   Mon, 30 Jul 2018 10:36:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-684ad537abff987886d63fb3c573eeca40d7f2db@git.kernel.org>
Cc:     pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: pasha.tatashin@oracle.com, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180725200018.23722-1-pasha.tatashin@oracle.com>
References: <20180725200018.23722-1-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] timekeeping: Prevent false warning when persistent
 clock is not available
Git-Commit-ID: 684ad537abff987886d63fb3c573eeca40d7f2db
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

Commit-ID:  684ad537abff987886d63fb3c573eeca40d7f2db
Gitweb:     https://git.kernel.org/tip/684ad537abff987886d63fb3c573eeca40d7f2db
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Wed, 25 Jul 2018 16:00:18 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 19:32:29 +0200

timekeeping: Prevent false warning when persistent clock is not available

On arches with no persistent clock a message like this is printed during
boot:

[    0.000000] Persistent clock returned invalid value

The value is not invalid: Zero means that no persistent clock is available
and the absence of persistent clock should be quietly accepted.

Fixes: 3eca993740b8 ("timekeeping: Replace read_boot_clock64() with read_persistent_wall_and_boot_offset()")
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: sboyd@kernel.org
Cc: john.stultz@linaro.org
Link: https://lkml.kernel.org/r/20180725200018.23722-1-pasha.tatashin@oracle.com
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 30d7f64ffc87..6183e7460138 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1536,7 +1536,7 @@ void __init timekeeping_init(void)
 	if (timespec64_valid_strict(&wall_time) &&
 	    timespec64_to_ns(&wall_time) > 0) {
 		persistent_clock_exists = true;
-	} else {
+	} else if (timespec64_to_ns(&wall_time) != 0) {
 		pr_warn("Persistent clock returned invalid value");
 		wall_time = (struct timespec64){0};
 	}
