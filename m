Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74987ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D3720866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WdCJ0V13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D3720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeIOGte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:34 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:19456
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729058AbeIOGtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xOurNoEH306tVoBsjO2kx9vEeSILOTFM8TYS5HRwoM=;
 b=WdCJ0V13VhZoIz9/sJP17MhUEjBa/9+bJfSpHeAwhJKjnqH/6GRt/4SuShM1sXoXZw15Wb/CqYF/lRuoO4whQrDcGz6/Cm53I8CRbR91aOqoVt46wXgJSW6JLjFQtal7/7bHTwhFN3+mF08BE0XYsy8jM+Dwy6gBYOhZRi9G2fY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:32:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 05/57] mtdchar: fix overflows in adjustment of
 `count`
Thread-Topic: [PATCH AUTOSEL 4.14 05/57] mtdchar: fix overflows in adjustment
 of `count`
Thread-Index: AQHUTJP4m3JxavioKUK8IFt0JFZ1Pg==
Date:   Sat, 15 Sep 2018 01:32:30 +0000
Message-ID: <20180915013223.179909-5-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:J3am4i8PVR3/1306ogs2e99wI0bQDZarfX4edUEN53jp81MSJnuwYfo3dJSJYkQKBajiuJdmntCXMj/boVZ6/jn/rVrpsiXPfFwAH8m1z0aIQXq0w4kR8GhhlVbKAU6TAr8nLROuiWxJJJ189KLciEVonlM7voQoUN9Y9FzDMCopwxp/MOw7Xr/bAFObZOFd1jxzhbAWgMkCaHbUUEIjZldS/s3pf7kBVCfm1X6qauzU1PWlIQkevpDX9PKRPNCaVM/4TyQwXPi9BuY2ZG6wOt3EsxOpKHEj3XxZ/6QXNu3o/V5D5VUOY97VkLTQUFvN+U23r52qEVa3idKOwF47R0C6ZBCe+M9BORz6kWxL88SyitNR24uWBe19SPKKocn2+Xqq7mFB1o5TRoBppKbkQOZxgq8OclJzHncR5Yhm23bVwi3H7Anrt+jRy/rV+r3ZtZxMeSr47jpwTcx0sTv5fQ==;5:YslcQTxqXn+4LP6Yn9DQeLlXducDeLyvYSoBlvsYMjs+hJg4wY1oYdW5gQNMRJyEZFPEFRM1QViq/VCXvkmcJeXONQrJJlQaC489yopS/BgZuBf0XuEd6xtlxK9aHFeMPw6sFJ3JWgLVlEygbZp3Ie3d63hMgxzMzz+YcMnxGYA=;7:dG4h3CtOk9cJ8f630tb8E1dD8dWjxYUj+OfCI0R8ZsVlpZY585Ols3rW4DJwO8szpfJJh4JNy5QN2n7OyK9bPdkqupLyq/dt3FKH1DRoJ0z4DxgRjPXr28EYVNmlX2RZMhQ6I+PcXd0i5c7sN6eMvtIKqMZTNCk2+nN5x7lXT7Tmkt5BkQdIS+gNO+JiFiCoB38nv9xURbagSkNhPSZTGDJGd7B9E0VGm2lu3eCmvi1S7MKEiOjof8yKBR3PuLh4
x-ms-office365-filtering-correlation-id: 9f1f4c4f-d79e-4388-2bbb-08d61aab1a96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01176077C80A594CE5883ED2FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aR1qqn5v3OrSCJEwJdFs/KJAujR+yQT2pz47qugtUxZauWGuY+Oacm0erpSDld240l53IBpL6lGFTOYGALRBlXvE1OGu8fmEUCuPp34MuvBgb5vwgDYuWdEClyDz6yqCmQ2GRqxtM9Vkhec1OlJlatpIs/0zh5RJtQXTwr5CjfoCz+n2Iw8KMizOETqArN/eEVuvO+bizwdRFmYWZtoUp/wmU1waOvVJu/sXYjIRFIjqUkyDHeA/8rNAYFy92vTXm0eJrMn7tbIzPYXNoadBCbmij12qZ7J82VVi5wcH052ZIxkhZ/eGf59RNGe723Bf71/0O3WAwbCAGy0EaVf/JqNRfPJyHL0vXLieC/hs83A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1f4c4f-d79e-4388-2bbb-08d61aab1a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:30.6345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit 6c6bc9ea84d0008024606bf5ba10519e20d851bf ]

The first checks in mtdchar_read() and mtdchar_write() attempt to limit
`count` such that `*ppos + count <=3D mtd->size`. However, they ignore the
possibility of `*ppos > mtd->size`, allowing the calculation of `count` to
wrap around. `mtdchar_lseek()` prevents seeking beyond mtd->size, but the
pread/pwrite syscalls bypass this.

I haven't found any codepath on which this actually causes dangerous
behavior, but it seems like a sensible change anyway.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/mtdchar.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index b25f444c5914..fa4d12217652 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -160,8 +160,12 @@ static ssize_t mtdchar_read(struct file *file, char __=
user *buf, size_t count,
=20
 	pr_debug("MTD_read\n");
=20
-	if (*ppos + count > mtd->size)
-		count =3D mtd->size - *ppos;
+	if (*ppos + count > mtd->size) {
+		if (*ppos < mtd->size)
+			count =3D mtd->size - *ppos;
+		else
+			count =3D 0;
+	}
=20
 	if (!count)
 		return 0;
@@ -246,7 +250,7 @@ static ssize_t mtdchar_write(struct file *file, const c=
har __user *buf, size_t c
=20
 	pr_debug("MTD_write\n");
=20
-	if (*ppos =3D=3D mtd->size)
+	if (*ppos >=3D mtd->size)
 		return -ENOSPC;
=20
 	if (*ppos + count > mtd->size)
--=20
2.17.1
