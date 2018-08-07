Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F44AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA64208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA64208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbeHGLqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:46:04 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47148 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbeHGLp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:45:59 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w779OoPm013778;
        Tue, 7 Aug 2018 04:32:30 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2kn9j1knvp-1;
        Tue, 07 Aug 2018 04:32:30 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 37781611C8BD;
        Tue,  7 Aug 2018 04:34:11 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 7 Aug 2018
 10:32:29 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w779WTGw011714;        Tue, 7 Aug 2018 10:32:29 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <linus.walleij@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] pinctrl: madera: Return ENOTSUPP for unsupported pin attributes
Date:   Tue, 7 Aug 2018 10:32:25 +0100
Message-ID: <20180807093226.5624-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180807093226.5624-1-rf@opensource.cirrus.com>
References: <20180807093226.5624-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=859 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808070096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin_config_[get|set] functions should return ENOTSUPP if
the requested attribute isn't supported.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/pinctrl/cirrus/pinctrl-madera-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
index 4f9b7e3b7cf2..4ba56ca5a9be 100644
--- a/drivers/pinctrl/cirrus/pinctrl-madera-core.c
+++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
@@ -801,7 +801,7 @@ static int madera_pin_conf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 			result = 1;
 		break;
 	default:
-		break;
+		return -ENOTSUPP;
 	}
 
 	*config = pinconf_to_config_packed(param, result);
@@ -905,7 +905,7 @@ static int madera_pin_conf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			conf[1] &= ~MADERA_GP1_DIR;
 			break;
 		default:
-			break;
+			return -ENOTSUPP;
 		}
 
 		++configs;
-- 
2.11.0

