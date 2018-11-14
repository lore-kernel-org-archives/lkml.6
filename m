Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFF1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CD22145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfVztxtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CD22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbeKOBRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:17:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46128 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbeKOBRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:17:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id s9-v6so8043658pfm.13;
        Wed, 14 Nov 2018 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UkCBF2EDLfD2e2ZiiMYugHupaQ/e5bJi0gC0yfGW7jU=;
        b=BfVztxtv2NQ6Q33hrGD7rB1v9sEXYs5JCKNA3vDa0HwZ90YkxLH2y523097bslm0Yz
         d60Gs7u18S9NCYnIPbdaQy2SYpZ7WuZGQRCDFvNM8Asi7uxtAJBMRvD2u58mbBYkb7ew
         0I+nu8/D5K17C0R1zpLQc4Zxm+fR3UjgfIuWtIwvzCQijNabhP6Fe0NjvmV9ckm09gDU
         WeBnvSGI0xsjNiRBcNm3Rwa+Vq/VqsYSbHbp5KxoFwvpGOiils7xi+wTCMihu2oZUiS8
         5lpAc60w6ylZoTRqS0J2b2wf+cM0bKM6rKyB4vybERBm/WIgnE+9NmpXerXQCUGIwlOu
         1a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UkCBF2EDLfD2e2ZiiMYugHupaQ/e5bJi0gC0yfGW7jU=;
        b=oqW7QPxOqpsLja5t8IK6uqrLlHlPo9BVhGnuCyG4VNzxMaDpx28hW9Lf/EfFb9pwPM
         q8+zIcewaiXz3CjuEqAdHLuVJ8/7/yYqe/I31aAifzJyEADV/jgeWGTjGc3v3hvR3bwG
         ysQi8nDKw/ngjq04v4wAovQEB8SMixllbLfSMRc+G9LCOCwkJRKxX7c20bc2K+cb8kLz
         Nm4Ki2PJBsivvVE1XhFubcCbjATpGunjISTODxIgjP07WTM9kpedaw91B9TTIjhuvmND
         /hZFf25MLxLO7Be0p4Gm1QYqKdHIwEYydAmTqldqjShmbCdhrhslnqUquosKfE1aAnIj
         2v0Q==
X-Gm-Message-State: AGRZ1gJwp7s6cqKyCIuqhT3MPNqUOCZH3UwCNvYCXsGAiyZqOI0dX5Kf
        L35PGnfnfgC4TxBBtZulsXY=
X-Google-Smtp-Source: AJdET5efVk4nEhZcYarmj6KmkE2Vcspg7kTa2+x7NxmfIjRemcsPARgCnO4Hpbrmyb1HUKV+ePVa3Q==
X-Received: by 2002:a63:4d:: with SMTP id 74mr2173570pga.248.1542208402467;
        Wed, 14 Nov 2018 07:13:22 -0800 (PST)
Received: from wyn-Yoga-2-13.hsd1.ca.comcast.net ([2601:646:8e00:e38b:25ca:44cc:87cb:9856])
        by smtp.gmail.com with ESMTPSA id o195-v6sm26858244pfg.112.2018.11.14.07.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:13:11 -0800 (PST)
From:   Loic WEI YU NENG <loic.wyn@gmail.com>
To:     Darren Hart <dvhart@infradead.org>, andy.shevchenko@gmail.com,
        ike.pan@canonical.com, andy@infradead.org, trivial@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Loic WEI YU NENG <loic.wyn@gmail.com>
Subject: [PATCH] ideapad-laptop: Add Lenovo Yoga 2 13 to the no_hw_rfkill DMI list
Date:   Wed, 14 Nov 2018 07:12:12 -0800
Message-Id: <20181114151212.20942-1-loic.wyn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Lenovo ideapad models lack a physical rfkill switch.
On Lenovo models Yoga 2 13, ideapad-laptop would wrongly report all
radios as blocked by hardware which caused wireless network connections
to fail.
Add these models without an rfkill switch to the no_hw_rfkill list.

Signed-off-by: Loic WEI YU NENG <loic.wyn@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index b6489cba2985..1589dffab9fa 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1188,6 +1188,13 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "Yoga2"),
 		},
 	},
+	{
+		.ident = "Lenovo Yoga 2 13",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Yoga 2 13"),
+		},
+	},
 	{
 		.ident = "Lenovo Yoga 3 1170 / 1470",
 		.matches = {
-- 
2.17.1

