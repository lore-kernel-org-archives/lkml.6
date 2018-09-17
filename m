Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B179ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7552147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kbF5T8Nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7552147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbeIQIdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:55 -0400
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:17664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731112AbeIQIdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zaPbrz2+m0dvkkyQvg5BVElxLeKXajIMOzUI3le5WM=;
 b=kbF5T8Nb4KJ+ueCG2ZqwFB5EoM+vS8pAB4LxdtQJSLf+IYCsYS70TPtaC8t6uyVjOGjBaxlkPwQ6LTlM5vZoP4wkI7GrDLOEdtxC2ssmAL0u8XbHnTBwXk4LgXEI2ZyFRXhBsWSp1pu3McPM/35pf+eM7Nwsv/9gcW4r3M7hi04=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:07:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 19/29] media: tm6000: add error handling for
 dvb_register_adapter
Thread-Topic: [PATCH AUTOSEL 3.18 19/29] media: tm6000: add error handling for
 dvb_register_adapter
Thread-Index: AQHUTjNW14FeBVZbkUafS5zM4b6vhg==
Date:   Mon, 17 Sep 2018 03:05:49 +0000
Message-ID: <20180917030533.592-19-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:VTerNA8dS2d4AL1uxuAZDPayym4n2BodaYG0fV4WQzwl8y+TQK63ZrnSpRZtg48YPjlvLptGQLxPuqjagOGczSgzTvg13tHUaiYk1ltt67aXCGgnD4hbluF3D3OMdZ9hIPb7TVPN3bB4GRKfdh7S+mjy3qvoSlx8iwVGD6m55jq58Gek4DC7hiaH4DPdZWY6biS4+owxg/FWPqY4f1rl9VxDTTj3sG1Y6CkYfu7Svwb1bBmUNCc6oNf0ikXLEdBbeWuWG/4XU67mJtxfXvsVyLMjpCSPm9wUTvfLxeRnh0E3TrVVvti+5jC1LrYw/WUvdSK1nWbyrfKo+qmNbBbebrSj/hLYsZXimIyFjqbmBCfx2B/V0GCa1NZ44iIOTK6gSr47Ptte3TE0ZXzqsKF4Wt3Itm01Tu2GbeIfNnFmraoZhIv56DMFpAwthQEBRwb01Hjvb6Gts/8coGRUvdAaYw==;5:mw+bhhy2/Ck+GNhPJT1U62rbpjaembtN2AVDyX1Du9FCZtVjKtXQLfa6Euvy7sv0V55ZmUoxG/7NUxnlWZixaeD7LjEvE+F06vO8VdEmyq9n5k3ftdKqhurqtsPkfDEjCVZqR+J9BdtEh8+fZ60g7n75ensekuHT2yp4j0XNgXU=;7:++5L7t8OZPpxAbqzyOTp/2kG6pMFNlnKNtlFyqflI4n5Q4umdyleXFTzLYZdwaQ/EOulmT7CjH3q4uEpsPGnDWPWoHiGYV4zV8Vynyu994nWx2uaPrOJKR7r7Oo5d7ZsQu9YiSA5FJeJTwy8o2ENKBVrRYyUZMgxxw1Nu1NvqWdRWau55nidqbYpi9vVeRxwNdhz99l6Y4apqzJJY1vE52WpQsG8ujWtyxmyza3udC5saCtNd936OaSNqBHbZq/G
x-ms-office365-filtering-correlation-id: da53b82f-251c-4f75-09c0-08d61c4ac372
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150EED51D7B18BFCA8B4203FB1E0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(95692535739014)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(2900100001)(39060400002)(2501003)(6666003)(11346002)(107886003)(5250100002)(14454004)(26005)(10290500003)(36756003)(217873002)(7736002)(99286004)(305945005)(102836004)(72206003)(2616005)(86612001)(476003)(6346003)(186003)(486006)(54906003)(110136005)(446003)(6436002)(5660300001)(4326008)(256004)(86362001)(10090500001)(2906002)(6486002)(316002)(6512007)(53936002)(22452003)(66066001)(97736004)(76176011)(81156014)(81166006)(8676002)(3846002)(6116002)(8936002)(25786009)(6506007)(68736007)(105586002)(106356001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: h6qfyI2EovaTnsd88+VzBf7iSsL1QVhm+AfVt6eqdUA2fWgA4xYhRUNexdw4vuVEtwxMfYjQPgWeMtzgzWX+d/yMMiVfDcGzketBwKUkEfDdewPfbMfYxK5l3dqGv0o9eXULSo8CdY7OVduxVKUrUEhgJP6J8tAfOZX6MpXqIpYv5+TzIRhudBCT9+48BxMbL2cemdCGZQT5JMHVSNX5DeY9Ar8TEZtEVOzwu79TNvs1Ay7trfYLrAjaaNtbORQA/kdQuBaKTYJsOUsmn2VU2i2VaIDQTFYNtbpndgvSgRG5Ib7+ES03QQmW+sx+Ut86+e2swR6Eu3YKCY6pG49HFqpOermyD+s51WxlSQ7GuhQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da53b82f-251c-4f75-09c0-08d61c4ac372
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:49.3889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit e95d7c6eb94c634852eaa5ff4caf3db05b5d2e86 ]

When dvb_register_adapter fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling dvb_register_adapter.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
[hans.verkuil@cisco.com: use pr_err and fix typo: adater -> adapter]
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/tm6000/tm6000-dvb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/tm6000/tm6000-dvb.c b/drivers/media/usb/tm60=
00/tm6000-dvb.c
index 095f5db1a790..4f317e2686e9 100644
--- a/drivers/media/usb/tm6000/tm6000-dvb.c
+++ b/drivers/media/usb/tm6000/tm6000-dvb.c
@@ -275,6 +275,11 @@ static int register_dvb(struct tm6000_core *dev)
=20
 	ret =3D dvb_register_adapter(&dvb->adapter, "Trident TVMaster 6000 DVB-T"=
,
 					THIS_MODULE, &dev->udev->dev, adapter_nr);
+	if (ret < 0) {
+		pr_err("tm6000: couldn't register the adapter!\n");
+		goto err;
+	}
+
 	dvb->adapter.priv =3D dev;
=20
 	if (dvb->frontend) {
--=20
2.17.1
