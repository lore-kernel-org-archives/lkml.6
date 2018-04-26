Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbeDZIXz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:23:55 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53398 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbeDZIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:23:52 -0400
Date: Thu, 26 Apr 2018 18:23:54 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Fix off-by-one calendar month
In-Reply-To: <S1753913AbeDWBDM/20180423010312Z+539@vger.kernel.org>
Message-ID: <alpine.LNX.2.21.1804261806450.8@nippy.intranet>
References: <S1753913AbeDWBDM/20180423010312Z+539@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed that my patch overlooked m68328_hwclk(). Like the other 
platforms, this one also needs tm_mon decremented.

Geert, can you amend the commit in your tree or should I submit this 
separately?

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
