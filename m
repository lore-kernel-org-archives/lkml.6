Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154CCC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8125B20877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Jrn7SU4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8125B20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbeIXVJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:09:57 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:55616
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733103AbeIXUvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u3NKQdUrhI4qD4WM8v788hjklXJmiZEF9eHLsnRqYA=;
 b=Jrn7SU4CW5yI7g/7AjzEjqJZSgq1Z/CjVWhncRz7tKAjdHgEGLkhl/te9AuiOGFlDUFRHlbEwxVb6rzPdegy84dD7Hw/v2lxWDgrHHWGDLBqXhPHfSzzpFc+KPNijrcBRcL9TVnKPgkwMlAkIkTzliStzcLzC5javqZxCcz1A4Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:49:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 58/76] cfg80211: fix a type issue in
 ieee80211_chandef_to_operating_class()
Thread-Topic: [PATCH AUTOSEL 4.18 58/76] cfg80211: fix a type issue in
 ieee80211_chandef_to_operating_class()
Thread-Index: AQHUVBWssGmJPSiYkEybS6Orhgh6tQ==
Date:   Mon, 24 Sep 2018 14:48:36 +0000
Message-ID: <20180924144751.164410-57-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:mqFJLeNBD7a0zhiV0gVT+NwNolY8X017BTSzH+WMJYEBMSZHiOj6zxkSgo7ArzB3vWPL+H97bnvGE9yylE77tawbyNAovUiGKaUXvHhfHmyc3R8ES5G3ZOLNgKbelLquh0P3DddrCtkiP9p2aKcic7gubO4XaXj3BNrshUsWb6FvbWGM6BYhyM3dDorrVUOVMp9Z05kBRZ/0T9kbXGl5FZ9pcdaflh9r70tDM2u0yxTtFtGtd07UZlOh4nbRecf1gFIDT+2sxBuiuVExlbFFSRthfTJcZRDObBSqZQd43Yqy/2L+fX/3gVAFUWfzu93irhukEbVtLQ35jStubAF+4opDxsx/NLrEVtTIJG4Lo9cB9cGyHchTzYPsfpFO34ly2WmM5IM/kcPbzogpS/uJru4KmuTLPZxP1qz+EuNRFz5T/Xtup5irck0a+nKlvgEgegTC8PSdoWfpusX5e14D6A==;5:5ACrOD66dAqtgzOeR7IhvX0YNvjK4TeZoVvb7u7TnzbMj62VI9sRkTlWLOkIT3NlD7nk8Aes/3YK+OQT5w2wUCZa5zJl1wXNmKCJHOvnuYptsZD4+Xb8De0XBRYC3ji38aFv5sLGT5T4p641v8bVLw1htD6CnwyyFcMar28GLtg=;7:tWFOntLPa3AFdAo31qN34qi+vf+69sYJ3s1Ed2HYoZrTtQis00D9izVL06+iKPqh12054nWLFS39bUr17cpeZEHqVrIiqH25JnUI814GadfFlzw7WVkl9sIedH90ksgB2fSuEW8JAS/K7qY5MDwUsU0+9MbCeB0FYbV9TG5EZHzqfIe9f4vuok0CTO7/pHtFQcDPbe8MCxQXyKalez4zdEOOEOIBB3zi7mDaq5g32DKG/FGNTG7nNHI7+7DJ25cy
x-ms-office365-filtering-correlation-id: 3d809cbc-1d8a-4d64-251a-08d6222cde40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07444E5E5847B63FAC279D97FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(575784001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(15760500003)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(14444005)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zMKl53g5SHOdgWHPPMqKQuQH4jJUmk8v7d9vSWtniUjkjaDd0yZKKhNZBKYXBUiNiJQyxtclmGZWGrSpORtAoQsytbb9DyYP0LAFygQTbY/lscp67AGQil3BH2RVv+wasNWYdJglNcb5SsyEUr2AXIrPdJaiFsP35P13W83JeveXuc1jE7D0wxt+oBv+em/SUU5kRAdGRpyUzWwc4SgxYej7fCktRQAtVLiwwC47D5qjS+5VnFtEAQvTVEVM9vpQ18mN77bT17iOL0ik9wC3T8xUNlAKQ+6iCFpnhbajSYRCEx3OAxKv+JvlX+lCyDJzgzm4uDwq7/Na7uyyD7RVfTvO49ehAzbxpgmmHOcluh4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d809cbc-1d8a-4d64-251a-08d6222cde40
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:36.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8442938c3a2177ba16043b3a935f2c78266ad399 ]

The "chandef->center_freq1" variable is a u32 but "freq" is a u16 so we
are truncating away the high bits.  I noticed this bug because in commit
9cf0a0b4b64a ("cfg80211: Add support for 60GHz band channels 5 and 6")
we made "freq <=3D 56160 + 2160 * 6" a valid requency when before it was
only "freq <=3D 56160 + 2160 * 4" that was valid.  It introduces a static
checker warning:

    net/wireless/util.c:1571 ieee80211_chandef_to_operating_class()
    warn: always true condition '(freq <=3D 56160 + 2160 * 6) =3D> (0-u16ma=
x <=3D 69120)'

But really we probably shouldn't have been truncating the high bits
away to begin with.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 3c654cd7ba56..908bf5b6d89e 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1374,7 +1374,7 @@ bool ieee80211_chandef_to_operating_class(struct cfg8=
0211_chan_def *chandef,
 					  u8 *op_class)
 {
 	u8 vht_opclass;
-	u16 freq =3D chandef->center_freq1;
+	u32 freq =3D chandef->center_freq1;
=20
 	if (freq >=3D 2412 && freq <=3D 2472) {
 		if (chandef->width > NL80211_CHAN_WIDTH_40)
--=20
2.17.1
