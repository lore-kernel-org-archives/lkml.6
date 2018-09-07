Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE8AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CC42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Rc9gPdlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CC42083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeIGFPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:04 -0400
Received: from mail-sn1nam01on0109.outbound.protection.outlook.com ([104.47.32.109]:39556
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729100AbeIGFPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHpf7yu1sP4Rz6N2CRDJ/3KfuRpyDclr+n6ogGVHVoI=;
 b=Rc9gPdlh2j+n/XVKGmI3KEI3Tach6hl/289imyQIeH3Lm1lYkIgCt89Sy8QaGrpcZgjHmtOMQ0f5Orxch/Y6ebRnwwkNkCqu9kc3+Oh1In3KF/j9DxdSDx9ZI6zRuCeDd3nnUvUif3/76nx+CYYYx8NgLO/Z435gp8rWSu97M7s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 55/88] powerpc/powernv: opal_put_chars partial
 write fix
Thread-Topic: [PATCH AUTOSEL 4.18 55/88] powerpc/powernv: opal_put_chars
 partial write fix
Thread-Index: AQHURkLTZW21Wt3FPkSQ3nR5QG0Rhg==
Date:   Fri, 7 Sep 2018 00:36:32 +0000
Message-ID: <20180907003547.57567-55-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:VIrcAHS99c/5VOCiA6tQ9iQzW4NYafUmPBOJtkAvbcxAWOoiRym7DXX6FW9nDhTGkfjf6loH8W5eeiQAAp+CCK5eM/R7RgolktmTHNOIk+yG+IDMS8OviZ4/UTYpCXBfuev/4rytiLea7SjK9uUiW0S43NoARjZWJQIE65sC1rKIlsMmnvElW6sUQAEVj78x2iST6R2VUBviyCnut/JAoJUHxOyeJ8ygR+mV4s+S0vo0ek/ZulIRAXOb0YcpXuumTolCf9b7tbQQPBk/kOy2TJJCobK0M2se74C82HwEnKwaxba694jyS82Ei34B58GoN8/mQaISFKJ5UMi+/bWGZ0S2z+n6RD7ge/IUeC1f1sYof2T2LLgiDiFhZKnPJIrAr6hjHOkAMqhki2hcmHlSEITwStmQ5+ik1aG85JmfR3MLAieuFnaIWlr4uBnsD3e3e56lYZvWVwuUsNSAdN7X3w==;5:Yg6RIavl98uwPyGaPGfTDpqcFwa+QhTG6lNn1/bIkq2lBKoyqcEAthpbBFLscBp0EoKMNei8lCuIYtUVw1kSP6HaQr0QaKyIuS7FBWq9GzNg0coeB7Qjue2EwPKnOFg1FSqpVsAR4Pv27EtczevE+SmYdQLCLmsue8T7UzIOrn0=;7:QNr7X+OTZbGQnq/v8FAXtV4qFRFS6ObLVaul6EZywp649UF9wDSz59/yD6O23bm7DhnKjqVH+5by7C46GB7fkUCmeFSCajo+9Q5tH+aFgWXD+ccaCtLdy5TE6QjgkKIm3yHlNcnX2D3aK14L1wKebVyraqpfp0r31FmQD2UXal2WFYJjhQbSDQc7dsN9KWOFg/4NtCCObamo9YyxahUfAAJITSVmFQtp4Z0jmPmlafVpbC6jSFb51jjDWXTq5jN4
x-ms-office365-filtering-correlation-id: 00e394dc-5b51-4331-755d-08d6145a0473
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469DCA0EC30E717C4D0EDCFFB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(39060400002)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dv8IgVhSsI+aXNoJ/bh2BIRGb2Q/FwF1bnSXPT8FdyDDBlLCDAteQ1HFYD1EFl7sNIz1FKuvKYQwi5Ym7gmfbJkRB09PMZMqeFLI2/fX8EaIz3gfFNgqpIG6UkuY9M9Tl4IrnUVGdBTriT2Nf7towBFd+sa0bQGixzplv7USCzDrPFkSTYW4iSmVZhmrO0bKmZOTmPBrWTMnL+6EpJdKv6u09jk4/GaC5v/5GXoUYTwHVI0FiN+zo7OYdRKU7QBH+jCKjEtgPV1x4xgVtUElha+08NEp+2qd8RvnbwEfM37oZmiQu7lzzPLXFZ60cjuDVxjLwNTrnmnRILuqZkSXPLsEKAo4H23JvjKZNnPb3Nw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e394dc-5b51-4331-755d-08d6145a0473
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:32.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 0d539c661748..371e33ecc547 100644
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
