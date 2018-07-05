Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660B0C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21288219CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21288219CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeGEO0M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:26:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9242 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753911AbeGEO0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:26:06 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65EOMtV020108;
        Thu, 5 Jul 2018 16:25:57 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k1k1j0mf2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 16:25:57 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 41CB731;
        Thu,  5 Jul 2018 14:25:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F3F752064;
        Thu,  5 Jul 2018 14:25:56 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 16:25:56 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 5 Jul 2018 16:25:56 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 2/3] regulator: core: Link consumer with regulator driver
Thread-Topic: [PATCH 2/3] regulator: core: Link consumer with regulator driver
Thread-Index: AQHUFGwWwlUWfYmgkkeEISLF07NUuw==
Date:   Thu, 5 Jul 2018 14:25:56 +0000
Message-ID: <1530800748-7300-3-git-send-email-p.paillet@st.com>
References: <1530800748-7300-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1530800748-7300-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

Add a device link between the consumer and the driver so that
the consumer is not suspended before the driver. The goal is to avoid
implementing suspend_late ops in regulator drivers.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 drivers/regulator/core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6ed568b..607ec47 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1740,6 +1740,8 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 			rdev->use_count = 0;
 	}
 
+	device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
+
 	return regulator;
 }
 
@@ -1829,9 +1831,21 @@ static void _regulator_put(struct regulator *regulator)
 
 	debugfs_remove_recursive(regulator->debugfs);
 
-	/* remove any sysfs entries */
-	if (regulator->dev)
+	if (regulator->dev) {
+		int count = 0;
+		struct regulator *r;
+
+		list_for_each_entry(r, &rdev->consumer_list, list)
+			if (r->dev == regulator->dev)
+				count++;
+
+		if (count == 1)
+			device_link_remove(regulator->dev, &rdev->dev);
+
+		/* remove any sysfs entries */
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
+	}
+
 	regulator_lock(rdev);
 	list_del(&regulator->list);
 
-- 
1.9.1
