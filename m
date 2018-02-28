Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeB1G34 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:29:56 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39834 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeB1G3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:29:55 -0500
X-Google-Smtp-Source: AG47ELvzVz/VmIFibdEqNuDbcdcSyhvsqc8wZbRuIDPE/DuYyFdaNyI9crAQy2GmKv5E3tDA3MChIw==
From: Baolin Wang <baolin.wang@linaro.org>
To: geert@linux-m68k.org, mingo@kernel.org, arnd@arndb.de
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH] m68k: Use read_persistent_clock64() instead of read_persistent_clock()
Date: Wed, 28 Feb 2018 14:29:12 +0800
Message-Id: <d4493391d55b44b53da4a7c4a7fd9b865b5d57cd.1519799224.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since struct timespec is not y2038 safe on 32bit machines, this patch
converts read_persistent_clock() to read_persistent_clock64() using
struct timespec64, as well as converting mktime() to mktime64().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/m68k/kernel/time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 87160b4..8cd79c9 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -71,7 +71,7 @@ static irqreturn_t timer_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	struct rtc_time time;
 	ts->tv_sec = 0;
@@ -82,7 +82,7 @@ void read_persistent_clock(struct timespec *ts)
 
 		if ((time.tm_year += 1900) < 1970)
 			time.tm_year += 100;
-		ts->tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
+		ts->tv_sec = mktime64(time.tm_year, time.tm_mon, time.tm_mday,
 				      time.tm_hour, time.tm_min, time.tm_sec);
 	}
 }
-- 
1.7.9.5
