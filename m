Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF22CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E4F214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LvNMcIKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E4F214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbeIXU4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:56:19 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731838AbeIXUyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WHDs3ItwkZKXxFmRZ7o2zMo8phPWJYW8ZR8gn6/P90=;
 b=LvNMcIKvVb7r96MmzvfQXVcqMayGP4ePXJ0T3WvCwPAcddbBybzfR6pYj4ISA5sovDjWvL5FhT01KcjQRtjLKbD8Xxf1MnhKGwYrwOTCUyUDtFjr2+0mcTZ4co0CNFi67J+Qodt82JFflPYIfQDHKDbtB87BQO4nKy7uMY8Lv5Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 11/18] net: cadence: Fix a sleep-in-atomic-context
 bug in macb_halt_tx()
Thread-Topic: [PATCH AUTOSEL 4.4 11/18] net: cadence: Fix a
 sleep-in-atomic-context bug in macb_halt_tx()
Thread-Index: AQHUVBXYidXq6nuFR0SyxDpAeOPmYg==
Date:   Mon, 24 Sep 2018 14:49:51 +0000
Message-ID: <20180924144942.164688-11-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:JaCGR+1mnQLKbafyFXA6nk5OzdkPOhlLzwKss/QzM22phsn+GlSt2yEWAz7i8FY0GgIodz/YETnrFX0voGQeKN0NLrNIfKCOQKgKqrDMcFxfTA//wgiNIDNC5b1RQyGkLJTswHwY1Gjv23sNpxztYRwtGF6QaMBA8LdgETe22zWAO+8EtO66DWIpwAl7WbyZ5wy09GeQBG9xUfIw57AE7wzc624syAmkAbYFvyvKJai1IR3Os/PZtPFmpN3ju+RoEq8MPICNzTII1G6XPsJFJ25GL8WMl/DQZr0nKX6AGseSDN1yuKJ5bB/Eptvi0xR2E/RFLd1nd22ACpZo3TrjLxVAzcjXI/CgJ3ug0N8esPe5sEvWF1aYzXF3qPoYYWxRppbvup4ZfpuyNd0PYtdvXlPYP4vSOZgYaX8zvx9vwyEBuMAp7FwMzoXbLBosrZE9pZKbjp34N5PepDgfGU+9xA==;5:D4Gg4AWAfVm42HWw0sh6VxB7soHS+w+xoSeks2VNMK3FAzj7Ht66v66TxByYmI3E82zr/zuV626/xcGr36zaJzEdM2eTGWw1pwHb42cuxd9pNpGRFdilZmVoGD7We7yGuoV1kQu9jpu5JX3I+cB8d4kx2OfDXc73jQUBbs5EF8g=;7:0xYASQNdwap+HlxOTvJI2AnPODm+0d7XmEXvy6kDZeOGZWJNHSD/Jsq8rjmVESmrvK3LxOg/SBYBuVNILSrHOjs131c1wDFLzS1vLAMrqR6gsv90CnxKZmeSYQCJ2eTAxfUA9dfU3abBQPWDnm7WwkrKemSH9mMg1MP7Zv36Gn+jXxwKdC8aFhvaxAKbbI8c1QNbczX0PFUpUi5pnsn2iWMYYtXS6DFl6qlyCcCFcmB9ThOFqx19yJ8Y7iQ1tLll
x-ms-office365-filtering-correlation-id: c9f26a72-8ddb-4418-bffe-08d6222d2a11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB082164B0A257EB7125317970FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(39060400002)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hH85rYPtugxtr1TtqO/pMNVpLBrewgtAWDVOY+NqlY8yngNkocaJppvO8+ilomnMCCrmgkGo7SgVnVr+aCirogdxiClVqK5rpGT7B5W1nMnP5BAfuF+LFxTrmLyc5NeA2mQF6GkLqYt1z+rmSX7/VXvVbZhWhNMr4q2YnfxPXTy8WH4iYrIt8Et890n2/Tp88/rJyyj+ZUKkAJHs8Tm7ygaviwPNLJ9QbSJjMsgiJr3sj2aCBvOryPTyb+SsZ81r2ojSQy+i3fCsgak+1wRPbZVIswrCupLg07nkOje/+amRAbcEppzWTyPeVSAgwepbI79aL2vkt/Zgc9dEO6SwEAglcIWFCCrn0jGkK+bCnpE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f26a72-8ddb-4418-bffe-08d6222d2a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:51.0907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 16fe10cf92783ed9ceb182d6ea2b8adf5e8ec1b8 ]

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] usleep_range
drivers/net/ethernet/cadence/macb_main.c, 648:
	usleep_range in macb_halt_tx
drivers/net/ethernet/cadence/macb_main.c, 730:
	macb_halt_tx in macb_tx_error_task
drivers/net/ethernet/cadence/macb_main.c, 721:
	_raw_spin_lock_irqsave in macb_tx_error_task

To fix this bug, usleep_range() is replaced with udelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cad=
ence/macb.c
index 8d54e7b41bbf..8c698d464716 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -523,7 +523,7 @@ static int macb_halt_tx(struct macb *bp)
 		if (!(status & MACB_BIT(TGO)))
 			return 0;
=20
-		usleep_range(10, 250);
+		udelay(250);
 	} while (time_before(halt_time, timeout));
=20
 	return -ETIMEDOUT;
--=20
2.17.1
