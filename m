Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E997ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFC5208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fV7w/EXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFC5208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeIOGrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:13 -0400
Received: from mail-by2nam01on0094.outbound.protection.outlook.com ([104.47.34.94]:11650
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728226AbeIOGrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij05clVcs4ySqDt9V0Fr7MbT7jUFMzRvYx6EcgsUL2Q=;
 b=fV7w/EXb2HROPaHR592aGhcXvPutKaQ0kpgyp5QoXs812D7tBziFHRw0LSx1R1bWeIjbrMHm2ld+t/yZg3R6ogjNrkMwlBlHfSPBMS/y/Ml+T25ghKeUyTj+nX6+fSZ74mT5XvJ3+m3ZmafLxklqfzQ0+eJG6aw12hulbr0l+UM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 27/92] ARM: hisi: handle of_iomap and fix missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.18 27/92] ARM: hisi: handle of_iomap and fix
 missing of_node_put
Thread-Index: AQHUTJOjROoxxyKEu0qNWupKfLdj6Q==
Date:   Sat, 15 Sep 2018 01:30:09 +0000
Message-ID: <20180915012944.179481-27-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:gTB8qn5CmCJgIToprzQ4+CVt1r36yzhT0+fUqzIfFxVuZ+nOIhH5rDgtS3ImbAPJ4iJphFqOV8s08hZD0tN4F7GWSj5HLAo3iI08kYCrpq+mjXcptUALKkC8NYDmAhUqvpRXaX4paoKVeFxVOnWJidlTSCNxV92of2HSLO2DxUVy3Z30whybTFrjn4RNKU6TIfBtMuIZv1zfgS93zxzi7tTD3T5hWVHYl8obHrMpSodeVHkyDaWEORqftiR8vi8565VHuwSmI4MvGCsvezEEwmRAamLx8/R+mOzk86kD9xktICVJH0njjkITn3ETvMt89z9xHRaduvyZdf2M/DRpl/gMzGorgT8NmKWT/kwN0dVABo0wKf8ovAvUx4n6u49QR+3XnC42QSZMmlER90fMdx0xvLZbH6YFXNCW4rCjPdiemmf6peqdDKVnRaJqFeysfDmBcKA3kkqhgaHTmxhSCw==;5:3cycBrp2Zp9eGQZvZT+r3hD4gHto2NL98EIh6E+djBL57Wd6qQCDr3JB3Q5jSGbLNJTAGn0sA7XuXDJ10krDRaWumOjvYNiG4axRHSBpGE6+6uf2mqieqCwF/o+zPcrVzGUP4gpjxOnBiPZTglcgP1wKUrNrbtC+ZcuZIRT33Yg=;7:xnmsBeTIcvg/iEIf31pMKg4C/LpcbbGRM/kf7Oo90e5zTlg5I2fIPzClZnLCCoNs9nCEVqrDcM9OXTCJOqnIaNe0fDNKvhLpNxoMKrPByXhtsC5l1Te0UxaUSG6vIyCjHSYCQIxBprasd63noPWHWCf+gceYQtSeGvmPAFuezDtpJn/W3mpMwzDbhCQxbTEiOwk4i63DzjGest+GUKFww8QBlSnq5/oxyobIhsV4PNKJc2ISdqFyLGP3US9qX8DU
x-ms-office365-filtering-correlation-id: bc4e4289-880b-4673-ec55-08d61aaac662
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB0741541FCF3FDD4D2291518FFB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(2900100001)(256004)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: AJ+94rsP+2kJQ8hAeBN9/mm6l3kJ7nnLFJBWyutlDde6MOl0C4evolWwxm9OqaQSYTYoz0c5AtArnJfR8mosa5XPjJ7srEVi36meJRHPtVgL3rwWvO8Cxw7+kh4F2LVRMUJ0BwvIXVtV+SpoPeLnc17LZO0wo7mwG/5otWsAr0rOygSmmrU/JCLJMvQ2iB23sJzDWfpn2Vwvd3ENU1xgj1v+EsKGy0OQC66mK53yi1Jgh9rsvarRH89gdv3Qo/UmLjgamqpoIw8apTWW96ulRAK6/udQpRKYYco8DClWCzX6++WrJJY0/Fbi9P+q7zd5fFfmv9O/F66YYQz8amo7EcGvevkWgShVG/+eLfYBpCI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4e4289-880b-4673-ec55-08d61aaac662
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:09.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit d396cb185c0337aae5664b250cdd9a73f6eb1503 ]

Relying on an unchecked of_iomap() which can return NULL is problematic
here, an explicit check seems mandatory. Also the call to
of_find_compatible_node() returns a device node with refcount incremented
therefor an explicit of_node_put() is needed here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 22bae4290457 ("ARM: hi3xxx: add hotplug support")
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-hisi/hotplug.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index a129aae72602..3f28c9141b48 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -148,13 +148,20 @@ static int hi3xxx_hotplug_init(void)
 	struct device_node *node;
=20
 	node =3D of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
-	if (node) {
-		ctrl_base =3D of_iomap(node, 0);
-		id =3D HI3620_CTRL;
-		return 0;
+	if (!node) {
+		id =3D ERROR_CTRL;
+		return -ENOENT;
 	}
-	id =3D ERROR_CTRL;
-	return -ENOENT;
+
+	ctrl_base =3D of_iomap(node, 0);
+	of_node_put(node);
+	if (!ctrl_base) {
+		id =3D ERROR_CTRL;
+		return -ENOMEM;
+	}
+
+	id =3D HI3620_CTRL;
+	return 0;
 }
=20
 void hi3xxx_set_cpu(int cpu, bool enable)
--=20
2.17.1
