Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F6E2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F6E2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756270AbeFSICr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:02:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755536AbeFSICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:02:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5J82OcT3015180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 01:02:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5J82O0w3015177;
        Tue, 19 Jun 2018 01:02:24 -0700
Date:   Tue, 19 Jun 2018 01:02:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-dc1b7b6ca9d5fa905c164a667086d8a3d8605875@git.kernel.org>
Cc:     tglx@linutronix.de, gorcunov@openvz.org, mingo@kernel.org,
        gorcunov@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org, linux@dominikbrodowski.net,
        arnd@arndb.de
Reply-To: tglx@linutronix.de, gorcunov@gmail.com, mingo@kernel.org,
          gorcunov@openvz.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          arnd@arndb.de, linux@dominikbrodowski.net,
          akpm@linux-foundation.org
In-Reply-To: <20180618150114.849216-1-arnd@arndb.de>
References: <20180618150114.849216-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] sysinfo: Remove get_monotonic_boottime()
Git-Commit-ID: dc1b7b6ca9d5fa905c164a667086d8a3d8605875
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

Commit-ID:  dc1b7b6ca9d5fa905c164a667086d8a3d8605875
Gitweb:     https://git.kernel.org/tip/dc1b7b6ca9d5fa905c164a667086d8a3d8605875
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon, 18 Jun 2018 17:00:38 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 19 Jun 2018 09:56:27 +0200

sysinfo: Remove get_monotonic_boottime()

get_monotonic_boottime() is deprecated because it uses the old 'timespec'
structure. This replaces one of the last callers with a call to
ktime_get_boottime.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: y2038@lists.linaro.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Link: https://lkml.kernel.org/r/20180618150114.849216-1-arnd@arndb.de

---
 kernel/sys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 38509dc1f77b..e27b51d3facd 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2512,11 +2512,11 @@ static int do_sysinfo(struct sysinfo *info)
 {
 	unsigned long mem_total, sav_total;
 	unsigned int mem_unit, bitcount;
-	struct timespec tp;
+	struct timespec64 tp;
 
 	memset(info, 0, sizeof(struct sysinfo));
 
-	get_monotonic_boottime(&tp);
+	ktime_get_boottime_ts64(&tp);
 	info->uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
 
 	get_avenrun(info->loads, 0, SI_LOAD_SHIFT - FSHIFT);
