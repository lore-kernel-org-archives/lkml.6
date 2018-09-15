Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF75ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEA121476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ROw3iCVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEA121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbeIOGt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:56 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729309AbeIOGty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bn6PWTWvbk+2USy6XbvFHL5EEwOO/vPslVZAnviIPEw=;
 b=ROw3iCVuQVwXA9rjBjBmDAHF+ZFhiE91sjocJCeQP+Orw9FZF4VdV8zpW9gbqfxO9KM24OkSzoaDG+S9BZK6CbvKZToVjmv5045y1qPhftB1TqOOdA0JTy0kDjlqy8ZvYKoCWKIj/lEUbKoXTR8PqXHl8RG3lgh6cJNgPqL5EBI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Karol Herbst <karolherbst@gmail.com>,
        Martin Peres <martin.peres@free.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 30/57] drm/nouveau/debugfs: Wake up GPU before
 doing any reclocking
Thread-Topic: [PATCH AUTOSEL 4.14 30/57] drm/nouveau/debugfs: Wake up GPU
 before doing any reclocking
Thread-Index: AQHUTJQComS6Z7/OikS3/GFw8vi/tw==
Date:   Sat, 15 Sep 2018 01:32:48 +0000
Message-ID: <20180915013223.179909-30-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:IIWZLXceRAcPpOpjdjeaEX+qHwAsFnsuYAV1TJpMWqnJsMueMHbVtWHo1NAv4D0JVMRKSuW5aUxHSotoPrPEn5bxDzwwLtU/j7r89wZ/uyxW4vkFNM4UvhBkAoid4URJ2KZpWOuUeMG/8cfErrjmpe5TdVEOOoZLpm8Bz7hZnT0NucvBM04si9QATjbQPiYOkXASUu9b3ocaSJ6ssVAok7FvEzKpg4qkppVUVGEBTZ61o6MYmwzwQRnq67YuTZAaVXVs+QX1AmAejyoEQrpklGZJvLdA0LbqC4Y5AWHtyaK6ERp73YJ4uhZlqDv9vA21guiXfaNqn/miEKoXsd6UKRSuCIedAn+qgANzJz0NjBbirow+q5d0SMqwq8Y/HR7KNdE/QFFykg8VglEOahpfRviFPBYaw0YM1W4eJV87D4OyFfqBOBbsP/CVmuEsM5ikcVyh7KqZh3eM4UVVMdykhA==;5:gi0Y8XLkWRxz1HSCkMgZ2iFhTYbmJVsyAQ5YqQjUiij2Tla3Tyo/te0h62R3iP5FFiGrtTP4x+bFTuApp9IiuCr9o9G0NDgT9yPuXwsnM/foe9MOxYP7GF7/HLQ7+4+RrwtBejcLARLxk6gQfhmww9f3YoxLiqVxL+djY5R1Tgc=;7:bdlOaG6/nnnY4/EqBv/e7OXWjmCieY1fCajV3MH3B/KFgWB6p5Vk3HLxdqGW+k4Dsp7oa4arh+LDWQTl91uC3tIA8QpzLr46vF23FA3Lm2ygoaeKaA8Y53+i1g94A2qhdmkEi1K4g0ahZmgxYijlVJ3Tbc81RAm+ftVEC6r23X7+87SAlBCOjsSlRl0NzS8iswjHUgG1Feza3158w5ghO2hnaoxtl+Eu1eCHI87s0MH3EtXLC1o4fwi5YUSWnfuj
x-ms-office365-filtering-correlation-id: 0164f948-7426-4fe3-92ab-08d61aab251e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822E00A09DEF62338186CDAFB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(39060400002)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U/j6HLAghKuHoOiY33qmskOrbjoBq+uPmx2Qn8yEHy0JMDWKGUuiEVWvIDZOT6amzxCqWomz+nDhPd+pmm9OQ8C59otdUafG6FM1st9HeVgC16pEwsFr6Tyto3aC2sJDWTqYhoJ6g6+QLAL11/+NgjSjaga2ID50paiBA7ZuLeKxZzguaCZfg/ZEkMOriUaSq75OshoK3qWOWJZxFB+IblhjKbvlajzSu90EWiwE9AeSOXpVv9kQPNgZgBX6Js5Rk+KeavM6pEJ6EFQoLJISQV27ge03qSQYicRCMNWgWqnHwEovGss78lZ7hKgkkDZq2F6CszKLDHazGttPEDcH4C8Dw5o3X3n/sREFYeutXx0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0164f948-7426-4fe3-92ab-08d61aab251e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:48.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
