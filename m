Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48339ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D366420673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="I7LflzIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D366420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390916AbeIUXQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:16:10 -0400
Received: from mail-oln040092006011.outbound.protection.outlook.com ([40.92.6.11]:42002
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390076AbeIUXQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTmRGEW5BRYURQ503HKwcEB3ehe04ykXdDjw3JAD9iA=;
 b=I7LflzIUYW9NjTznNhoU5SmWlQWvd/7b9YMnreli+JWH/5ygQrWaS9jDCoVxiQkipSmgKqOaMM4G9FGNUX3CNkiL1OtrydrYbEqc/H/YyncTQqegekg9kCFpjG3ml02PwzZjxUDq1JxPPSrVJPvdKyt2uC41fNBHHYcHDguDy+BpZYe5yta3HNaoOYfe1tG7FHy/F15l2FGDVSyHC0zalDfcFvq8wlqInt/bro7Ao5Yvyx+hcizQFNfwYFtC8kFomM1WOt8z2OBi3xWfIJjw8DQ6FJyELRR+I1GoN8Y00s43v6rT62mzLmS9MsUDNhh0vZn4nOAm17Nr4ijd1ue7mg==
Received: from CO1NAM03FT038.eop-NAM03.prod.protection.outlook.com
 (10.152.80.58) by CO1NAM03HT006.eop-NAM03.prod.protection.outlook.com
 (10.152.80.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.1164.13; Fri, 21
 Sep 2018 17:26:16 +0000
Received: from BN6PR17MB0996.namprd17.prod.outlook.com (10.152.80.57) by
 CO1NAM03FT038.mail.protection.outlook.com (10.152.81.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.13 via Frontend Transport; Fri, 21 Sep 2018 17:26:16 +0000
Received: from BN6PR17MB0996.namprd17.prod.outlook.com
 ([fe80::2cd3:5085:8114:52cf]) by BN6PR17MB0996.namprd17.prod.outlook.com
 ([fe80::2cd3:5085:8114:52cf%4]) with mapi id 15.20.1143.019; Fri, 21 Sep 2018
 17:26:16 +0000
From:   Karthik Nishanth <nishanthkarthik@live.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Karthik Nishanth" <nishanthkarthik@live.com>
Subject: [PATCH] Fix clang warning -Wpointer-bool-conversion by removing
 unnecessary check in regd.c
Thread-Topic: [PATCH] Fix clang warning -Wpointer-bool-conversion by removing
 unnecessary check in regd.c
Thread-Index: AQHUUdAzTB9srBlPUkCULV35zqxrLA==
Date:   Fri, 21 Sep 2018 17:26:15 +0000
Message-ID: <BN6PR17MB099677ADA332476DC575F2EDCA120@BN6PR17MB0996.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To BN6PR17MB0996.namprd17.prod.outlook.com
 (2603:10b6:404:6e::10)
x-incomingtopheadermarker: OriginalChecksum:D7E4273AE908B3E82C6C09914FE725173BCAA0BF30793794098943E5D5A8BD96;UpperCasedChecksum:576C37A222B9981F1FFF03E2B1404C62E5F580DBDD86329F1A4AF33443953E25;SizeAsReceived:7620;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [rgxtkoEuQC/0S2/0no6gf+QTjgEX4wTy]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO1NAM03HT006;6:futjUHqXTE5x1+DQ3lxPj+2E5fkiKWZWD7f4fnAEquiafL06sXQGrlqWQR7cW3AOfi0Lbk9ndGwUOOmf9hjlumqpQsp1CIzC1+d0e7qYd9lwLXLLSH+blxBA089RXLEvBVBaGEm+eT5gg+Em+kNNeLTHfgumDlhDK7ipqZACLgzzH17TTJ3bi1HGkpu60BbdItfYC+v3tL1e7BvDEqHrWQJfPgxUKkTdxlDuSihd0VmcFimyAdm7AmSPN1OQTN8TUII5AtZNCLt9mSPXXKUl7M+JWzz/gjfLj/KplOjYQEkUJwXnJX7ShaTKZnkDwzP4/ekNCcBVa7Jl2MUkSlmX1QBmwTaq/C2pCCexdS85cxnN7Cfer7pV6iiM7bqULexL8kxzOl3h1KlDIUuyk9YELtDWuys7K7lHVKc6eZg9jP8IohSJ0ME/eMbFwwfUMoz81xdMXznwqf0u+LKHaFhKZQ==;5:TxdajKKuESi1vXApmAcCUtCwq4ut71TkkiYAdBxrFb3ShwXNU0i4D8kZbyKGgHdPvAMJftXxWQvdYac6yZ0Pjspn3R1cRQqEbrRwqI+VByexZze95ytT5+//tqbY0a28KyNg4ktxkgZBQ98Lf/u29i1jyNOgFrL68FBZ17bc8gg=;7:4NsVmx7ekVJX5ntW5TUV2I17FGjEThLOH8bp95bb390eGEpOQX1rM7XNBdH/2ohqXzcrMaR45qyii7WrrS+Ak41JOQqXWHNWyW/RXmAhQaYObX3WgSOGXaPmHIhWo+dbqs1qhGpMc1O+3xMnEGtzzp6J2u5fFpZP8cfUAexHWYBg/LuGAgGmjM7IPwtSjQQUhl95ePG7Y/Wt7rDZfw14sig8gkRoiMAGv+GVc9fnx03suiLS8I6L2IwAZyOlkBB6
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: citmFLqyTFTjBVAsc0QWdDTnTRRSRVAjrUXJW6LTV63CJtDHOib6uMYrM2Dw+R8hR0f0ATLpGrTEA/GVKZoB/TWHhDFeN6NYaV6x6Fe6obfdlC/QYYtyKBafqP8LAQijMvxfN4g6bck1YyUDlN04id1yfpOhMahkmjTKV5aMMfV7q9g1woLxdIzICJgfXnAYREsq2S78hWfDP4ZNJMUNkp0HC+hDfFA98E7n7vbAfbd+bI8OY6bD4WvSqlz15oyvMksTYWQPV99NDeF6038O+fdXvUKNzw8GcFCwQWXO1uXhQcrt2PqPY8Fws2OiyVIowY6KJRfa7MwqONmp3IQAX20VBaflNBGoDPEszRBGsqnLeNLdqe+cTX6IVqWXS1GpAp/Mt0gbHYxtyfDLoRQOYWzF4Rwhd/0BUO7Nl4YsrUMSxgSmLDiMTuINwWIfGSYyFzZMk4LUkxvgP0UDLZcu5vp/atsnVtWP3dZPkKgNSysGxAHWJXcMJ6vHX7g1NT0yBIMz/2JXf6FRxuar+FK/vVad7aLpwsoisATcuirhbBF82Dgh7fUErNBP4YMfq77Y188rpoWdEeg9iDjguVqvB450OHfzeSZFV6k6VlumSIjc58DkvKYer5IXNn5BWj+EnAvI2m3P7ihZKld6SOUmzE41/3a8DyVA10pBR46yIFKyvz4RgoIW96RpxMykwpFlvSNzHGPlZLWIJ7XMyshHpgKruz1ii9zsW91ixwApOOid1nThqGUcdeA7MjogcX5YS8Kf0d92hYR7CRO4JSU229RQBZdpsmI69KaArKkdXA8=
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(201702181274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:CO1NAM03HT006;
x-ms-traffictypediagnostic: CO1NAM03HT006:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:CO1NAM03HT006;BCL:0;PCL:0;RULEID:;SRVR:CO1NAM03HT006;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(199004)(189003)(966005)(14454004)(71190400001)(71200400001)(74316002)(14444005)(5640700003)(256004)(305945005)(104016004)(476003)(6436002)(486006)(6346003)(26005)(6506007)(2501003)(97736004)(5250100002)(1857600001)(56003)(2900100001)(102836004)(8936002)(68736007)(386003)(7696005)(39060400002)(4326008)(99286004)(54906003)(2351001)(25786009)(5660300001)(81156014)(86362001)(1730700003)(55016002)(8676002)(6306002)(33656002)(82202002)(106356001)(105586002)(6916009)(9686003);DIR:OUT;SFP:1901;SCL:1;SRVR:CO1NAM03HT006;H:BN6PR17MB0996.namprd17.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: live.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nishanthkarthik@live.com; 
x-microsoft-antispam-message-info: T95ykadvIxJG/mMk7kxRj63sOWkbWEQKRqiJVPh53baCJAjxUAfgtEuxQoD8VMIGnrlfJ/PferaoPeOukRlw5hbMaq4l0Hv85R4Dgt17ckAf8grayZbgIxSfn/MpWmm05xWKKJ6d6weHOXqM95nbgPslwuQvC7YUjlAVsBZKlhr0FuO65KXefnAzusJZ7mpq13+6UE6OlbDR2ql6PcYmh6fl6s26sx9KrqDS2ITNusM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: c001924d-3e68-4f40-89c2-901a49278da7
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3996ce-1533-40af-4913-08d61fe75589
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: c001924d-3e68-4f40-89c2-901a49278da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 17:26:16.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM03HT006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member regd of the struct rtl_priv is true in a boolean context.

drivers/staging/rtlwifi/regd.c:413:27: warning: address of 'rtlpriv->regd' =
will always
      evaluate to 'true' [-Wpointer-bool-conversion]
        if (!wiphy || !&rtlpriv->regd)
                      ~ ~~~~~~~~~^~~~
1 warning generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/170

Signed-off-by: Karthik Nishanth <nishanthkarthik@live.com>
---
 drivers/staging/rtlwifi/regd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/regd.c b/drivers/staging/rtlwifi/regd.=
c
index 3afd206ce4b1..5213ca771175 100644
--- a/drivers/staging/rtlwifi/regd.c
+++ b/drivers/staging/rtlwifi/regd.c
@@ -410,7 +410,7 @@ int rtl_regd_init(struct ieee80211_hw *hw,
 	struct wiphy *wiphy =3D hw->wiphy;
 	struct country_code_to_enum_rd *country =3D NULL;
=20
-	if (!wiphy || !&rtlpriv->regd)
+	if (!wiphy)
 		return -EINVAL;
=20
 	/* init country_code from efuse channel plan */
--=20
2.19.0

