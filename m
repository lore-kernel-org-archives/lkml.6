Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D530C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC082083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JwPEs4/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC082083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeIGF3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:29:13 -0400
Received: from mail-sn1nam02on0101.outbound.protection.outlook.com ([104.47.36.101]:49984
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730302AbeIGFRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF4Ds4hlfPlFKqUVo6o96IcLH8Dr1KpAzNgfzSA6d0o=;
 b=JwPEs4/TbHgwfXDz/9UWaI1FrkPeP7vY0H14L8EKOy5PHVB6udOnh4hCNzmmAUzOlVD8zFEvW4CVw0Mbn/3fC6vh1Bl5gfspDWlJ+Q6OR39PBTQbTmaacfj7jjj56I78nf9Azh1q2H2mHS84zAy5UcsCtVcTFoZdL9SK2waZns8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:39:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 42/67] powerpc/powernv: opal_put_chars partial
 write fix
Thread-Topic: [PATCH AUTOSEL 4.14 42/67] powerpc/powernv: opal_put_chars
 partial write fix
Thread-Index: AQHURkMCnjuyMHxPMkKSUSdU2EYRcQ==
Date:   Fri, 7 Sep 2018 00:37:52 +0000
Message-ID: <20180907003716.57737-42-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:74v42JDOyAzkHQv/D0e02dihdXXifxfwtkU5mmno0qx5S/lxxswlTgN6KeqC3bR1AqxpulHYtvlfF50uWE2SQM2asITaifBpR6dKsjBls6JKNfCLIoF7zH24AStnSJvrdGGwCsnyKZOMW5HqFPrfKtp4A0KQav2VoxWcOmp3xvGbLgP+6wQmVlO4wdJ4q4AhePtTXm0qfoZVr2rxDMH63QuvPW83xLG3ZayBhs1SPgM5QIVIEXwz49d8v37LvBoYgEeM4QjhA0juQvKISxJGM0D3Gm1jSx6cxZYHjtGCZqBeNnNmFTXbao2LcOLLSaa7xOz0q0qzBHx0NFQFuYCl9bL07mVNGKuXkI4eSzCZY/tnfTRiCpNiWf8FAOsMrG29EKLGHZKZJ3gdZkze9yACx/JuBtJCOoYR9ddKCRf9NwVDQtdzhhxIoSxaM146d92ONS9MOR22xk0Im4FzyE7xCg==;5:2w0nK602FuuFLxehWd4F1cj3YrdsBV3NZZKlq98dqOqJYWnEsa9gV52fUSzv6U2tRVGN0++zqPJe3EmjAvmul3yv66ONyksX9dllUpOgefrqXFFLMtFaq3LyrA06gwXjfCUGmhYw9gcpAcxCMQDNceVuWU85/oWzweyRFfMmsYw=;7:FXSRqFEpeQ74nlNOWuBJ+P0SDnCQH+0AlzH2JU+ArA8tpaQAPQG1eYOC391Me+HPeyQZ5dfGdJzobTfQl8UE7rGHJSLEYcGuV6T8Dk1oFyLzTWdKyKeIZeEqo2uvTGdsbDGiP23VcT3YpYVHs5xoQ7Wjmvu9vbGAZTIbG2tZVIucsi02oHLK6306UJegOPJTaN3IN1e+xXlqwUrAWb7nM3jfDrZyYb+M6Ruh21zE9l4A3wTKBLau2Cu/hvFpk/FA
x-ms-office365-filtering-correlation-id: 202c6fb1-b23b-49b6-a745-08d6145a4de9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB08405BAA6D40736D7A7A0009FB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(575784001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(39060400002)(256004)(14444005)(305945005)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: SD/h5bl4O/z8O9wE1nSfsMxqLmR1Ow59aTglxH0UKqL67Xw+jM1x+McaqKSiVklD2lZVQ+zkNtJknyZXaVspawxX/6HC3A8W9GgdL2//o1fdw/2K45MKTecFVHB/47dpQsxtdE5g3vHhWEYwFvrkmYQ9qFuB/3Tb1IReXvb9gHzpNnZcNNtmWghxog8uMotEp4ajl/DEDXLKLcDi43S2EDIeA3sgOKFb4Y6sLJeuk2azx33PsgxhKrV3AZPSUvSMPiAlUGEB9tsWRQuefSuYrfijZXJm1Cv7oj8ASXQHzE6NNqZoq6ITNPBhH/gpLU9i5D12v3rhGjJf0qomOjKhrXEWYLcxE2+EWeKSUH59dX0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202c6fb1-b23b-49b6-a745-08d6145a4de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:52.7789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit bd90284cc6c1c9e8e48c8eadd0c79574fcce0b81 ]

The intention here is to consume and discard the remaining buffer
upon error. This works if there has not been a previous partial write.
If there has been, then total_len is no longer total number of bytes
to copy. total_len is always "bytes left to copy", so it should be
added to written bytes.

This code may not be exercised any more if partial writes will not be
hit, but this is a small bugfix before a larger change.

Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms=
/powernv/opal.c
index 65c79ecf5a4d..c8a743af6bf5 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -388,7 +388,7 @@ int opal_put_chars(uint32_t vtermno, const char *data, =
int total_len)
 		/* Closed or other error drop */
 		if (rc !=3D OPAL_SUCCESS && rc !=3D OPAL_BUSY &&
 		    rc !=3D OPAL_BUSY_EVENT) {
-			written =3D total_len;
+			written +=3D total_len;
 			break;
 		}
 		if (rc =3D=3D OPAL_SUCCESS) {
--=20
2.17.1
