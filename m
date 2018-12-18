Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C2DC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733CE21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeLRVex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:34:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43958 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbeLRVex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:34:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A511820824; Tue, 18 Dec 2018 22:34:50 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7AAF3206FF;
        Tue, 18 Dec 2018 22:34:40 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] selftests: rtc: rtctest: fix alarm tests
Date:   Tue, 18 Dec 2018 22:34:20 +0100
Message-Id: <20181218213421.15447-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return values for select are not checked properly and timeouts may not be
detected.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 tools/testing/selftests/rtc/rtctest.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index e20b017e7073..dea4e3d6d9e1 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -145,15 +145,12 @@ TEST_F(rtc, alarm_alm_set) {
 
 	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
 	ASSERT_NE(-1, rc);
-	EXPECT_NE(0, rc);
+	ASSERT_NE(0, rc);
 
 	/* Disable alarm interrupts */
 	rc = ioctl(self->fd, RTC_AIE_OFF, 0);
 	ASSERT_NE(-1, rc);
 
-	if (rc == 0)
-		return;
-
 	rc = read(self->fd, &data, sizeof(unsigned long));
 	ASSERT_NE(-1, rc);
 	TH_LOG("data: %lx", data);
@@ -202,7 +199,7 @@ TEST_F(rtc, alarm_wkalm_set) {
 
 	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
 	ASSERT_NE(-1, rc);
-	EXPECT_NE(0, rc);
+	ASSERT_NE(0, rc);
 
 	rc = read(self->fd, &data, sizeof(unsigned long));
 	ASSERT_NE(-1, rc);
-- 
2.20.0

