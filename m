Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E831ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31DF214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mDO0zQH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31DF214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeIQIZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:59 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728680AbeIQIZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1lXdUmpGzWAy8yPdQDJ2dy6UaF2wLP/924+jkM7xLc=;
 b=mDO0zQH5vaFZ3zHibPRJJlb97dPOkxJ12Y+frw8jvm6K1DpWrgWAT3ODcimWb5wKc36Zxmosn5lbjHPFf04aBpIrgG4Q6sUAuuVkcIjE6fOy35bTTB8poLzx+uRSXpGnunXcl3p3VFOW9iWxaCqBwo7RazGhp4Hme4Kndef22e4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 028/136] cxgb4: Fix the condition to check if the
 card is T5
Thread-Topic: [PATCH AUTOSEL 4.18 028/136] cxgb4: Fix the condition to check
 if the card is T5
Thread-Index: AQHUTjKW6EmtJPFGx0SFn5Er3upQdQ==
Date:   Mon, 17 Sep 2018 03:00:29 +0000
Message-ID: <20180917030006.245495-28-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:cv79QkKQS3YGUhbZABZhcBkfmHikEg3ycFv+5iNTzi9IZRNctFHP1LavB1WSebKejai5BjZEMzy9OXqpuBu/2qhuT8Q7ukHwsK9RwPNg7uafONaKCNxkE9kBPUjWCdkDA5pxObzoy/9vfLiHhZ/OwrfFX3dKWdZ7L6TOFJSseFL262HlxbAdSrWAAOCcyWpkM1xOIRGTg4r5SM7zHCG4pmfCx9xGCrYiyeg+UcGIGf+7F7hkq92PR9dS31VYFPyBEqB/rXJCN1FE83GJR/byYZi3sH9l4br8ty0OptvAiLeeMeOsI5j2+XkAtW9LFUQiJzqtu/rGhBghNPRsv8sNkTck7moXk5Kowf+0z6A/AyeZfxXlfFSl0njitnKO4FhUFeUBtZPyaigZAe6kOU9KRDxdeeqVMcQHp+3jZiX/2kIGHUh7SN5OPjcj3WLmD5NxXyIGgxzt7l9KMeg9xbUydA==;5:aNLS+q2cUunqx+0VMfnkHB9v8YfszzvQFrgz0zYhtSSllpmnvEyUQnyp4C6Vov8N2qfkMot3O6C/rYPzQzd/PUz46jvim3E6ZWVuUpWk62xH9p1UOGVCmUaRWayg5FzAHZKtamHNEz7m61jhV6X+5g96LjBUVbCF+Q4OUpkvIFw=;7:5S0PbqAwn9BJLqiK9TzS4ZjLvRf+K4ekPWaHrZJY3cWB1SqzdEn3WmhXcmT3T4hNxvcvDD5/pgtvW1Kc6zHNt8RpvsORRNn4FvBU+697oE9RzIAgp5XoWLASAYdfUzF1qmu3UC9U19zcY0hXCHqcLdor/r3fNh+/KklKgCvesmvSkhBVx8ir8ITnr5XI5NVuBQMd5Ti8d/p3AqencxjrMaVW/wL35X+J9s2vUF3YUWfrSvyjV4LifOZrDGZBK+sv
x-ms-office365-filtering-correlation-id: b09ccd7b-8a06-40e3-279d-08d61c49b999
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB027766B58BBFDD9317F4E8AFFB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(575784001)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BJYX99m2JEscRBMshJhil1AqJce7MzOD9V6Qebt40sEwI8+tItLgfgfPJMGVktzoDQ3Paz8lUrB4ixGMieNcYm0EsCRVsMZM5oSjeBqsBJPE2WRkFFtpMTEz7PnerTIudccXMX/vRRF9Ak0pJxbk/Hcj+lwhKwCLZ35X3QRe8sYuNAAQZJIh2U5HcMruVpFS6beGzz7Hay1Y2WmTNT0mO+Bx8WVVtg0MZNkqhZJjWyedMGGvvNp+h/Ty/iI+MGeVsFmwJDpdejkio/XqRfaGBb5jfAf/mtfDdZUyap7U42F+M07YSMQfwYpqqN0zoSXlwTbBae3CLAmhmepsiMfG4vkBIZWauVW8aMuHE2W19o0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09ccd7b-8a06-40e3-279d-08d61c49b999
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:29.0578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganesh Goudar <ganeshgr@chelsio.com>

[ Upstream commit dfecc759e64b0ea581468fe2359836f1998deac9 ]

Use 'chip_ver' rather than 'chip' to check if the card
is T5.

Fixes: e8d452923ae6 ("cxgb4: clean up init_one")
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/=
ethernet/chelsio/cxgb4/cxgb4_main.c
index a8926e97935e..c5d387be6cfe 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5705,7 +5705,7 @@ static int init_one(struct pci_dev *pdev, const struc=
t pci_device_id *ent)
 		if (t4_read_reg(adapter, LE_DB_CONFIG_A) & HASHEN_F) {
 			u32 hash_base, hash_reg;
=20
-			if (chip <=3D CHELSIO_T5) {
+			if (chip_ver <=3D CHELSIO_T5) {
 				hash_reg =3D LE_DB_TID_HASHBASE_A;
 				hash_base =3D t4_read_reg(adapter, hash_reg);
 				adapter->tids.hash_base =3D hash_base / 4;
--=20
2.17.1
