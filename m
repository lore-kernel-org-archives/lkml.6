Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD38C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389EB2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438421AbfBNKlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:41:18 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41845 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406638AbfBNKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:41:15 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EAexU1030617;
        Thu, 14 Feb 2019 11:41:00 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qmwsujrjr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:41:00 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59A6434;
        Thu, 14 Feb 2019 10:40:55 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 346C24EB1;
        Thu, 14 Feb 2019 10:40:55 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb 2019 11:40:54
 +0100
From:   <gabriel.fernandez@st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [PATCH v2 6/7] clk: stm32mp1: remove unnecessary CLK_DIVIDER_ALLOW_ZERO flag
Date:   Thu, 14 Feb 2019 11:40:46 +0100
Message-ID: <20190214104047.1173-7-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214104047.1173-1-gabriel.fernandez@st.com>
References: <20190214104047.1173-1-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

The divisor of ethptp_k and ck_hse_rtc clocks is: 'value register
plus one'.
Then CLK_DIVIDER_ALLOW_ZERO flag has no effect and is useless here.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 8958bc11ff05..ca987632564e 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1959,11 +1959,10 @@ static const struct clock_config stm32mp1_clock_cfg[] = {
 		  CLK_SET_RATE_NO_REPARENT,
 		  _NO_GATE,
 		  _MMUX(M_ETHCK),
-		  _DIV(RCC_ETHCKSELR, 4, 4, CLK_DIVIDER_ALLOW_ZERO, NULL)),
+		  _DIV(RCC_ETHCKSELR, 4, 4, 0, NULL)),
 
 	/* RTC clock */
-	DIV(NO_ID, "ck_hse_rtc", "ck_hse", 0, RCC_RTCDIVR, 0, 7,
-	    CLK_DIVIDER_ALLOW_ZERO),
+	DIV(NO_ID, "ck_hse_rtc", "ck_hse", 0, RCC_RTCDIVR, 0, 7, 0),
 
 	COMPOSITE(RTC, "ck_rtc", rtc_src, CLK_OPS_PARENT_ENABLE |
 		   CLK_SET_RATE_PARENT,
-- 
2.17.0

