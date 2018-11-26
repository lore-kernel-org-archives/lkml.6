Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856B3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC520855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zyZF/Ak7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACC520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeKZTFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:05:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50710 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeKZTFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:05:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQ83W6g104246;
        Mon, 26 Nov 2018 08:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=vM/1hQRoO5Z020g/GDy93mEgVgeFOp0b1vwWdsJHoMM=;
 b=zyZF/Ak7spiT5SEmThyI1OfS+YtzgsWTmjpuvXLZhI8CtwtAouHHWwFuSPD2CI7PaISH
 ZvvmD3TY2BqE1wlOa9+mZWT03xCPiA0xKONOUbRptZZy29YSjXutOsRwxoZIoH3v3L0p
 8OzZTD7DRxP2MJfq74iokpsyFYrpqtcb1OhawarNNDBlzX6nuzSZWBZvUmoYIIVgVA1B
 LdHo2Xejz1QRkLLIWx93/2ELbbG0mLNTBE7YMu6CjOSDas2w9r7CFhNcGk6Z2sr4TZ8Q
 tm/DI9cYHf9+OS6Lw8n8Y8w4Uy07LnfWkoITq8SfVJ9dw0oKdm8HRUhmWoa9H5WAYZSP IA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nxx2tv5mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 08:11:25 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAQ8BOlF015006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 08:11:24 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAQ8BNXP004295;
        Mon, 26 Nov 2018 08:11:23 GMT
Received: from kili.mountain (/41.202.241.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 00:11:22 -0800
Date:   Mon, 26 Nov 2018 11:11:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] fsi: occ: fix a NULL vs IS_ERR() check
Message-ID: <20181126081115.hmsplacwvcdvpvxn@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9088 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=911
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_device_register_full() function doesn't return NULL, it
returns error pointers.

Fixes: 4e01f5644463 ("fsi: Add On-Chip Controller (OCC) driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/fsi/fsi-occ.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index a2301cea1cbb..d8695f67622f 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -546,7 +546,7 @@ static int occ_probe(struct platform_device *pdev)
 
 	hwmon_dev_info.id = occ->idx;
 	hwmon_dev = platform_device_register_full(&hwmon_dev_info);
-	if (!hwmon_dev)
+	if (IS_ERR(hwmon_dev))
 		dev_warn(dev, "failed to create hwmon device\n");
 
 	return 0;
-- 
2.11.0

