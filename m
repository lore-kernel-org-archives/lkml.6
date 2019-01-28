Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66945C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353E12148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="roTtRAOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfA1RcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:32:01 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25433 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbfA1Rb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:31:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548696679; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ddMIIsv9TA/YQJhNlRNL4OYLTZLcZFZP+WEMImEYp85m0B0sUvuEhc2vgc+UlaxhVqMMdAHwdsLGxjaPpjstaJ2ZMfvx/wVewHcJox+bnDZjQg5/jXy8jFOTxZ4+xspLjlwj62zu6Pz8N/ok7EEBxvRcsPkgzNadwLM6vMxwI7k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548696679; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=JCIEz/20JAonFJ+lboQH2xyKwW1qYqwbsPE71m3Y2k0=; 
        b=YJRTygTIaVCPQUjy1j9TrY0nztm4GmIWa3NQo5uTkMuQIdJOevm83EK6UPPFoomwozWfxlFitU2w1DBwqJ+Id3JYCHkDy2kQkQcYfgMk1XMeCHTl000BuKkhcipfL7UaSekuWaDxWUAYNyRQf3iLlJ1KpygO3LPIDeMnHt7Hg2Q=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=smANOio4TH2jiVojIGPISEbZpufJcvfD/kCHh3VBWwhC3MZpYRGljVdIf7+Iz6Is0V3Xu0fXP56j
    RFeVtvutw/eNphoQeEy0ewhtn2SejDi8QK+RqmKhfIUwa9Qj3oec  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548696679;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1728; bh=JCIEz/20JAonFJ+lboQH2xyKwW1qYqwbsPE71m3Y2k0=;
        b=roTtRAOA1FESPif0vHEHcJ0ttLFbKYqDG2y/rEvNUoEfOzJVO55097PZzQknEw2F
        RN3r0ECNUnkfyEJuP9treBxM8y3xkYpdG9Yki8h1EgFtquZGeAayOo1BVeYPYUBtmhN
        4Ov0jTdGO72pl0Nbe2dPDVb8O9BXlh5kNR2OufXw=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548696678305861.8532035662225; Mon, 28 Jan 2019 09:31:18 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        paul.burton@mips.com, mark.rutland@arm.com, syq@debian.org,
        jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH 1/3] RTC: Ingenic: Add support for the X1000.
Date:   Tue, 29 Jan 2019 01:29:57 +0800
Message-Id: <1548696599-53639-2-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
References: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the rtc-jz4740 driver on the
X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/rtc/rtc-jz4740.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index d0a8917..0c7ae65 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -34,7 +34,7 @@
 #define JZ_REG_RTC_RESET_COUNTER	0x28
 #define JZ_REG_RTC_SCRATCHPAD	0x34
 
-/* The following are present on the jz4780 */
+/* The following are present on the jz4780 and x1000 */
 #define JZ_REG_RTC_WENR	0x3C
 #define JZ_RTC_WENR_WEN	BIT(31)
 
@@ -46,7 +46,7 @@
 #define JZ_RTC_CTRL_AE		BIT(2)
 #define JZ_RTC_CTRL_ENABLE	BIT(0)
 
-/* Magic value to enable writes on jz4780 */
+/* Magic value to enable writes on jz4780 and x1000 */
 #define JZ_RTC_WENR_MAGIC	0xA55A
 
 #define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
@@ -55,6 +55,7 @@
 enum jz4740_rtc_type {
 	ID_JZ4740,
 	ID_JZ4780,
+	ID_X1000,
 };
 
 struct jz4740_rtc {
@@ -301,6 +302,7 @@ static void jz4740_rtc_power_off(void)
 static const struct of_device_id jz4740_rtc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-rtc", .data = (void *)ID_JZ4740 },
 	{ .compatible = "ingenic,jz4780-rtc", .data = (void *)ID_JZ4780 },
+	{ .compatible = "ingenic,x1000-rtc", .data = (void *)ID_X1000 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_rtc_of_match);
@@ -429,6 +431,7 @@ static const struct dev_pm_ops jz4740_pm_ops = {
 static const struct platform_device_id jz4740_rtc_ids[] = {
 	{ "jz4740-rtc", ID_JZ4740 },
 	{ "jz4780-rtc", ID_JZ4780 },
+	{ "x1000-rtc", ID_X1000 },
 	{}
 };
 MODULE_DEVICE_TABLE(platform, jz4740_rtc_ids);
-- 
2.7.4


