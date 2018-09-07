Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D56BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAC32083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E1U/sApS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAC32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbeIGFUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:55 -0400
Received: from mail-bl2nam02on0097.outbound.protection.outlook.com ([104.47.38.97]:7296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbeIGFUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6Q3+i7/t975Fo6y4oC+itkZl/61siFIp/tDPvMraqk=;
 b=E1U/sApSBx0fx4krHoDr4YqJM7W1Hriinhlit67+oUi1CZiFYFWTo6087TicaFDB2xODpgq6Yw/bROd0W6RBmQPKW5RHg2u+CwlRmMmz8UBp4OmABqnrUhBYjVjtssI+kcfqw1bblBj03Un/MbQl0EFBvRMRBNTVroyvG4/PETA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:42:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 15/19] powerpc/powernv: opal_put_chars partial
 write fix
Thread-Topic: [PATCH AUTOSEL 3.18 15/19] powerpc/powernv: opal_put_chars
 partial write fix
Thread-Index: AQHURkNAxftDGkWYzESOZQWxkNxapA==
Date:   Fri, 7 Sep 2018 00:39:36 +0000
Message-ID: <20180907003923.58019-15-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:TppYth+yXHijeuuh6aSVGd96YelC1ATjKFBqMRHZRbpz11H194bw977RFOMaHIc8oYtqG9rgNYcz4zRD4OGMcy6t5WvciczbIlYfVi5BmO2JWqD9ha2d6SeUn5Jm/wgCFl2JepE2lhcoUW6XHbLU/qFMjxmGTvVlE47k750CHx/YlYih8dDaz/v0f+ltXC35G8Rsl2ZxNCt8PvYZbDFwQxw5eJpItArbgTDawF6QNQiZsMgaxJ2ZBgG7U4zcQLzd/l+0ZakY7epx/SQj0HurXoqg5DeXUr1AceT6Wn7TuLUKHHFYpK3zVm7GGYyqV9ir5FMQB2+LEkMCE7MI90HNAl4sjPeU0PwC/86MF/w1KHwGPO09VDP3F0gG1/LS9qRn6z4LHKuSWTyovWCxj3qwY+lHqQnssvCr5wSXNYgxlrMoid/PerkcWv90K45XbREP1R+V2d/jJP6MV3sbAi9PkQ==;5:7gGoePrH5GtYMIB0bYntynCwcAuiy+sz+8d3pVZ/QoE8kGdUBCUzhVCw7pyBY1oSAcUw40qdKnhVepaEXOq/1sUanT+xOtfMRTF2QDKnm0HE+25dg5nRpu3iy3u6yz3+klgA/xy/0iyLv2f20vFb0ewue6aprURSiCLHJExDYdo=;7:8ZU6fvJ3iBguXHaR7gV9xa14SYQu/G23E7zWlecaEgcp9cVYXSUsF/jJ3Ehb2SccKZ8VG5xxU2QBHjyzliO7erc1qYJ/bjD6rD6ix1jEPqNk3lldkTUyt/idVjAX7epr21oxPe3xTcUeGIPU+d+83Vscb4a8HS3k8juuNMkSp6vN7ZHyjaFSMowbxE1IqiVRO8mVKW5wyLx2H1/hWKw4/b5KM8Hka8RxOj+iIDr8XzDUy0RrxdmRsxiwvUIUJnPd
x-ms-office365-filtering-correlation-id: 828e3c6d-51df-48cc-2b09-08d6145ad3f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
x-microsoft-antispam-prvs: <CY4PR21MB06317C90ECCF726A3041182EFB000@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(8676002)(72206003)(5660300001)(26005)(39060400002)(66066001)(6486002)(2501003)(14454004)(8936002)(6506007)(81166006)(36756003)(97736004)(10290500003)(81156014)(478600001)(22452003)(6346003)(4326008)(217873002)(10090500001)(102836004)(1076002)(107886003)(6436002)(256004)(68736007)(106356001)(14444005)(110136005)(486006)(11346002)(6666003)(186003)(6512007)(99286004)(2900100001)(105586002)(7736002)(305945005)(6116002)(2616005)(3846002)(316002)(5250100002)(54906003)(2906002)(86612001)(25786009)(476003)(76176011)(446003)(53936002)(86362001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: TlJdUpzzPmjB4R8+/jOrowHknMpSgwTRYRjZkrAcvCQU2pNfjUCaIqgoGkoQJZkeIJqG0KW11KZOds9aBLsup8KevJSDISlYJlCvREZrBpkXTGhj3dYHr8V9up3lbaa4LnTUPCKJPwegXfv9aV3rFRkU+wxgddR4zehH7fpDj5wubCHfzLgf/yb86mDuq4k75x1P+6UBw17uz9+lVuIXCLayGfVIUrPcoagV+Xntrg/hEPPrlrkRZq4u6o8Pai+XQW2NnXGVMIOgqngMTuaCrOWVodKfcpTjM5fZaapgslkuK0Q1RLXrl8/QXK77Y7+sNS2M1PIwhK1IKu0wEWHfSE0aWzFg4hX5FmNAsf8OkY0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828e3c6d-51df-48cc-2b09-08d6145ad3f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:36.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
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
index d019b081df9d..ff3e1fe4936b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -452,7 +452,7 @@ int opal_put_chars(uint32_t vtermno, const char *data, =
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
