Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F34C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B6320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FWu755Up";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rmlwPu03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfBVUM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:12:56 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58730 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbfBVUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:12:55 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MK3dgI018272;
        Fri, 22 Feb 2019 12:12:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=proofpoint;
 bh=5A9X9+yb8ElteRaR0WL5jzjgqB508eNOU8Lyh+ir/pQ=;
 b=FWu755UpLiTVJApRMpSGzKD7cOTFqR1PFbmUXJpDnu7tDVBioIJRzRsi8zp5pJzOWSnm
 tooDmn7B9bfPfaihybis6hSjGZQ6ATm6iCnqHpCQCZ9Vlwcriu5ZbltH1vjvqnoHQyEI
 nS1SyMc5zYlpQXkyUTU4yKyq6+5V0AKC76QrG29aTAIxOd8EibdPtqv0UOv9F2BgyEz5
 Z8J9W3ecokWZ2KV66O7rNagWlGoSTAuKJn4VDXqTgoYgFjOExW8nfWkEBAiiLq02jYHB
 jLc9B5Re8Am0B29d9xfak1+koXaGC0ds7VaFRZ5xu9lynI0NWCrD9dBDalvurTTTpjw3 hw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2056.outbound.protection.outlook.com [104.47.41.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qspmmrb4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 12:12:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A9X9+yb8ElteRaR0WL5jzjgqB508eNOU8Lyh+ir/pQ=;
 b=rmlwPu03ZA0W0aG8CG+2ljuGZOfjJjZhSS7qQye0DxEyHhMh+3NU37ITaAk6cXXWJKuXzEJjsXTtBTib7oB4rapIHc5/Z34AWF9azLH0SDRBtKiPISPWUgM9lWeCdHx9ofT5GTDTPQ8DOaZIgANI4b5p4nPMmo2Ld2UXWg9+Jj0=
Received: from DM5PR07CA0081.namprd07.prod.outlook.com (2603:10b6:4:ad::46) by
 CY1PR07MB2248.namprd07.prod.outlook.com (2a01:111:e400:5a10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.18; Fri, 22 Feb
 2019 20:12:46 +0000
Received: from BY2NAM05FT049.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::208) by DM5PR07CA0081.outlook.office365.com
 (2603:10b6:4:ad::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Fri, 22 Feb 2019 20:12:46 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT049.mail.protection.outlook.com (10.152.100.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.5 via Frontend Transport; Fri, 22 Feb 2019 20:12:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x1MKChgM005227
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Feb 2019 12:12:45 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 22 Feb 2019 21:12:42 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 22 Feb 2019 21:12:42 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1MKCgXA023091;
        Fri, 22 Feb 2019 20:12:42 GMT
Received: (from pthombar@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1MKCgqC023080;
        Fri, 22 Feb 2019 20:12:42 GMT
Date:   Fri, 22 Feb 2019 20:12:42 +0000
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>, <linux-kernel@vger.kernel.org>,
        <rafalc@cadence.com>, <piotrs@cadence.com>, <jank@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH 2/3] net: ethernet: add c45 PHY support in MDIO read/write
 functions.
Message-ID: <20190222201242.GA20889@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39850400004)(2980300002)(199004)(189003)(36092001)(106466001)(7636002)(8936002)(305945005)(8676002)(105596002)(246002)(1076003)(5660300002)(356004)(86362001)(2201001)(47776003)(186003)(26826003)(478600001)(426003)(33656002)(23726003)(87636003)(97756001)(46406003)(42186006)(486006)(336012)(476003)(126002)(50466002)(16586007)(26005)(58126008)(110136005)(2906002)(316002)(18370500001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2248;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ecb45c6-9d6c-4eb3-af63-08d699021c1d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY1PR07MB2248;
X-MS-TrafficTypeDiagnostic: CY1PR07MB2248:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2248;20:0MI0Og23tmla/XA3M1FRIMzJulbvvY3N3pQehqDTVlKIQsqQoFgHsf83E+uCUhi8sMicjIIsjOB8eamyRA3yVQOHS+JKp2NDe0yusJL74cvyEpwdA+xTIX1hBb4tDhOLHpHfqvyDOidGcCmr+Y+WkCPA7O0SbmIMFlATPqcQtLKMuE3epgyTxl6rLPeowSaGYlE3gDJAijqG/C56MlWFBmGsNXOETCe3HVzcHL8RNeZuNobFl7TRU9k5BuOnXc4avZ/vhfLUOQPRUe2pDDiB5cYH9ufKmpKVWX0bPKtRxMExLakx05VFIqu3GwlkCQIeZxE0U1cW7sTmWSUlJr6R1Qd7KBVyZBXulFxk0bjBZLv/sGtk7vTrQI08kf3S4MFthmAxCMZc1EzMUBK4IgQTFhK/5O0y0F9YiYbteJCfQoCOT7eqiYJT9TN/bxpOC63UCRToFzCeySVyJuhVeQ1Ypt+vcskDlUCTD+hxJFGU/am78tshnYHYczN8mFAPFzTt
X-Microsoft-Antispam-PRVS: <CY1PR07MB22485D900E581AE36AA23F81C17F0@CY1PR07MB2248.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09565527D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2248;23:mIgmtvycF3XJbMV4C6wRd1VWCZrPtgX5/+dIfhkRZ?=
 =?us-ascii?Q?R924K8jdEf/JJGNb9jrspTn69tYZO57wlww3OcggQTXXbk7eqZykf1FR83tD?=
 =?us-ascii?Q?9Z305GUaw5PAGDo0ZvTVtbgbc/VbOKFHsd7oaNS6LefbmTuViAOEsMNWumg5?=
 =?us-ascii?Q?WBrmSdglU08m8I8LUvYabjPOR+voax8mHhTGbAMC6lbAdWL3ysEohsl+/ZqI?=
 =?us-ascii?Q?UNVIKwWX540Mw4t5Cutyi7QGn7M8TfCU5s+ChI+Dav0VY9dBI3fm35gBHVSw?=
 =?us-ascii?Q?/rQq9vaql0occ4U8xhpjuphkLgqg1bZ00I9eSx3zcBYV5TixtPTNrdcu4eHt?=
 =?us-ascii?Q?IUP9SJ58BLRuXZRPM7Qa9OuxW++sA4e4yQ5OS2IZ+08lOsIuwIrnVjAuEKxT?=
 =?us-ascii?Q?CYfurMZ2EfdUdUjwz8ueOVBjKCk68NKdMuRRC+FQHgmujeWdez9gsGMVJq+A?=
 =?us-ascii?Q?UiD1ogFvHmzBowm8U6kRA00Y6SkCQjsbcYfiNSVrQ7+Qlh3Q7fwgCCTSgZsZ?=
 =?us-ascii?Q?VmzdH0rPSyz3+q+XNIGkvLi6meJcRuPNBW0vOvh2wyfyxE7cnDVXq6IWm13r?=
 =?us-ascii?Q?SHf06cJ3cpp8X93M4D5b1ttA0ufOFU+3rL5LIoXDF/9R/zIM18Uco6scpcdf?=
 =?us-ascii?Q?EvGWS04/HEYw0WZLtzSjF6NWRWgloovrtOz1aSbEEOfx2g1rmYHatOcyAYx2?=
 =?us-ascii?Q?EOC7lUUKGfKHRUomDvU8LcdR2mrro95J0XLWEAK5HkVPZs4lqTs99KahfEJt?=
 =?us-ascii?Q?ogpgBwMc9lGS65KFPG0PAezdccFT/JiAjlYi2VBNO3OSQEteEHPox5G1kk2m?=
 =?us-ascii?Q?jPTPHBOb6cc810Anw9HDxGWnYK/r72rrxUb8uX45NgTFXMVdL00LiEbb4v6a?=
 =?us-ascii?Q?yxAny+c4QifVjvplMLsWxzU72aFYg9RWJu7reFd2XtHLwbAmUrhfftWcvdIw?=
 =?us-ascii?Q?2UksgFQL/Gh23EnpJLUSzKHC7yw5oQETgECHJ+vwphtq2I2ndHmz4Yf1NVgG?=
 =?us-ascii?Q?zFZ1ZLHTEnBKJZjEdbhdHwAJ+TUhMaahYi6PdN4duRZ3g=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: aRA85flw5X7pwnXBQZz3YDGSFMucFkdagRvKnpAJF1WwlCIaDpt9a+eoGyXVBozppraDfOadQJE7xmZKR41Pmdgo9Axs1JNtAQl5W+XlAACGglHnKW2rrW9uiDKoLphcsdL4s+aqNkO/RbVueXPrVZ5jY9BV2Q3LTO4dsYeg3eYZmUOM9cdjZqZQWYTOSo2d0etIfU16D6/JUy4p72k5kidfVU8rVo0e4JmO0O5j3I0xAztf1lBVUyCKirQtsrY1pfpgGX68JSxlsbGtnN8OYj0YpLVhX/T4AFIv51dHVFadmSw7mxLeV9b7bjWCXFZr3P5Lg1hNzYcAmpewBqsl3SJ9rqJ4/J0nGFmPlu/ElYMuONxmtd7vRBFaCeTicj7LCcR4fOIfCpWu2H5VF+5jioemNEgMzIUA/uqrqR7f9FY=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2248;20:ftmO2NUjEY2Be0ZuizSQfLEZ5rNJT/IPBn0vu6c6X9lIDNu/3fTXtAKuEoVuvBhoyTysh5rO+Wmdrip04UVb4AuHtr/avJWq1KmaTUWRINg5VusTvLlFxiOKw4OPXxtADRSrrluM+0a99azhS17uSpR6kiGc0epK5U3lTKBVxxQXC45xUWm3kdKc5/TUN/AaeBZtT0vC/gPKNeMQxH7XCbwtl5G6uAqWQxU8+NfY8rs4JkJzyOMjeTFuHFF12zo+
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2019 20:12:45.9585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecb45c6-9d6c-4eb3-af63-08d699021c1d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2248
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modify MDIO read/write functions to support
communication with C45 PHY in Cadence ethernet controller driver.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/net/ethernet/cadence/macb.h      |   15 +++++--
 drivers/net/ethernet/cadence/macb_main.c |   61 ++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index bed4ded..59c23e0 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -636,10 +636,17 @@
 #define GEM_CLK_DIV96				5
 
 /* Constants for MAN register */
-#define MACB_MAN_SOF				1
-#define MACB_MAN_WRITE				1
-#define MACB_MAN_READ				2
-#define MACB_MAN_CODE				2
+#define MACB_MAN_C22_SOF                        1
+#define MACB_MAN_C22_WRITE                      1
+#define MACB_MAN_C22_READ                       2
+#define MACB_MAN_C22_CODE                       2
+
+#define MACB_MAN_C45_SOF                        0
+#define MACB_MAN_C45_ADDR                       0
+#define MACB_MAN_C45_WRITE                      1
+#define MACB_MAN_C45_POST_READ_INCR             2
+#define MACB_MAN_C45_READ                       3
+#define MACB_MAN_C45_CODE                       2
 
 /* Capability mask bits */
 #define MACB_CAPS_ISR_CLEAR_ON_WRITE		0x00000001
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 4f4f8e5..2494abf 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -323,11 +323,30 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 	struct macb *bp = bus->priv;
 	int value;
 
-	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
-			      | MACB_BF(RW, MACB_MAN_READ)
-			      | MACB_BF(PHYA, mii_id)
-			      | MACB_BF(REGA, regnum)
-			      | MACB_BF(CODE, MACB_MAN_CODE)));
+	if (regnum & MII_ADDR_C45) {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+				| MACB_BF(RW, MACB_MAN_C45_ADDR)
+				| MACB_BF(PHYA, mii_id)
+				| MACB_BF(REGA, (regnum >> 16) & 0x1F)
+				| MACB_BF(DATA, regnum & 0xFFFF)
+				| MACB_BF(CODE, MACB_MAN_C45_CODE)));
+
+	/* wait for end of transfer */
+	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+		cpu_relax();
+
+	 macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+			| MACB_BF(RW, MACB_MAN_C45_READ)
+			| MACB_BF(PHYA, mii_id)
+			| MACB_BF(REGA, (regnum >> 16) & 0x1F)
+			| MACB_BF(CODE, MACB_MAN_C45_CODE)));
+	} else {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
+				| MACB_BF(RW, MACB_MAN_C22_READ)
+				| MACB_BF(PHYA, mii_id)
+				| MACB_BF(REGA, regnum)
+				| MACB_BF(CODE, MACB_MAN_C22_CODE)));
+	}
 
 	/* wait for end of transfer */
 	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
