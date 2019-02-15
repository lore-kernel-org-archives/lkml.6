Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E0C21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198066;
	bh=y5Vtc8YidNoTw9PwpTl6UrIpFn1CINVZFcLTZgF8b44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UOEtqDzMGFfKE6tUwR3LAb6K2mV11L0KdzeLKWOUIjmaOkOJObs1byimqlncXpE9F
	 tnIgBHVy1/gvRo8Y2xFh2n98JkgVFBcfwzrfJEWSXJTuAIPdbqNOOfxKsDRX1bR+yF
	 PP6i6rfXLjrKgyQAJju6V1crHpWrI7j9obF4gpkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbfBOCeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403957AbfBOCLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F9621B68;
        Fri, 15 Feb 2019 02:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196702;
        bh=y5Vtc8YidNoTw9PwpTl6UrIpFn1CINVZFcLTZgF8b44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0YstYm2v5jQA903Q2gcTJd4vSDa70bVVh4oj4dSnyoXTEFvAP/fiiyXLT80ZqqMU
         Ehc0LAHnUVb2U9zHUzK4UhRQsWkqRiWvXzCdJ4hE3rDPf2qMEfmEqxQdv6FQvq1D8h
         mU71OFXsxfVLhMC1PgwgqStpbFFyCeuG3otOyQ+w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/65] selftests: rtc: rtctest: fix alarm tests
Date:   Thu, 14 Feb 2019 21:10:28 -0500
Message-Id: <20190215021121.177674-12-sashal@kernel.org>
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

[ Upstream commit fdac94489c4d247088b3885875b39b3e1eb621ef ]

Return values for select are not checked properly and timeouts may not be
detected.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

