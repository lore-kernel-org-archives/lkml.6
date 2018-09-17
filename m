Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC41FECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6890A2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RVW5yzQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6890A2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbeIQIdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:08 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:19879
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730718AbeIQIdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMTaILXXKYZwF/DwPzFHuYUYe55/hY5pCp0uQ+Ssy3k=;
 b=RVW5yzQEnSUmyGSjuwmkQyBOG0+z238HGZ9tzyIh7B5OitCMKzKUsQID0OLn4I6nqtcP0WmMDAfIYNSyP+lQCjzfJf0kArrhy4owR9aJwCyJWsZwf7x+HkkE3MuX865d8XWJnYSQ0mVC2CAHoB4aqJ1S9jHL3KuK3grx6uEUAuo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 39/43] EDAC, i7core: Fix memleaks and
 use-after-free on probe and remove
Thread-Topic: [PATCH AUTOSEL 4.4 39/43] EDAC, i7core: Fix memleaks and
 use-after-free on probe and remove
Thread-Index: AQHUTjNAHHR/zY3XMkuoKtYfVM06UA==
Date:   Mon, 17 Sep 2018 03:05:13 +0000
Message-ID: <20180917030445.484-39-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:h8bobM0derkfkJraQHULl545Yvejs4wE1qzD8PVu4NxxgMhVKYw2mG5Dx6tA2ns0SWViEfq3Lk1fClGWvkSA5gkGXanJD2pikyrNwPnXVEia2EoAojG5qU/5ELJrQ7bMCDCKSQKONUAgsxsolSMJzVSyDI4Ahv/vDJ3bFv3hr3WXJ/isX4jCZbN9TKB53eN7adexjWG/6H6xxdoEEuu5rglm8U41ePls3GU8lzsDPjH+3Eh42OFicwOQl9DmNy9zrMnCQwBggNfp4Np3jHhFnPNpkSMjSoyM08bZqerGmhd1EqJmX9zmGFOdtK1weqSBLLgr3vp5G4aMOS+i0kaM0QO82HaVcXxjUWspQbNsztKfuQ8oLE8kJ2Aga9C6Rv3h16AM0yACq2+cUP8/9N3+n3aaM3i8TgU3kGYIySbzYlAg3QokkKtM2MlavVKjMGLR3VcK8KJCQwjuTHxw5aB3Zg==;5:x2EaKB8OtyMV5si5uHneCLOsqrW0EiMV0Ss8cyG4bi8d+kacFT0QdYLZNMjW/QYyl1wivwdoTufVKxh1p26HkstE1TVN/yDapc0POMTIGS83fXCNsJPfeyy5V5r9X0CVhHq34sZQ/jKmaM1zlnqizVOAgsO/IYH7g9lV10Sr72I=;7:UNXUlzpG+oc9VkQ++q0caqWtnqMVgTWVocKQejAZyiTltG6+UAhEkfZUb80yIWfgJIn5OUm2ppGOQx+tFLDAAEqwGjZDQBwFhE/UpMQxSsKAufILp/sePXDQwLQm4gY65DhQO5ykow/2JXkUyBAG7NEqlrnQR0Y9mbANMNGQOvF+IHkRy48jAK9FJZD6jfTlM87F14CpR5jOh50c3IhQ0Pbe9Y01T7TCTaJ73q9a7uORHf5tjUD+o0ouBIQ5udCp
x-ms-office365-filtering-correlation-id: 1b33ac1e-8fde-4d10-2308-08d61c4abe17
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB083935A2321A70919E86FA8BFB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(966005)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(6306002)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: TpGHcOhEV4ZuR3k+oU9w2q5pgBy/E+0TPmNkgmkdg2bjk93dE+e2Nud1zVZxRnI9VuBqlbgbHEQZTkU7ocZq42YqXnOaLhQat/M3IkkuKcX42Y+bAY9EcBo/+3fpLZLESHs8BaVUw3SJbjZd4KqsNXFTUwMQmuYpTX4zai+qGnizqvdiq0BJQDpnP3sN3Uwn+xcidHOQwfjpySBU2KAzQWrFEfLdWyj/WRqzfCX5FmNm9xUbYPyQ5P3EygTtUZ6TVCBptMFCyxKAFJc1XT9FenE++UJKTrUktaFdbuhIjoSPUkJusqJJYWFIHT+L0H3hi4I50VXqiEchy2dJlr+r82LHLq1vyL/r2Nup1gt5CmA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b33ac1e-8fde-4d10-2308-08d61c4abe17
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:13.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 792bdae2b91d..d14c8ffea910 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1187,15 +1187,14 @@ static int i7core_create_sysfs_devices(struct mem_c=
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
@@ -1209,9 +1208,18 @@ static int i7core_create_sysfs_devices(struct mem_ct=
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
@@ -1221,11 +1229,11 @@ static void i7core_delete_sysfs_devices(struct mem_=
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
