Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5301DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0203204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GAlEr+6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0203204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeIBRWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:25 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbeIBRWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l21gEKboSxxVawCFMSTWzSxvf3ZdVZbSYvQ+hNcUqBM=;
 b=GAlEr+6NbA04q2EE1Pgi4BhorY4hZYi/ZlYMjG7HETzzy29rJ4LYYvcgIS/UKSVcKKr8T4jIuisCMxM9XYH6oZ3rF548ycN4eM36ZkHsrOFhAlJ7jjFBdLK/n0YoCaKj0NxwCsmDeeY6fXm9w/5nAgsidHZpALM23Jc5m7P7c4c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 12/89] scsi: qla2xxx: Fix unintended Logout
Thread-Topic: [PATCH AUTOSEL 4.14 12/89] scsi: qla2xxx: Fix unintended Logout
Thread-Index: AQHUQr2/6mR/YzomxUW5gkxXXGOo/Q==
Date:   Sun, 2 Sep 2018 13:06:23 +0000
Message-ID: <20180902064918.183387-12-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:iDiHm0/+5X9Vo062xb8NV8TSwXYdaTBgt0lFoGMyRYp4wwzqNcc0jTRHiWaXTmamRMFMTJLBEec06L0DXJF2eHQtc3w6NzgJY66prougXsDgcq3BvVysjaslNY1JyB8PRQ1PfGY2EMVjJAllFmFRLNCTEEqqKbYYPJ+5elkkeO6WY7hEA0fHM2FQ4LaIbuuF6Bp8xQkoknQV1yjqTLh1AnUeF6W/TVAAOEWYIxcCanP+zT1V66JIlDdrf38wOLLP6/67QtOoq4BQq2oF+w7RfFAfRGX0R7pgcX3C9XfWaMxLHCLvhDirfzUo5s2blDGzSGTnc1RGFsFskPq6DDD/5clIAsriubUkyhAmWshY5V2VzNK1mVftGihXioT89R+pMSemrJB6NMF34oHDS53gGe4uBx9eyXJo4n2jEIg0GzCDVOPcRItqIww7h93P62A4nB1iHNTkBMXCg4uJl/gfZA==;5:9qgoXbmDplrQa04Oq5G6J6ZFxXiSUZGs/bb8nlFFH7w8sXzh6PUyI7ZwcE578ZVzmsYK3FsJm9zBPEtdgPbv499MGmtI+njhThnypQVsC+tvg/7+p6O4M42Oz49ReiILFuxNx2bKJsSTsm34IU7tvWC3nET/TGoi1vo6KOStoGQ=;7:ID8Ms5WsuIfpuc8hFvDZcA8fP6lut6n1JJLKc+KB/Vr0vRoUjMzaMos/D5E8K4NOBv5e88EhxjkjFdOxeHIi7sNNy603xcIf4eSLTI5VCNdW+ntCfOqQkM8YhE1YC7fWyJYvOivTGlzoRJEgVISsnAaC9krssACuPNZFOaJ31xAUdRN6j4W9YeZD8mVDalLfaYIvCY+a2Fqovk5aKKKYK62vMEY9zhza/i+aEmH7lxnR0Ez6xUS28h3x1kmCiujB
x-ms-office365-filtering-correlation-id: c1f45856-5b2d-4f2b-feeb-08d610d4e2f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08220DC0E8C6FCA9CE204609FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Gh5yvIjQaQZaneL243ZqtrOf0WKq1l75iWp7hn3AO4O/dDOX1m4ASOYo06bTGcWCl4VQigNW2KzmkJDJ41Le+FD/Xj+8DIId66q8XaDEYbZUydO0KHA2CLAhuImU1Ywqw5qHsLYXlmBrxA+BYpgUGGdye3qXVBypE0f05qpkuqad2hENenynMbFZAVEsstl+H8HxAvTyUxNkYQ+9jIHgkanyWWNnpkQJw85JKoNRNtKLjEAMapK1cl85+mqTMX7gztqjguOzNJBrIoRZl2mYG3VRTGrp/Rn9pSMWsF8Ijnmh84yjXpYjwDP6sQ3cVWCbz5de3fIDOAwACdy6z47rJjZ3mHqPwh+sRz67ruASMXY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f45856-5b2d-4f2b-feeb-08d610d4e2f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:23.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index d6fe08de59a0..d9fcfdbe34e8 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -971,8 +971,9 @@ static void qlt_free_session_done(struct work_struct *w=
ork)
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
