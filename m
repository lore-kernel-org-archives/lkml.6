Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D38CECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FE9214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CQt4jaBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FE9214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbeIQIor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:44:47 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730424AbeIQIa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8og3E+rYH1dq+Ak0i7daIBlFlzLpH8wNsneMss2dDYg=;
 b=CQt4jaBjhK66Ijvl1np77QhDtfUKk/AF0RftnoipW7FibkISfMjR2KQb6RSPUO+/XlOVFTUlDGVTZZs5KI8Js5rnQe+TP7vSeL/Cu+L8TuNB0zWeanV9WYq3G8gThmRsWhFmMssQ5JwrNX8HKtDveg4D9Jr6tuh19iduDBwVtH8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 77/87] EDAC, i7core: Fix memleaks and
 use-after-free on probe and remove
Thread-Topic: [PATCH AUTOSEL 4.14 77/87] EDAC, i7core: Fix memleaks and
 use-after-free on probe and remove
Thread-Index: AQHUTjL5nrilvnLG/EKIDUwv56lWcA==
Date:   Mon, 17 Sep 2018 03:03:13 +0000
Message-ID: <20180917030220.245686-77-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:ErSxY2lAE1T1rms7L6StEpbVTQhS7H8sFNfCDJ6FmirFQF4zmKREIMiBMCVbkyeE2whXwpuhjGpQqNMHn2hdxdjpViTdFnO3TbZceUjM/jPlk0Q6WiC1GkfFgLu6NV+0j/iEhJYbYNiv8S7tGxegQ8YNIUUhkqq+PZuIbj5Xjjplj5MvdfAoap6YObag1/7s9c7zyo87iu81IbGO1JJQEUtuOkOmp++9OD+KcAcBFcNqIf7wZvgWHRw8y2V4GD1pBTyQ5jM8BGRGfc62toIlrGXdnZTghJPj75ioeSmtDBpefLvSssaSgWQfd5OEvt8Ba9bAbtefIm9fH4cMUYGIcDjo3m1l+USdS4R6z4psHc3yqaM+akeoztWbvG3IART4u5s95cebmgm5Z+FLfmddLV/pEOC+i23D38hBonQfxiCi2kXIV3buPKDQmaMnemCeW6u89KIn5YU3cLaNk9J0ow==;5:OBbEnnkyWuPVWGi10Y8heICgcJlULzcVOENzDZMXo9Mjz+89yko2j7z/INjZnbJ7q0B+CzC7UnZ8AmojfHdxVJdUyO4ZfEJYCEOye8/EE+PnCuVg9OKpm02RR43qXEnLzbDWI5oGWCjxCe9kiBoHLCp4jqRyCNcTOaEiFERgAzg=;7:M1yzCSqx1esTiSDpcK2fm3Aa69Bdh10IlEXw533elH73y1WFc1Cpbvh9yN3sXH33fAthuBzFsK91cGDaCKQFVAkWuVeYZyLAsk0IA6e9rKonRSfglQOPWi3XSP/IukAWkiIT+SyV6Rb8E9MrXrEcRcOTWqavM/UZJZcGVYKrfXtNNt6TOaRNO58622fd8trZ4aDasSAmu/3otiMgafQ43a21AZd0+VzL7p/qYcr+qg4i+5loVZv9e8di+JLVzoHu
x-ms-office365-filtering-correlation-id: 8785d7bb-19cc-4020-e5fd-08d61c4a5be5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0133E85F027E6D70EEE82D51FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(14444005)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(966005)(72206003)(105586002)(99286004)(6486002)(6306002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k2pHjXrvl1bVxk+eSHxE0sNFas2oPWStwYeEmdxnSMc5MKi51vpjgF/wq4wJKkTyaoJahlHzguYV7tCSjxSdCqamBp51JlJngZeN4o6/MYx2XBDJWXKZ3VpkT8Juqbi1uTO0f4fUH1XLSTW7IFB39FRHtSCFatYuhdenzX3GWsSjEyOSh4PonzcLU6dhqpCFzKd0x9yebwdBj+LlwbcrUEQFetfl78j1QG4qXZf52pJSr0OWMyTEUC6ws8RCX6y8R8og0wJ8YY8mmZotnf5RulhE5p4orM9n9bL92RF8hq2zHBtJfWDP7Dap0c37YcLbUiEU8QYAg7QtRDJiKpKiVWDj4uXCtUmi/new4ui/Cpg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8785d7bb-19cc-4020-e5fd-08d61c4a5be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:13.9934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 6c974d4dfafe5e9ee754f2a6fba0eb1864f1649e ]

Make sure to free and deregister the addrmatch and chancounts devices
allocated during probe in all error paths. Also fix use-after-free in a
probe error path and in the remove success path where the devices were
being put before before deregistration.

Signed-off-by: Johan Hovold <johan@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Fixes: 356f0a30860d ("i7core_edac: change the mem allocation scheme to make=
 Documentation/kobject.txt happy")
Link: http://lkml.kernel.org/r/20180612124335.6420-2-johan@kernel.org
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/i7core_edac.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index c16c3b931b3d..6c7d5f20eacb 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1177,15 +1177,14 @@ static int i7core_create_sysfs_devices(struct mem_c=
tl_info *mci)
=20
 	rc =3D device_add(pvt->addrmatch_dev);
 	if (rc < 0)
-		return rc;
+		goto err_put_addrmatch;
=20
 	if (!pvt->is_registered) {
 		pvt->chancounts_dev =3D kzalloc(sizeof(*pvt->chancounts_dev),
 					      GFP_KERNEL);
 		if (!pvt->chancounts_dev) {
-			put_device(pvt->addrmatch_dev);
-			device_del(pvt->addrmatch_dev);
-			return -ENOMEM;
+			rc =3D -ENOMEM;
+			goto err_del_addrmatch;
 		}
=20
 		pvt->chancounts_dev->type =3D &all_channel_counts_type;
@@ -1199,9 +1198,18 @@ static int i7core_create_sysfs_devices(struct mem_ct=
l_info *mci)
=20
 		rc =3D device_add(pvt->chancounts_dev);
 		if (rc < 0)
-			return rc;
+			goto err_put_chancounts;
 	}
 	return 0;
+
+err_put_chancounts:
+	put_device(pvt->chancounts_dev);
+err_del_addrmatch:
+	device_del(pvt->addrmatch_dev);
+err_put_addrmatch:
+	put_device(pvt->addrmatch_dev);
+
+	return rc;
 }
=20
 static void i7core_delete_sysfs_devices(struct mem_ctl_info *mci)
@@ -1211,11 +1219,11 @@ static void i7core_delete_sysfs_devices(struct mem_=
ctl_info *mci)
 	edac_dbg(1, "\n");
=20
 	if (!pvt->is_registered) {
-		put_device(pvt->chancounts_dev);
 		device_del(pvt->chancounts_dev);
+		put_device(pvt->chancounts_dev);
 	}
-	put_device(pvt->addrmatch_dev);
 	device_del(pvt->addrmatch_dev);
+	put_device(pvt->addrmatch_dev);
 }
=20
 /*************************************************************************=
***
--=20
2.17.1
