Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A1CECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0845B208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="T8PUEyhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0845B208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbeIOGxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:53:05 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:53808
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730063AbeIOGxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBdh4FVriGA/CcbGhVeIXsoZbERfklF2mXpFBX+9KEU=;
 b=T8PUEyhOMf3cU8EOC1LYH5pfp8d5CdRCyAgrByDfZ55xNxgtWu782887jtIzlpvgpUOlOKFuymgpayLS1Tua1Cs9ksiY8FqDPfh6n0JpsImA5vZrUb76R1JTLOmeUfgw6Gw9DtP8SvJeKjX2mEyP7nQZ3Mq3D2mdLdJF8Wq5coI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:36:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:36:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 10/11] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
Thread-Topic: [PATCH AUTOSEL 3.18 10/11] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
Thread-Index: AQHUTJRjAS7f6vHtyE+IapMK69Vxaw==
Date:   Sat, 15 Sep 2018 01:35:30 +0000
Message-ID: <20180915013521.180178-10-alexander.levin@microsoft.com>
References: <20180915013521.180178-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:hSaIXEp3FSgCaFLejqsyuSGgPbN0lxX5AxuVQx3fAC3rdKC8EnWb+C+yVcVgbKvUMY1T3BGOIC7F2dZk1oexRfEAt8UI9RFsNZDxzd+W5T0+pl/2BpooN7zCmO4FXeCSLuQQrZPCY4R+v3lephfWp67VKnGtQYJdj/AKFnsBvunO4CTzH56I/+pjBCOrwQbPQDXWLG5iNDnbvmTEY29N/IPkBwkymDE4JymElEE5iEMLlQ1FgRg+4vfsY+PMXjQ0tZmVYAILFzUHo2QI1rHfpBqqROMHbUKU93IaS0l3FKA9yxUJ8tN/PSkeRecPG60cWjORyd+D68VOTGYHGRvm1i6IDRYpQrLp5/EMa4ZhXb4ZzW5tYhdfY9kMAbPcdnjpcc5cYzFz/6IukWMgSSXs0DcfKgBd8DTYFpOUlJeiUnCD1qwMs7g+V92qx6AvvX5BjLo+Xv51UH+e1omB+rJt6A==;5:okmQApVln4iMujVc7ivLs8l2lhheYbJSYrbiYPwAyKLzsenSakIWXG6umpo2m10OUnxWQcRoh7bbOS5fIfgBUrKnoePNMkBLfAjXUpMSJJm2kQHeWT5ozo6i/bHaBuqBvbtiYJyReSMaOlmAwBUa8tzxhQnAvdowVIqqhr1mk10=;7:Y8a9//bPT44E18MVUl/iS8wGsH9UAjiNzJBB95Q+vdGR3MDYJlPBEAQPai5C0Uo6ij6LxrUB88tjatuEILKuEPBm5HvOHi0cnxJA8j+pihMQ++vNKFIxUBtsXYsZIKF4K5Ju9ujFCxnDKV1fWLMP6orkRakdKOOUQhosrJuEAw00+Wbp8rnCE9Lypwn5FqV/SNTuQvuczI01Q1FtOxc8etblHaN6ZyNjylHy7oDU5eDw2whM9BBujreUa+JBSs/e
x-ms-office365-filtering-correlation-id: 481f180b-1903-4e33-b109-08d61aab9776
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB0280E798F6FEA779A66EF5ABFB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(966005)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(14444005)(256004)(217873002)(478600001)(5660300001)(6666003)(6512007)(5250100002)(2501003)(6306002)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(15760500003)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(575784001)(86362001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: pLsk590QWL+x1Vi16xsgkQtUd6NkTuI5FKKS2PVtjtEXx2NaanE90mekciiriefix4a/+oB2SW6hxwRNYhtjVq68PuesVxArTIpAGuTXqgJ3X399J6qs9h3DitPeJ8ttmA5kkkuxKSFdwt1U3CeN+FBjH77HG2RFnNLsxOPRLLYn5M5yocm24RzwqpAtqGt2QzYmIvZ0HqUCNgGHvshOegGkZDt7YjF7K2PxHwqIxhIclbaXxIFQ0HtzC1qlrrelBRbFxjQTrUm6fKIhGBlChmC2lnKGT2C2NQzkm5Z9vE2zSqba/JRJhtC5Dhcu7bgvsdgIWPYNGaNOoVfajBWPf92vuFMI3swnxA5F9Kmnv1o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481f180b-1903-4e33-b109-08d61aab9776
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:30.7223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit cd0e0ca69109d025b1a1b6609f70682db62138b0 ]

The ARRAY_SIZE() macro is type size_t.  If s6e8aa0_dcs_read() returns a
negative error code, then "ret < ARRAY_SIZE(id)" is false because the
negative error code is type promoted to a high positive value.

Fixes: 02051ca06371 ("drm/panel: add S6E8AA0 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180704093807.s3lqsb2v=
6dg2k43d@kili.mountain
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/panel/panel-s6e8aa0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-s6e8aa0.c b/drivers/gpu/drm/panel/=
panel-s6e8aa0.c
index b5217fe37f02..0e46b6762cf0 100644
--- a/drivers/gpu/drm/panel/panel-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-s6e8aa0.c
@@ -835,7 +835,7 @@ static void s6e8aa0_read_mtp_id(struct s6e8aa0 *ctx)
 	int ret, i;
=20
 	ret =3D s6e8aa0_dcs_read(ctx, 0xd1, id, ARRAY_SIZE(id));
-	if (ret < ARRAY_SIZE(id) || id[0] =3D=3D 0x00) {
+	if (ret < 0 || ret < ARRAY_SIZE(id) || id[0] =3D=3D 0x00) {
 		dev_err(ctx->dev, "read id failed\n");
 		ctx->error =3D -EIO;
 		return;
--=20
2.17.1
