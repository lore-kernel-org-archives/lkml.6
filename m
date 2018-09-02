Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF47C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240E920652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hEe3kE7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240E920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbeIBRcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:25 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730293AbeIBRcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpoK2GkuTYecjCZH7t09JS427VZAzyRVGOG4AQsjICU=;
 b=hEe3kE7MNhcFztpHDErQorb7BaeMM49UTdjxlGmN4KNkRmqXLa9ZefSG9Wav00mJD1Fy+K5V3qWheZPvhG6XWvMZ7HVHUK7RkIGrpqQYgEK+/bMYxpO8UfJJKYOQaaFbmwG8aRLOdbiodExk+5ieA+g8MLhzRO7sJQYgS70MP5o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yelena Krivosheev <yelena@marvell.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 25/47] net: mvneta: fix mtu change on port without
 link
Thread-Topic: [PATCH AUTOSEL 4.4 25/47] net: mvneta: fix mtu change on port
 without link
Thread-Index: AQHUQr8dRRf7bH5nCk+MZFiTsFmlQg==
Date:   Sun, 2 Sep 2018 13:16:10 +0000
Message-ID: <20180902131533.184092-25-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:EznsZQSVJCpC6diYsJxI+eDKL59KtF/gpjYWWVe/97TjniuML/YQEcrwe0T9Rzvt7IT0q0Q3aUBrzzuUZ36FErdxxESK8X+K/bQh227btryeWCAM3zZERn8l1uturd4F/eik5chLB73h1y23uCsKVoKqVf0d9y2x0XafB0R4c2kSL/JNpjb2ZEirgRmlpdYrT9FZ/2zNmPpLuHOPeSX4mjtu7ewceVa2zio7prXn0Hy9leBxCnepsomt2tlfwckwIaDH6k4O3FcxUa8is1c209PZqlxN3VW9qSjKeHJzmpGe2QWAntokS2E9hkz/ZXMMCSWb3lGT8xEL3y3y1i0p3diZIXsDwX22C6DTUL3jWoMhWosARTKF/U1dJWHtaIDUKjYiRDdZntHbh/4QCah/+QYoJwuJwg6evjRGIqrPC895T4CqnPdS+2QPBc71XB0K3ebkL7HpfW53T///vgxi1w==;5:DKPrSNnFByo/HhEqztpL/SQgxEdvUJnJXHEO6bvC7GfYBC5aE7jVDQC74LbsH2C44SlhFX9rIr6BJDWC1YqZ1uJxXKaiDAEh3CXoLHg+DLojt1DSuzMLy/0phxRTKYEASGCDHAvjXZlGmJHmgo2MRA1PkMrvsCx3ZOYlz+FZEi0=;7:C9zMgwtUOnt/5sRSwMI8SvPnywFBi9fJEBqt2bcs41Lfa+bAaWRZfMIqWZaLkuCIP3W3ahMv7BUhwUaVcOCPHv0XSK7D0HRlG5KmKYeeiVY3iEgY/gCtJmNCD3w2nWVBL591X3a842UucuN2bpa2YbRlKgGc8YUjk4D2mu+qtlCBtXRaTbwAhggqWp8vCDrpQQl5rptUMwgyDhaP4XedQltPHN94xV+jhLI7nAlxr0hqVi8EHfLA9ZvTBh5byHkR
x-ms-office365-filtering-correlation-id: cec3269c-840b-4077-357d-08d610d648fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629446D3B2946D48C0737D9FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(575784001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /0RTeqVyGdpJsLBMyaQJ8PEvbzhDsgHj3u6GJ0T+SXP1ykd/+4nBO4WeL7gVT1AcZlAy1rU0sf4oA4JRLl26ub4brLuJXNn1qabEZm3tBSzq2uCGtz3mV1S9KeJBMwWGcJr82E0IyoI5tKyfJ8zZ2NPUJJe3L8zMSVkI8EPInxPuz/PebN7hpH/HJLPOAj0duvScA6SRiV4HmbbRD1WTfi2nUTMUeX1bMaxbPHjIIIiWfp+NhwSDj17lhNEWfdqP7ds4qHP6SqAfHqdwwyY2ht9o8CHQJbVwHTFE6lOSg4GiAPQIE1Q0IDGGl89FvTIAelBU4E93782BNYM98bJ9qIcoFjtCcOXABfiBYf3ZvJ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec3269c-840b-4077-357d-08d610d648fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:10.1617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yelena Krivosheev <yelena@marvell.com>

[ Upstream commit 8466baf788ec3e18836bd9c91ba0b1a07af25878 ]

It is incorrect to enable TX/RX queues (call by mvneta_port_up()) for
port without link. Indeed MTU change for interface without link causes TX
queues to stuck.

Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP
network unit")
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
[gregory.clement: adding Fixes tags and rewording commit log]
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/m=
arvell/mvneta.c
index ea693bbf56d8..1c300259d70a 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2569,7 +2569,6 @@ static int mvneta_change_mtu(struct net_device *dev, =
int mtu)
 	}
=20
 	mvneta_start_dev(pp);
-	mvneta_port_up(pp);
=20
 	netdev_update_features(dev);
=20
--=20
2.17.1
