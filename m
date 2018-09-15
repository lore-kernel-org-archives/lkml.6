Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A385CECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FD820866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e1PHxlSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FD820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeIOHB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:01:56 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:27616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728307AbeIOGth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvW5DwwEaHLANhIwrLbT61N49aMlLNrUM8bw99phZW0=;
 b=e1PHxlSVkeW1TpoawFpv5qxtGxVMz7ehehz3Xzb1yDoiOTUjxCPXDhb2f8OL/P9Kzw5jp2mXlfVx1nXh8UAIsKq3C8vhItz3yxPzV0vRN7HRvW2igUQzAS5/EIlYqRrPwjaBf0Xhi+KodARPpwqzcMXCsCOk3bOnvaVcixL9VYg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arvind Yadav <arvind.yadav.cs@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 12/57] PM / devfreq: use put_device() instead of
 kfree()
Thread-Topic: [PATCH AUTOSEL 4.14 12/57] PM / devfreq: use put_device()
 instead of kfree()
Thread-Index: AQHUTJP7sjlgRXBsNUuYHr6m8jiTzA==
Date:   Sat, 15 Sep 2018 01:32:35 +0000
Message-ID: <20180915013223.179909-12-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:jwTxtlcaWvGH/VG/7tG+52e19J+dNEC74eZHxSpNCc2T0Ubv9n6gbx0kFg/DRg5DFZVqsd18ssjc50clkhmuuyaQVp2BeIhDDLSCiGxMJxmA+BEz7GCLMgUNfwVpWI9mp1vswEC6TpzJnIUU4c9iWZIeVQyQZB1XQkdP8azvgOlptlMw0UzXIE/O1FnCtO91BvyL94zExq9LUom7zu2zlw5CWRtutbzWtIP0UJmhTbIASg70mwzklB/HH81C9mi6nA2m+BEF/tUsshb/+2Dd2++KKzosRhISePyVhyHRRnk/dH8hEFFQ3NCh0pOcC2piRpoqtya79SkBmdcLwJI2TvCf2i5q5qCXrZKtuPH9RnUZBBMdUt+kNvnl+kL/HaKqME7ctLCZrn3mg5dAqgw6UkSa6s5Z8UIkjwUzrHjY0YbimmZmcW5vkaKVnA3BC+sleZfEp1bNZoeSWqJd3hBjyw==;5:U03INBQXjs9JIKlvqZAHs5L5lMQtB57dSi+mHD4yzMIUwfnBuNNLXcqLlCzH6ZCfZFCzr412NvOx0YKJNQXrz//Un08qQhVJbdNtH4GnZw7RA6bs9+79oSlhIW/c5WAq6+JoGoA5Jj4dNKbGuhAZrF0v9dcwz6Qq8nvi1y4+GMo=;7:klII99omkqnb7Q/B1IX+KgTyidEL3nT7Mjrj2RGzjJ4sMNj9DBFZv2+fGyoZ26HQf5iUb6nvcHfglk05tFH2kZwOfal9UGB+hkLHGmJZJOkRnXeVFUtpadi3J+W8ktZbzILMQ3Gc60RDEt7WFKlknE0XWx9vTPDJHaQoGPn5FHKGEqNUJu4zYrZQvmx9r3D20170NpxmZaCpXsdrhtsvboDcmXC0FRuXOsxHKYCgBqCb7DFJ5p34ZQN5ICTAMujC
x-ms-office365-filtering-correlation-id: 729f2ce5-d1e8-42b6-242c-08d61aab1dc3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB082252307D9C90B5E5D2385CFB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(39060400002)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f4LXQTzAKVE9U+LeOKSSfJl8MH9ZAvnqVyTWQuu/reQnvnkkLo5BPhAjMBhGCSzvJTDvywfiUj6ICTyHZqQ6bc9E4mMICzDutcuVGGRh9UoNmb+lB4qLRGD9lx1pEGdHWIAWLbNyM+vPKcppnDaeqRiJo/rY+Z7lU0VXlLRziIk7Md4w5vn9P73hCucteKkbIT6Vy/JriCRWDtIryaTAs6Dq5cHORLwHRdgckeOzi2lrxwRl/SnCEYylNMC+UYYWHnqboJjVyXaHrgSYWRWmvwcYLtPfG7OlIQls5QeUps1udt/zi3D/b7qh3Q03YokXAo3vT/OEMkQTVH/Z4m3IkOa8ifa2944ob3QlGYvhv7U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729f2ce5-d1e8-42b6-242c-08d61aab1dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:35.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

[ Upstream commit 2d803dc8f7a5f622ac47c3b650834ada3a2659b9 ]

Never directly free @dev after calling device_register() or
device_unregister(), even if device_register() returned an error.
Always use put_device() to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/devfreq/devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8a411514a7c5..cb3f3d33557e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -564,7 +564,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	err =3D device_register(&devfreq->dev);
 	if (err) {
 		mutex_unlock(&devfreq->lock);
-		goto err_dev;
+		put_device(&devfreq->dev);
+		goto err_out;
 	}
=20
 	devfreq->trans_table =3D	devm_kzalloc(&devfreq->dev,
@@ -610,6 +611,7 @@ err_init:
 	mutex_unlock(&devfreq_list_lock);
=20
 	device_unregister(&devfreq->dev);
+	devfreq =3D NULL;
 err_dev:
 	if (devfreq)
 		kfree(devfreq);
--=20
2.17.1
