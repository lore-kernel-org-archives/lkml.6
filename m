Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB61ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2630A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2630A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeGTIDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:03:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50583 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727028AbeGTIDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:03:52 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6K7E2bD011311;
        Fri, 20 Jul 2018 09:16:45 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k87uey5er-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 09:16:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59BBC31;
        Fri, 20 Jul 2018 07:16:44 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1527318FC;
        Fri, 20 Jul 2018 07:16:44 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 20 Jul 2018 09:16:43
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>
CC:     <fabrice.gasnier@st.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pwm: stm32-lp: Remove useless loop in stm32_pwm_lp_remove()
Date:   Fri, 20 Jul 2018 09:16:32 +0200
Message-ID: <1532070992-16831-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPTimer has only one pwm channel (npwm = 1). Remove useless for loop
in remove routine.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32-lp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 7c13e25..0059b24c 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -217,10 +217,8 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 static int stm32_pwm_lp_remove(struct platform_device *pdev)
 {
 	struct stm32_pwm_lp *priv = platform_get_drvdata(pdev);
-	unsigned int i;
 
-	for (i = 0; i < priv->chip.npwm; i++)
-		pwm_disable(&priv->chip.pwms[i]);
+	pwm_disable(&priv->chip.pwms[0]);
 
 	return pwmchip_remove(&priv->chip);
 }
-- 
1.9.1

