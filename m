Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB27C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A3020837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="APxQ4rd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A3020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeIBRna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:43:30 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728792AbeIBRWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWmUQr+WLY78lzLwVj2s6RhXxBOl8hAK/9Wo0uZyaZo=;
 b=APxQ4rd6MWC8Ua5glTenGNHZPchvps++4XRju3ueFH5AsFF93UvrqXliAn0Ad0PnBBlJFc1jRrr6gLaeFrpKtgcQJVycYM0JcHrfk0iuMqZbBuPV4pbnkA3qtMM/OVUOpy6I8SAg1yUYZLjB762jHQ9FptpM0kNZyo4JmQUMiDg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 131/131] fuse: Add missed unlock_page() to
 fuse_readpages_fill()
Thread-Topic: [PATCH AUTOSEL 4.18 131/131] fuse: Add missed unlock_page() to
 fuse_readpages_fill()
Thread-Index: AQHUQr2q7WDKxNBbFEmQoiBxdlHeHA==
Date:   Sun, 2 Sep 2018 13:05:47 +0000
Message-ID: <20180902064601.183036-131-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:XOTMHpa/u5hGk+ck589SPUPAeCI6wRSVXXAz2f1LpVOZqQ9cdN2IzBa932twiIJd1D/UM0AjgnHknNbPurHzmdQpM4ZwK5gnzq4/L7yfahfQq8fyTFIpfPj23LwwhqXoRQVzramXWuLxcdN4ZEql0ao/1r9ibA2AERZxMIsQrutfKf5rkjZDiAA5wSsD25aPQec5NPGT2FA9enYJVqjY41pFprIpKPyMEbaXwF7CWdK14bq3EZGNJRUhrqGYWlBIAvmb8CduhQwDfUkPnfPwC9zJGqQ10FfnYDgCBrmo8/zWZBQOeO4WRMRWW7b2S75X57JAIGvmv8cx88DzATYF4I2AqKPw2dmNt0QAqvZOwJB/BZx98NuBi6sVnN5/7DLloYvctKpEGhRLyFFJ32rclYyLaqiXRkXm9ShSAHGYbdH7Y2KL9cXOp0mcqc0kvhFCdPU20QZBfOYb24bqmQe9qA==;5:BIjZWJil+4TxASuo3qqhMVGhUuzkbUZPkdgF2dbGKOY54zrUeLWNtFIUqeHQ19HSyN3w9uoCV5/ewNSoxj48xtuTBagTJF7dgTsxI2KIJBU2EAThaNog736GYY1YeI/+uQrHUyILYJHd8FBcG2b9R6+gf3ac6Lul5qjLCf/rb9A=;7:ZaahmZVgkS3SG682XhshnaNlJ5BzTNc1PObg4wrCPnfR9wliheygtuu0rPnZE+BpVcas2toQhju2wCbd10lDTa1g1u4daIjtWu59x1yaM9LVG8Nd4r9NCkHBBLJCD7ICRCfADHQJiu9NZIudPAGfNFOcu8220aamLIEWINdR8TSolMnyuoZRxFqBQSTkq/yQPEivldupIG+oqoqXxRoSX1Jmt8Dxl95FBWaFx0AChNVhQCkCrqvV63TY3xxla4z4
x-ms-office365-filtering-correlation-id: 0c960b2d-1b8d-43ab-6dc9-08d610d4e02d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822DC8310BB94715AF576A0FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(575784001)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4Rr430aXgioktnRIK9uXtanqGkm6yUi+rxIxEWfDxQz/JCOZCWvxgNO0QYAaMRjKSLYJe4elfjBgiXv7ejy5gbNiTBRswSB6Lpm4ar8EzLqYO2jTJeNjUsbmk3kr8O0xj0MnICKAcAKKxdUbbbVkvu9ftdH+OBNT0KMDHVttrJHzFIHPgtHiOwnIdnyAOftVqzGD4IVl2X2YefAVcXgCEveNriiF/66nGhMo3L9XszNzDON9F1YEBkOdZKNyKTTZ/PcxkzOV/Cz5W984YKtuqba+1OXZMA+977mPJiw+YsbsUHsm+/BqlQiWtdxoGIOfFLiDLRziaTEgF3RCdsAHqGCW4AEd1HqfUwMzkLRIQ6c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c960b2d-1b8d-43ab-6dc9-08d610d4e02d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:47.7791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

[ Upstream commit 109728ccc5933151c68d1106e4065478a487a323 ]

The above error path returns with page unlocked, so this place seems also
to behave the same.

Fixes: f8dbdf81821b ("fuse: rework fuse_readpages()")
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/fuse/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a201fb0ac64f..aa23749a943b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -866,6 +866,7 @@ static int fuse_readpages_fill(void *_data, struct page=
 *page)
 	}
=20
 	if (WARN_ON(req->num_pages >=3D req->max_pages)) {
+		unlock_page(page);
 		fuse_put_request(fc, req);
 		return -EIO;
 	}
--=20
2.17.1
