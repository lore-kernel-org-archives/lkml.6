Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9621DECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4568A21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BSBkchxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4568A21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeIOGue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:34 -0400
Received: from mail-eopbgr730120.outbound.protection.outlook.com ([40.107.73.120]:32793
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729449AbeIOGud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msQwjAqgVud6RzmQpyjMTmMOhiuReqAWiBcIvhQD5jw=;
 b=BSBkchxzwKtILZzYKFzykNyJhTk6iNlbfCK/fnPL0AQE2cS/wva0n5qqOBQED6cHSfqQzWOCYsMP2Ow3O88hgEf1skPGEAwSYz7ff/+amZ4jykVm/hrwT4W7t9AEJoaIrTVw8siATzhYRD+xXdISsoUefAB/frppbpKzxH8lObM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 49/57] dmaengine: hsu: Support
 dmaengine_terminate_sync()
Thread-Topic: [PATCH AUTOSEL 4.14 49/57] dmaengine: hsu: Support
 dmaengine_terminate_sync()
Thread-Index: AQHUTJQJfFE8mzDWBUqEbVYcMYsAzA==
Date:   Sat, 15 Sep 2018 01:33:00 +0000
Message-ID: <20180915013223.179909-49-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:JIhUA5OLmRDVi8pxPQ5SfvloZlN9q9TicyOV+O7CyFkJlS+dm5JC6eCzwWYQIJVemb74xNTCg/hO8QgKEoVr/zjiE9K6uBdWyDJXCKR34HfFF8c+f39fRN9tRJWOZ/Gcbo1VYFnVWKzS+cXVtcRD7Le+AlbP2XBAw/VgrG0RrLScJlrgR/qV0Wv9FMFkxnfNN2koZ3BIt2PU6neF0SYzBhUfLcjOqfQX9AxLGbhQ/V7ki6bU63kFlsGCAKeQ/Ff6EYCKWovAPt+GBWsYzLzYMoKfZHIEExlXYlIU7K5JIOJCQrBPvrt1GzmwKUHx41MswoPr8KFnebGfACa1zwk+ImONtM6TZXaecTi0eJu8qbfkwC5tsOXEoISFb5wxC9gubNpaDPk1oFVMfK9GoNXm48FdpLdWv4h0XJCCMnjTgBZsNfGmmR+QBjAksDpt1L2SVXgbZ4XvijSvCfUqMG2bXA==;5:iuDVwthN3HDw6E3yqGkeDpGb19UkHbtv1+iBSXKXg6m8sagRxiNwmlzgDSc618jr6jsFFGjSYYlMKcpzTgCV9n8H0AZokPqe/ERC4XlUubg90MZPh4v0hRV66abAZVavxoVkT9RllEt0NYifVHCT5JNjV42+GtnkB3hRiRZ3cEo=;7:6lgh8gc4lIiEflJE+sqcMBamVv/gNVoObT1I6FmQD1weHSonagQGGY44RPQ50Xx+TCf0es/kZo/a/rLwh5yJIgHcs5+GhwM1Bj67O7uWAw4L0cBs1Q+kTKeLZ5qIEJeo4epVhG3Ci+hKF8eJ6TbFYRTkUJsXytXurQH4UQlGGthnAp10fgSihytbL3DCMVdu1oXDfqggM5PfV1TacWfbsAAE3kEhQgho0eLOkmCHaZqBK0ec08zf54FgFFF2ahsm
x-ms-office365-filtering-correlation-id: aeca829d-37ee-4489-1afd-08d61aab3b2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471172A6457E52FDE5DDAFBFB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: xSOQjqkh9o1KDOfLfTKelc3wuC29hAhC0njqPIkFamy5GYKPFrleyhZNb9FjTRPLA/78/DryV3pJ0VTFduYQjFf0edMB3WSchc0Y2q9dC9Be9UV5aVAljZjY+QW8JBVOTTTTjjLg+KQZ9LDMxVtKVA4xQBEjpWnV8SqJSFH8w3YPV74rpPcj8dE2mIA8sGAEBWfsJE81M6zAQc8qV2rpNPCiJsyVzn34QfxqOoxGdxOq95MTSdIqtobCzPDcF96Q2t99WvO+KAfIa7L/2vvg11DjSxRdUZ3GmpLrlpWd5VtAQfOhCnbd9M5/SZ5IKdJSZPW5M4Qy955VTcnGcCWmrd+skJ9A+WH9xh+XGgxIUEw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeca829d-37ee-4489-1afd-08d61aab3b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:33:00.0239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 2abc66cd499aa16876e45c6438788902f7d1ce22 ]

It appears that the driver misses the support of dmaengine_terminate_sync()=
.
Since many of callers expects this behaviour implement the new
device_synchronize() callback to allow proper synchronization when stopping
a channel.

Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization s=
upport")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/hsu/hsu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index 29d04ca71d52..202ffa9f7611 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -413,6 +413,13 @@ static void hsu_dma_free_chan_resources(struct dma_cha=
n *chan)
 	vchan_free_chan_resources(to_virt_chan(chan));
 }
=20
+static void hsu_dma_synchronize(struct dma_chan *chan)
+{
+	struct hsu_dma_chan *hsuc =3D to_hsu_dma_chan(chan);
+
+	vchan_synchronize(&hsuc->vchan);
+}
+
 int hsu_dma_probe(struct hsu_dma_chip *chip)
 {
 	struct hsu_dma *hsu;
@@ -459,6 +466,7 @@ int hsu_dma_probe(struct hsu_dma_chip *chip)
 	hsu->dma.device_pause =3D hsu_dma_pause;
 	hsu->dma.device_resume =3D hsu_dma_resume;
 	hsu->dma.device_terminate_all =3D hsu_dma_terminate_all;
+	hsu->dma.device_synchronize =3D hsu_dma_synchronize;
=20
 	hsu->dma.src_addr_widths =3D HSU_DMA_BUSWIDTHS;
 	hsu->dma.dst_addr_widths =3D HSU_DMA_BUSWIDTHS;
--=20
2.17.1
