Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2A4C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277BE204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O3GfFngW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277BE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeIBRW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:26 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728943AbeIBRWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4S4l4MYP/xU7DVtzxSarT9J+9GPXOHVUdzNOfGm0sg=;
 b=O3GfFngWnAkbbpFOxYyCGc2qWD65g7V460X5NpNK5z0DD8dxKy/Oyyzk+CVOKs2gAnBtryH1BHSEP/ya2hmdRITNymRnSXCE9IUoLFuOhsmglwdxx38UUH+7F7NuONbO2rrKJwmU/0QSzinJHiSVb3Pj9Yfu46XfJI9z689114g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Christie <mchristi@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 14/89] scsi: target: fix
 __transport_register_session locking
Thread-Topic: [PATCH AUTOSEL 4.14 14/89] scsi: target: fix
 __transport_register_session locking
Thread-Index: AQHUQr3Bf1Kh8SkVx0mo8Hkh4Ry7bg==
Date:   Sun, 2 Sep 2018 13:06:26 +0000
Message-ID: <20180902064918.183387-14-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:wWOr9OeSwuZFT0r0ps6+Q6jgiEkI0dheQGFu5jaWb+t7nlZL8KDOPxv15gEfAUykKGlFUlIqrGYdsc2U29KQN5nKlqfB3+GWF10RPd/8/caie7rIZSO2/NkvGHI4nTby1u9Z+wP+Yv7o7yPiDAsde5d0vI8nPuY0FeU28IM9z0QMFia3onUt3kPcltgnWezNPwwYPuRMxoY031jicB+bQ+k2B4zD9Sh5M9CRlys31liiGpI8fiAQDqitscrEJgnnibLQZQ5+h5GEHYdiUAfRfQhSAAobEmtS1+p9LUpVMrcL7ujKloR7MwnOiOrlOUnBsZz9ZB/pDQ+fgJuIxOghsCJ/fa05pU2NyucA4oR/nW7IFht7N9+bg/NP4uuU18LYRSTEWAedT+IaKK+jxK5ZAG62E7J109SgAbV3NwjFk/rWCBFw4Dob6dDaDRv/u0gkV6kHjFYAKm6trVZE7RJBzw==;5:rrwfwZomCEbDA8Gg0K943Q6f84xhd8/8Z4QJhDo+2Tumy6uVAK3KPgwqPJUn0S0ZXFrtmEkU6WMnjpJjBjfr+wVlapKy4a+VBIWdPcJ+oZai5I+RmxQQdfvOzDBDbY3dW0Dn6p/n7vZf+8UhQ+ALuSPMr8br3RCk5j57TdIYeU4=;7:7L4x7gLS4d+wZbJgbBRP+K3r4EfEA7TnE6ue0GcwhOYukMYEtpKifgT+cNoI0UWC+Hx2KS1UexfZv7uR3aRv3LQAayUfK5VUnIhK5LLI8OBqyqZZ1USHvfUvh+CCA0rEDTsmV5YjtYETR0kx7fcM2H3SyZxn9wK0NBYRlora2VpFPnfDfbJjH3KUmN6DTtgwvk7T8glYaNJ8EmucUhZ8e5hgf7Qm/6Y6/WRolwZdR8ltK/dnb/F23tDom+3QzSiC
x-ms-office365-filtering-correlation-id: 1f3b8ea8-933b-4c9e-85a1-08d610d4e3e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822B55C6E66E869F8D470EAFB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(575784001)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: KE7vZ1juhPNxTMxETyulJqA+BDC5Y8y/b0bbdv28wwgxKxYuUKd0aC06ErxbklsZi4jBrLhwpgTEsQXc0iedKNIACE9tfEu0SKLrgI/yEOQLEY2h/Qy4HpYyBrToWgWxkY3jMBXWnQQDaoF0sRPr+Roa9F/1/BLcsLK1Zddha1cL71J00nm5LduTbJb6Hm/XPtImG25qX8bTkdfsyh8uyG2E5y3+W7BwsnNk72rK9ZBQdhOaFFmDFFvUebnKeCLutNbBgpvbvQuP7B6vXfzdBcsR+d06HvjIscFdR5xKrFNT2K40wlwjXstHWkxMFKTHlW8l5xbTc7sprzSGBI+3eNVYxeqAshjfFW6lu2fOMlU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3b8ea8-933b-4c9e-85a1-08d610d4e3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:26.0989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit 6a64f6e1591322beb8ce16e952a53582caf2a15c ]

When __transport_register_session is called from transport_register_session
irqs will already have been disabled, so we do not want the unlock irq call
to enable them until the higher level has done the final
spin_unlock_irqrestore/ spin_unlock_irq.

This has __transport_register_session use the save/restore call.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/target_core_transport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target=
_core_transport.c
index e6d51135d105..0d0be7d8b9d6 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -317,6 +317,7 @@ void __transport_register_session(
 {
 	const struct target_core_fabric_ops *tfo =3D se_tpg->se_tpg_tfo;
 	unsigned char buf[PR_REG_ISID_LEN];
+	unsigned long flags;
=20
 	se_sess->se_tpg =3D se_tpg;
 	se_sess->fabric_sess_ptr =3D fabric_sess_ptr;
@@ -353,7 +354,7 @@ void __transport_register_session(
 			se_sess->sess_bin_isid =3D get_unaligned_be64(&buf[0]);
 		}
=20
-		spin_lock_irq(&se_nacl->nacl_sess_lock);
+		spin_lock_irqsave(&se_nacl->nacl_sess_lock, flags);
 		/*
 		 * The se_nacl->nacl_sess pointer will be set to the
 		 * last active I_T Nexus for each struct se_node_acl.
@@ -362,7 +363,7 @@ void __transport_register_session(
=20
 		list_add_tail(&se_sess->sess_acl_list,
 			      &se_nacl->acl_sess_list);
-		spin_unlock_irq(&se_nacl->nacl_sess_lock);
+		spin_unlock_irqrestore(&se_nacl->nacl_sess_lock, flags);
 	}
 	list_add_tail(&se_sess->sess_list, &se_tpg->tpg_sess_list);
=20
--=20
2.17.1