@@ -343,12 +362,32 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 {
 	struct macb *bp = bus->priv;
 
-	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
-			      | MACB_BF(RW, MACB_MAN_WRITE)
-			      | MACB_BF(PHYA, mii_id)
-			      | MACB_BF(REGA, regnum)
-			      | MACB_BF(CODE, MACB_MAN_CODE)
-			      | MACB_BF(DATA, value)));
+	if (regnum & MII_ADDR_C45) {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+				| MACB_BF(RW, MACB_MAN_C45_ADDR)
+				| MACB_BF(PHYA, mii_id)
+				| MACB_BF(REGA, (regnum >> 16) & 0x1F)
+				| MACB_BF(DATA, regnum & 0xFFFF)
+				| MACB_BF(CODE, MACB_MAN_C45_CODE)));
+
+		/* wait for end of transfer */
+		while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+			cpu_relax();
+
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
+				| MACB_BF(RW, MACB_MAN_C45_WRITE)
+				| MACB_BF(PHYA, mii_id)
+				| MACB_BF(REGA, (regnum >> 16) & 0x1F)
+				| MACB_BF(CODE, MACB_MAN_C45_CODE)
+				| MACB_BF(DATA, value))); //Data
+	} else {
+		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
+				| MACB_BF(RW, MACB_MAN_C22_WRITE)
+				| MACB_BF(PHYA, mii_id)
+				| MACB_BF(REGA, regnum)
+				| MACB_BF(CODE, MACB_MAN_C22_CODE)
+				| MACB_BF(DATA, value)));
+	}
 
 	/* wait for end of transfer */
 	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
-- 
1.7.1

