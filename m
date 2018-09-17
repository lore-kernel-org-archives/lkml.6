Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880DAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D73214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dKBbS5Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D73214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbeIQIbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:49 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:32192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728849AbeIQIbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hIAKbiXlc6kqNibI1tqPBb/povK5UgdlqREOuohCqw=;
 b=dKBbS5HutbvjPaHT7sF25UC3eMcEcmZ8zM9ghmhjnXsfWzzXclVvaw2DfYl2GVDSmg3+tjBQjLiguotmEPsO4G2dHVlzsskgExHaPvnp4tGvR1zhC2I7jmenKfHxHdfKfj4iZpKprfkxR+RP8oauJEDLGeiJKtyQbjHjckoViP0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Denis Kirjanov <kirjanov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 56/57] EDAC: Fix memleak in module init error path
Thread-Topic: [PATCH AUTOSEL 4.9 56/57] EDAC: Fix memleak in module init error
 path
Thread-Index: AQHUTjMfwTMChwkEDE2d/IaEwo+p+w==
Date:   Mon, 17 Sep 2018 03:04:18 +0000
Message-ID: <20180917030340.378-56-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:Vh9PHyHiEddA1yn8zcuNzBoK54MOsbdOhgLMrjLYQDtrc6Ynj1UAN97RDLDpn3d9CEWHIFQwiRBroDVlApD90OlEiBs7l2ejCGfrBjtgU94kctib+FkLi3rYGdX3DiD7iH0SemlQnibDulDw8uk/bnOeH1sRd2hAm5Ah0epJ9u3nZTOdcL0zmT9AiBPv3RT1XI4wWT3cGTYhV5nq9ifyIKEZR4wGKdlGTgX7WppDCDV17A/pNAiSOIXgbq4YWuXk8u30XJnkFtQdbXj9QVUvRXvEr5mzQDaKHbnD91RucZQ7M5WuJXOD1kmOO0t7Tf1SFb30HMoregNf4ITPGewBwxnuqd3I+InYla2Y2/QwNXviNg/ozeg+yhDmHcV98rGZrra8n3KHD4tKy9hQ7NzaF/oL8fPu7vjdvHZIHZuMauNOzgDHZIX2CTVvlJSRFM3x12WDObqEWALNTj6tDyWWqQ==;5:DP6/ldIsldtd9V6Mz9oOEG+qX5HMcs/r2YgL/3MmtHFU4V+m07izlmaryl1UfoxLdwxCchESihUzbgf3HiN2JKQwBdTJ/XPPhyafM4M2zLKVV/mWcSmPeDbQQKuSF3XC6b1MwO9Cy4mOOQbP0e0BKNmDfLfdgyPXd4jlwCFuQTY=;7:DpU3mpCSxxALQRyfq444gQzeUugFDe0u/H2daYkEVSFURxWLe9M9YsKDnGq9qzGGL++rnDp6KtrkWnpEAt+Jy/5SZQy6+8Y4kymQWAj97iPzdjKTAenYzD6mgRFjFgkxzjkNFRTPNeIh/YDjzlrHwkZqx7GVdEZUg5RSuCrp6rAV+3H3PSuemksHR1lzbrYMvmzxLpchvuYXPpPuUlCfFl1FkZS7mGnJaIpl2HMI8sGuJfE0QmjsLmb22TqZh1RG
x-ms-office365-filtering-correlation-id: 00eb7d30-ebbf-4336-f86b-08d61c4a8f96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB016631B10B790D08260D9609FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(966005)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(39060400002)(1076002)(575784001)(97736004)(86362001)(6436002)(6306002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: pxafqoFF/AIlcp4LQzKKy7rkRlt5DI5/ooqvG1qth6IaY/SdSKML17xy2+aNwbz+Y2p72XxcqPzX1jiaeTXmKxW3kIId67gImBIBPYT/bCcDvGaWWEktuL4VOOXkSmE3JWMsRGaTlRGpq1ZbsGgrc1daRJ92O3crYido3DHj+zAueooKSj/oGNFDIen64LBABDCTfXX6A5hhguMTdIim7tZjyVNHHy1FC4G+fr9d96V1NCtPpP4rvvjgUUw5ApVGuMK2tLxXCrFaWceuvW2yfHBWnxc0gCl5j2x+pbkv4gJH9Sz9pS9CAn8en34PGskBK0WK/0lcaWpKSt2UuobT/BRIgo4VKZZiJAar/pxMKkM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eb7d30-ebbf-4336-f86b-08d61c4a8f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:18.5551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 4708aa85d50cc6e962dfa8acf5ad4e0d290a21db ]

Make sure to use put_device() to free the initialised struct device so
that resources managed by driver core also gets released in the event of
a registration failure.

Signed-off-by: Johan Hovold <johan@kernel.org>
Cc: Denis Kirjanov <kirjanov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Fixes: 2d56b109e3a5 ("EDAC: Handle error path in edac_mc_sysfs_init() prope=
rly")
Link: http://lkml.kernel.org/r/20180612124335.6420-1-johan@kernel.org
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/edac_mc_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 4e0f8e720ad9..40d792e96b75 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -1059,14 +1059,14 @@ int __init edac_mc_sysfs_init(void)
=20
 	err =3D device_add(mci_pdev);
 	if (err < 0)
-		goto out_dev_free;
+		goto out_put_device;
=20
 	edac_dbg(0, "device %s created\n", dev_name(mci_pdev));
=20
 	return 0;
=20
- out_dev_free:
-	kfree(mci_pdev);
+ out_put_device:
+	put_device(mci_pdev);
  out:
 	return err;
 }
--=20
2.17.1
