Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E8AC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA602083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KuJ0k39w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA602083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbeJAH12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:27:28 -0400
Received: from mail-by2nam01on0138.outbound.protection.outlook.com ([104.47.34.138]:39861
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728730AbeJAHNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA/tJV5RWhh6RwpDH9NXpEPTCS56fLaCIxUtPedJWtM=;
 b=KuJ0k39wRIO68b1Pls+9KYdmsVUWHSK07/oHewzBBXaBfgPkJQH2CApH0jfWC9ZC3aE0HZg/6QtdW1Yjzj4+7hHX7WRMF8ysZ6sn5ot+8sexADyaNZSG+dtpA0vjBrAiOUe6H9RdwmpMXO0qz4Zu/WLT0rZXlxI7eNeLi+dkwes=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 30/65] drm/nouveau: fix oops in client init
 failure path
Thread-Topic: [PATCH AUTOSEL 4.18 30/65] drm/nouveau: fix oops in client init
 failure path
Thread-Index: AQHUWR8N2rZ3CxlYs0Kygjw+/vg1Lg==
Date:   Mon, 1 Oct 2018 00:38:21 +0000
Message-ID: <20181001003754.146961-30-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:rjyFHvX/oYX4YiQHN3nuPNSt8tL6vpU7YlyW0Ur5/yFFoaiWdmdaVlQwnsv/9ixyQAGuaQr8zMmGwQ207pxfFLigEyxKwkqonP3ukgTRxhc7s1sD2bO+lyd2oEDVQ/vnQAMeiV3/snATc3tRatJ3xAk0EoAEk62O711gKrIbhLMnupg00N46mJdthAZzfdLbTAN+3lFio+TnGq/FlSunRWPmgR5yhL1ovYoTUBcLq/ojpzFP2ZkLcgdR1CH4dlWeG720zxzZ0GCt7II++mqO2Q38kqRHleTyYEkeQVv/BhbQs7zKnHApdDispg3DCOpbzNp4/z1qDfKznUi/4sVVU0CUxrI1J25MMp7c2sWAITYAPHJWhW3oFQjnxODCAr17mAFl9yvCnxYW3fO5EPhT2CR9AaL/5CMzn3rNA1OcLEzKxw4hP4MAkf7dEOuqwfH7PH5Su7T9Y57Vu/ldAYPFpA==;5:08xWYV1/MEe7l2VUmb33qjCzBqkDfFJECCEN+QHBziSSrG7JuNQzm+GxGuoLSULjK3hruBt93qcwHazsHc0O6MI3A1jZatKcsMaLOTpR8hBWpa0F6rbZvQUlougaFGNClQSFDesekGvbXrxgTsiDwIokVhk6kHql1DMbvd3C0wA=;7:YBlYv0KRBm5XEd73RX+6wKtlXjdN43GhJV+YLrORLVkWdrGXdBXLcjoqw+DeuBwYe8n4U7uLXiDA+Vl8gmfbA7ZZ71/0QSzK4hQN2H6DTFPdZ8S1JHQUxTCZdF2wib11WnVm2sjshqQthf67T4WnJnnCBdBE71b37YZwkS0Z9w+D6mclNoPkbkroN6jRdzhb80QXwUvYdTPGIWsVG6HgOf7pfHryM9U+uEYC+hmQ+/G/603jzf6PmJzolBYLO4Ev
x-ms-office365-filtering-correlation-id: ee2af106-4afe-434d-5a71-08d62736308d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01813671C08A4155B7635824FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TFRLQyDn6v6i5MeuyPXYlNb28WNRLWmdxQtYI24hJ8lwz1Bi9PyQzmG26c+2pQGjPSSWT48Aoj5CKH4lUtxn74qwsDI1F4z+OXyZA/GU+y8j+N05T8dN8DPa6yd1+5GGoJ9nL7F9s97MmyOXAib5+1frdD4IwMZglQmMgzvcPoVwj5ofnpkpcReNqw0FEokKxd3bZzCZv9JrAlQQaANvM1i7EuabeLfhQjW+/alSYRGrW38yBfYphXn+UILP8DIlcuW+Cp8BLQYX0LMHtaaFRm+oDxVKM+ORvNtMMq3rB6nVFiGLhepLPVUcI8ZAEDCMY7Q7gfrTw4BaFKJo5QROKOt/VUMm8JAl4232JM7OIPs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2af106-4afe-434d-5a71-08d62736308d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:21.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit a43b16dda2d7485f5c5aed075c1dc9785e339515 ]

The NV_ERROR macro requires drm->client to be initialised, which it may not
be at this stage of the init process.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouvea=
u/nouveau_drm.c
index c2ebe5da34d0..89225adaa60a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -230,7 +230,7 @@ nouveau_cli_init(struct nouveau_drm *drm, const char *s=
name,
 		mutex_unlock(&drm->master.lock);
 	}
 	if (ret) {
-		NV_ERROR(drm, "Client allocation failed: %d\n", ret);
+		NV_PRINTK(err, cli, "Client allocation failed: %d\n", ret);
 		goto done;
 	}
=20
@@ -240,37 +240,37 @@ nouveau_cli_init(struct nouveau_drm *drm, const char =
*sname,
 			       }, sizeof(struct nv_device_v0),
 			       &cli->device);
 	if (ret) {
-		NV_ERROR(drm, "Device allocation failed: %d\n", ret);
+		NV_PRINTK(err, cli, "Device allocation failed: %d\n", ret);
 		goto done;
 	}
=20
 	ret =3D nvif_mclass(&cli->device.object, mmus);
 	if (ret < 0) {
-		NV_ERROR(drm, "No supported MMU class\n");
+		NV_PRINTK(err, cli, "No supported MMU class\n");
 		goto done;
 	}
=20
 	ret =3D nvif_mmu_init(&cli->device.object, mmus[ret].oclass, &cli->mmu);
 	if (ret) {
-		NV_ERROR(drm, "MMU allocation failed: %d\n", ret);
+		NV_PRINTK(err, cli, "MMU allocation failed: %d\n", ret);
 		goto done;
 	}
=20
 	ret =3D nvif_mclass(&cli->mmu.object, vmms);
 	if (ret < 0) {
-		NV_ERROR(drm, "No supported VMM class\n");
+		NV_PRINTK(err, cli, "No supported VMM class\n");
 		goto done;
 	}
=20
 	ret =3D nouveau_vmm_init(cli, vmms[ret].oclass, &cli->vmm);
 	if (ret) {
-		NV_ERROR(drm, "VMM allocation failed: %d\n", ret);
+		NV_PRINTK(err, cli, "VMM allocation failed: %d\n", ret);
 		goto done;
 	}
=20
 	ret =3D nvif_mclass(&cli->mmu.object, mems);
 	if (ret < 0) {
-		NV_ERROR(drm, "No supported MEM class\n");
+		NV_PRINTK(err, cli, "No supported MEM class\n");
 		goto done;
 	}
=20
--=20
2.17.1
