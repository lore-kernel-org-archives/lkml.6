Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E60C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F5020837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M/D+wb2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F5020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbeIBRcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:23 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:32096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730264AbeIBRcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLwB90n5bqyZDppJPkB95gvRAix5c1IdExIm5PsZuHo=;
 b=M/D+wb2DBGjIWzQiu3sxtFxdbZep6mQjsImYkpLeEMKZIO6TgyjcZ4TWeCQpUBMxpLR1xCxdoitzDiM5UK2rUX5mA0VUFr8fRBzHcBz++T0P5sVT0a3IUS8mqfmjQVayKAzDH1XTUQV5scftBlJi9seb6hco2buaa+VHkBQUGSM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 32/47] partitions/aix: fix usage of uninitialized
 lv_info and lvname structures
Thread-Topic: [PATCH AUTOSEL 4.4 32/47] partitions/aix: fix usage of
 uninitialized lv_info and lvname structures
Thread-Index: AQHUQr8iCWT0MgQRWEKNJy3q3X0B4g==
Date:   Sun, 2 Sep 2018 13:16:17 +0000
Message-ID: <20180902131533.184092-32-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:FPqZu/ZdVPbbo83thG5k37Rop1ZCsu3I/ltQV/YAXvISyMPWO0p0rAiMdEgy6lAsfHGoN3yB9rhfIO4njFsJ/1aqubN0de09AGMKncvwiZpJe9oARTH1YBR+3nzowXUf09IVLyevcBq9wbaC69MDUNL3nbJsJ3NQqBeE7s8EKZ+zZM91xQV29tg97V0G1zdCy9wpiRdbfrUvptAI8XDHL35ivQAyw9BlVCYFSDTrrcP8VObdNFlmPj1XM8mTKaakKGhwmgYikYg8MtBt3kuQY/gOPF3molCacQbFoBzIMVYM0de/AK2Tmv+LQK9STfPsLl8Nzxtrq7+an+GxkSkQWz1BD4ppn6qjpNrouLCYnGXj6y1pBD1K3IDysRTmM7uRaiI28Oezmt+snpAmFuYSpef2AhiIxkhE0OAfBc4IHuIALcO9YhkxdiVY2zKYRpc7A6DNDkOZHB7Rl1Az5StghA==;5:0UJEkaoo0b6r++PEAuOCVahN2VvGTOKIHP+utd7EprJ6uBAjNpPGGOKBy/gw7rpunEvMoJMSwW4nliLAbqpurl1tSu5cRsbi9cPNzjOEXHS3LLmn8KcUsdky+5a2UXNOrMyjp4Ln+FPDEAsRCWGewBEzhlfDOtl0uEPv4K3NpI0=;7:mO1ricw4aQEAqMYJ9E3aooWYIwzMouUAgHSLNhygGbF/TXvQfzyyfGLSLVonF+S5S+RQIBkBkz4kEPJXivufKuOwqVNTorjZNuMBuKpKG3ARmp5t9/dF82f3hHFrtcW870g7qqnO2gY4RiGsd7gPBmQvhKLrl6fmjztkXdFBIbJuoOfXdMT9EiqhtNxN/yixyEagiZmD+OHBzf3KDzc4ZaMEAY0TTku6cMDboJodGRsYhfDmCHUddvM77Bv4OSDy
x-ms-office365-filtering-correlation-id: add4e4b7-d561-43c3-455d-08d610d64abb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB016738D8CFE7CED26CD65204FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(5024004)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(86362001)(107886003)(72206003)(14454004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5e2Y3DVJWYE9EyeDin2JInWtxehoE2o+3vsGaB0bWJt2MgSmns6izAX2CNe3FMOzVsmup4t9MZiri0oIR9s2PjirdzxzBaZ645LLRa8aqdF0uLGUDOJOKzjRoMD0+7W6TBMmhNy06QZD71TQD5/4auyGZGOqo9Xj6qZCX3qNBvb+ycYKQ1p70ay7X6Q1RbkJZbrajjn1t2H5ZhZWaWxE27Hgb44AhoJPpRNBWrPgO9RQFEUR/xBNVQo9XQ+0B87mueRVHpZliMOVPZPDOFI/X1fFhVSaI9KakwwUpBlMzdxYLLXdLusnSfYHdW+ihY+KMfObhEmNVvUPxpXP3otq1mYw8m3zbrEaoNSKbQeVJ5o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add4e4b7-d561-43c3-455d-08d610d64abb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:17.9571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit 14cb2c8a6c5dae57ee3e2da10fa3db2b9087e39e ]

The if-block that sets a successful return value in aix_partition()
uses 'lvip[].pps_per_lv' and 'n[].name' potentially uninitialized.

For example, if 'numlvs' is zero or alloc_lvn() fails, neither is
initialized, but are used anyway if alloc_pvd() succeeds after it.

So, make the alloc_pvd() call conditional on their initialization.

This has been hit when attaching an apparently corrupted/stressed
AIX LUN, misleading the kernel to pr_warn() invalid data and hang.

    [...] partition (null) (11 pp's found) is not contiguous
    [...] partition (null) (2 pp's found) is not contiguous
    [...] partition (null) (3 pp's found) is not contiguous
    [...] partition (null) (64 pp's found) is not contiguous

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/partitions/aix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index fa74698e12a6..8e7d358e0226 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -177,7 +177,7 @@ int aix_partition(struct parsed_partitions *state)
 	u32 vgda_sector =3D 0;
 	u32 vgda_len =3D 0;
 	int numlvs =3D 0;
-	struct pvd *pvd;
+	struct pvd *pvd =3D NULL;
 	struct lv_info {
 		unsigned short pps_per_lv;
 		unsigned short pps_found;
@@ -231,10 +231,11 @@ int aix_partition(struct parsed_partitions *state)
 				if (lvip[i].pps_per_lv)
 					foundlvs +=3D 1;
 			}
+			/* pvd loops depend on n[].name and lvip[].pps_per_lv */
+			pvd =3D alloc_pvd(state, vgda_sector + 17);
 		}
 		put_dev_sector(sect);
 	}
-	pvd =3D alloc_pvd(state, vgda_sector + 17);
 	if (pvd) {
 		int numpps =3D be16_to_cpu(pvd->pp_count);
 		int psn_part1 =3D be32_to_cpu(pvd->psn_part1);
--=20
2.17.1
