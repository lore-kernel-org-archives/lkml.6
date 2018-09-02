Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC67C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1383204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ic+77oUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1383204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbeIBRYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:51 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:32952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729724AbeIBRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr4uV+JiSmz6FFFhoeFau/l1JyYIuIfzlkkyHWeKAMk=;
 b=ic+77oUI8VsPWd/vJVnG/728iIVlSZH7QaqYB1OCvUaAq3Ts0afQHap2QSC6XXVXOvgQ2qzbouiUhSWvNlDNiOgez9JtXtE1XGPdn0Oz3sbJtILZyZ/lqTSOkLrr3ZFu5waj3dPeWZ35sNiLwMtQER5DgRqtr3CCPF5VvjtO4vA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Christie <mchristi@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 06/62] scsi: target: fix
 __transport_register_session locking
Thread-Topic: [PATCH AUTOSEL 4.9 06/62] scsi: target: fix
 __transport_register_session locking
Thread-Index: AQHUQr4Ql//gyhWgQEWjMqK1RX7TsA==
Date:   Sun, 2 Sep 2018 13:08:39 +0000
Message-ID: <20180902065131.183542-6-alexander.levin@microsoft.com>
References: <20180902065131.183542-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902065131.183542-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:J/0VHfL4MRydT09MOiOtxETNd4/Ycgzz76e8god3PLs4i0xY1uiwHEwd7xJ0sIc5tn7+69hTfFjCsy1fydQWGmjdWAImMssF5wvGlBNn1L9CqhImyxVbE6U9g6akLZOTb32t/U4XUT982GF13hK9T5QjPsjXifZMflIUSdHK1fgKmPbb+rJXkBrK9ZJ1H1bhYqVVL2AG0mOKN9cI51dlCBrHSVYeKxD866BgMJd+A7L2Hj9mqNyagfxZtthLejda+cO2GuCQPrDqLQZTAd1KjQ8PQkL0ClWpyfTBCn5+hwC8Lb51n65bCwft+48yTau8h/Aw8YOAWIkhq20IXA8Pk+z6Ne1rotg4+3RgYcS31hebKkNX45XAK7m2BOFSPKvhcIa38SOkaF0uhclsbm4kjyN1rR3fmINIRnCVgSs6w2ClbJ0L/2UfdIrtdfS6ylyBBypy5BurjzhRIl2zP7s66Q==;5:gbMpIxnol84shrUt+/DSuoG5q3l8bGR4O8L7AR9w5tw1N0GJW/4APuCja9LhXLk4RwYBks0SVlbnieQRmEjpNb8GGtGe5kVSRljB8zle89FpnbGQmraZ0Y9sIEkFAMr4xvbHcFx0HFhXxrp4UV6R4945JAeTcHrEhk0PGKl1PlA=;7:PSDOupcGDb/i3uP99HWGJvlb0/Jlx+AcL4HABCwJEhQDBjgy7e18nqr44axZnS6vys2I2lIhV/+kh32wYyo/nnaBFsCauioiKoBNI8WeYxQYyZRShWQZZgtyPVBChA8jjGNzqcCL7sSE63f98K5tnhUqTbdikFdl4zsaibeIo3BhDqmH0pHGkzRWZXPo5w/282h4x/+BzutNelwGr8FjuYMB5sKQ9TRP1SK2fGJ4my+ClaQeorsD2WrOCIOKby6B
x-ms-office365-filtering-correlation-id: 0f1fa323-b76b-48c7-0eeb-08d610d53caf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469E243825E664FDD763AA6FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w7E2i7o86E2+sj85KLqRllxVy2f8sYZJBLgcYhccqv/5NJI3twcFsBpS5nrN8UVDZZco6YNLhfXevMarCEUj5GttToJu8IxwT9/ercdrwfEsd22BoGfKWuPZjPK3pmFo/LoSnb20VH05iocqybzHRJ+Qzm/jHqurN+4DoOG9dNcwRo0jS39nHBJJb+tnZabqSSod0gNZ7e8AbosntX06aqy8MxW+wUHrbhBgsUVaADnlPKe4j5Di1e34gGGHyoVYBvWtGVV4GYJYw5TvSuvbQy7wFUM8j0TCAJYN3nt+mCcj409KX39fsGN0QavBatVSAeheAherKALRTkX+FNfkyq3p5a8Okcrm5YlZH4riBx8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1fa323-b76b-48c7-0eeb-08d610d53caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:39.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 6f3eccf986c7..e738b4621cbb 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -316,6 +316,7 @@ void __transport_register_session(
 {
 	const struct target_core_fabric_ops *tfo =3D se_tpg->se_tpg_tfo;
 	unsigned char buf[PR_REG_ISID_LEN];
+	unsigned long flags;
=20
 	se_sess->se_tpg =3D se_tpg;
 	se_sess->fabric_sess_ptr =3D fabric_sess_ptr;
@@ -352,7 +353,7 @@ void __transport_register_session(
 			se_sess->sess_bin_isid =3D get_unaligned_be64(&buf[0]);
 		}
=20
-		spin_lock_irq(&se_nacl->nacl_sess_lock);
+		spin_lock_irqsave(&se_nacl->nacl_sess_lock, flags);
 		/*
 		 * The se_nacl->nacl_sess pointer will be set to the
 		 * last active I_T Nexus for each struct se_node_acl.
@@ -361,7 +362,7 @@ void __transport_register_session(
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
