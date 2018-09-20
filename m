Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B0CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E9121521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ymgq7nDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E9121521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbeITI2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:46 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:41534
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387629AbeITI2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW2OcuyaK//YQKMTjQsV9AW80sR4F8rkjsV1ZURpqtg=;
 b=Ymgq7nDP8Ooy5g/BnECE3QKlIZlxBYX7tgVPErrdoQN0DjsIpBzMzXTstRuW1sEZob4/J2ym9A0vMLIkCBR8K5UJrBdcsMd+KS9ld9Q2ZR9L7sgZmDqHpU1iYX4ihcmpW9NO2Utz4D3XwxrFEVkShRNeN55ksfwTb4V9wkplViM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 12/56] bus: ti-sysc: Fix no_console_suspend
 handling
Thread-Topic: [PATCH AUTOSEL 4.18 12/56] bus: ti-sysc: Fix no_console_suspend
 handling
Thread-Index: AQHUUIxJ8mP5bMzElU+w6023wzqesQ==
Date:   Thu, 20 Sep 2018 02:47:35 +0000
Message-ID: <20180920024716.58490-12-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:rnFH/VMIjetC5VKoU6HhzXZ7qzaTbwEBwi6E2oXADojThxgF2/nFungZBNsWmjZKCq/3EGG5A6LzbjMLBOR3giKr0jM1wdbuKifaAFdlxUatn0VANLJQEBFnhFa7iZ4fGCYOCszrrJ73EknNv799g4bgq7404xa7Y4gbXDvowwwlBmaXBWCcPrZXZz/slezzS8CYNAjHCXKJ2chg6MQwBvUv1f66NU0ptBjfZeLaUpgpVVSKLplBwyLqDoZo0/iw16icWt7j6TgJhwv9KNLHA7QFNCWP/XrNOK7XD8+XTA4DiC7eEKQCbQZcuI5ADBgfW+wYS6RdUbH041svYp979CsomAwNVvCVamlCNUmI0jyX3j7Jv1ZK6VoKGCaqOscyJptLVtDJMCzS1aB5yYMQpxHGMHdGGTnj0juAki+ZNo3lQbxVjqayghb1gjK4K1JMdNOnknA4CJAobBoUzVF2VA==;5:08FqOQdaHfskAM/7TmcNcE49lpAIdnb9IG81Ts3xpKMA0SnVRLrqCMgtH9aRy2mL4h6rGf/DLCzExTe59wSVdhqNXNH9jvtP2jxqrVjNYr51zya5te37OBw1Lwtr3LlfEZ9okKgJ8UbQNOjSLebU3F9zZwGW+kSaXQMuG1ZHe48=;7:pJirMEmeXd57eQhBQ/vBNhJyj+F2ofBDJPGii6kxQvr82gDAIrlo6YkPClmXddBRUEsvNPNj6illI7scZWwMocPnBuRdz31NX5HCPaa0IukcPq7zqp5YG0l1ZkdjAKC5Ok5QD2wnCzaVuLE1H1BbTFjylpt16RPSQ1o+ZUd7WoleFuIFZ2rViV2dYg1tB7TCSs02Ift5WaG6BZUlXAASX83Ksg8jiuzXcOitDrQMb5nkuwb3d+LnNa4Va2SZzRc6
x-ms-office365-filtering-correlation-id: 3a713009-bbe1-4634-b264-08d61ea36bf3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB082244E9AF0EDBBBAF84F5C2FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(575784001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 1kthldFjz7jOdx5Px9lZMTMFHnUTFI7+wahyQHxkLJIxtqanXoK4wfbZQJ4n0e9p0GxsaBrL+Dthz/dfS0j7BejEyzjTjBFIGveU0oszHM78tMBGqqDL9oYq6QrucPZuKL2lZ870H92oknjrilBR2/371xC+jMSIb+KBwU6PT9QbEY1fiq7Vl971viSMwS4MGFGeVYwGch3iHq1iEVZRP3+/OxXCTzezbLLimD89qsu5W7Cnnsuf6M7ei33wiCOkj+fTO01JW1dufaxDaHDhLo5LXS8uGp5mQqLn31NWPgFLrABzMSaXiDz/5bd36etXXdq+5PgOm0gstDhlYx18ihXusP9/Olo9w9H0Fkyj6DE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a713009-bbe1-4634-b264-08d61ea36bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:35.7576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 4f3530f4a41d49c41015020cd9a5ed5c95b5d2db ]

If no_console_suspend is set, we should keep console enabled during suspend=
.
Lets fix this by only producing a warning if we can't idle hardware during
suspend.

Fixes: ef55f8215a78 ("bus: ti-sysc: Improve suspend and resume handling")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bus/ti-sysc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index b31bf03ea497..4576a1268e0e 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1175,10 +1175,10 @@ static int sysc_child_suspend_noirq(struct device *=
dev)
 	if (!pm_runtime_status_suspended(dev)) {
 		error =3D pm_generic_runtime_suspend(dev);
 		if (error) {
-			dev_err(dev, "%s error at %i: %i\n",
-				__func__, __LINE__, error);
+			dev_warn(dev, "%s busy at %i: %i\n",
+				 __func__, __LINE__, error);
=20
-			return error;
+			return 0;
 		}
=20
 		error =3D sysc_runtime_suspend(ddata->dev);
--=20
2.17.1
