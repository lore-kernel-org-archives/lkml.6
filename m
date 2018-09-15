Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8547AECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3318F21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Xm+S5De1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3318F21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbeIOGvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:38 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:50720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728379AbeIOGvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij05clVcs4ySqDt9V0Fr7MbT7jUFMzRvYx6EcgsUL2Q=;
 b=Xm+S5De1jgQdY6VeIeXWwaA4PTWf2EFTOrH4VltwFCmzQDcY7go7soIQmHO01g3MDeDMX8SRNQBPE32+08C/Uv6WEGsv8grEanQ4VYdV3eUeQU/JXX0HOlUu2pYHXiLxrjCqqNrwchUAPTAAk4bSLuXerpGyvtvDnksC7+IyEiE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 10/34] ARM: hisi: handle of_iomap and fix missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 4.9 10/34] ARM: hisi: handle of_iomap and fix
 missing of_node_put
Thread-Index: AQHUTJRASzggIfvCkU+ZszcEuutpyA==
Date:   Sat, 15 Sep 2018 01:34:31 +0000
Message-ID: <20180915013422.180023-10-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:1nef6a2TDfCq0+7F3D5SAuhKlhnBqhVFi4SLnfeTKZTmejhUBaE45si+czAqlB8LwaqjTGJoB36vhHXqDbN8hvz+UFiivsQjoulRAXfKMVD5Gjji7JfHiPCu4oT9IgwV3wmAhy2m8pQhEM2qjMiNDlxIUBcx+VGZT6pX2GJNQt14HAuXRO9+J6HCA7D4lff0YNGDNeCD0BSWYNSD+EWbtAti851NwhSPHWGHP8prd6nbYCE47OvaaClyKxKVr5FuX4X0pjspGneVkkX1h0qCKpVOgANWOHtiDog/rJMBt1BwDlr0ZCcS3qbwcZuvD45OyQePHN3ZuKhe2oVa0YVbWs6XDaWXbcCId/91tl/EoCa9z3djGoMqlpTEx3Jfkx7oazlxPwWHGb6CK94zkLkpd9H+u1XAmecdQyYcSuuW5Gk7pBJh25zVv53VJhkukhCxzNvFTcFPGkmW4XlS2/rnBg==;5:GA7+DjG8g8qrNBZmt4B8pUzWlZA4MP7iYgSfRPW5zqMYbr0x1oQTJSPnNDY89pfwFP5dgm5jiSOgdogPlm6C5IFExKca0RS+oDDq7j+leiDMPVMMh+uzaHB1FBQth09aFw+UnuqvQ/Y12sLi7+9LokEBSCNa8fyB3dzZ1xrvW1A=;7:LmLJf+MAMGIMpKzd8YYIewQEmyA/tGxYTiOwJLIlXJipZuTouPDYZwtNnPUpAS31SfKeiJYqhuNr0nOQI+IMGM1+vtzGOG50TpJJmv0orJj4TDqmpx/Dag0mlcxui3WgewF1F6Q042eKTzBqaT6UlSx7TUUnW099yNRikH8ppsviFLBJCabkdm9YNOknROdjJNQZfhkhEBgncISRVp6G039TfzNFR9qhyxJH4L3Ky1/jE7CcNtI1jPFPton/uCoQ
x-ms-office365-filtering-correlation-id: 0cc7fc96-a2d4-4129-668b-08d61aab62d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855547DCB62760DBFEEC2BEFB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8Yx19Gh1X8efi6mcZNVsE3C3jY1n/suhdhEkuQWIEyEdKZRtYuLl+1o+hAz3w7S++9W44+demvF/HcdjsgbWlKbAgxRyrt//Akgihb1wkYkDr7G7tXUU7SbziueMFbaZPA5a9YIrWgiXFd55VqYha7NlTYteaVp9Lfvb4rrS7r3it/vrujO4GcdiQ3MY0RbCqFj45fMBEFJACAC+FP9y+eq1sbSAhcb3wxAsyeCEDrnGgGwJDlvSxDcYMIp1l0ggVzx8xZydBMAGCKs084g/sTFlE/PfCHfpFw1wvjQwKhmbvAAXzDQADJOoZ1IPwedLjI7IAubLexZaG//ej+f3Rz0DLq+i2mf4Z49ls5ANU4g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc7fc96-a2d4-4129-668b-08d61aab62d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:31.8645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
