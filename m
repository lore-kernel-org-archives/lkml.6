Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ACCECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F442087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a5Hur5TZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F442087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbeIXU7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:59:06 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:52378
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388521AbeIXUxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoCXGFevacjbmQdXhAsYJMePQJZbYAeJEuQRsxnhI/A=;
 b=a5Hur5TZM9qvZiGLcmOCur6qoEz5ImKNmPXxahg9ejzIvP8D1u+UWf/KRtROVa5cs4GkpJZSn6TeNqIueTD/9hGdhBFmFRIAid1iwVl/RYbd8uSUqw5JgCvP4RD52f/EdRJLhcv98XUj3v9e/AhZzFd0vCVD/69NuMbN6Tb6+I0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Danek Duvall <duvall@comfychair.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 03/23] mac80211: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Topic: [PATCH AUTOSEL 4.9 03/23] mac80211: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Index: AQHUVBXJ7qKfkYvGGkCyIbKMFShlRw==
Date:   Mon, 24 Sep 2018 14:49:24 +0000
Message-ID: <20180924144919.164617-3-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:zAGXG0N3Opw62Wr12ezoGTpQkNNCHvjei/IEJoElaoi3+pZQzW+3NRQPn/Jdgopzd9R5S6N09KnqBbiBMuONrfl4JWRezAOAx8s5710qukI+3y+n7IUkVwo4B1G5b3+YTOviWbcNfx4IVrgXzTKPKoNuGlYEimJo1a8qVxhy9/j3ixYN27noHXeo9ayD8QF3b8LPcqv2xHn1mV/5axYIKVzrqcI5EMmi0qwkFu+FODpZjY8GppngnVecJnAZYef+B2hKLq2K0R6SNUGhO9yThKQaKvHlIS703A+WrRbmRdhUAUSLA27Ug3bh31yxlsITcTTJG7dZ1cwsLxXnhcoa5DqUdfQerNeqzU6ywBhD+JNOkA8UzJx4XFrnH4zcRicKYA+iS2SVyPqxKa5pm7StZbQ51/Q9WkDciPQVrFdME03RSDfsfl1r5UJCTbGf8AfqdycrXRrmSA0VPssco/Lbaw==;5:16YWE49V27hTPKOtj+mpdnzWFj2dt646wpOpsp8aEcWu2QCPgasin5/ViQ+Zd09U8DreJIYmebz+8+kFCkOJa2UlB+dy5RwQ6Xo04hF8DCS3oCYT3nygz++S/KJ1HvQXf/YWMcOyFs5FwB1KmqWS55ZyxibJG/hitOJiltT/PJw=;7:wGUWZ+iTR/Fsdh+f10JwcF0zBvABzCBAoK7hCZ9ppSMfdZhkRYWyaMu6iViyrpLNFJbSqlbnx+RTKPBPI9zmEd5xehXlwYETWSh3zdIK9kfteGOeHPIs05rR5II/P92FvT2M8mHmI6GQvaToUxPb6gzs4w5i5H3fuBImAUtx0EPsr3nfDRgb+e3ljECgSdV3mmWVgXQnm6etXCs+XVf9d83wY4pe0V/Ccp1TZd1668OA0EhmOeO7PP96S9AXOhbg
x-ms-office365-filtering-correlation-id: eb66ac1c-d4bc-4439-104b-08d6222d0f5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181D3AA36752371FEFAE2C1FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(5250100002)(217873002)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(15760500003)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BNvd84H6i7qiquRPzU1NUAIaFKu+2U97oRJdNwDudARrZj2s4+DBmrQKJcMb7q2iA+hMgySwwTuaqWwpbwNX80eI0VF7a2wrJ3lwDZXbh+iXu6S2EYCAO7Vr+B+8Vt42GznnazJP1IXYX7KDXIfrHEYOwJYLtD1b+rsMhzmH1DQ+zWiQiWp8lr+D5M7P2mfl6dUzrB5B9sfmg5FEGTV4iHeCNDlG3LrfV2o7qr44ZAMcGIl7Hf3WGjwvyT2FoPTfRnh0Ig1JQt6UzU1LRJ+WElTgApQpTdEwreoek020436ZQklAkRF2lP/K6oiGHgvaDvkKtRa7f7IOqY6ZnaDmfa4cWgevUq2/KmIHKhfdOgQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb66ac1c-d4bc-4439-104b-08d6222d0f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:24.7390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danek Duvall <duvall@comfychair.org>

[ Upstream commit 67d1ba8a6dc83d90cd58b89fa6cbf9ae35a0cf7f ]

The mod mask for VHT capabilities intends to say that you can override
the number of STBC receive streams, and it does, but only by accident.
The IEEE80211_VHT_CAP_RXSTBC_X aren't bits to be set, but values (albeit
left-shifted).  ORing the bits together gets the right answer, but we
should use the _MASK macro here instead.

Signed-off-by: Danek Duvall <duvall@comfychair.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6389ce868668..4729e1c09bcc 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -466,10 +466,7 @@ static const struct ieee80211_vht_cap mac80211_vht_cap=
a_mod_mask =3D {
 		cpu_to_le32(IEEE80211_VHT_CAP_RXLDPC |
 			    IEEE80211_VHT_CAP_SHORT_GI_80 |
 			    IEEE80211_VHT_CAP_SHORT_GI_160 |
-			    IEEE80211_VHT_CAP_RXSTBC_1 |
-			    IEEE80211_VHT_CAP_RXSTBC_2 |
-			    IEEE80211_VHT_CAP_RXSTBC_3 |
-			    IEEE80211_VHT_CAP_RXSTBC_4 |
+			    IEEE80211_VHT_CAP_RXSTBC_MASK |
 			    IEEE80211_VHT_CAP_TXSTBC |
 			    IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
 			    IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
--=20
2.17.1
