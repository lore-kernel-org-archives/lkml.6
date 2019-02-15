Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FEC20675
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198053;
	bh=a2XlMNwkxCqbKdEk2qYjdpGrEODXQvqJMMiqtzQmxC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SRuJlM3UQOfguopq02EEtwMIc54wqS80SU1uO0UlmehRCbgV5aKVYH3rXC7VdyPLa
	 ASMMbepZK1JI8oEgwb3zOr5ku1yFI9FeXBTD5MLdytNi+68hQ9xB2Mat26vkWMvN7q
	 k45AU48aEWrJ6PueW97i57FMjI/yZZ2oICbmK8Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbfBOCeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:34:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403968AbfBOCLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B329E2229F;
        Fri, 15 Feb 2019 02:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196703;
        bh=a2XlMNwkxCqbKdEk2qYjdpGrEODXQvqJMMiqtzQmxC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWLibVqify1LlFZmMQtC3W4VIGx7d6vLo3oXSoxmTpOil05ukODqpNEaVguj+RVv1
         ppHXuukgmqPO6CGmUNR1lUJJUnmpXCGfhbh0OrId4/MCz0ZB1X9Jd/mcKdT6L/zZix
         V5p52NljrK2UzH2byaa1UBhBSxPiHYKeA2tYMHyQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/65] selftests: rtc: rtctest: add alarm test on minute boundary
Date:   Thu, 14 Feb 2019 21:10:29 -0500
Message-Id: <20190215021121.177674-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 7b3027728f4d4f6763f4d7e771acfc9424cdd0e6 ]

Unfortunately, some RTC don't have a second resolution for alarm so also
test for alarm on a minute boundary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

