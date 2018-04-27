Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757241AbeD0BMz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:12:55 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33198 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbeD0BMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:12:53 -0400
Date: Fri, 27 Apr 2018 11:12:56 +1000
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k: Fix calendar month regression on M68328
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S1757241AbeD0BMz/20180427011256Z+196@vger.kernel.org>

My earlier fix for read_persistent_clock() neglected to cover
m68328_hwclk(). Correct this oversight.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Greg, the read_persistent_clock() change has already been queued
by Geert. Should this patch be pushed together with that one
(presuming your ack)? Sorry for the inconvenience.
---
 arch/m68k/68000/timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
index 252455bce144..71ddb4c98726 100644
--- a/arch/m68k/68000/timers.c
+++ b/arch/m68k/68000/timers.c
@@ -125,7 +125,9 @@ int m68328_hwclk(int set, struct rtc_time *t)
 {
 	if (!set) {
 		long now = RTCTIME;
-		t->tm_year = t->tm_mon = t->tm_mday = 1;
+		t->tm_year = 1;
+		t->tm_mon = 0;
+		t->tm_mday = 1;
 		t->tm_hour = (now >> 24) % 24;
 		t->tm_min = (now >> 16) % 60;
 		t->tm_sec = now % 60;
-- 
2.16.1
