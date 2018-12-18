Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D4FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5FA21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeLRVey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:34:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43961 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbeLRVey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:34:54 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E7D46207D9; Tue, 18 Dec 2018 22:34:50 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id B9E4A207BE;
        Tue, 18 Dec 2018 22:34:40 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] selftests: rtc: rtctest: add alarm test on minute boundary
Date:   Tue, 18 Dec 2018 22:34:21 +0100
Message-Id: <20181218213421.15447-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181218213421.15447-1-alexandre.belloni@bootlin.com>
References: <20181218213421.15447-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, some RTC don't have a second resolution for alarm so also
test for alarm on a minute boundary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 tools/testing/selftests/rtc/rtctest.c | 102 ++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index dea4e3d6d9e1..b2065536d407 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -211,6 +211,108 @@ TEST_F(rtc, alarm_wkalm_set) {
 	ASSERT_EQ(new, secs);
 }
 
+TEST_F(rtc, alarm_alm_set_minute) {
+	struct timeval tv = { .tv_sec = 62 };
+	unsigned long data;
+	struct rtc_time tm;
+	fd_set readfds;
+	time_t secs, new;
+	int rc;
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	secs = timegm((struct tm *)&tm) + 60 - tm.tm_sec;
+	gmtime_r(&secs, (struct tm *)&tm);
+
+	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip alarms are not supported.");
+		return;
+	}
+
+	rc = ioctl(self->fd, RTC_ALM_READ, &tm);
+	ASSERT_NE(-1, rc);
+
+	TH_LOG("Alarm time now set to %02d:%02d:%02d.",
+	       tm.tm_hour, tm.tm_min, tm.tm_sec);
+
+	/* Enable alarm interrupts */
+	rc = ioctl(self->fd, RTC_AIE_ON, 0);
+	ASSERT_NE(-1, rc);
+
+	FD_ZERO(&readfds);
+	FD_SET(self->fd, &readfds);
+
+	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
+	ASSERT_NE(-1, rc);
+	ASSERT_NE(0, rc);
+
+	/* Disable alarm interrupts */
+	rc = ioctl(self->fd, RTC_AIE_OFF, 0);
+	ASSERT_NE(-1, rc);
+
+	rc = read(self->fd, &data, sizeof(unsigned long));
+	ASSERT_NE(-1, rc);
+	TH_LOG("data: %lx", data);
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	new = timegm((struct tm *)&tm);
+	ASSERT_EQ(new, secs);
+}
+
+TEST_F(rtc, alarm_wkalm_set_minute) {
+	struct timeval tv = { .tv_sec = 62 };
+	struct rtc_wkalrm alarm = { 0 };
+	struct rtc_time tm;
+	unsigned long data;
+	fd_set readfds;
+	time_t secs, new;
+	int rc;
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
+	ASSERT_NE(-1, rc);
+
+	secs = timegm((struct tm *)&alarm.time) + 60 - alarm.time.tm_sec;
+	gmtime_r(&secs, (struct tm *)&alarm.time);
+
+	alarm.enabled = 1;
+
+	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip alarms are not supported.");
+		return;
+	}
+
+	rc = ioctl(self->fd, RTC_WKALM_RD, &alarm);
+	ASSERT_NE(-1, rc);
+
+	TH_LOG("Alarm time now set to %02d/%02d/%02d %02d:%02d:%02d.",
+	       alarm.time.tm_mday, alarm.time.tm_mon + 1,
+	       alarm.time.tm_year + 1900, alarm.time.tm_hour,
+	       alarm.time.tm_min, alarm.time.tm_sec);
+
+	FD_ZERO(&readfds);
+	FD_SET(self->fd, &readfds);
+
+	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
+	ASSERT_NE(-1, rc);
+	ASSERT_NE(0, rc);
+
+	rc = read(self->fd, &data, sizeof(unsigned long));
+	ASSERT_NE(-1, rc);
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	new = timegm((struct tm *)&tm);
+	ASSERT_EQ(new, secs);
+}
+
 static void __attribute__((constructor))
 __constructor_order_last(void)
 {
-- 
2.20.0

