Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260B4C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CFC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FdTjFDYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CFC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbeIGFUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:20 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:29984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbeIGFUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRR5BFC7B+oKYED0qKOOvxNeW1JxGjQaZ+1sB5ism1c=;
 b=FdTjFDYi2PmFd8UZp6a7tb+1w6Vogt2NIy+kQMFIrQX+Kee0DrRU2r9slJx1696ZzfMB3ag1IU5XQgsWOskAmndgyxoR3lNLXf8ky57BE5hOkG0wilKdnuB4Ik0hmwmzUBml/R3U3NxtEQXes26OYEfcruvid16R9wAVi6ZTgOQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 22/30] powerpc/powernv: opal_put_chars partial
 write fix
Thread-Topic: [PATCH AUTOSEL 4.4 22/30] powerpc/powernv: opal_put_chars
 partial write fix
Thread-Index: AQHURkMzydpTemg2DE6n3vmOfrKK3w==
Date:   Fri, 7 Sep 2018 00:39:13 +0000
Message-ID: <20180907003853.57942-22-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:d1kEckoJ+8pwNJsbd1MX2wdnuu5fPTI6H3MhJyiTu6NKEaO490cN+zwlN56gDXwNiqUJkVHjb8cZf5khD+Tytub6geLv+2JJFu4uUSyHeetGrN7LBCJOfCSLIOo4xYChfgG0hmM+j0qyz0MzSEx3WE6hyagbXCmkUjCEsBYH3fr/OaD5EgXAtrRJauczjXpp74f1aZxUHEeIBsjypxbqtQh7T//wHgLCT5PQOAoLPmRncSOErWjVLP6SKOCCOCtgkOIhHWRokmebmwnQIQ+X0HPoQTeVEoZiCWgEZJynSsSN5jmQObuhqzbPTiWly5TPBj6zhkuhakypDnG8p8LiP6ym1S9VP+G2Y0CCyjRVBS+MubIXd9Qi1IedIKvh8A2D8Sv8EDVTy5vpdBN3mat3UqEsqVpIJUhSNyLlgfJUQrMfsZAHR4sw7XI1/34dRFFnsaJYTnQSEXeY2iFoodJ8FQ==;5:9YRtgUNfslfOsVMNH5Zmxk37KQ67lvsg7s1O7Y83fFtE9ZuDVs3TttKwTlfl0QaKriqOQqrfTJAdbZhQ6ch4931P6BpSG4RlAy2FBSA5DOAKlWCNoWH21x89o05lAJ9mSRo1zx4altvYFM3i5CQn0EpVONtpbkyG7fcd5iVOIcY=;7:UNWgQkXLCYDMRREKBgupJt3cxD+MJJj9wTxiCfCIfUteteXbF1bEVrpAHRDNm/03o4OpgqFDmX7AexREFW6oy3B+XINK6GyDfJG7Uxa6wGwqCtEozpRJqrMP7pEaf0sXMef3vjZTEAD2hYzEcyWQVW3zh/lJkKa2elB9p7BFmCTrOBXqGh3kjio4RbbbcvQQjSgrpWd4Nl8KWD1eg/ECI7EB+nU2CPNF499qPZd3S9HDWnN0Xmbz30oOwqNpYTfG
x-ms-office365-filtering-correlation-id: 20e2f217-4c3e-4d10-f1cd-08d6145abb51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB082282BC75C41945AC4D9ED4FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(39060400002)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6u4bNlJC7xK5wMdzRbnil7FIdaNqEPg9Wsu7NJcDNAbKTRKx7hswAfkSL0VaunOD/+PzfU9DeCHNmTCvbCit7S+ZGIUuEs6V8ig9d/nYgbJ16uEQ7+IQA0LbfDUOGNa9zYY/QX1GbnW3IcZf6wzax8XhrVjzA3eTwgTtbljTnQtGiqnJgEUuVx6COGQkNCCBznWm+1N56p03da0QuRc7phmCEJSkPUbRxjdFEBkG+QuB0nWLRwz8OdsijRmanEmyYoWu8CmZGl7nGaoqIe6LN2B6v4I8e+1c+LalIqHSOQs0p9yNXBN47BDffMDho+colkehsRaYFC6MtsjiaMcWi6kYHwXOy/g2NXvZaERk79U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e2f217-4c3e-4d10-f1cd-08d6145abb51
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:13.6016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index e48826aa314c..b40606051efe 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -371,7 +371,7 @@ int opal_put_chars(uint32_t vtermno, const char *data, =
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
