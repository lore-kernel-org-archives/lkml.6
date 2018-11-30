Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EBDC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F7820868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F7820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeK3VFM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:05:12 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47640 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbeK3VFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:05:11 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAU9sFSK007736;
        Fri, 30 Nov 2018 10:55:54 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nxw03163e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 30 Nov 2018 10:55:54 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 99D33586;
        Fri, 30 Nov 2018 10:55:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1436C289F;
        Fri, 30 Nov 2018 09:55:52 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 30 Nov
 2018 10:55:51 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 30 Nov 2018 10:55:51 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH v7 7/7] regulator: stpmic1: fix regulator_lock usage
Thread-Topic: [PATCH v7 7/7] regulator: stpmic1: fix regulator_lock usage
Thread-Index: AQHUiJLg8qmy8yA/8kuv2m2omb36Ug==
Date:   Fri, 30 Nov 2018 09:55:51 +0000
Message-ID: <1543571742-17995-8-git-send-email-p.paillet@st.com>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1543571742-17995-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-30_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a compilation issue due to regulator_lock usage.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
changes in v7: 
* new patch due to rebase on regul/for-next

 drivers/regulator/stpmic1_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index eac0848..16ba029 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -489,7 +489,7 @@ static irqreturn_t stpmic1_curlim_irq_handler(int irq, void *data)
 {
 	struct regulator_dev *rdev = (struct regulator_dev *)data;
 
-	regulator_lock(rdev, NULL);
+	regulator_lock(rdev);
 
 	/* Send an overcurrent notification */
 	regulator_notifier_call_chain(rdev,
-- 
1.9.1
