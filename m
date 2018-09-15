Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131B1ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A94208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iMykwKDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A94208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeIOGwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:46 -0400
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:8380
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729484AbeIOGwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlKYVBbXpNrUNMY5QDWdEoRqXoGWbrYo7SUrYCOolXA=;
 b=iMykwKDP3pboieQGi5TcdkHyayhB+NK1/CdwGmisL2YYiLSALMqy8Q5CdlK2okWaa4vS2akeLbfEHRwaXnXEKXVLgRw50ed50+rfKOh0C4GgF92Y4EAZw87FStnyT4/dojHMqJqwdUlr+B9nM622po8dbtTgQBXM9Yo7pCZuW98=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 05/11] ARM: hisi: handle of_iomap and fix missing
 of_node_put
Thread-Topic: [PATCH AUTOSEL 3.18 05/11] ARM: hisi: handle of_iomap and fix
 missing of_node_put
Thread-Index: AQHUTJRhSokemaXSIEytYem+WOnOzw==
Date:   Sat, 15 Sep 2018 01:35:27 +0000
Message-ID: <20180915013521.180178-5-alexander.levin@microsoft.com>
References: <20180915013521.180178-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:GYRJOX79mSAGK1/ZH8MqKCmsq+WWxWJ0Tm7pJypX2XxlrfZK+bR+PhCmigKc1r0jRNq5C8kNqBX0Y7sdf/g4YeapSbyu/SR9JWydsDfqPTPXNs3HRI6g2e1cl6voW8Qntx0KfGOIVcqJrktj4lQ8YOuZ30IuSF32/UZwuHn+P+M0tv96hr1s9cxIte1jORw4jXTc/gOqq8EWZBQH4mOB/ReM0mqIoYIpwyJBQfFlrXnWaq0o1IeThQ+M1Cr/6D3vDDHB1X0e6FMfbRorlWFk3aDa7+uZg6xiqiNzODO3ConlbKiQjVoCMt4jchtTveSMV2j+fXy2qlVga5A+fElSevhBl81OEDBs4B854qM7IjL0QJLR7XzTZr8ha7WhtvN0+CaQPub9SKDJHxh/zKM5f84HxIuy/i1tmW76aa611qc3BpTDKseJFnI82DJ9iNWlf/pgypNp9uiVVS9Ja0EwEw==;5:HJ41ats27UnPQ4hpjrUVcelt6JiAsPlOyxissJrbtdRM/Oah1mXwmHEERQ8vgdUSxWgX6FJFRXi/4SiDX4WOkLvHdRQxSmydc9JzBI6h02q0ZBnv4v2rYqm74lYRHh1Ht9lSoQ2q0GrvHyyk0JKmU98mR2TwKqiOAUzJaJh3vGg=;7:lSn1ZS1ojqjCHD2tIHgXHgUa/gyShe+5yKd8YezH7rzQKtuW0TGF29zpNehO9T2WJQv+/dxBZRSBvSWNVX1OYHvBqAkWFvMNLxKcG70XHIb/mVfuKxM6vk1d+N+X3w5/wtBlZX5LerfJejcCXjntOs16iz2naTqbTWiZRdH++FcezmPojVdTBYZ3+oMxMz97KKE9h6TrNwxcRFHwIPdSyNCF5QkPjy/um7XbARS4IqV702hrGxENhMMrdPUuBg3i
x-ms-office365-filtering-correlation-id: 65f9c206-3c94-4747-2d81-08d61aab840e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB0280A8BFCB7070366FC1F41EFB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(256004)(217873002)(478600001)(5660300001)(6512007)(5250100002)(2501003)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(86362001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: fMvEEwOpK6B7n+FszIpPbXytSxk3PYqIkJ4trS0u3ydH9JkJWazLR42K2PIk6D7AY0E4mlpMi1Rs6TWj219Ew6aEjSrv1Ff9OVuoDpE6E4lX7AAOhiegXMENsHFhsGxw06U4JFBjz+lT7WCHGKpLi1l0VCIcTeDF5Qsn+/KY3umWpLHLf30I+cUK0KW+Og3HzpjUPHl65z2W9KeHxCEx5PcypBnn2Wp3lF0FBGl/E5g5curTDPo7OraWMWC7oBO8cd6dKWLrCZYgHoQSnkMN6gZQStt6T5PJB/nuFiti0fqKZBf18tg1/WLA1m688iUkaBPkXAItj2+SL0NDREH1LP3EGTjOqfdl6lmhKKI6mPg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f9c206-3c94-4747-2d81-08d61aab840e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:27.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
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
index 84e6919f68c7..6385abcd321e 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -145,13 +145,20 @@ static int hi3xxx_hotplug_init(void)
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
