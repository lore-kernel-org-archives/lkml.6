Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6675ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CEC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="cC/PDLuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CEC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeGRJ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:59:24 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:33006 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbeGRJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:59:23 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id ADD9DB00776
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:22:23 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1531905743; x=1532769744; bh=BL
        qxhPVu4LtyC6/jHt4trzmmoH+QJ4BdUT17yDY9lg8=; b=cC/PDLuEJu4vCIvrIx
        QcHSdyoQlkHCgjqnusp37d1+hjEN952B51XmyP5eYAJhzt+j4Z3m2e2RbJuveC4u
        9dfsThi2bnHB8DBhejh8X05DInv/Bkh4Hwy7JSiPWE4+x2nUGekmyHDryhibEAoO
        LTvzRjro1hVahD/an/mafww4Q=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id efEInhnoOg53 for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 11:22:23 +0200 (CEST)
Received: from localhost.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 16884B002CE;
        Wed, 18 Jul 2018 11:22:22 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 1/4] rtc: ds1307: fix data pointer to m41t0
Date:   Wed, 18 Jul 2018 11:22:16 +0200
Message-Id: <20180718092216.91053-4-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718092216.91053-1-giulio.benetti@micronovasrl.com>
References: <20180718092216.91053-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

data field points to m41t00, instead it should point to m41t0.
Driver works correctly because on both cases(m41t0 and m41t00) chip_desc
are equal.

Point to right enum m41t0 instead of m41t00.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index e9ec4160d7f6..aa4a161bae98 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -299,7 +299,7 @@ static const struct of_device_id ds1307_of_match[] = {
 	},
 	{
 		.compatible = "st,m41t0",
-		.data = (void *)m41t00
+		.data = (void *)m41t0
 	},
 	{
 		.compatible = "st,m41t00",
-- 
2.17.1

