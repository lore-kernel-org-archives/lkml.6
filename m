Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5166C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78425218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="WzAiGXbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfB0IvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:51:10 -0500
Received: from mail-eopbgr750051.outbound.protection.outlook.com ([40.107.75.51]:2560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726894AbfB0IvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+LyOHTTTZg6EACpZSSJFeMpeSfk5Oeddv2giyt5j7Q=;
 b=WzAiGXbJVXJKGRGLTTmjygbtO9LvmOJWr9rKGc3Bmvv47bKcl3XcasLfjNv+hMVK2gjgqCodCldr9UB7GS9HMUxbI+GLm5/Nod8n1oIrvKkLrmTWrNH0Wa4uGIgu4MQSvAhoz1Gkgrm8SHRbNcYLvYk0cMICpoihgD3Q3ve9CJg=
Received: from BN3PR03CA0106.namprd03.prod.outlook.com (2603:10b6:400:4::24)
 by DM6PR03MB3755.namprd03.prod.outlook.com (2603:10b6:5:50::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.18; Wed, 27 Feb
 2019 08:51:05 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN3PR03CA0106.outlook.office365.com
 (2603:10b6:400:4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.15 via Frontend
 Transport; Wed, 27 Feb 2019 08:51:05 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; lab.ntt.co.jp; dkim=none (message not signed)
 header.d=none;lab.ntt.co.jp; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 08:51:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1R8p3AL024091
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Feb 2019 00:51:03 -0800
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 03:51:02 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <axboe@kernel.dk>, <khandual@linux.vnet.ibm.com>,
        <bhole_prashant_q7@lab.ntt.co.jp>, <keescook@chromium.org>,
        <john.fastabend@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] lib/scatterlist: introduce sg_nents_for_dma() helper
Date:   Wed, 27 Feb 2019 10:50:50 +0200
Message-ID: <20190227085050.30000-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(199004)(189003)(14444005)(426003)(336012)(106466001)(126002)(486006)(77096007)(476003)(2616005)(186003)(107886003)(36756003)(50226002)(966005)(47776003)(72206003)(106002)(6666004)(356004)(5660300002)(53416004)(2906002)(26005)(6306002)(478600001)(44832011)(316002)(8936002)(4326008)(54906003)(48376002)(50466002)(7636002)(246002)(8676002)(305945005)(2201001)(1076003)(16586007)(7696005)(110136005)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3755;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1295c6c4-5050-424f-5440-08d69c90b533
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR03MB3755;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3755:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3755;20:cBZfT0NgjobHpYn+xyffZiD/WYYiAqWi7EBPALoEjQPp97bvcI8YtwfcUxcTe9X+bKAXf3hveUQfpL32gU3+6MJQX3auzqoJ5hcW3OGqZ16nslzwN2RolHNb657Wzo9W/ZZiUEXHepsGRWRSZAH10/GTT9SKPzlJAab5PoW5zCriUWqDQAnJVhEjVdGnSSB6xaWiLFrVwdvjgMMPbRtxNtod4iahP5m6D5R4nhpDAfP4M09PTuJtc5ltg0f/44mmn6kkG+0yp9RqNCpdDaL9YjU6+RAAvyFgohwNoG036xUvxpWXjVQ0rjmbhi9Gqpsrs+8jfmqPeF4FnEFHv4UAl7kp0J77a9c1lC+wa22cdo0tobygbDOpHPRUK0HtKbRcJYe/IjKB+fBmJzka20VtbIN2rWZxZvBRVbDiHd2/3UeeH4SflO+zqwpOC61PGQVpFt1zKlBC9Z1DvoKrZmIa5qxqnnVcE4kkuY5V07mlB9Xxu4DmbKMx8lj+EgzI+6x3
X-Microsoft-Antispam-PRVS: <DM6PR03MB3755C112A7A73883CD2EB81895740@DM6PR03MB3755.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR03MB3755;23:zgCVHgA7bPixMgqm6jFmJYME0/dzZu60uzkrt4/dZ?=
 =?us-ascii?Q?FIpPs/SnXW9655qIBeEzC9/Md5W0yPP4m80Lbz6oBI907csV02fs7rZuj339?=
 =?us-ascii?Q?x5RZdv2rUQ/H7MkLnBSvvllb7zoZd9OBjS1vT/YIDQYbZsWfCSLdkUjee3on?=
 =?us-ascii?Q?g3FqSsYA9Wm8jiKyZh5w3LymK2PV/vRphHGLKHVh8yDjEIzCiWryu+KpALMd?=
 =?us-ascii?Q?wYiA92WhgRLEPR7rYr1Qb9MTbGQt1//ZsdqhZK+xFnW5kJ6baGP3s4Os/wE6?=
 =?us-ascii?Q?lcx9Wni1jSgTw61k9UHOHWpsubi/Wga3kR6GN3EvudnusmlXasC/99vqPsus?=
 =?us-ascii?Q?fAxCLRLbmqTmBn0XTizLZBFWUHIXX6dFX73sbCJ9tteGZTbp8MFBkLtkFAs/?=
 =?us-ascii?Q?wZS7a2UBWn9f+BRBpQ//yz4BlvBx1z2E/ZOJ+1PIzOn3JI4aJ8UN0QcEeAam?=
 =?us-ascii?Q?gtMgUqzVkPegFRuJaJduZ5lwVBiDUeBklkQx3DHBlbPyPmx0jBZc9YfWtPef?=
 =?us-ascii?Q?BUs1pgkqs//hWf+BDl5Iwai1jeCX0ldcc6rB1gpEdI4EGyhzhxf18PboRBuV?=
 =?us-ascii?Q?MqumCDO+w+W56RGARd6GKxUiNtonlvGScCtfaOgVbxFEWAvTrS55D/3k+9PO?=
 =?us-ascii?Q?y41tO7U4iqhw0gyqhBvgcj9mYzZRZbTFiw6kty0E6WyBRoOsuXX1TOMNdtgA?=
 =?us-ascii?Q?/tuf0Hc85PDJ/2jriKq41XkOPHs7jXMhbZiAhbcAYsCXiJ79Uh0cLnhBBPQN?=
 =?us-ascii?Q?D+h3Onbaih/YDE16gA1Pm11jZNBT3osIfgwSAUUSYW1LZmrFPZfSxjuVbEkE?=
 =?us-ascii?Q?tBivR+t3Es5ox9+mfo2z/F5pyTd6m0ED7xJFtGkqIGiETlOPgsvNRUbpcddm?=
 =?us-ascii?Q?IJLXa7mbrZsDXfu/kn0mith1ZjR4hWV/TKgW5oMfK2oC5sS4HlcPyoclG/Wm?=
 =?us-ascii?Q?L/zlTHcqpB0HDhhoNrCFycGkU+fHq50Yv9tjF3G2txFYZIWDaR4no6nRMRu3?=
 =?us-ascii?Q?NrFt9mPLQiS02a48VGSHoLlhrQLIm2wt0HWAgNT44xaIDC9IK2wEYJpH5vG0?=
 =?us-ascii?Q?1LJbVJm0TQcVFEbKS4fG4vjxVjTzE9MoZkfb6vZJXOp7yn98A=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZIi7oJcbgdfJyghH/A21m/Ka7hzzYL6NlY4L2OmzNElE3HxgmcCq/0DJLBhm+FTjDqm13xizKpWjTsq2/9n2bzJbggTmCP3RKe5qMaum1tVWqLJPMc0E3Ky93vlsC+xbq3aq880X0XihVcl3FNQ6O8rx/OMd1cdGT4izZPvkLoQDystfZpQEg3iW4V0iXdIhI99/K2u0Xl83PalNWC5FQZvKb9fMsWQTlONVe/sW6oyTU1lLhsd3EoBtjvqfWJFqixpuw6l0sG5kxdPet14hS5f3o1mGznQjzUx2aA1IIBIb6kstxWXpWyCLShkvK4FEYlgzHHvUx6dP18UaRHsGnson/JUrDG836CfeaHBzAfuTGnEO2M3h+Cb15/43msqEo+IRcJPVqd875tvfuqaaWu7mJFSx+QR3GCxXxZRQAdo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 08:51:04.5127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1295c6c4-5050-424f-5440-08d69c90b533
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andy.shevchenko@gmail.com>

Sometimes the user needs to split each entry on the mapped scatter list
due to DMA length constrains. This helper returns a number of entities
assuming that each of them is not bigger than supplied maximum length.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Patch was sent in 2016 initially to the DMA engine sub-system.
Link:
  https://patchwork.kernel.org/patch/9389821/
This was part of a larger series:
  https://patchwork.kernel.org/project/linux-dmaengine/list/?q=sg_nents_for_dma&archive=both&series=&submitter=&delegate=&state=*

I'm not sure if this is supposed to go into DMAEngine or lib/scatterlist.
It doesn't look like lib/scatterlist is managed by DMAEngine, so (by using
the `get_maintainers.pl` script) I'm sending this patch to this group of
parties.

Thanks
Alex

 include/linux/scatterlist.h |  1 +
 lib/scatterlist.c           | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index b96f0d0b5b8f..4f40455c40e2 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -253,6 +253,7 @@ static inline void sg_init_marker(struct scatterlist *sgl,
 
 int sg_nents(struct scatterlist *sg);
 int sg_nents_for_len(struct scatterlist *sg, u64 len);
+int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len);
 struct scatterlist *sg_next(struct scatterlist *);
 struct scatterlist *sg_last(struct scatterlist *s, unsigned int);
 void sg_init_table(struct scatterlist *, unsigned int);
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 9ba349e775ef..5a6fc32f485d 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -86,6 +86,32 @@ int sg_nents_for_len(struct scatterlist *sg, u64 len)
 }
 EXPORT_SYMBOL(sg_nents_for_len);
 
+/**
+ * sg_nents_for_dma - return count of DMA-capable entries in scatterlist
+ * @sgl:	The scatterlist
+ * @sglen:	The current number of entries
+ * @len:	The maximum length of DMA-capable block
+ *
+ * Description:
+ *   Determines the number of entries in @sgl which would be permitted in
+ *   DMA-capable transfer if list had been split accordingly, taking into
+ *   account chaining as well.
+ *
+ * Returns:
+ *   the number of sgl entries needed
+ *
+ **/
+int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len)
+{
+	struct scatterlist *sg;
+	int i, nents = 0;
+
+	for_each_sg(sgl, sg, sglen, i)
+		nents += DIV_ROUND_UP(sg_dma_len(sg), len);
+	return nents;
+}
+EXPORT_SYMBOL(sg_nents_for_dma);
+
 /**
  * sg_last - return the last scatterlist entry in a list
  * @sgl:	First entry in the scatterlist
-- 
2.17.1

