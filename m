Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35CFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866192089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="odGb2sO3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GvqVB6+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866192089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbeKPJzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:55:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbeKPJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:55:01 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAFNi6jt027702;
        Thu, 15 Nov 2018 15:44:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=kklnJMJPBwp87IaYZNNvkCVqjsugyC8CbvIOJNN0tzU=;
 b=odGb2sO3ZBwjRsqXdSQh6cYrYFgx0h0LPhReaA0+6WVJABkeXsWgYCzcD4L6nerUoXs4
 iwJlItMsBCDodJ+ybJKBXYd0Q0GzsZ/8GAHP+fABC45N+2a5zadL/lKeWUCULwHtdqbK
 HXJDsMCXOfBiFNfIlem/rYXvIbhnEiw7Y3E= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nsft38q73-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 15 Nov 2018 15:44:32 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 15 Nov 2018 15:44:28 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 15 Nov 2018 15:44:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kklnJMJPBwp87IaYZNNvkCVqjsugyC8CbvIOJNN0tzU=;
 b=GvqVB6+NDboVvdIVnihy0w8WFvQzaIpDiT4fATmvsvjVD/5vialL+TDv6SjoAIHdD2f5ESr/jTIuO+FfaJBTIZgbFX5fxT7WhBCmemmEEGLb29HK0Y5a784Vay2wDZw5hvK6q8kMgkqjbADjDO072NhoOHxeoCzAgqO0xKUXLQM=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1902.namprd15.prod.outlook.com (10.174.100.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 15 Nov 2018 23:44:26 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6%2]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 23:44:26 +0000
From:   Tao Ren <taoren@fb.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Subject: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Thread-Topic: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Thread-Index: AQHUfT0kb1jOq4Gqx0OLsq0sLX4HDA==
Date:   Thu, 15 Nov 2018 23:44:26 +0000
Message-ID: <20181115234413.27009-1-taoren@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:101:1f::20) To MWHPR15MB1216.namprd15.prod.outlook.com
 (2603:10b6:320:23::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:cb25]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1902;20:0VcxGYlIgtEjoAQUr0GWmdAOf4NLLKNLNcw+jnIKxqA+U5FTvUDzZZ2eMURnfVfwZ7t36WF7qoDEkDxEk2mh56hrIo8VDFMiMhcoc4Nss53R27V/ZfG/uSsCrV6JjN8xJ1rnO0TEiAJ++tR9Xx/8baFntAoFvylp1NU6iCBNTzU=
x-ms-office365-filtering-correlation-id: 6d3fb20f-e292-4f36-9832-08d64b54471b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1902;
x-ms-traffictypediagnostic: MWHPR15MB1902:
x-microsoft-antispam-prvs: <MWHPR15MB19024DF2C81F79FE13963AB9B2DC0@MWHPR15MB1902.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231415)(11241501184)(944501410)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1902;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1902;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(478600001)(6436002)(386003)(52116002)(1076002)(6506007)(15650500001)(6486002)(68736007)(102836004)(186003)(2906002)(6116002)(2501003)(53936002)(14444005)(46003)(486006)(256004)(97736004)(4326008)(86362001)(110136005)(105586002)(81166006)(81156014)(36756003)(316002)(5660300001)(71200400001)(2900100001)(476003)(71190400001)(14454004)(305945005)(2616005)(106356001)(6512007)(1857600001)(7736002)(8936002)(8676002)(25786009)(99286004)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1902;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xY1LGeEju25RzBKpHZB9ko+XY+yHkyktbrha8B+pvkwqL3c51bDysOJ2/YDo5yLOpD0/eDt6B6tRSC6+gh+tpyQJDGFdoa+jZRUhOKNOyTLIlH60yFxOCUUdrJkTxbaIl/uDsH15dozaeeDJgIgHr327CGLxcUOY024TtPcK5R8QtBsO6xIzokRtJ+MLeSzh77Dr1H1aJR8sw08O2uvhn+PgF+JOYvLqs6DVlOeH8Pa1y+VaGXc+ndPFZ0Rho1s0uRaaiZEpoBUQ3BKsRZbdH/sWArtaLXmiVFyU1rmS28s5prDpjVLb8oeO+Y1v2tS/5C7PVc3uQlPuJTfDWVGNEYjl2arHjX/p2UXrqWsPaMA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3fb20f-e292-4f36-9832-08d64b54471b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 23:44:26.6830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1902
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently "watchdog did not stop!" message is printed when the watchdog
timer is not stopped at close. For example, people may see the message
when rebooting the system, or the message will be logged to console
periodically if watchdog is kicked by a scirpt which runs "echo k >
/dev/watchdog" command.

Given a critical message usually indicates a serious hardware/software
failure, this message could easily lead to confusion, so it's better to
just delete the message.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 drivers/watchdog/watchdog_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index f6c24b22b37c..65e9ebbd8759 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -879,7 +879,6 @@ static int watchdog_release(struct inode *inode, struct=
 file *file)
=20
 	/* If the watchdog was not stopped, send a keepalive ping */
 	if (err < 0) {
-		pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
 		watchdog_ping(wdd);
 	}
=20
--=20
2.17.1

