Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36151ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F0C208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aU67Y725"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F0C208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbeIOGrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:53 -0400
Received: from mail-cys01nam02on0095.outbound.protection.outlook.com ([104.47.37.95]:24416
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728297AbeIOGru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bn6PWTWvbk+2USy6XbvFHL5EEwOO/vPslVZAnviIPEw=;
 b=aU67Y725nK4fXWV9I+W+HAhOcKDcc6TfFLYGZgkQ7zJM42fIq5WoiBVNMqRFEbLKVorcJVmyyzFuoml0mQ1YheEsSOw3zvcfR8B/UxR60rf8vFB+1EgKkomSrxjCGE4IY5E6IDPMYcI8HmTKKT4xZq3w1vlzmQMQEIl3RaOJ7PM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Karol Herbst <karolherbst@gmail.com>,
        Martin Peres <martin.peres@free.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 42/92] drm/nouveau/debugfs: Wake up GPU before
 doing any reclocking
Thread-Topic: [PATCH AUTOSEL 4.18 42/92] drm/nouveau/debugfs: Wake up GPU
 before doing any reclocking
Thread-Index: AQHUTJOpaxFhir+94EWA7j2nMpJFCA==
Date:   Sat, 15 Sep 2018 01:30:18 +0000
Message-ID: <20180915012944.179481-42-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:f6yaJOnmEjKeJbI43z9M5yEX+xoNweGpamzkw+Em2dUpRLZPF18l4L82bF0DrZpUaFVD171WdsyA9NBKUF40ZB6OErdu7JE98tsuZ4TTtCcpdn0oSKdEvOsWg6wfBpZy3fYONsOzjctFCZ4tyVXwSKDKBkOsjhC+RSwM1M6puvxSs390oPntgHJgOpk7v6t1YQJIT1ENYLzGBLSvAd4KEOrVrH6RZfumgMdQjK5wPNUzkBG+cxQ0m4NfcGKmLtna0n2uc4aM7CmEjPIMg3jpu8Gmi/KY2XEkf5NdCyo005+zMq40W0F92QBgoGkdE9koXPGyqoFOgHL+37pe5OtsPl0HUrh8BGL+913C4rQRRkGsb9U9YMH2WDwKrkTvqfjpp9zbiNoWKoXf8AHiPDiC63VsN9NmBsHr5bHQ3Q9Wd6VveCQQSfYMq4pcO4W1tdW/dJ8Q9Nac02qA7GIz4pWDpQ==;5:KQn7454tpBJoksM4PWV6oh67X58IxZyGCrhMm5OuaIdGUnPXdEl8B4T3BAsK9TxijxxRwXO62m0P5mitKlygwXZM5Yl61HDjJH9xnedq6aT7KvLsyzLCS3aBp96I1HZpdlJl5NPZIgr5t1wUGlUv5ycyir0WQPMnxMLfWFunB8w=;7:qXDUnz67jdN+91r+BJYHTzyHVEPBkk0F5rF8y/Y3XttRnKGdKQ31Q0DcbHeF/dy6fF/Z/3by07zXEULfk/T2CLck6FT0b5TTOUoa7pef6kFmhAsF5AlP+X/Asr/U7kRVihqXPB1ACkR7tNA4eN5mbi4RmSlhZVeG57BlQnnz+i+c4A31bSV1iANqLEflxsbSp99H2NIZBbVcHUxomVyk/5HzJrPOujlG/s1gw079pQMSwa6mfub8Su/7MYwbRJ1R
x-ms-office365-filtering-correlation-id: f6688414-5051-4d0f-c46f-08d61aaadd12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB0856CD96F0E5CFEA1B16ED6AFB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(39060400002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(76176011)(68736007)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: RvEVC1gxGMydKLQK9is1iFwYqipN2KZSs7cscEwZ0ap8V5Lx3yCKLtB9gAJNoU8mB2fHCK96l2EgWvjxVeHzjc0iuPF6fINUMnQgzhri3eC9YL/EsaA0Pu+zxlkS4tWvWP9TqDum67YhOipSrWsvyOKoJOJwMT0vap2wBNoG8GlLm5zWJJ3R3aGVmJVt9c1yraMl8QyTDD4vpiVrJT3flipGvAZEX0yLtBn2FJWPwzj+cBhgAbkdRpAjr/JX51+ap2Rb4E9XLBl+B5vBw7QaMxfGqIx669pB4TIlM9dLPoTUtOFKP46LoD2bmC/+gRd3FHrC24LWVkYoRu8P0ghfubWakeusC2BooylaKr1wmJM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6688414-5051-4d0f-c46f-08d61aaadd12
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:18.8543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karol Herbst <karolherbst@gmail.com>

[ Upstream commit eaeb9010bb4bcdc20e58254fa42f3fe730a7f908 ]

Fixes various reclocking related issues on prime systems.

Signed-off-by: Karol Herbst <karolherbst@gmail.com>
Signed-off-by: Martin Peres <martin.peres@free.fr>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/no=
uveau/nouveau_debugfs.c
index 963a4dba8213..9109b69cd052 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -160,7 +160,11 @@ nouveau_debugfs_pstate_set(struct file *file, const ch=
ar __user *ubuf,
 		args.ustate =3D value;
 	}
=20
+	ret =3D pm_runtime_get_sync(drm->dev);
+	if (IS_ERR_VALUE(ret) && ret !=3D -EACCES)
+		return ret;
 	ret =3D nvif_mthd(ctrl, NVIF_CONTROL_PSTATE_USER, &args, sizeof(args));
+	pm_runtime_put_autosuspend(drm->dev);
 	if (ret < 0)
 		return ret;
=20
--=20
2.17.1
