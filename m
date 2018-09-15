Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2E1ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C9721477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fTewfnNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C9721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeIOHGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:06:10 -0400
Received: from mail-cys01nam02on0095.outbound.protection.outlook.com ([104.47.37.95]:24416
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728533AbeIOGry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDvixhcW4K1OaXVKM9e0OaVOJwHUH/5dj+391Ym4tiI=;
 b=fTewfnNwCIvpHGF/KaXXVBCZSBL+/54soOlKDj4t3OX+JWFr8BJMOZKuMIUAyfzeaVcyKdazIdBBqoV06DizJqvujaozIqqipXVWJ7GXNJXbJVwomxKD6Dxz00/cPLsGPM6v3blD/TCxmRPqX/WZ2ev/9zrhP+FGwtTlUdu2rPM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 47/92] coresight: Handle errors in finding
 input/output ports
Thread-Topic: [PATCH AUTOSEL 4.18 47/92] coresight: Handle errors in finding
 input/output ports
Thread-Index: AQHUTJOrU2E4GqGpa0eJF2WDgUuZ/w==
Date:   Sat, 15 Sep 2018 01:30:22 +0000
Message-ID: <20180915012944.179481-46-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:YmY95NIMQed+934HXc55Wnq18Mi3QzDBGgT0suog5H86GtvOj72l4OC7Yws22ksQFdZLs68p8w56t76sUuXa7oEu5fevI8MekG/14ZXgGgg8rN4OLiKGwx2WVcViaE+M2+Vx3dc7cz77Pa6mEiPpitjHHf4dPYkohXRVbR2imBNl+WQj9Hj72R5AJ2MRq88tZ9RZKWBHaoRaqzokIxM22fem049n2qvjqmcW6i2rt/vXAFsvp9xs7b+RrtGSOFU3kupmq0Nx3R5e0zKRuvjvds6pzuzzpwcs4D4SBFBiq4S/PJBnzeliVhTWMsOvHuFve68F8G6vRKDiUg8G7JDTG2H+UmTKAlWAveZSaY7+q6N5u7a75ZBOGePBYj9pXftqLtr8lBvecBQ2Q2lFk4BCg1psWu3/IfB1IcDwyZnCH/QYh69c631rkxkouUE+76XJL/Pjd0x6Ax2KHsJxe3yZow==;5:ay5L0uxQdTZhVwHycsEDTGHG2eAh+WI38NbYkrO8KWpHFUB+ieH5kxMB6e/I9qR7TxBKVyniJ0tCWTzsYldQGa3Kz7qoejj4gW3OQpS0ijkxhNhni+upBtjz+W2xY3BJXYidWPNEdvSusNeC/vE8hHtvZMVLM0sG3ieENoXlBAg=;7:qwXnYqo/wTM+ijckcAvyVB/FjXeh1M1bwKf/GC5jhPOCAniRo/CCj4i6ig1WE0m7vJIKoiriqG803Mwqbpnt954boQwoeZSYZS/5nSqDnmF/F8LEiO9rmvuoMD9koC641g+GyMeXcRysMhzYtFqnlKiUdyzi4yt2dnncb3RNL3esniBGcIRSZJDWeKW+KFflmShQIaHBhZEN1dRVj4HZQO+8fGO/BmPlrf/l+wN/MAh9wTcFCcvuM6N6AuPOKj+N
x-ms-office365-filtering-correlation-id: 52f9cdc5-33b9-48d7-cb81-08d61aaade1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB085618C6F34CD9A2085FD722FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(76176011)(68736007)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: bc2aWwk2tWnFN4Y02/odnKyK2UBwgz40fqjBf3QmzBAioGUFI6z9UfhOzrdsHcuIV410SSnLvMbI25lDqLx44cYCFYmGbr7QZLsCJyHZKjUaEYEwQdK30fGRX0JUw57XAKtwxX2xJkIWL3aCIxHzsgO1XiXn/pTRn/d4681TNpDtE3eFA9g0OjNQD4e1csDUNKP0aJi+vvu+YE+siVKZjjxbjogtVYo/a8nV1jGC0hTSpyRtAi3gL50q9NECqTZhhrUvsoVx24F3hqIYJFPiV0iGq/6GM9OfKrgf7uBrih7p5fzhPIFmOrDkTCE2Rv0UN58yG9+evnW35r8dOZ9ToNnWkSVuObR95INAXpDzeQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f9cdc5-33b9-48d7-cb81-08d61aaade1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:22.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit fe470f5f7f684ed15bc49b6183a64237547910ff ]

If we fail to find the input / output port for a LINK component
while enabling a path, we should fail gracefully rather than
assuming port "0".

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/co=
resight/coresight.c
index 29e834aab539..b673718952f6 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -108,7 +108,7 @@ static int coresight_find_link_inport(struct coresight_=
device *csdev,
 	dev_err(&csdev->dev, "couldn't find inport, parent: %s, child: %s\n",
 		dev_name(&parent->dev), dev_name(&csdev->dev));
=20
-	return 0;
+	return -ENODEV;
 }
=20
 static int coresight_find_link_outport(struct coresight_device *csdev,
@@ -126,7 +126,7 @@ static int coresight_find_link_outport(struct coresight=
_device *csdev,
 	dev_err(&csdev->dev, "couldn't find outport, parent: %s, child: %s\n",
 		dev_name(&csdev->dev), dev_name(&child->dev));
=20
-	return 0;
+	return -ENODEV;
 }
=20
 static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
@@ -179,6 +179,9 @@ static int coresight_enable_link(struct coresight_devic=
e *csdev,
 	else
 		refport =3D 0;
=20
+	if (refport < 0)
+		return refport;
+
 	if (atomic_inc_return(&csdev->refcnt[refport]) =3D=3D 1) {
 		if (link_ops(csdev)->enable) {
 			ret =3D link_ops(csdev)->enable(csdev, inport, outport);
--=20
2.17.1
