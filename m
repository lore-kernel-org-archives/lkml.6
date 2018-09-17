Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4780DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D782147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XRyMGyFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D782147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeIQI2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:39 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:10368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728227AbeIQI2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8dbKmyt9EfWYjwXtznsw+p4LN44pZg5mj0aZT1td6w=;
 b=XRyMGyFm6ie6zSHMNckBSbv1qxTSor2EjG3AgO8dCtE8nZvIpe0L8sJ1dXYLeaYjhzVSSAqD4SnpRqbE9cqB+amc1VDvzk1nbU03WX9XHOrAzQuLzPZi9Aoh1WdkWizWRi0MlofAcr5G2I8mnNIW8MTmtkx9VNZ9p1nYvj/zRMs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Denis Kirjanov <kirjanov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 122/136] EDAC: Fix memleak in module init error
 path
Thread-Topic: [PATCH AUTOSEL 4.18 122/136] EDAC: Fix memleak in module init
 error path
Thread-Index: AQHUTjK6iZKotTJqZkuqyTMNDAWmmw==
Date:   Mon, 17 Sep 2018 03:01:28 +0000
Message-ID: <20180917030006.245495-122-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:NofEugF8pgkc9Taeb3zhW05utzVwqu/VlXbMbyPeUwpHGtGREND5qfb8n2O3zarziHxVQPWhH58zl1T4zzTytPcCt8AytYrvPJTvcS2AkmKR9+e99kqiEmua77xhiwHkzLp+l3Hme80P/tVEYB8V1qmaB6MpOGjqj7VXIdfQr5U0/kfina/v+ZPdqOC5ATwdrnae08NadFMPS3MzTWEqWywp9h1XyvIOwj3oTzR2D0pAnUj6+jGyAGpyTH0U/R7lEoWsNSqSHwWSm7B/bgG3p1EPWMRELayLO/XytKXKGTQFakmBwGA6aRMmJ1tnyFpMeFHa25cpoaYoLjqfa1wt0yGPuBP3L+lFeCjZOWmYabRbCcUo602bikp6EjoesHQBbIGLa/7wW9pjRDxChzfcj58P5GCHQs/PvGViI2i5GUlWIKFLwi0cAjz0473755e0cHsghQZpGdCsp8yD3nPWUg==;5:UeoX9x2cRP5Io7JZT5sZGeO2EtfXPAmlpaS8Mq9gQHt2bmxOwAPbeMpfyaBFTpnBDLVlSdSWjxqjGgRNYCzxHxRwuInPMmq79wm7yayvCvqwzPDV18rbdxDIPU50dWRbGBOQvsBygnLYiFvyjWYGV0h49Jbqpit72VMRNwAcl88=;7:vkcwie+WfssQIvYUT5x8t9C7PTt9Nlcso+A20cOpdIR6gsXpmcQ8IMN42qr5wY1IadvHmO+0JtlZRxhvyn/S+zNwolmAqsd0eo5nCpN5u/LC0/rqr6+zOCHE0FHrlL+47Qt9lGIDqbBWB0IZaMZ2+tlEw/OTDXqepMj0xYX9+ePfamXdCOk3sk0r4sI3KpIT2/wJreQlgNUz8hgsp69Np99x7/J4uZtamJcoQdR6eA1+pJkLNy49ha3+m8UVNFdg
x-ms-office365-filtering-correlation-id: e839f267-aac1-4a6b-63c8-08d61c4a1f28
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB01181425826CB1291FD63B17FB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(966005)(8676002)(575784001)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6666003)(39060400002)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(6306002)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: XSnJteRmes+A9LEMyl0ssK9m5cIAznEJXnh5tyLDXvy1N+NIcU5nXpQr6fJOyPBOiZMRf3vIU2HWoEWEu5TAheJE9oLYFYfPEHFgCASzOiydSiwryfJlHboDKTA1GSt0XMdH4PW4iugM6MYPPF61lurbXJd9Df6W2sC1c3cw3Ef+QXRxNuAnY1iIvOxQ/gLywrGZjTzrdyF0AAq2sRUJO2vm8gCB9Lrm4mI/n60z6hy+xG8gOthVp7XFTW6ubVIu9wd6jFGbWzKsqYXZIMD391D5lf16EnvqDYjvM8XruhIo7d0cN6JJUK6pVUinqNHs0rBEcqC4Uee8TONtZTpWHSUl/I8XD9rh/4lON25Bj8Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e839f267-aac1-4a6b-63c8-08d61c4a1f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:28.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
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
index 7481955160a4..20374b8248f0 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -1075,14 +1075,14 @@ int __init edac_mc_sysfs_init(void)
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
