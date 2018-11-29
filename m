Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A5BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96162081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96162081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeK2VdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:33:25 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60820 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726823AbeK2VdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:33:25 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wATAOWFh017069;
        Thu, 29 Nov 2018 04:28:30 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2p2724rx8v-1;
        Thu, 29 Nov 2018 04:28:30 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 4AAD9611C8B7;
        Thu, 29 Nov 2018 04:32:01 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 10:28:29 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wATASLba028814; Thu,
 29 Nov 2018 10:28:21 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/2] regulator: Factor out location of init data OF node
Date:   Thu, 29 Nov 2018 10:28:20 +0000
Message-ID: <20181129102821.18396-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181129102821.18396-1-ckeepax@opensource.cirrus.com>
References: <20181129102821.18396-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811290091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support future additions factor out the location of the OF node
containing the init data for the regulator from the code that parses the
init data.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/regulator/of_regulator.c | 64 +++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c711a0a2bc4b..4bb8928bdb3f 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -371,13 +371,10 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(of_regulator_match);
 
-struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
-					    const struct regulator_desc *desc,
-					    struct regulator_config *config,
-					    struct device_node **node)
+struct device_node *regulator_of_get_init_node(struct device *dev,
+					       const struct regulator_desc *desc)
 {
 	struct device_node *search, *child;
-	struct regulator_init_data *init_data = NULL;
 	const char *name;
 
 	if (!dev->of_node || !desc->of_match)
@@ -400,35 +397,48 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 		if (!name)
 			name = child->name;
 
-		if (strcmp(desc->of_match, name))
-			continue;
+		if (!strcmp(desc->of_match, name))
+			return of_node_get(child);
+	}
 
-		init_data = of_get_regulator_init_data(dev, child, desc);
-		if (!init_data) {
-			dev_err(dev,
-				"failed to parse DT for regulator %pOFn\n",
-				child);
-			break;
-		}
+	of_node_put(search);
 
-		if (desc->of_parse_cb) {
-			if (desc->of_parse_cb(child, desc, config)) {
-				dev_err(dev,
-					"driver callback failed to parse DT for regulator %pOFn\n",
-					child);
-				init_data = NULL;
-				break;
-			}
-		}
+	return NULL;
+}
 
-		of_node_get(child);
-		*node = child;
-		break;
+struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
+					    const struct regulator_desc *desc,
+					    struct regulator_config *config,
+					    struct device_node **node)
+{
+	struct device_node *child;
+	struct regulator_init_data *init_data = NULL;
+
+	child = regulator_of_get_init_node(dev, desc);
+	if (!child)
+		return NULL;
+
+	init_data = of_get_regulator_init_data(dev, child, desc);
+	if (!init_data) {
+		dev_err(dev, "failed to parse DT for regulator %pOFn\n", child);
+		goto error;
 	}
 
-	of_node_put(search);
+	if (desc->of_parse_cb && desc->of_parse_cb(child, desc, config)) {
+		dev_err(dev,
+			"driver callback failed to parse DT for regulator %pOFn\n",
+			child);
+		goto error;
+	}
+
+	*node = child;
 
 	return init_data;
+
+error:
+	of_node_put(child);
+
+	return NULL;
 }
 
 static int of_node_match(struct device *dev, const void *data)
-- 
2.11.0

