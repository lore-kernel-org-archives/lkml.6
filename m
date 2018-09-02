Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C5FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6445920841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mJSjmhFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6445920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeIBRT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:59 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:46915
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727414AbeIBRT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll7syr48z3vSLsqdzMzU7QVFUOqE8MlaXovXdVvfZ0k=;
 b=mJSjmhFDzid++qK1psEOYWmknnSzARZRLQ4m9j+RWLstNF2ZhTkZKCiMNvg1p4s6iY5ifuQqjJ33339qP61W4d680u5Mm2jvGiiPFhNZY9Q5jjV0deys9iDvillkyY/UJxQ4lrc3FqXF887g97u9d2JX9Gq/PE+AsEAC92qtR40=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 017/131] scsi: qla2xxx: Fix session state stuck
 in Get Port DB
Thread-Topic: [PATCH AUTOSEL 4.18 017/131] scsi: qla2xxx: Fix session state
 stuck in Get Port DB
Thread-Index: AQHUQr1SW1LyyAo9LUW0osUgqHw4AQ==
Date:   Sun, 2 Sep 2018 13:03:19 +0000
Message-ID: <20180902064601.183036-17-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:WhX5aZ6XXuISqDYxh/ba6OWp/bCy+a5G5MQKAnJsgK/NqnB4NN2wLI3zBcf1ceUHjxEJhEP7ojcKbgZtSnP69bXb/i/UWj8MzpYaO98bIAvCCPwW0ReVajanTHJb+Yb3sikybffrZYtgh1hjvWnwA25hxU1ExR/o99JSlZBK24KLxCTmJ6KCJNw+pTWM/fyIo+3tuVXpFfxZPH7k9QKnD5e1j4yHDsL7asebeBveW1WTRQQvz6Ze42R3LyobCKQzOji3086g7owj76zQoxi7HuksaSRbdBCw1zmRfM2L8QSB1u/bJdO6d4mQHivHev32wZ1qUPT/rwFOlst5z4sxjpArr+ktwSEscKu4jIEWG4AsqDmiZOXs49gvXnQvhCcvdkbeJt7h26WAghgYGVvWUoU40ouTguyu9C4doGzvanT/8dpJctlGxdntml30dkeOnrpBLL1Ww3OH7TsoS5VIdg==;5:Igrs3tJGWwPzBA+Z05pZk+slNgOrJR5obBigJ0p+x1Zx7Okj/WmkVhXfZ1Sg6RBdn1kEJjC4yOt2GLYxh1fIYYCoYFsaP0P2263tq/W81TcBgQRp65nULE270nBdSfTukkG0zvfzDXd8xiQ2YDCVMlKLn7jxrw5hRHIWPbqVX7Y=;7:CYLNUFmD6VLlW1pszMYdEbjaP47ch/7A0LjKft/GvDjJWI6ZueQBkkdHIxJ00UDxxxTavbdWt4KXBlRmWfTXLO5hdJ22UNY2SNm4aFwjjoQr5w/n7j4hwYwAy+EflE6yoCEhPnVlaK31Zo0pVO4MDu4eDZ6+JlDqGK317r7/8vuQrvhNlygmx8q6NGOMsTz7aHkO4ZE+JRcU8w1gWHqS4rvIvkJwk4zOOBYs/AN2FxmcHFaurPwigGN4fxbfTNbR
x-ms-office365-filtering-correlation-id: cf17f01d-196a-4393-82b9-08d610d474f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150D93201F7012A1FC653E3FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: xye9pHNOdCI0DFkp7ZV+ORnIY8mniZTHhbIGtvYmPFlMCQhsEHz5mIznYaOilicuKpNzzoyr9VrdaVz9wUKPwRk2GbSXDcu2p47qmqBoFTB54xMSuWolxBmlTgxptOGTciezJQiAyGdE/jIbfcqjukoo4/M35nqq+dA0LVAmLWr+PAXnmFbFZECjbaMcwBLE+0xKEcn/ZnXzta+bP5bSqOIKUJSAHkFJLfbQrsuoDOAj/EG4yrhb2puCSQq7XzpSXBVjzEg+6TA3kTdwTlF7CjhiXgLQbaD3TeH3ECTwnTrCYaYLSeIqhedctoSckAFJ1LAVtTNT6hQ/YMEOj6ZOBYT3wdDT6m15Q+Kx3Z7OnNc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf17f01d-196a-4393-82b9-08d610d474f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:19.9108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit 8fde6977ac478c00eeb2beccfdd4a6ad44219f6c ]

This patch sets discovery state back to GNL (Get Name List) when session is
stuck at GPDB (Get Port DataBase). This will allow state machine to retry
login and move session state ahead in discovery.

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_ini=
t.c
index 1b19b954bbae..ee6d38fa4fec 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1074,9 +1074,12 @@ void qla24xx_handle_gpdb_event(scsi_qla_host_t *vha,=
 struct event_arg *ea)
 	case PDS_PLOGI_COMPLETE:
 	case PDS_PRLI_PENDING:
 	case PDS_PRLI2_PENDING:
-		ql_dbg(ql_dbg_disc, vha, 0x20d5, "%s %d %8phC relogin needed\n",
-		    __func__, __LINE__, fcport->port_name);
-		set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
+		/* Set discovery state back to GNL to Relogin attempt */
+		if (qla_dual_mode_enabled(vha) ||
+		    qla_ini_mode_enabled(vha)) {
+			fcport->disc_state =3D DSC_GNL;
+			set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
+		}
 		return;
 	case PDS_LOGO_PENDING:
 	case PDS_PORT_UNAVAILABLE:
--=20
2.17.1
