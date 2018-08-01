Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C68C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B53820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="KiKS0WIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B53820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbeHAREY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:04:24 -0400
Received: from mail-eopbgr730075.outbound.protection.outlook.com ([40.107.73.75]:62784
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389656AbeHAREY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCPYu6/JS4dQKY7tRxohA7+LD5h0U2GXJW9boTFGuGY=;
 b=KiKS0WIa3bvEBqehZb+X9HZ/EC9NZYkKCts8QXMqlYhgVcpENIWS4+VjgtN9l3x79+J+VJG4qk62y0rAzHFE2vZ0KHsxk7OJyVtiTtJz0GewU/S3DWoUsP5DfRYJuUbOCJHxCc+EMkKW7gt3w4Gh/1oAuOE0E9RPp9Ii4dHKD4A=
Received: from BYAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:a02:a8::20)
 by BLUPR03MB552.namprd03.prod.outlook.com (2a01:111:e400:883::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 15:18:07 +0000
Received: from BL2FFO11FD005.protection.gbl (2a01:111:f400:7c09::191) by
 BYAPR03CA0007.outlook.office365.com (2603:10b6:a02:a8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.14 via Frontend Transport; Wed, 1 Aug 2018 15:18:06 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD005.mail.protection.outlook.com (10.173.161.1) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1017.15
 via Frontend Transport; Wed, 1 Aug 2018 15:18:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w71FI561015489
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Wed, 1 Aug 2018 08:18:05 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Wed, 1 Aug 2018
 11:18:05 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <broonie@kernel.org>, <jic23@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v2 3/6] regmap: Add regmap_pipe_read API
Date:   Wed, 1 Aug 2018 18:17:47 +0300
Message-ID: <1533136667-31828-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(2980300002)(438002)(199004)(189003)(50226002)(7636002)(305945005)(47776003)(77096007)(26005)(186003)(2906002)(476003)(16586007)(6666003)(316002)(246002)(5660300001)(7696005)(336012)(36756003)(14444005)(106002)(8936002)(51416003)(48376002)(478600001)(50466002)(72206003)(4326008)(126002)(106466001)(8676002)(2616005)(44832011)(426003)(486006)(356003)(54906003)(53416004)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB552;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD005;1:M1d54sCzRsRsk2fVszrqpiNo+SVpGZSTHcS3qeTHBo7IaA1zw6eQ6XaHzvj/v/TK06hiWX6t6q4xEHDGOMhztH5+m273CPAwyOajGjp/scpFzLFACHZ+10ee81M4YkTN
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abd53a7-9196-47e9-3a4f-08d5f7c1fb4c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;3:xdm4EbzV7Qy30oKO5WQSTTfKeUGODV5wi7FvwvSmH/EToBg1XTQsdQujgId/E/Fd5ZaxGjv5dzFu/zMpJRC+2/604/zW9sgqYtvLbS3LRqrxHPMal/+2H5WPWHuemrvO7eU1ckOLTJNxpU+lUsMFo9EIVpEFToQ6omOjbVOYo3D4rVJQoBeXifkHpUdPhUtks4Mpu0kBwFtD4A7e67aNGQ3XXxUfIQHzK+XpEVzhLpOhZvpwGsg5E5WqOLVE2kczf+fo/dfq46McNPW9aFbJ48u8IF4ZT71vrPPHeUgTfXyTPM8MY6imJKkXkcCjCLemykX11RfjeBMcjC03KMY8Bej/Um9h3sCjuW+sOJLWCzg=;25:LMgaiiH1RNisz/83MGDSXKPipGHyqUUSqnKb99Fgjy9GZBjOCwIGEqUkykzoC3bskYqqFf4I8xNwzAhTYCTUva0dhXpHEOj/6mKMQ2JcKyBZmvSIRse2M8qpnSaWBo6NCe27NQ5EJ94BXLVTowaXabaxkB9dgDBNn+AgmxbKaq8TqoKdc1AZMtESZuSEw0Jrtj1kl5z98Il0cWpVa1rNq0bvlqWtb6rnAi+jgaAvB+Vrr1ggSfX3qplSNSSIh2MpzJlhV9OuzLODuhwJwXBkqBkoye97P9rCu60GjrL7LSBe3VWD6ijsvNaKHh7V8gVPXJV/jEZdjFgJPM4dy5Gyzw==
X-MS-TrafficTypeDiagnostic: BLUPR03MB552:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;31:i7EKTL2c5t/86vR0aT48IkVREB4wss7KR59fJpGfd89hv/8kgcCH6IZs+sPiEJ1PEwHE81hBdG5XKbjm7cTddV6nvEK6JwicpTE+aeXrVj+vn12smOO5dWNYHb9p5g+As+0ToHabXtxNramo1mt1+D6+guoyTCT2Me3jJVwvyWkZvcXWrDaUYfK6V6iYVMCieT06PybmI9qLdLTqLuXHasSvBwb5XfH+O+HP3XaXZsc=;20:7w+dEgWui15qcCgNhSODtLM2n2L0m/qXlKMYM7dB3sB9eqKxKltbuEzyZtFZ+OaILWj1yrxsLIDVk+V/05cSwWOEtWGLqysmxRalobRKzbkBrIlWYsfrUBYaVaiqqI/BvsmfOY0fAxGgxodEuOsXEzEglIs0ztv9nyJPx7f0cvehZD3qyIXSoI9AkzSYdkrwrbQHFnyjH34mEN+0xt9Snhops78l2Apew5Eg5jIc4Rn6Oh/vRUImqepY2MExVIJ/nlzTV9tb9qELLr9oYIZc14pOnBhDvPMc5VRp8jkb6aYtQ7OGXaukftyrCJ/loX+IWlEzliel//ffEnmoRZU3T5PFCYsbI8RLW7ROTZiu0HfVhG9HK31Sl1Cl4UZkc1S5AEvCqEldJROj+sJTCN4joKiyegEL8KpwJ6rG3MH/GHtirFkFY0D9KVwxISyS0CPSEKMbtlbjK7nc7f7nD9qj9wxyOXXwcAQVyR7rWJMiif2TObHN9/uBdbzV7CRMXJVq
X-Microsoft-Antispam-PRVS: <BLUPR03MB552BF536152EB2B7F976B729D2D0@BLUPR03MB552.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BLUPR03MB552;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;4:O4UCRKO66ICldPD0/fuwXpAt2GdZBA249ziUAIRbQn98SanfnoTwTHMYmENnCZVgX1tStNnoqCny9EzDjiZbXH0bPzs7V3W26Sm6QvFhn/pEV1OtRi9/B2OfFjfWFWSGZc2Zt5mld8szKk2c+wR7QN9OgVzvI1PGBC/67V5XtXGiw9SdcSd0SiHxISmkcQQIjgsjIJlZdM1lgTS/SWMmisRTEAzfHuCjyMkJMNt/7pCCdjppuCE2J0LRh4wzB6vsDl9yUceCNljIK+QyHqsTJMGvQI07/47x4chWpJdfQRaPH7WwO6hxpfsGfyJx12b1UM8jS5mbO7N2bd+jt/WN7jLp66K81SWNJtBVJP6Rscw=
X-Forefront-PRVS: 0751474A44
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB552;23:0wwfgN/jRuQbOR/vQ0GzszsQEqh3f3e4mQYUAZyeej?=
 =?us-ascii?Q?cCynppdxFSmct7IDyev81EJjRzHQyc+R6gNkjeU4e0z2MBy8mNhZj6aJaw32?=
 =?us-ascii?Q?xDzhr73Q2Tx3BeLR8/SPMx2deCzdlIE0xsXUMJbnslaQ5GimQckqxE98jm4K?=
 =?us-ascii?Q?j7LOPp2DMDALutwQLo2JRJK3A6OQre6nktBULJeplNohK3PVIoD0HpGOkSkl?=
 =?us-ascii?Q?z3c6uzxBdrRaNbTeLUyat6tft7klivnZUuITOjGrZb0B3jsm3TnHRawog99d?=
 =?us-ascii?Q?emVBXVWz1/QStoikLALAHXAtuvZ64jlwk8K2A5mpN78wYz7TOaS6U0hIPng0?=
 =?us-ascii?Q?1Rd8olFMOdm2MDvvvI8SRo6YGAoeln8Y6PMJbmVFvzjrsJRFcyy/v0KE0dir?=
 =?us-ascii?Q?tHdc2xohcueJ9rfHSRh2EivfvZ4tGcJCnT9/2HufnchZh1s8OIVLHGV2Y2c+?=
 =?us-ascii?Q?glibzbvUtFj+ycG1rhngoP3Qjxe9ZmyAunGgJKEcQNHgB1GGtKQw4xaMMDz3?=
 =?us-ascii?Q?iOoxVIRqbrF22psVUww+AtiTrfqFAViChGGGNtxXu/44jXDzGHvMcX01kM7P?=
 =?us-ascii?Q?/7izFkedk9FBIHCHY3NLY+bT+WVwqQJzFDXTmt+yE1AzuI9rkG2JBNR0D0F0?=
 =?us-ascii?Q?YWfy+Fk8MlL8h3bkWOpmg//HYN9KfeZvvfqdhNhIrArpRnoVc5rVRC53Zw/6?=
 =?us-ascii?Q?POCq6s5Of+zlxY2F4b/3F4w6aryzRS0OHz84W/gmf6C0cjXn4wE8nC8+vjYU?=
 =?us-ascii?Q?lSzYVPO0XCt5URJy2mImVsiAJ7hzlpfgeTPKKf6qI33faxzzjntqvrdiNbi3?=
 =?us-ascii?Q?ai9X5y6FPxPsiGrDhX6rBgg2b+37OcCwnCdbrFcccEfQ9oVTtqgYMSq/qd6d?=
 =?us-ascii?Q?R+gqB36LpYXXOhgbNDds1Ye6wq6nLpqX5T802vrxJteBqqKw4v+RQHrZcGCT?=
 =?us-ascii?Q?3AWYgFDRjWcTlyUduAkMxlfaYL6xyMF2r/zhpErInFh7uuLUi6OehtZG9y99?=
 =?us-ascii?Q?5m8RhxoZz/GhdowJHBQO/t?=
X-Microsoft-Antispam-Message-Info: Pla9XlXyNf4csZ+eViXtTEqe7LSEJ1VcNqKRW5xx/yoyzavsUKLiCfvU4YGZ+W5xcm7sLJ+1+ngMnSMeX7BsTMzgY92fBS7paX1EkBVp4L1l2sTjN0HKXjA0lPCP5KnAy7NYc5Lb+LaAvEAlEQFmiOlSvrn3ojpSv6/mQ+WDYDai8QGj+G4TRGeIxTBtqUL/hy4U00Up48rS4VvIRIxobXuoFT5aSG7zuzUhc/ZBfQ1G8oscHUaQiwMDN4D+1nkxgdnAohqYoc5bC2nGdujmWc3z3xiQVF1V8hPWEU40fXzde9iq2c3n/korktGuYH4iKOBd02j1qEy5s1o1a8oEVO+Sh5l7Sf0YjkmaiXkNz90=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;6:z4RM2vsMrY0uZEl5RUzvrBZzL0GHe5MRuuAvrMPhbiP7G35WKbSNW41wcuheoHyla+/Oh9kmVs0TXQw+XwXnNim0wKBXv8otktfnhNNn11K3VYxWEL0vt99QETL1/kxZZ33jaSYZ2S23xHDXD4W/TJRBeGGZUhH2Pl3TbxVZyUPZo5ImkIx9BjK8HpFrlQXgBwB3cK1a8srFLXyTE6N03GTOhab6jS4ZhQLdc4Y4bEjA/EVyI93WaI6717uN3G9d8H5qW/RpryxA9GKTlZZb+MkITRR2JBNnp7vhp29NEwQuSpuGURIn6FGnyf24kbdFZ1PZjeYPL/dtv186du/dkaIZwat+tMs+fJFpkaaNHMVgzxZx+S7HdSxkAVQ3mAn3CbBicAT1H4M2qmut6jnyWTqDMjXCNedklZvz8kulmqEdjo6arvsraDmAdoxNBEOFJx3DXDXz5HSxmy49ZFFeFg==;5:T34bqhz2iHfwaBq9kjuCi/1tJfUScdkB1E2VD/BvOZoRFmyQA7Uo2rbSOD2pKuTr2VJflhhr+7WiwrStVhFQgnjvtLgsgWQD/3gxFNAhAPKnoVri5vwUhut2zZHb3Wn1WF3c0VpN/DZHmDjuT9+sFB94RdPgRKiYiOsx5cggH0I=;7:UJAlPKHvDjy6R7TGkWtCrP3BnNkuyBtML8B/RwJ6Z/pt3GYrSIwDvvVvxpAt6vzjIv9vm5i3fMV1qmf7Lrkr9UHqVSuPaO5GBAQX2fh+MS1M+Uas4t2SduCiTBG9Q3iV+pBeZIiKIWxAHjB8HLWltRTyTxyW1puHWB9HS0xiVE5s9SgV9/uIyswlRigd4tFJu7j+Qep9e24ozEeSJe6EiXAZjr8+LZXTU2BnSGBPUFSj9TGYP3Vv/cNi5mtfw+4V
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 15:18:05.8525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abd53a7-9196-47e9-3a4f-08d5f7c1fb4c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crestez Dan Leonard <leonard.crestez@intel.com>

The regmap API usually assumes that bulk read operations will read a
range of registers but some I2C/SPI devices have certain registers for
which a such a read operation will return data from an internal FIFO
instead. Add an explicit API to support bulk read with pipe rather than
range semantics.

Some linux drivers use regmap_bulk_read or regmap_raw_read for such
registers, for example mpu6050 or bmi150 from IIO. This only happens to
work because when caching is disabled a single regmap read op will map
to a single bus read op (as desired). This breaks if caching is enabled and
reg+1 happens to be a cacheable register.

Without regmap support refactoring a driver to enable regmap caching
requires separate I2C and SPI paths. This is exactly what regmap is
supposed to help avoid.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	Included as part of this patch series as the regmap_pipe_read()
	API will be used to read the data from the FIFO.

 drivers/base/regmap/regmap.c | 64 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/regmap.h       |  9 +++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 3bc8488..73bacbd 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2564,7 +2564,69 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 EXPORT_SYMBOL_GPL(regmap_raw_read);
 
 /**
- * regmap_field_read() - Read a value to a single register field
+ * regmap_pipe_read(): Read data from a register with pipe semantics
+ *
+ * @map: Register map to read from
+ * @reg: Register to read from
+ * @val: Pointer to data buffer
+ * @val_len: Length of output buffer in bytes.
+ *
+ * The regmap API usually assumes that bulk bus read operations will read a
+ * range of registers. Some devices have certain registers for which a read
+ * operation read will read from an internal FIFO.
+ *
+ * The target register must be volatile but registers after it can be
+ * completely unrelated cacheable registers.
+ *
+ * This will attempt multiple reads as required to read val_len bytes.
+ *
+ * A value of zero will be returned on success, a negative errno will be
+ * returned in error cases.
+ */
+int regmap_pipe_read(struct regmap *map, unsigned int reg,
+		     void *val, size_t val_len)
+{
+	size_t read_len;
+	int ret;
+
+	if (!map->bus)
+		return -EINVAL;
+	if (!map->bus->read)
+		return -ENOTSUPP;
+	if (val_len % map->format.val_bytes)
+		return -EINVAL;
+	if (!IS_ALIGNED(reg, map->reg_stride))
+		return -EINVAL;
+	if (val_len == 0)
+		return -EINVAL;
+
+	map->lock(map->lock_arg);
+
+	if (!regmap_volatile(map, reg)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	while (val_len) {
+		if (map->max_raw_read && map->max_raw_read < val_len)
+			read_len = map->max_raw_read;
+		else
+			read_len = val_len;
+		ret = _regmap_raw_read(map, reg, val, read_len);
+		if (ret)
+			goto out_unlock;
+		val = ((u8 *)val) + read_len;
+		val_len -= read_len;
+	}
+
+out_unlock:
+	map->unlock(map->lock_arg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_pipe_read);
+
+/**
+ * regmap_field_read(): Read a value to a single register field
  *
  * @field: Register field to read from
  * @val: Pointer to store read value
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4f38068..91c5cb6 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -946,6 +946,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
 int regmap_raw_read(struct regmap *map, unsigned int reg,
 		    void *val, size_t val_len);
+int regmap_pipe_read(struct regmap *map, unsigned int reg,
+		     void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
@@ -1196,6 +1198,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_pipe_read(struct regmap *map, unsigned int reg,
+				   void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_bulk_read(struct regmap *map, unsigned int reg,
 				   void *val, size_t val_count)
 {
-- 
2.7.4

