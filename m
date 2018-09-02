Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE0EC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7447A20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YjzB3KYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7447A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbeIBRXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:50 -0400
Received: from mail-dm3nam03on0118.outbound.protection.outlook.com ([104.47.41.118]:8192
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeIBRXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOSl0LapzioiqWzUVjPoyhGTpHYbfUyabIDt76E89X0=;
 b=YjzB3KYzoT9pYvNDi0oQcGtzANvnCQ3SxJ/1zeowCrefvo/KIVAw5v00LNdor+enVEUS2mTeUR1m1dI41dJO+vTYAuheqX11ciy3a0MrORP1w+I2A6hfjQxc8iX5C/cRCIFMLIJS+J2bFYZ+lSnofF4PU++w6AO2T6gvF7E0K1k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 70/89] media: helene: fix xtal frequency setting
 at power on
Thread-Topic: [PATCH AUTOSEL 4.14 70/89] media: helene: fix xtal frequency
 setting at power on
Thread-Index: AQHUQr3q/ycf/1XC7kW5NvbQH62eQw==
Date:   Sun, 2 Sep 2018 13:07:35 +0000
Message-ID: <20180902064918.183387-70-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:4dIk1LxjoPTwQLoBM4UTCaROfP6NkOIwa1FalG6jcmf5pXQ4C63NgWi7B3A38s5voFfxYt0i6eLXL3Sb4BSJjLxminAWH0kCuAqABGaHcGQ+Kl7u/sho8CJdN1LLiSk6KsBZPu0HDbqE/W751pCNZJ35kjsf9pbMoC9HX1RqYDoPl6xRW2OaJ1pn4xdqQD74thGjT2JavbhKspqHJ12JQDAoMcbzeuNOOrnZ6bUkDFCr3nDzFQHaBbbKGoaKPdCfx4x+ydRWSJjs16hDwtBeKC2ZynsDebS2+77hrSthzXa9cwJOwQjAAR68vG4+qjXrZrC5GPJtv61yop4ouTK52UQSehFYKbfxEAxska5UmNLtNCCgmrY+jjyTWHPp2MdykLSWJYAVt+t/RCi+N5X6N8Ppvw1p0ep4VndblMh5/niJZxy0mxEst8xKnSBlnKGZ2HTiyHhOMoTdheWlh06HVw==;5:VJ6HGIf8FTdggsSOQvK7Xvcz4aOIkOLEe0ypzOW75egrpeA7vJL7iegjP4G1aVgnwUFOewaoq0mON5hMy1xfuIVgx65ej72M1EZQwqsorKnB4QDJQ5XGjR8GLfcFn9YO6yEvUIpyEr/8pTE8HE9+5EDonUu2jnNFp9i11hJjVYs=;7:LEOnnz5W4VRD9JgY5E954lxvOna2yHSoMRGjlgLt+wjG/1A0jEpCF9JPfO8FncPw1pv+sgwpaCmeDpvtO0OFVbVxN9CT+i8u5710ADyRiqVyLQhMWS30QtUWU45PMlFMKVNil3PSR19jaJVznKuCSOAmqBYvg+Jt6rc6qbYtZcjXIuKx+r2v7WYQcDZg8TAwux4i63IGeWyfbD/QXQJxtC5jR0JHTK7o6wGBzlMC98TR4HzhCD+jLQldCl+RrRu/
x-ms-office365-filtering-correlation-id: 6555d205-0a6b-4622-f25f-08d610d517de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB014911BD1935BDF08D92E0E8FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(4477795004)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7R81AJFybqE1mdiHqs+WiTVi95c6m6kjWzI+lQMI8lhywiOXorauym5tnNb/ujQAht+3gU7NTGHaiOmztJZ0870cX+ylNmyueNwNpr7NZr38Ym67ZhjBdZhpOKI7BUy5CIOSNM6Eei2V/jdrQ9oMZIsYFD9u/0c0+uLXyp41ZM5ojrrAqYXeadcE7Ha6hPDjd3U4fGeou8opA55xQW2pyohquUXouKFIsI1c2lH9nHSfKLan324hSINUb3MLrGi6BrI4eVr3tzbQYH98BjoSVivv2UFUYPaaRqqfLfmeL8ZhCms/S2AP5+tZqih4JS+Ej/kuVY8GoDYxsdBGdNk+Q4dLtADWNSpjtioieHEl1yA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6555d205-0a6b-4622-f25f-08d610d517de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:35.1103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

[ Upstream commit a00e5f074b3f3cd39d1ccdc53d4d805b014df3f3 ]

This patch fixes crystal frequency setting when power on this device.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Abylay Ospan <aospan@netup.ru>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/dvb-frontends/helene.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/helene.c b/drivers/media/dvb-front=
ends/helene.c
index 2ab8d83e5576..fcfe658a4328 100644
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -897,7 +897,10 @@ static int helene_x_pon(struct helene_priv *priv)
 	helene_write_regs(priv, 0x99, cdata, sizeof(cdata));
=20
 	/* 0x81 - 0x94 */
-	data[0] =3D 0x18; /* xtal 24 MHz */
+	if (priv->xtal =3D=3D SONY_HELENE_XTAL_16000)
+		data[0] =3D 0x10; /* xtal 16 MHz */
+	else
+		data[0] =3D 0x18; /* xtal 24 MHz */
 	data[1] =3D (uint8_t)(0x80 | (0x04 & 0x1F)); /* 4 x 25 =3D 100uA */
 	data[2] =3D (uint8_t)(0x80 | (0x26 & 0x7F)); /* 38 x 0.25 =3D 9.5pF */
 	data[3] =3D 0x80; /* REFOUT signal output 500mVpp */
--=20
2.17.1
