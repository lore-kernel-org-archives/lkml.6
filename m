Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeDTQPh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:15:37 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52585 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDTQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:14:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] rtc: ls1x: remove mktime usage
Date: Fri, 20 Apr 2018 18:14:25 +0200
Message-Id: <20180420161433.3721192-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180420161433.3721192-1-arnd@arndb.de>
References: <20180420161433.3721192-1-arnd@arndb.de>
X-Provags-ID: V03:K1:jLE80nIlTuHNBXQS5Q/kQoDTiwWNUWQEnwnlls4orHmeBQUKjjB
 N77cwiVuy6dsEhFiEXrwHIi9VkkjydOE/7GwGMuK5h7N27usXUdEy0mqvlyNW2cdBGbuhxO
 VczAqeW+ALJK3NgfG3vT/lV/akWejvHBZmQmu3QjroztusFbju0KENnqVEKqFKHBAeRBYkZ
 05/1TJCNDmQjATPXoEREA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4BCmzUPsy58=:umGPZc5w0R0G9gUX/EFSYp
 5h/BwkQdvU83AX1DnPvFpsVD+t4tUuV2Y7eabH9Z5bchs/vfHkUI0gwcDofv5gKBmThHHAlCu
 W1wgGlfecIAz5/DR8oh5KLo9bfM4hQT4ZK4n29pY9PEIGXagZcpmhUEv6i3Ezzxl6rNFMcXfV
 fBnVtJhE5Y+PFNGwO+ckQPFO199/bde840s6qDVwPz7ncHlOUGJz8hiEIFjFJj4FXWbQk+l3q
 wR7wNvlt9Ph9EF3osXjD1OfOUHuTPM8DG3pNarzjdLRPzj5jrmmBaCHz3tBPJsOjns3bpb69s
 Zeh3gGWTH5sfXsz6o0x6JVXOoGd2dGy99HHx3itiTClxAHIrScdkqQdiBqfIjEU4bET1DeHqp
 oXgMME0xyr3cJiWV1E2nLvN7NjEXdalE1bUkvb7wyXwV/qI2Q2aTDP3hoVmVWgdpHfepvZnru
 hT0hs5PNx6rSnCNURlryRi8AEFwa+/AFbSZ77WvGwE4AbdDHF0jDT30AsAqSMWWB3QkiiPKeF
 KwumMcnOcJhfSauan7GIsnRz4LDBZYNZEHRCKYlYxHeWnYuR2OVdPU3DlRcVRf8tnVfau/lcb
 +7iHg8kxkWU9Mg/J2+YmswZloppSF9DK9wRMIXHUUoh0TIzqLmDz3mfIL7p66z/qlTvw1/bVO
 PJPkyRopIAvbcH0Qps7jkZjmUfJGJm0D8FCbaaKe72CzqjunvjEV3hSrWlw6Xz+jtJjjq2vjS
 8jv1VoHmLfxQn/dTp4swoPYt9NiQG8PC9pBR+w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loongson1 platform is 32-bit, so storing a time value in 32 bits
suffers from limited range. In this case it is likely to be correct
until 2106, but it's better to avoid the limitation and just use
the time64_t based mktime64() and rtc_time64_to_tm() interfaces.

The hardware uses a 32-bit year number, and time64_t can cover that
entire range.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-ls1x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
index 045af1135e48..de86f9fabc11 100644
--- a/drivers/rtc/rtc-ls1x.c
+++ b/drivers/rtc/rtc-ls1x.c
@@ -87,16 +87,17 @@
 
 static int ls1x_rtc_read_time(struct device *dev, struct rtc_time *rtm)
 {
-	unsigned long v, t;
+	unsigned long v;
+	time64_t t;
 
 	v = readl(SYS_TOYREAD0);
 	t = readl(SYS_TOYREAD1);
 
 	memset(rtm, 0, sizeof(struct rtc_time));
-	t  = mktime((t & LS1X_YEAR_MASK), ls1x_get_month(v),
+	t  = mktime64((t & LS1X_YEAR_MASK), ls1x_get_month(v),
 			ls1x_get_day(v), ls1x_get_hour(v),
 			ls1x_get_min(v), ls1x_get_sec(v));
-	rtc_time_to_tm(t, rtm);
+	rtc_time64_to_tm(t, rtm);
 
 	return 0;
 }
-- 
2.9.0
