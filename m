Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AA6C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9856520841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nJwmLf5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9856520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeIBRTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:06 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:46915
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbeIBRTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBrkR0Sb17OneU1U5p1o3w4TQMmcDG5EDV32mRpPuIA=;
 b=nJwmLf5OgdD62V1sd5pP/3RLW4cCgaVRNPTC4zOZ1hU7A4c9Aiy3Z7fHa5i0+olQZf6cP23JCNZwzLEWQQPRNd1/FjoMrLhVs9PqHrNCUVuV+XjOOuuRQLlu8E9ZRTcOrqm0XAUuXQ8D3XsnhVTabpv0V/Pq0tvkijSdd1nrsJg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 016/131] scsi: qla2xxx: Fix unintended Logout
Thread-Topic: [PATCH AUTOSEL 4.18 016/131] scsi: qla2xxx: Fix unintended
 Logout
Thread-Index: AQHUQr1RZGc588KHQUaKb8R28HjJKA==
Date:   Sun, 2 Sep 2018 13:03:18 +0000
Message-ID: <20180902064601.183036-16-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:Bm3CSs0bSQ6iMm4LbMareGrThcLWvWT12QLCQ8w1gwG36BvukUzwCTerxu3CioVwa4CkdcVvjKz2FqA+4+HWGvpsKvpOzW74LcKlU34FMrG5qF0DCikEvSNevSINQS8syQdtDc+ges3szhJxZCMbxnKtEYEKwcTVGJEkB2UVLtIXqehH6fx23c5n3KMqNuYvfi5FQZFuS0dYy4XVTRr5E+XKnqAWLCc1rZ/CztV5TSsJm7GAZ82zeyIzVoAm2ViPMRyBJatXKxV4WEPb8cneSgAGpkiN13Y8M18c8PE3dMSieymursFNttnjWEpCcrmaJ06NfeuZNM5ticbBmEJA9DupjRjRWcAzREtowB3euBSkN46V8/I8Al6H/JZzwseItopWFYO4cJcI6c7AD19vMa0CuqV8QuBFNdsuXuLWWaQGxRGNlAbgwDfBKouT4hKPMJ8FyI4sc6+3ClE90H+8eA==;5:Dg228G/a9BFiUrqFWGrninsBaKDw6Pym8Z4xGA5WEH+LDmRsLglrnSE+kmW6pPP40GKrBkbBYnGUsQqFWjZMl3g6cODNBQE3rzDoFwKKHIGUxD6TbVtv1RoDGTungEXxDQP6Y+S8cMtTtmc2jTn54hsP5dcmKvbeCEfGsmlNvK8=;7:holHSvBhLaqWiLeyUASjI3FI/RYkemcKg1DEJCtn+o/bN4/re1rHxmK8Qhw/LagEG3mL71iTopLs2N31Igdrbnk32zpsjsdF9Cfppk9bLLidJWcbbsQKe6c5amW/+nVenwqn+RODNcpHI+RnsxGVkLGWxRlwwx2+51Z/YR63dJsOgal3svPjvVWHUJQpihenzDFt1C7NMpAkKAIt+HIKaZi/DnsfvrIPK7ZUFUT2GbxwIqOQKawGrw7fp+2TuA1j
x-ms-office365-filtering-correlation-id: 554d016d-9491-4b94-0c17-08d610d47437
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB01503E8C31C7F88665F8B94DFB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(575784001)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: fLHGktusry0KXbSXKjtXKo0RrNpgT+OehSnYwDmnSUegtnip18NaGhp0MCeJdyZZ6Wp+eMBvx8yqTHKXQt5dJH3H3mXquHZZqkHr0ImRN6ZIckR1eN5d6k51lB1iu1Zm6RbttFBV91I5GdhyyO+VsWH7QwqdowZs80CBW68F2Hr3dbrgVmxU5BQT84MvCkvlKOB7yR+Dn9FH+3raK7XUADpfnKN+UlO4pcQNpjF70Hcp1lmF7d4EcYeSSNA4M1slVSMW0KN0i0Xs5ceAx0DqePqJ3lGBFHq9F4MvN69iQcmHrQSmK+XQwS6kQ1+bMPpAz+wbcAMW4VA3GzT4tBTO8uYGjFM1p5UxH0gvZbiEvho=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554d016d-9491-4b94-0c17-08d610d47437
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:18.7118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit cb97f2c2e8d9f8c71ddbf04ad57e163ee6d86474 ]

During normal IO, FW can return IO with 'port unavailble' status.  Driver
would send a LOGO to remote port for session resync.  On an off chance, a
PLOGI could arrive before sending the LOGO.  This patch will skip sendiing
LOGO if a PLOGI just came in.

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_t=
arget.c
index 1027b0cb7fa3..6dc1b1bd8069 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -982,8 +982,9 @@ void qlt_free_session_done(struct work_struct *work)
=20
 			logo.id =3D sess->d_id;
 			logo.cmd_count =3D 0;
+			if (!own)
+				qlt_send_first_logo(vha, &logo);
 			sess->send_els_logo =3D 0;
-			qlt_send_first_logo(vha, &logo);
 		}
=20
 		if (sess->logout_on_delete && sess->loop_id !=3D FC_NO_LOOP_ID) {
--=20
2.17.1
