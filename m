Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA3ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364CF208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iN5tl2iu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364CF208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbeIOGuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:50:25 -0400
Received: from mail-eopbgr730099.outbound.protection.outlook.com ([40.107.73.99]:42981
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725744AbeIOGuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YLMQ7MCrDP9zdSVZSf4lswiWDc1LYd9q6qoJGXJlqI=;
 b=iN5tl2iuaay8LcAnwDfiOFO4OoujgE43HZed7uh5Dhcf03qToh6MqwQ5Yi80JeqOI3IQBtI68LsePWozu6fhLjUx+nRs42GXHgb0XjVXc5F0Qv4xmQcyJ5Lt7V09vFk5wE6giAfjAj6KQ/8WBmyAme6i8ipb/fXLGB3YGPaCv5U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 34/57] coresight: Handle errors in finding
 input/output ports
Thread-Topic: [PATCH AUTOSEL 4.14 34/57] coresight: Handle errors in finding
 input/output ports
Thread-Index: AQHUTJQEh1NN8cuIbEKJ1F108scZeQ==
Date:   Sat, 15 Sep 2018 01:32:51 +0000
Message-ID: <20180915013223.179909-34-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:YF2cx6UvSzVuCq6KQwRnCDYo7M5hId9mEGnTRRFFOkZt7s7YrlyQppJ4xqIpv+IdoV0uRvSKhlh85PIL3mgqXdt3cdLcbZiI58JDm6LnRrwpLBa/WBvfdNWwYA+zXLUBLBmkTWVMQYZSgKOx/WFp81kgKtBP2M2TBdSJMcIw9O7RA5CIRrQA2YfsdalYgkn1YRfXxydYD4plNlnOzGGBbhWNQfL06ZGFoPVt6h3vsTI11zDy95esZlDUohNLyvWXm/j3E/hLCyNtIWP6c3CPyEIOqOWXUgUWVO9TpiytyKJQ8LZZvvHrJTHX3N4oIq31Cvz9omor/t50/kmMT15Ml3Xspv/u//0rl96NCi/NNx8stQsa2QireGCGl2aWFt4xObiwbkYBzuavhuzZ/yXwrmQiZiQWrdu6Hs7JvBMr1of8xDsdkgFAohD9Fp+9/8RyeZCfltwm2R/GTbvZ3vVKhQ==;5:ulDYyRVcM73zu/VJZQTikjjFG+e2S9N/uhfQf6ufdH0rBpm+NMSYox1KkWPRHrVyDc9Z3XB6PMrEJccr06bDzcUhDrmX63e9Ym2gsz6Yc5wBYPTmgGexRJ2f99FlEIFuaiiId5S22rsQXsuogmnYvvtPk//Tv67Hr+pHVYwJ/nA=;7:ltJxwn0P02Y7dUdP2cTxk/QzkZqTz62tzzf8/WNmLDn1KSEX9QcG1f5XugDtLne2sgrgxoSIH4ujRp24Fq16lkBeEXHOdKWYQ1bv/KPausR5D5pxDfasGalQPj9HqP0wb6pynEM4Q1nuabcaGre/hIDpeFNcQdjfBrhMB6blBVMiSxHH/YEYN4h7jgXjQRAZ6fmXRrU1bKhXUyuYY3uoQ9HEPOJYaAuNxVFZYpFiPpm/5Rvxq6sh22pfzu2isa65
x-ms-office365-filtering-correlation-id: 7fbca60f-aa54-436b-97e2-08d61aab37f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB047165A694D9880F1B435C72FB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Yfwx2AsP7T+sBXJV882fg4KCgTFpSO+W4mNuMXG/XofsA6T/JDVmdVGqnNgNGxrQrP0/DGGB/bBnwe+d5HOqwBDtGQapD2ebQUNavG2rIkIpRMPlVZxYXVBspSQozH67Ikog2E79legy51qtZgBOVzFgUVoNJWP4Uc0cEAUlgzr30LRZF2Lnx8vrWX7QPUj6FPYjBLFQoNDuAL3YoEX+F55wLp2UxcGNNTqibtupt8qEimrHdCe9vNwtkOgiE2ZTGPkieVoDEQfQb7qqj4HJwnhW1KwR+liyGr2HhpkLuaWMGnPl+yEfyG3XvG2aie8LnlKCRq7wuCA13BSJI5pc2H9l58Bh1RN3cR3JKgLtySs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbca60f-aa54-436b-97e2-08d61aab37f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:51.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index b8091bef21dc..e571e4010dff 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -115,7 +115,7 @@ static int coresight_find_link_inport(struct coresight_=
device *csdev,
 	dev_err(&csdev->dev, "couldn't find inport, parent: %s, child: %s\n",
 		dev_name(&parent->dev), dev_name(&csdev->dev));
=20
-	return 0;
+	return -ENODEV;
 }
=20
 static int coresight_find_link_outport(struct coresight_device *csdev,
@@ -133,7 +133,7 @@ static int coresight_find_link_outport(struct coresight=
_device *csdev,
 	dev_err(&csdev->dev, "couldn't find outport, parent: %s, child: %s\n",
 		dev_name(&csdev->dev), dev_name(&child->dev));
=20
-	return 0;
+	return -ENODEV;
 }
=20
 static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
@@ -186,6 +186,9 @@ static int coresight_enable_link(struct coresight_devic=
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
