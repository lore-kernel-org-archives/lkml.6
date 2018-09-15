Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C4DECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F0B21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="guGMTRLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F0B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeIOGs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:56 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728895AbeIOGsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msQwjAqgVud6RzmQpyjMTmMOhiuReqAWiBcIvhQD5jw=;
 b=guGMTRLyvBi1ya2hRN9KQiUxGCnMx09Qewd5xmsjQ9GRjp3ObZBUfYAVFpdpQlg8qvs6ZGzNlQ47kwV2cmtQaUCrgxOO8mnNpUZHZgKKEKv5vtuIgQ1cpiLzXDTtfVGrPQvVl7LKecO5SGtEkwSXYLqtZUEc4rTT+FFa21/+yiI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 80/92] dmaengine: hsu: Support
 dmaengine_terminate_sync()
Thread-Topic: [PATCH AUTOSEL 4.18 80/92] dmaengine: hsu: Support
 dmaengine_terminate_sync()
Thread-Index: AQHUTJO6JyXJvw7MkU25PmVBq+jh8g==
Date:   Sat, 15 Sep 2018 01:30:46 +0000
Message-ID: <20180915012944.179481-79-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:n9Qg1MTEZ5xYK+QN63zMdeEnI8CPfdxHOUFi/On0oY7hzG9amjSEqSlrI6k8ZSHMuR8WaYH7q/WKSbCzfJPUIi5ZWo7YiUzxCTVbvo0VHA3Ji+54Pq9aYkeVEh0f46kSSLGzsnCREQK2C9W49cY/jRrtaKwNLgDdv7Xy5CTWGCso3wPlCqQ0zTYr44UFRfJCU93wqbDedfiu5F3rO4ORP7w5V9Yb3ojBCRcetKiPi8zRWYw0ZcJZI+HuMlvvCOzWCnnh1QmtLAHjshBtLJ5QK3/5GM/dRBbZqahQWqW3cy+0faSixhJMrJnKminw2odRNLh9sjEf80vZ6FbpZMHV0YW1AnXibpifbJll0j48voHkI75/0c0mTVpykJKd6MFf0HVAtFahjcs9ZCurWE7YFrOXoT/+ikC5v8xXkZC8Tt0lols9Bi54nHBtV4L3rJxXtv5XkC7IMTJOhRP3GmMKhQ==;5:w4hSCHMYDQFRiqe1bj5L5D7htd4jZO+sgdr2EgfRFEAo9tWNi/SCJQXEg5jZ67hY9JCbxxOI8dgptFUBJ3fD1EVP76l++6F0bqr2/5j67HxZbNJWCMzI79XHIDPfBCrSBIy3qXS6fpSnbxve1t92IrQX+QKFZmrPnXPQK4ytNQA=;7:0HC9Ps2rmPzYlqhGToMUMuw34ws1oeka7cRG9xz/oO1nPMINkXdrFcln+DDwDDkoc+wlfCb/IySyyubQYFwtgNSJP9om302RWSGCKZkgCCTJXuZbOgt4/44evke/h1eTjGV7Y5bu0gYQhEspehFpzl7RXrJMzf7uBnWTurV+193yRcz2LleSu9kUJqB0fX9D7m8Xlv28EXw6XxhMqVgW7VPM8ZpyVk65YpaVSc6BjcuRswqQ/guTApjjfrB93F+f
x-ms-office365-filtering-correlation-id: 0c9d99b6-a4db-49a0-4509-08d61aaafb7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB04708EBE00D01CB3206BAF9CFB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HvgW/Sepr6yBt2+K8fBGt/Hr6kriB9wyfJa4QS2zDumcnYijVM16/NGDGxKnOtZNI7XSVunHOpwBQqR3sWqGY9uGkQZ4AUDmOcRZWVSn3J+bAd69jle3dfe+AePC15d+fH43zo6VKa2PCklPnFLbg11XP1hdCqQgNLSgrq19j1rynAkyvjz/qNwgN76FMFqwxPrydXLIW3NhbAmMzp3yPNvrwiPslSSLw5Dc5kSLfnlJAZwXmH4TXdUGUXOG1s5X1e8uzZ8u4ubhb/os8RqPstsBdHmu5hzkWb5/c7Z+h5U3pbaXQXQ7Ooq9w+xjJVyAdPL/ZtW5zG0fE2La03cZflWrUbX24stCfu4dd09Dlxg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9d99b6-a4db-49a0-4509-08d61aaafb7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:46.9011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
