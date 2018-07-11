Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2093BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF2620875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EjPs9WzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF2620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeGKIB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:01:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46336 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeGKIB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:01:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6B7ruRp019217;
        Wed, 11 Jul 2018 07:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=RUY1f+0uwYpchTsH7lrZCAyAjkveni0kcG0DBDQBjv0=;
 b=EjPs9WzRdHNi8fm5zDp4ohar9H3MVcmBTASSlopOxCzqI0AHObo9dDRgNLg4+04PFo9J
 iyLR9SJS1DU8r+pfqHXiYG6uLscprg/7ptrReUtdcZQriOL0OMqwBnmq5+06HmZFjk94
 erIeuCoiZf6IwVS+dXFsOMA5hczB0MeyTxaA90pHXvBoy0Ydyw/6Dqr9bLMEVRDDfGtx
 KTkQWn/z+nD2wSfWZ51WhCPUlxotaSd/cz0wcPFEgk0aqMzPfXV0E7uoy9gLGM4cxHuX
 OqlJpdMgCZclnSxl59bi2V49IQ7J7OA6X09ivVnTzYqIkjxtG5Hki9v+RF95EsaInMfW 8Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k2p7652rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 07:58:22 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6B7wLMu025915
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 07:58:21 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6B7wLll001129;
        Wed, 11 Jul 2018 07:58:21 GMT
Received: from kili.mountain (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 00:58:20 -0700
Date:   Wed, 11 Jul 2018 10:58:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] power: supply: adp5061: Fix a couple off by ones
Message-ID: <20180711075808.gpa3362vbins7crx@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8950 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=610
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We end up reading one element beyond the end of the adp5061_vmax[] array
here.

Fixes: fe8e81b7e899 ("adp5061: New driver for ADP5061 I2C battery charger")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index c00a02ef7424..939fd3d8fb1a 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -266,8 +266,8 @@ static int adp5061_get_max_voltage(struct adp5061_state *st,
 		return ret;
 
 	regval = ((regval & ADP5061_TERM_SET_VTRM_MSK) >> 2) - 0x0F;
-	if (regval > ARRAY_SIZE(adp5061_vmax))
-		regval = ARRAY_SIZE(adp5061_vmax);
+	if (regval >= ARRAY_SIZE(adp5061_vmax))
+		regval = ARRAY_SIZE(adp5061_vmax) - 1;
 
 	val->intval = adp5061_vmax[regval] * 1000;
 
@@ -344,8 +344,8 @@ static int adp5061_get_const_chg_current(struct adp5061_state *st,
 		return ret;
 
 	regval = ((regval & ADP5061_CHG_CURR_ICHG_MSK) >> 2);
-	if (regval > ARRAY_SIZE(adp5061_const_ichg))
-		regval = ARRAY_SIZE(adp5061_const_ichg);
+	if (regval >= ARRAY_SIZE(adp5061_const_ichg))
+		regval = ARRAY_SIZE(adp5061_const_ichg) - 1;
 
 	val->intval = adp5061_const_ichg[regval] * 1000;
 
