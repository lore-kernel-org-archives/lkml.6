Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2167DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32992147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OytqgFg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32992147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbeIQI16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:58 -0400
Received: from mail-eopbgr710102.outbound.protection.outlook.com ([40.107.71.102]:64704
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729437AbeIQI14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWS7IOJRoYn4h3CMN+3v6Cz2andk+HjCw1TTLXZ0Q4g=;
 b=OytqgFg4wdnV/KpYXPCcTCUZ18KA50deDQNVmnqE+EgyHBo++UWDcQNVXiqqnHT75fVanqz4TJ7IKKD3eAtF4I/yoNgoufUe7MJCwI4n23aCnXi6t3qWgBSqWCAK9PRD9hl8dy11K9soABNzM8gNDRteA43H7972oM1CJag0+6E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 092/136] rndis_wlan: potential buffer overflow in
 rndis_wlan_auth_indication()
Thread-Topic: [PATCH AUTOSEL 4.18 092/136] rndis_wlan: potential buffer
 overflow in rndis_wlan_auth_indication()
Thread-Index: AQHUTjKvGGB5+cZLKEuzHixiaEt7Iw==
Date:   Mon, 17 Sep 2018 03:01:10 +0000
Message-ID: <20180917030006.245495-92-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:aLMGsxLIlv2lHS20ViAm/18hMggIOWSF52HoOZv/I7vJouPHLsxMOWA/niGsOjm5TL4mklybSLonvrQ4Cm1ZHiFLtbbubvkaxoKgthnUiASIpZYgr8jtNk1MhPmW9Z4/DP206tFlh8TEo/0/WzNccR4e6I74Er+7mPzmRXaAesqgnKakQnXCFfVFqNnaKOOYWf0pO2KqCw6W1k3oumQFvwD1EezHbBx3PljRskRp4xK74XGl6hNmfP/iYvHK6IlKSoOgxCDosjB/yXeWE38gqGZ3P4kHjttt95MaNZ8yNaumhG7WL/zQX1kkGwpExhVsbviQFFxZ4INVaNwO6Kt2PVe1hw3izWptKQo3Jc3f4RZU7zsWZgOlpLSlZvRcq1FBl66bwb4vyHoHVM5yT5g4yDX/W/72j6GQx3LGvi2xoNbiZ3pvCAThuxu+1L4SOlykx6C/Y0dbE539LSudmflljw==;5:EmZTsQ9BJ4lTFKot36XQbUrEikxfNo+95D6dEITc7epGE9GwM8L91ovDjB4W+y8aCj9Ao+6an5Py1uf4kFfVPmt+mCpsjuoHu5wvoPL+mj+WYlUG47oRhmZeOGsGKjPBjbrvE4iLFmXg43FNfPjKqwt0Sf79IgqbjI8RhIHukY8=;7:XMGVR663f2G7KFxTOEg/TWBnDkiKTHWjZ93EYnRQuPeBcc+UioPfWKyRrBrWZ+2exHnqirkuhYY+k20TT5xv9Jna4sIl4vr6VU/jOeKGwxIVGNUWymXqm/8G8NYD3dWTsI5ZdE3Bni9Z6WbBFcGR4COZQ73HK1BpKOYlwkBHGdD04MG5LdzQ6exprKgecAR31052LZZvtBPRybwtk903Rmggq4/g4Jf7Olxp4YmUOp24D8eIPNe1zXCW65Ic5z+J
x-ms-office365-filtering-correlation-id: 94da3170-4f65-46ad-3e0f-08d61c4a0470
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB07902DADB6E43FAF26D7BCA3FB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(6666003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: OJSJrYtkageeijCJ2m27qAEiTV5IkOAlOWd/NmfTfoIB40Gn6kXDZg8d0vy+dgKaxwWA+KwPoVU0k5M3IzZeScTtD15LfpeZODXpCdAegenZN7EifIUJS2KEFfiESrqbFjJqYXs1pLv9DktwoEjDWa2Mn/QH2fNGWZRaQkOrQgUAS+ljeWTMewkHVSDqMqOthi25P4oqr0ifEyk1DAjyh7Ma1KoKQhDdOAHaq80j1oIDPpDJcgioDuHLijujs7papoatvVMzwxODjpS0QH9qnKvbqUHXqzJGIaeu+Qybfk0Dff3NVcuQjBN4lz/rDUurNnADOZr5KdEYr/F0sCcsYe27PTmSI3mjeiIlRDSfoxo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94da3170-4f65-46ad-3e0f-08d61c4a0470
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:10.1511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ae636fb1554833ee5133ca47bf4b2791b6739c52 ]

This is a static checker fix, not something I have tested.  The issue
is that on the second iteration through the loop, we jump forward by
le32_to_cpu(auth_req->length) bytes.  The problem is that if the length
is more than "buflen" then we end up with a negative "buflen".  A
negative buflen is type promoted to a high positive value and the loop
continues but it's accessing beyond the end of the buffer.

I believe the "auth_req->length" comes from the firmware and if the
firmware is malicious or buggy, you're already toasted so the impact of
this bug is probably not very severe.

Fixes: 030645aceb3d ("rndis_wlan: handle 802.11 indications from device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/rndis_wlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis=
_wlan.c
index 9935bd09db1f..d4947e3a909e 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -2928,6 +2928,8 @@ static void rndis_wlan_auth_indication(struct usbnet =
*usbdev,
=20
 	while (buflen >=3D sizeof(*auth_req)) {
 		auth_req =3D (void *)buf;
+		if (buflen < le32_to_cpu(auth_req->length))
+			return;
 		type =3D "unknown";
 		flags =3D le32_to_cpu(auth_req->flags);
 		pairwise_error =3D false;
--=20
2.17.1
