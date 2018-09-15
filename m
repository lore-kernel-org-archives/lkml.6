Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB93ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC7C21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EJKUpcND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC7C21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIOGrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:04 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:14354
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727994AbeIOGrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KxAXL73HijrGYBMTlo6I2uhXOrqbgA/Z+yXWfGF5r0=;
 b=EJKUpcND/ZVEAmyzdZgxyolGupShbzllSBum1lLQbLqLdQJnuYJZpYEp5w1NVV4UhRzh26Z9hVWaDe32bnoc74FQLD43RNnrbxpZCbSXE4P4XWxps/6/CLY2H2F6+V75vJAgG2yyZLstxt/lfqGdnQ4Zm31QjR9h9BKF8IvLkOc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arvind Yadav <arvind.yadav.cs@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 15/92] PM / devfreq: use put_device() instead of
 kfree()
Thread-Topic: [PATCH AUTOSEL 4.18 15/92] PM / devfreq: use put_device()
 instead of kfree()
Thread-Index: AQHUTJOdndYbV4OxIkuwMdD3kgKdJA==
Date:   Sat, 15 Sep 2018 01:29:58 +0000
Message-ID: <20180915012944.179481-15-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:kmfm+uw8y1kDu/C8ltQpIoY6GI9IFrps/Ev5xQylGqGsd6OfLWQEH1+VS7cHIcF+pNF/ANx8HBtaZD2WY1rI4SxobkJvnAr6x5cTK3fJf4EVKLZRSQfNkvhrrqISlHgtKnhW8K7P+7p1xPU/2EVvUAQeVr0OBsTBriDWpNSLy8K8l1AVVqK3/nrnwtJEZttqTiBjb4KV+SO785ylADhbvFzrh2HIDvlXLCKe4A7tVvp8QtXJw/2AnajNpoA7NfJHFKVAJL85hXvjsi30wNu7G47FYzaPg5BsXJDFqSQBKwtd+moHaMf9L97scxGNw+lgCUk71rg0aynnYemmRQsCtyUrdqahS4pTojZMl3ivyFTYv2o0UP4mD6Ud6tnLbqvJov1qPfGIMHC5TTSOqEiveWkaStBCEs23sIRSJfkd+0k1SWWc55MMxcv+P2Lk4iPpMAz14KEn6rkk5+VHZyG1Xw==;5:7piC/ITPDctiGSHfTFBjzdf8JsmpTmwV5HT4Xpk6DiczzmEE9hYS2VoyiIetMD8aeOQjsZE76r23pgE/cVqph5fIG2ka3/AlMh2ECp+KEBa9gUI6ag7Gz0sTN11b4qskYNBi0MOggDroSUJ9F58nvIeQQ7z3jg2cydvN+/BIunw=;7:V1VT88Qd0zPhafVGhVT8JdKUNA7KZZjVB1yCOx/MaGpJEmciWFXuGuDwMXlcBnzw+8DlNa71GBgvMLc5juK0uOfjM4D/S9Et4K/KWWm7xka9BZ2oZUqoncBXudM51E6SVc3Dm48ipXirGW1Tt8+mSwaLnI/DXkKLt5pZAnnRHRtBhXK9UfefiO+o9FlVtfFjr9hIFNEdm7xlsaaOVUMTOM5lgs7mqUhdIDMtOoGo5vwfNRwOEqCEqHdlpBQirpaz
x-ms-office365-filtering-correlation-id: cdbba1c3-cc97-4c4d-e7f2-08d61aaac046
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840D16C0227E174CCF6263CFB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(39060400002)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZdEodug+EzqVbEjzch8B/U+M5fzibtNgC1XlW121XiTN98VA1TylAhKafZ0ifQSlwZj6kdViU1Ex5XISk/nZFHFYysoLTMG0iTWVVlw9qRM2Ltb5hvwEUSDDAQ2C3G9n6jVNF75snt8JcMFktxAn8i+Fukk370A7g3ZsST/FQzJAt+itBNGoEx6aAa0zBj7nGta9o548wLFZ4KSll85DvcS6g8TZa3pVCrfUE37kxK/orrYjSHGewPWxHOOO91odrsuGZgd0EYLyFaAW4XaDMUzuACgL5wGoot62eWFHvmCgYyxR9rOqp4/m2oylsgS4ufMxtFon2kNebzxsY2VRGg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbba1c3-cc97-4c4d-e7f2-08d61aaac046
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:59.0732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
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
index 0b5b3abe054e..e26adf67e218 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -625,7 +625,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	err =3D device_register(&devfreq->dev);
 	if (err) {
 		mutex_unlock(&devfreq->lock);
-		goto err_dev;
+		put_device(&devfreq->dev);
+		goto err_out;
 	}
=20
 	devfreq->trans_table =3D
@@ -672,6 +673,7 @@ err_init:
 	mutex_unlock(&devfreq_list_lock);
=20
 	device_unregister(&devfreq->dev);
+	devfreq =3D NULL;
 err_dev:
 	if (devfreq)
 		kfree(devfreq);
--=20
2.17.1
