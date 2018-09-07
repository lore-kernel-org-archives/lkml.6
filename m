Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3054C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5012B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mne+ZLQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5012B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeIGF0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:26:07 -0400
Received: from mail-sn1nam01on0096.outbound.protection.outlook.com ([104.47.32.96]:40162
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729693AbeIGFT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycz4g3M15BsHSBKcLMI0w4eeUeTvaOlwFtXmJgm9CAo=;
 b=Mne+ZLQOof56PmVG7c13818xJmxJED0j0OdcFHoAoNaNr6PRlYIg6pWUBnFSH0Ta6seWnYrjWYPbQAcPHG0DMFd3Fpr4z675JsdA/zNdUwdmfqRZll5HnHGu9xKxhr9fttzs1ep3BXe0l9Y4it8jfBvr+ibe63lieDq1xqhy42c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 27/43] powerpc/powernv: opal_put_chars partial
 write fix
Thread-Topic: [PATCH AUTOSEL 4.9 27/43] powerpc/powernv: opal_put_chars
 partial write fix
Thread-Index: AQHURkMe0QcAJeY72E2Uk6WFKT6CgQ==
Date:   Fri, 7 Sep 2018 00:38:38 +0000
Message-ID: <20180907003816.57852-27-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0853;6:DS2VCwagWjMKROpFUGyK3kLWLZ3RZuyYBwSGoNtPPVdaoPX+H+3qiDly6drHl8geo19tkpC/RYgpMdfnQfz8BBCtTqzkvCIQFqg1rpyBdtFLQKm+a97iAd/QWE8MfetaPQYWExyNAm85Tk/hARoATeiskIhEI+iUPsxBsYsf9uQpaz2sGl8gMXqmx2wlc7Gz1KjVipc9OwXMyFEXeJEtn04SKV4Pg2NuEFq2GG/oAQKasZB4cRuGf0+57CDks9lssgxy4nKbwjPdjmQYuqeQXO2ZwuvkvQ2P8CryIH5TkGgY3swTG7hPxHtmiWaydEoieLXOJjzn2qoWZpj1grZE9Yrv7INd5e5rnuEw7mWHXDvE/gLIoVrAlvsSC+0LqUdHGivOuTSblOHYgxD0mjI30V+I4cfPY0vK/AgM3+F8HlFIQngQk2pplmCRJALCeVwTB9V9wT6mSJosbnrTyNJ0dw==;5:e5XncpheLLbQFm2bPac9MDvLGnPPrXoAuXBK7Q0bXDN+p5qt4ZPThNIOfSBXcY5jy2lHZQhgBmRTmjYmJ4kr4bxiw2DvPyy2XiiNBD/HdrlQpBVjYGi2DcrchhCAO8N+k4O6QsKS140U3vCS2cqdaBBZdmNGldTbH1amHnhqnLI=;7:Bz7PU6idmy3VoQZNrYgvP1TaxUcgkoU9Cbwtd9FCSS45JzUC24xbOvF5drplkcwXo1ef4EO44ga0jgamZCPV7+3BzFBct0I6CWDIQNxzD5C2Ba+t2QMNEQaLMjyk0BBOe5eucUcYIPEYpSZ8iKc6Z3h5qMwQBUNt7veoIt5ix+/tXlgkTyI5xbKXtUayueA35shztUhdBV/QCMrTsdQ/kA//SlQtbfg4s8fMmhGCzhSva0uyyUhXZzZ5DToiu2D7
x-ms-office365-filtering-correlation-id: ec0861fc-3528-45a6-93d0-08d6145a9f9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0853;
x-ms-traffictypediagnostic: CY4PR21MB0853:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0853C5ADFB1DF163F3EBF5C6FB000@CY4PR21MB0853.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0853;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0853;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(217873002)(105586002)(106356001)(14444005)(256004)(1076002)(66066001)(3846002)(6116002)(4326008)(25786009)(39060400002)(107886003)(486006)(6436002)(6512007)(6666003)(53936002)(5660300001)(68736007)(102836004)(10290500003)(186003)(2906002)(2616005)(11346002)(476003)(2501003)(5250100002)(6506007)(446003)(110136005)(8936002)(36756003)(54906003)(76176011)(99286004)(26005)(2900100001)(81166006)(7736002)(81156014)(8676002)(14454004)(305945005)(6486002)(97736004)(72206003)(478600001)(86362001)(10090500001)(316002)(22452003)(575784001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 06woMPIIiqDymemDxcXKPKYHnfqbm36kqKIaJdcVuMrZxejcJpPPevCvg5dx4w9TlUt3IfQZ6zpbY8fWKiuAeKxgn95uNlf7Myuz/N2FNCsJjjlQcC2Njm2XS3yGnkdlvG7+e6gsrX0QZckaJzqIxU3IRckLqob01voL2zigcaYEwSYzj23qlZQKMX667FYftnalSlVgQp9TArKCqFq7IDix/aNO2gB2V65PDLfSjADSLFVCDA8P5cEJR4qSqgZ+ut1IP9cR0ppZt+g61ySpuTPJH6GXjFZ4+n5aGK0btswDrmPkmMx68ugohbo22c7rH6Bw3nGtT/cPaFh28uIWUPW6BYV4ksp9BCuHaDjn3mE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0861fc-3528-45a6-93d0-08d6145a9f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:38.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
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
index 6c9a65b52e63..7fb61ebc99a2 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -369,7 +369,7 @@ int opal_put_chars(uint32_t vtermno, const char *data, =
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
