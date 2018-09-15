Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601FEECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB5B20671
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Bcq5AZ4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB5B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbeIOG56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:57:58 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:50720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728397AbeIOGve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YklIUnHsjQpmsKhhNtwJbgVHEM+f7QGlW/OCAws/rv0=;
 b=Bcq5AZ4JQhWL0T3A9M2tl+IjvV3bV0T4iS8uqjzTu2apVDyIIZGxZppYZdVwVkWWe3UBetpuGwTsuAdSEnNH0oNZEsJIJZ78jtb3AMZWXExXLJHQeFfMM72mptTFh2aoXF4ga8U/YAcBgmW0domj1yWh7VuiEqmgEaSv/78sRPA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arvind Yadav <arvind.yadav.cs@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 06/34] PM / devfreq: use put_device() instead of
 kfree()
Thread-Topic: [PATCH AUTOSEL 4.9 06/34] PM / devfreq: use put_device() instead
 of kfree()
Thread-Index: AQHUTJQ+tYPorp3BuEGE1ANl2igLuQ==
Date:   Sat, 15 Sep 2018 01:34:29 +0000
Message-ID: <20180915013422.180023-6-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:m37wybWotqUEn4Rxxvu9PDMYUbFZ8pJSTMqOsVB8MdEwtkk4H0JNHQzSmXcgh2y206vl1KtgLdQXEHItDl85sQCNpMc4iu+TnGpoeujEpppDO4TkBd6Js+wIbU4pFw4vPBpiyEQzvFu1Zh54eA3ipzKozNqGjJr2YRBA7EmB1DbpQm5WEUlDEtRgnCl9C/znZ0b/Lr8KqT1n3MbbFsseLlIfE5nAfzjGlOPoXa+9dPA7Cy2y/F23tyRN1xrkv6DGjjZQO0Hie7UvBZwOkBh6oRE9ccyzuVF9ZdbpZkIb1Yr8J+VZq76ogs65JZMfSD5+SQJ5r25MXpkfZ3h6vqBcj0Af2SulYLiSq6yVJeTEr+a4k8PIceVJBAqvPJYYXsO2Xwivw5LClw/MP6RzZQ+e8Y/t1Y+pNU13FxAjBZUv20IZuNdctHIDQeKXSJWId3z9q4seGSNX9qYyllai9ehYxA==;5:Fi89FEQ6xI91z380YAoBHcdHTSSvB1SfS29HZgP7v9LKP0h9g0ZuFWh39IZRSgN23sykUpDkbeKtlKR+HfTWAKOeBv+BIzNadbpcqklXscn10q6zz9ZW7Dy2+jQsc68Tqr27w0vuIi8reRtq30P2zcSFmcoSRzDciSHzAuk24Xw=;7:ml71T3xkZxE5cN1TNNYvLKdgtYXvv0TKBmb8Qi9X5YYKncxq4ZnDXvnTV9TdyyLy8L9Os66gTriE2+RHeL2X9i/gLOz4pSuJx2aCpyfjvCgnc9twkhjmlwAClAmQKOfstsaAtyIaT06AIaMmfsHSsiBFV+4qkV/z04zmVMjHtyAtSKyAfDBrJ2+JoNtZ25z7fECl1nduV+7lcXqdnPLpeTW9U/gTl1EhBIV/RM859zaHzAbGgDMY/LOMiV3vSs06
x-ms-office365-filtering-correlation-id: 88b545b6-b1ef-488f-f32f-08d61aab613b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08551E70167187E54E767C88FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(39060400002)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Ua5iPTMPY9fArXQ+dNaQaVMM/tvNlRPeDBJfn3b361rpM4Zr2KQNEqCvfkRC3SGJtTT+w3qcr7qg9KO3AcTh3bHzJbp7k6J6Swv6oipRL+mHdRKlA+VKcWGDCeCYKJle+yRax/l47EQmaGPhGZnHLMzWYocJ5RTmRnxPTf22CFj5zJeS1tcAliM6E4598tFjZ+431jL8xIx67D7SNXpuIoOLbO1cRXDRO1j0lW2ZrPU+TLRbNn+dn1Av1Jot89QfpelEME/hRhNlKlcieAqgE1h6cwpJjyT6c0LnxzNsBlAozQdORb3OKEuMIC3l7N0Q0XZTEjZkEFG9Rud0MTpCSQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b545b6-b1ef-488f-f32f-08d61aab613b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:29.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index db70cee71caa..07600af0084d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -574,7 +574,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	err =3D device_register(&devfreq->dev);
 	if (err) {
 		mutex_unlock(&devfreq->lock);
-		goto err_dev;
+		put_device(&devfreq->dev);
+		goto err_out;
 	}
=20
 	devfreq->trans_table =3D	devm_kzalloc(&devfreq->dev, sizeof(unsigned int)=
 *
@@ -618,6 +619,7 @@ err_init:
 	mutex_unlock(&devfreq_list_lock);
=20
 	device_unregister(&devfreq->dev);
+	devfreq =3D NULL;
 err_dev:
 	if (devfreq)
 		kfree(devfreq);
--=20
2.17.1
