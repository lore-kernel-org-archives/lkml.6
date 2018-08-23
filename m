Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F24C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E59208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E59208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeHWMci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:32:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeHWMci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:32:38 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C6EEBBF;
        Thu, 23 Aug 2018 09:03:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 258/324] rtc: fix alarm read and set offset
Date:   Thu, 23 Aug 2018 09:55:24 +0200
Message-Id: <20180823075008.931538622@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit fd6792bb022e43faa0c4a45b6f25285e21206f9d ]

The offset needs to be added after reading the alarm value.

It also needs to be subtracted after the now < alarm test.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/interface.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -265,8 +265,10 @@ int __rtc_read_alarm(struct rtc_device *
 			return err;
 
 		/* full-function RTCs won't have such missing fields */
-		if (rtc_valid_tm(&alarm->time) == 0)
+		if (rtc_valid_tm(&alarm->time) == 0) {
+			rtc_add_offset(rtc, &alarm->time);
 			return 0;
+		}
 
 		/* get the "after" timestamp, to detect wrapped fields */
 		err = rtc_read_time(rtc, &now);
@@ -409,7 +411,6 @@ static int __rtc_set_alarm(struct rtc_de
 	if (err)
 		return err;
 
-	rtc_subtract_offset(rtc, &alarm->time);
 	scheduled = rtc_tm_to_time64(&alarm->time);
 
 	/* Make sure we're not setting alarms in the past */
@@ -426,6 +427,8 @@ static int __rtc_set_alarm(struct rtc_de
 	 * over right here, before we set the alarm.
 	 */
 
+	rtc_subtract_offset(rtc, &alarm->time);
+
 	if (!rtc->ops)
 		err = -ENODEV;
 	else if (!rtc->ops->set_alarm)
@@ -467,7 +470,6 @@ int rtc_set_alarm(struct rtc_device *rtc
 
 	mutex_unlock(&rtc->ops_lock);
 
-	rtc_add_offset(rtc, &alarm->time);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_set_alarm);


