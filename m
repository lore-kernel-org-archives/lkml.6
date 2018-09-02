Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F6C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D83320841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jbEgKLq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D83320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeIBRTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:31 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbeIBRTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfbjaDdAVF9OTOYPLmChZJBnrBW5MEF8o8Omr9VhLF8=;
 b=jbEgKLq1iZ7EX+bsD6IkGQf5VL2d7ipDiYLj5UbrDv40Bd8ZFlMxd8vjXO/KBm+aKwWNvxYB/LIlEebLDTF7s93PWi4+bQh/JPT/1W7JhTJW22M2Antvy6kgnQPR/CPIjhkWT0i1tc/9INabIfcvLA2z4DF2p81ko+4IeUOnzCs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Christie <mchristi@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 022/131] scsi: target: fix
 __transport_register_session locking
Thread-Topic: [PATCH AUTOSEL 4.18 022/131] scsi: target: fix
 __transport_register_session locking
Thread-Index: AQHUQr1WIMETYBKz5k2pKid/0uDbYQ==
Date:   Sun, 2 Sep 2018 13:03:26 +0000
Message-ID: <20180902064601.183036-22-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:7WqSL8fDdDb7Unw6l24gylUQc/TWq55tlDwvkV+hKJm23DpaftAk4PgUtC2+7O0HRp7RAu+qNR4HGbCqh+PIxJBOMVY4bPlwfxUGylUsK2DT3WPrJNeNw7HlIdJ2zajU6Po2QHPhvflRTbNGsuaBzn37sS7JbNIRVHrSUb+JgsyTHV4floESChnRj/l83aFi3GFPk3z/DNpkb2tnCXVjmjT5vou6GBS34FrmZMw7vct4+IVjR49zp5+yDw+zDmC/h/JSGXXFJai7jMGE8wcb+yGjb2GGrcDEig6gvn85R55jUU5ATkSiZLCX4MvF/t1XBhYxTRUBHAu1TclZtOvOuc1Hwh06Gkp3UHEjumOaXIZp1pZLzkhB6l+rl+ZuD6/rfquP2A62tpiYH0GpMeB4yPp/xFL2cvJdDBJxUV670F7Im2D3apMhNp+o658T41LDyopyM4f+7XgqHYU3XPQz8g==;5:7t3q9+rmUIAdvFdF/SOG8OA4mwGQzC370gMf72W+MHDWXsBLo+u82FXsba1mjn1a1fPlUW0S2GMssAgjLlekbt3Qrl10lU0rMaJJYGjEkr41P0vfU6JyCoWm06AVM9HcB5EBoKxRfhqMOmlrknbXJJNOG61tkYGWqLUQredFnOQ=;7:tvWhshf0aQRLAsUMV4QUDBd6BrtpQdo8afopcs5DI4aNKxwDgqmN1Rv4d7y1yWaAkIUueqC7IpK3Fvr3V8XFEaK3tvTUcpxs1hVUObeqrURfNcgKSi5C+NW45sq+syJfOCkGfDU1mg5lnGBdMWLxOOi+4DT82sWxw2dzcQcg+95YG7duJtZsM6JbvY+r7Eq4WFXea1NGKdG55wJ83ZQGw0PjyAt6HGNCfRWSADwqIUti4YyTSZpuyV0T4kZkdtg+
x-ms-office365-filtering-correlation-id: e9090ffa-87e0-4228-437d-08d610d478ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150670E571F2E79C313EAA9FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /D/OSgvXzkyFoQdk7HkRkiBm6xP4CkondWC8zwnnSir+7c8AoJcktIglyYjuDvnGrOPolKbyPElbMqspeo/xFZwucz4w3LeTK3fx9gB6dUUxl3KUjwKo5A20SOmJLug44OZXbvT7sKkpMmqohbsHIiujQ0Em3BfiLXQXb6sGyfWx+loYQ6VJNwN3FtkBl/0cm+pznmUn+k6KEE4TPD43QbXq/i3vFjAy3DTCjfP4afq2wVfvHf1S9qBL3VTLzn55n17fdZRXDbrcOr4C3jodL9ZbWt3l2y3CjlvUSXUfeUUIYGgmecQh4LhB+7J4xEy47FMOSuUzNWHSk2g4aQzQcDB7kq79qhkASwPY/tsgIj4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9090ffa-87e0-4228-437d-08d610d478ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:26.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
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
index ee5081ba5313..1fc87a3260cc 100644
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
