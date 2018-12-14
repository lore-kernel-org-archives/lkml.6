Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D76206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fiJLBxKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeLNQEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:04:09 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:15328
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727540AbeLNQEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXrMfQ7OEZRJqoYR/fTWGRpjvS5vDZ63Cm6cHNI/e1E=;
 b=fiJLBxKc3JRjwM7xm8fOFRorO15bwU/BCRdogrHPdN0juDQ0c1KgLgLZSItC+0GkPVq7yrfzyHQmkjbEojPyHC+5Nxco4A2KB/rKg2e0/198gigbGsHtyoes5cfGUh3Dr6W59HXO+TpeEbU1SKKK5FNO/6vXIlWPTiNaFcuBHy0=
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com (20.177.40.15) by
 AM0PR04MB5316.eurprd04.prod.outlook.com (20.177.42.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 14 Dec 2018 16:04:05 +0000
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2]) by AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2%5]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 16:04:05 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/2] soc: fsl: dpio: Add prefetch instruction
Thread-Topic: [PATCH 1/2] soc: fsl: dpio: Add prefetch instruction
Thread-Index: AQHUk8ajer0tRabDUk2jBJsm+D1IkQ==
Date:   Fri, 14 Dec 2018 16:04:05 +0000
Message-ID: <1544803440-32755-1-git-send-email-ruxandra.radulescu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM0PR04MB4994.eurprd04.prod.outlook.com
 (2603:10a6:208:c7::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5316;6:7tnRetFbKjN8Kocwn6cAv+T/rqzA8BBCiCauiYmEf38oRwgYogp1GcZXcMb4LjfI3ShErrBMUo5YGTqM69l1wTD1KL9T6dctxz46jYzFXuLcueK53MjbzBCUnSddm0sTzJcW3UVZczCW8p2bobNsj03RujfZB0TwVcXCa/jJYb48H5iOcI1J74v6ftsegvLftLSSAEbot9tOpTytSS0kRCItG0d2U3muEx74dB9i1SJMuQxh5dnucTVj7Hq+DDAj2uJE88pbTUZdyXWEFS4sX9VxnBcZ2jFEqZdJ8yZXbODkWyFReqxu/pHSSn3r9HlSRXGBDg6QVbElJzi1Pc9+2LBjHMUEJgiclsf00HnSTSPXbOwX22eZPt6TZeV+lrenYEeEFcT5Dqds8twPrLNcuZfMISzUr5VdbgjnX4RQgSB8+nBwIdE20VhSZjyIBf2IidkbCSwdNng2hiuRDYlFbQ==;5:/TFgKR57t2dxR3ETWAWAZte8WO6TBT4pxEp/Ft8VJCgUkyfsRvjBZ1qTdPRmq5zK/Lb8SGFQvuMkOZx6a25gOOp2mNUT/0MARvtcznKgZV+jkj5pn9QDwEKbn6TP9RTqQSgFMAhgro+qtZtcnPpODo1lNhsxMPBTndw8m8o9cVM=;7:vnF0qWEeoyOLHy38wL6URDX21H/bCIoVj6YD46deHvzsWl/JRq6Ci6JhEXzObFHgNheCFiFvBuUz5ELZOt5Zokg3BVvL99lwBRtC5sTQ6JJCiYkFJZ3mJWe09rYVPnL3EyOE47d1/Kc32U9K0lWaSg==
x-ms-office365-filtering-correlation-id: fbac121c-af2b-46e9-ca94-08d661ddc5a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5316;
x-ms-traffictypediagnostic: AM0PR04MB5316:
x-microsoft-antispam-prvs: <AM0PR04MB531630867572714B91C1732C94A10@AM0PR04MB5316.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5316;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5316;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(52116002)(26005)(71190400001)(8936002)(99286004)(71200400001)(478600001)(25786009)(476003)(53936002)(105586002)(106356001)(110136005)(102836004)(6116002)(6436002)(54906003)(186003)(81156014)(81166006)(6506007)(256004)(316002)(85306007)(3846002)(86362001)(97736004)(386003)(36756003)(4326008)(68736007)(486006)(8676002)(305945005)(2616005)(6486002)(5660300001)(6636002)(66066001)(2906002)(14454004)(6512007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5316;H:AM0PR04MB4994.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jcSHqDnQMxptrkB7ZvewRerqGH5rTQrEhpy655YgSTRuTlgtpfB0MTsPFSpyMdks8rIfqUQ2zsNTIK47dHcN/fWXYilk69NLM5gvJRvFcLRCGkPF+mbR41ntsPiSqBHeTZjvXaq/hKaeKw4RJ2nV7DvVXp2ZSrJuSrZ/yyj6uaSg07qYjjTocrHlTn6UsvOkH4C3e/D033YkvfQ4PWXBFNNh+2gNUtwvEdfN6x/bdUmwQQeCD370Fs2LnJRGndwp+W8yUy2QDCZvBNLCRjXRAjCu3DJgf8T4L4jMxcrUHGRn6ZhvNc05nH529xQ3bMXk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbac121c-af2b-46e9-ca94-08d661ddc5a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 16:04:05.4616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5316
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dpaa2_io_store_next(), if the current dequeue entry is not
the last, prefetch the next one as most likely it will be
requested shortly by the consumer driver.

This brings a ~3% improvement for dpaa2 ethernet driver
IP forwarding with small size frames.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-service.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpi=
o-service.c
index 5583d28..56a35c0 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -613,6 +613,7 @@ struct dpaa2_dq *dpaa2_io_store_next(struct dpaa2_io_st=
ore *s, int *is_last)
 		if (!(dpaa2_dq_flags(ret) & DPAA2_DQ_STAT_VALIDFRAME))
 			ret =3D NULL;
 	} else {
+		prefetch(&s->vaddr[s->idx]);
 		*is_last =3D 0;
 	}
=20
--=20
2.7.4

