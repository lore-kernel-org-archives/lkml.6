Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A7C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B1420852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B1420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934732AbeFROWw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:22:52 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933445AbeFROWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:22:50 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MDl62-1fR8UL45Py-00H7ZT; Mon, 18 Jun 2018 16:22:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: use ktime_get_real_ts64() instead of getnstimeofday64()
Date:   Mon, 18 Jun 2018 16:22:14 +0200
Message-Id: <20180618142238.3509274-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:K2Lw+Iu4ix/Pc/R17HKwR7RQ9nDkEcx/qZGVyiV3s0CoAhlEAaA
 NjBUE/D7V+ZVRLh1577DuzTIbImKajTvYg0R6gXAEIY8FiIGi+CEVzQCXxvfqoylzfLFY0U
 ZeKh10p5txPeS5Io41fxj2kdF2U3Ok/WWL1btTZH5ymO5hOSr5BRL2A2UonHxnUB0W8NWAt
 n0ekbRKrACo/ONykyjJ1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+l6XrIyDNK0=:gnE0nQBY1oRY5LrvEIZzog
 7ulKVr/jod7oe7A0LFgl1FqFebZznLSsLlVU6/7OWlt9oKUVU/5v3MJfu55JxexzzYSW3dPyk
 nWwfR0QjSF5C3sbbpEeS5SShghrVrtraE10um4Cb0MmjI45l12LX7aIpByU9K0TYVlq4yZOsG
 bFVRQOTgYSOPUpmTiH6x8D2ZATGDgyOpABQdSop7H27wivhUQtoHBVSTGZjEv+Faw0avH3X6F
 pFZzSJOqHTaCKC01VWzzvjPq9oj+i7VMj8uVkY/mGfYRjgWJrDJkSLQwNlKQyhCoBkeN+Vf3g
 DJQitoNiza83RsxdNhYCuZk7B3uXXeUlKIc8IO0ZWt5C4oPyxUc2X687t4M1tgaAN01l1Wv3d
 /3z5UyxIsW8IywwRAKdijQPI0FKDu9guRfbz11D7McNoadJP3qofS+7hlPCtyrkDD6HOuqLt7
 neP/l4URFkKFnB9Zadl8q+jzoo2xUUK5sY6fJP3QeFq9HXAKXk0SZ04P0bJuBi3IGU5BBpuR0
 BqBHG6h09f7xLVQ1Y/6VCvcLT8ycLOJVCImQeqLhOuux7O2AbznGc35k1/bkekaCkZIh4ZX8K
 OeRsuXT31QoEoFSmza/cOCq2dE09kVMAftakVDobNoxpAbrzAtBvr/yMKziZe0l7Y2Sp6+BKS
 0oWo7bm8vq5KN/u8t8FfiMsaAPx7C3LscKTclKhlzt3DUWSs2UNPFF6oyw6wgapIakYk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getnstimeofday64() is just a wrapper around the ktime accessor, so
we should use that directly.

I considered using ktime_get_boottime_ts64() (to avoid leap second
problems) or ktime_get_real_seconds() (to simplify the calculation,
but in the end concluded that the existing interface is probably
the most appropriate in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index d37588f08055..7fa32c922617 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -68,7 +68,7 @@ static int rtc_suspend(struct device *dev)
 		return 0;
 	}
 
-	getnstimeofday64(&old_system);
+	ktime_get_real_ts64(&old_system);
 	old_rtc.tv_sec = rtc_tm_to_time64(&tm);
 
 
@@ -110,7 +110,7 @@ static int rtc_resume(struct device *dev)
 		return 0;
 
 	/* snapshot the current rtc and system time at resume */
-	getnstimeofday64(&new_system);
+	ktime_get_real_ts64(&new_system);
 	err = rtc_read_time(rtc, &tm);
 	if (err < 0) {
 		pr_debug("%s:  fail to read rtc time\n", dev_name(&rtc->dev));
-- 
2.9.0

