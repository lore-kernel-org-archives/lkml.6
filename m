Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BDDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DF1208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="odhSX7zF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DF1208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeHBIZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:25:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45314 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHBIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:25:30 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w726ZdH2086569;
        Thu, 2 Aug 2018 01:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533191739;
        bh=LwrEQsq/9ej0hBUnY8eBhiYUM8Vb627H559JaTjbQOg=;
        h=From:To:CC:Subject:Date;
        b=odhSX7zF8j5EvfZara5YD8Ak5azJJ96mrCJRiRDrj5gfvEbqnC6u6CFotIPefunIQ
         mWNCDLnx9O3i81vffq/MxvNroJvnXBs5ADgskVTZcTJUgmPR9QVezqWICC7Ru5DzmU
         OE3ZdaS2fpFVaup7DRLg/VbM/wkD8sR9Q8n6kknc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w726ZdpH009377;
        Thu, 2 Aug 2018 01:35:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 2 Aug
 2018 01:35:38 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 2 Aug 2018 01:35:38 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w726ZYLB023193;
        Thu, 2 Aug 2018 01:35:35 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <baolin.wang@linaro.org>, <d-gerlach@ti.com>, <tony@atomide.com>,
        <grygorii.strashko@ti.com>, <j-keerthy@ti.com>, <t-kristo@ti.com>
Subject: [PATCH] clocksource: ti-32k: Remove CLOCK_SOURCE_SUSPEND_NONSTOP flag
Date:   Thu, 2 Aug 2018 12:05:16 +0530
Message-ID: <1533191716-20476-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of below commit:

commit 39232ed5a1793f67b11430c43ed8a9ed6e96c6eb

time: Introduce one suspend clocksource to compensate the suspend time

The suspend/resume fails on AM437x platforms as the source is not
a non-stop while trying to compensate time using this.

Hence remove the CLOCK_SOURCE_SUSPEND_NONSTOP flag.

Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/clocksource/timer-ti-32k.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 880a861..7368e8e 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -78,8 +78,7 @@ static u64 notrace ti_32k_read_cycles(struct clocksource *cs)
 		.rating		= 250,
 		.read		= ti_32k_read_cycles,
 		.mask		= CLOCKSOURCE_MASK(32),
-		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
-				CLOCK_SOURCE_SUSPEND_NONSTOP,
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS, 
 	},
 };
 
-- 
1.9.1

