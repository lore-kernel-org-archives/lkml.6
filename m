Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6165AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3160E222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196575;
	bh=y5Vtc8YidNoTw9PwpTl6UrIpFn1CINVZFcLTZgF8b44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rBKHFjL+kf8PDtcBZ3M2y8ew1hBEtNmalD+dp2nEliN2aXveU1mD4t9uo4ouXIXkm
	 S/Q1COz/DhvqSs41udhY154dNpZggak2TuQudczTIvttfryEwoUZog+xdmQNy2DhvF
	 tXXj4D4Hwz/ur3jnhR05+CfK669h1sqNkc1rZ80w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbfBOCJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387637AbfBOCJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3CED206BA;
        Fri, 15 Feb 2019 02:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196570;
        bh=y5Vtc8YidNoTw9PwpTl6UrIpFn1CINVZFcLTZgF8b44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jm6oUiINJeSpic4DZIGGs8W6U1qZKShFz3ofC6eq0a/LErv159YXdkTOqP8b6YIGz
         FETSn6nwEcxTrJQbUAQKT4AAXupA319KLHlH4TcvFdQAYDQplVV29Ai1eWY35rv8kG
         Pq6KC0OF2OpADMbFpdAFnOQwaWj6veipFwlBuiEI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 18/77] selftests: rtc: rtctest: fix alarm tests
Date:   Thu, 14 Feb 2019 21:07:56 -0500
Message-Id: <20190215020855.176727-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
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

