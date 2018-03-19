Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965498AbeCSXsj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:48:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54262 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964813AbeCSXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:48:33 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/6] rtc: hctosys: Ensure system time doesn't overflow time_t
Date: Tue, 20 Mar 2018 00:48:12 +0100
Message-Id: <20180319234817.16199-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32bit platforms, time_t is still a signed 32bit long. If it is
overflowed, userspace and the kernel cant agree on the current system time.
This causes multiple issues, in particular with systemd:
https://github.com/systemd/systemd/issues/1143

A good workaround is to simply avoid using systohc which is something I
greatly encourage as the time is better set by userspace.

However, many distribution enable it and use systemd which is rendering the
system unusable in case the RTC holds a date after 2038 (and more so after
2106). Many drivers have workaround for this case and they should be
eliminated so there is only one place left to fix when userspace is able to
cope with dates after the 31bit overflow.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/hctosys.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
index e1cfa06810ef..e79f2a181ad2 100644
--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -49,6 +49,11 @@ static int __init rtc_hctosys(void)
 
 	tv64.tv_sec = rtc_tm_to_time64(&tm);
 
+#if BITS_PER_LONG == 32
+	if (tv64.tv_sec > INT_MAX)
+		goto err_read;
+#endif
+
 	err = do_settimeofday64(&tv64);
 
 	dev_info(rtc->dev.parent,
-- 
2.16.2
