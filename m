Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997ACC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A63720652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m2qRal7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A63720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbeIBRbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:45 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:54352
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729240AbeIBRbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgeGv3zdrAlkNWGoqZOfBWomnz8fnROssp6tEBH+gvc=;
 b=m2qRal7huR0ylHhgcC1BydKfc1yxg0EMssEwRd22l7GFXQZ7lOhdz4Z+mrm11rilcLmkiSz+61RAcbu+LrfciFPln6RkUsp8/CdwRm+xb+O1CDBi0fcCJJ09YkJAUAwI3LtUJ08ZF5hmQPKSg0X69Z/X9S+uJ9sZldUPXgtym7s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Christie <mchristi@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 05/47] scsi: target: fix
 __transport_register_session locking
Thread-Topic: [PATCH AUTOSEL 4.4 05/47] scsi: target: fix
 __transport_register_session locking
Thread-Index: AQHUQr8N8G+na/YrSEWz0K1+RB0PhA==
Date:   Sun, 2 Sep 2018 13:15:43 +0000
Message-ID: <20180902131533.184092-5-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:Q/pBkq3LR89tRC2rsLVMwRRPzT814CoyyNZHOCWvoRtVQ8G723iWkrbOB6+gTI0xECueN76SWTuwXzw2sMrUTgenxprJzXmBx/SE14XY+TUeach/647lfp+xP2rqMUQBw+xw4ye8MhDvTr3cwh4qD0EOWG4mDubAfwYpGLy61+NbnvRtFZOZ0ir3QdVjsV48mJbSFXgfaKVtpDOWGpPSls74p3Zw25O6IDxtCF56wYmUixEU/T6gBlTx931KspYk0meab7LkSkMEVSehCuYSjPZduJuKhveYvZZBJoFLhbd5+7QbLE8GGsIXuyQ1mWCad87fj68drBYPKhiW8l9k2cCYm65ofPp2a0ULrSgO0pMgQrr2Wu5e3RxUJYotLGpEIp+/SF2nODHOvyJ2an8fnYgUOIQj4iFO7xqcXZ1hyn6ZiqwXj7khlGI2Fx+sGduzBP2QJhrKFPnxA9UxuQwpFA==;5:kEEevGroKBvSI572y5oVgf+rrEzRDbJ/vORJ7WasUOeUcPKIYvm91l4H8Yrgcs9vBS85WvyFSN5IR1No7Nl+xr/ZbwFNZxNUOqUefZp1MfCRr5VpFEL2Kdlz1DbOdyaHoJeDVN8wAlYBaHHB0RPTMTU+BWPfE2SEhIhJ178c43c=;7:jUj9pg5DX3nTiOLEul1A8OzIdQck2/AGxWjLhzUgKueryp3HVrdFxs+7vSi02xEgJcRP4gI7fSqWM5ZNgRxiexDZjdCEIUFk74eb2xu8DqteAlc3/pUhLk/J1f3HAhc7C+/P+3Oc/Awim9lYIOIPmkkzetogAFBsL1ckMkmnU7Hnybh5MTU/MVGb4axF5xIAMseIIH5dO2BFZ8vyZzu/Xnd9A7wk2i38GFHqwSPkZJRH+k43pzolPXHxVN4vPy6Z
x-ms-office365-filtering-correlation-id: f3d486a7-15a3-44cd-84aa-08d610d62ffa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01847A36C4D3046462125C22FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5Wl5j//fYdtxW2ilzswHxZivMaaGwzL51FYIg+DM3DQKd3WBE/yrL8Q/NILj8m+vwOAzypuXJOMqvR6RTMzzZBS5qb1zhL/XIFEElcwmtizXteDAdqpFIogtY4stfgd6NyNJ6nW3sWxGZawsfiJ+1vLdw/dmeCm0Izu77kxS88k6B5ecxFM7X1IDJ7GtLu2V+Fm/9+uWzdicgN7230MzxaXVrISECzoH3NrDwBTpx8a2iwN1DncdHYEXFj+Wuw0MXMObbLArZ6TUGm06jDJ8bnHJyPhSKcdG9/w3lw5wWkLqt23OblDeWg5LFwDNqL0J25j3fnyUJKCVWZ+PhKV34o18lgJo2KjyCfRAmQ0aGRQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d486a7-15a3-44cd-84aa-08d610d62ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:43.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 21f888ac550e..7199bac67333 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -306,6 +306,7 @@ void __transport_register_session(
 {
 	const struct target_core_fabric_ops *tfo =3D se_tpg->se_tpg_tfo;
 	unsigned char buf[PR_REG_ISID_LEN];
+	unsigned long flags;
=20
 	se_sess->se_tpg =3D se_tpg;
 	se_sess->fabric_sess_ptr =3D fabric_sess_ptr;
@@ -342,7 +343,7 @@ void __transport_register_session(
 			se_sess->sess_bin_isid =3D get_unaligned_be64(&buf[0]);
 		}
=20
-		spin_lock_irq(&se_nacl->nacl_sess_lock);
+		spin_lock_irqsave(&se_nacl->nacl_sess_lock, flags);
 		/*
 		 * The se_nacl->nacl_sess pointer will be set to the
 		 * last active I_T Nexus for each struct se_node_acl.
@@ -351,7 +352,7 @@ void __transport_register_session(
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
