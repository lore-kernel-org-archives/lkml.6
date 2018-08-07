Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB4FC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7852151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7852151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390709AbeHGVNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:13:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389340AbeHGVNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:13:17 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C7FBAD54;
        Tue,  7 Aug 2018 18:57:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 09/85] rtc: ensure rtc_set_alarm fails when alarms are not supported
Date:   Tue,  7 Aug 2018 20:51:11 +0200
Message-Id: <20180807172357.706080711@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit abfdff44bc38e9e2ef7929f633fb8462632299d4 ]

When using RTC_ALM_SET or RTC_WKALM_SET with rtc_wkalrm.enabled not set,
rtc_timer_enqueue() is not called and rtc_set_alarm() may succeed but the
subsequent RTC_AIE_ON ioctl will fail. RTC_ALM_READ would also fail in that
case.

Ensure rtc_set_alarm() fails when alarms are not supported to avoid letting
programs think the alarms are working for a particular RTC when they are
not.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/interface.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -381,6 +381,11 @@ int rtc_set_alarm(struct rtc_device *rtc
 {
 	int err;
 
+	if (!rtc->ops)
+		return -ENODEV;
+	else if (!rtc->ops->set_alarm)
+		return -EINVAL;
+
 	err = rtc_valid_tm(&alarm->time);
 	if (err != 0)
 		return err;


